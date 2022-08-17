Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBF59678F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiHQCxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiHQCxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:53:44 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3352451
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:53:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660704821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKHknFPdtsEpagdsawoMuSymjD5F5nqPAIA2dcTKaCg=;
        b=MCfzvq+WCMJb/PWdlB8BFTca2XvJukPQyMAnOk9F4TlOV7FX5qBqJbunguzLUiaH+Vgbzj
        gR2r93hrKZEr32kLH5n+i7gi/AFRetHqQGV/mC+wgAjESshzpcSinB9Oo81F1laZ869FoB
        CNbFg2IIRYkbkK9QUuzmmdwmwTYOTC0=
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220816130553.31406-5-linmiaohe@huawei.com>
Date:   Wed, 17 Aug 2022 10:53:08 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> The memory barrier smp_wmb() is needed to make sure that preceding =
stores
> to the page contents become visible before the below set_pte_at() =
write.

I=E2=80=99m not sure if you are right. I think it is set_pte_at()=E2=80=99=
s responsibility.
Take arm64 (since it is a Relaxed Memory Order model) as an example (the
following code snippet is set_pte()), I see a barrier guarantee. So I am
curious what issues you are facing. So I want to know the basis for you =
to
do this change.

 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
        *ptep =3D pte;

        /*
         * Only if the new pte is valid and kernel, otherwise TLB =
maintenance
         * or update_mmu_cache() have the necessary barriers.
         */
        if (pte_valid_not_user(pte)) {
               dsb(ishst);
               isb();
        }
 }

Thanks.

>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> mm/hugetlb_vmemmap.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 20f414c0379f..76b2d03a0d8d 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -287,6 +287,11 @@ static void vmemmap_restore_pte(pte_t *pte, =
unsigned long addr,
> 	copy_page(to, (void *)walk->reuse_addr);
> 	reset_struct_pages(to);
>=20
> +	/*
> +	 * Makes sure that preceding stores to the page contents become =
visible
> +	 * before the set_pte_at() write.
> +	 */
> +	smp_wmb();
> 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> }
>=20
> --=20
> 2.23.0
>=20
>=20

