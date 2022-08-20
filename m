Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9D59AC80
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiHTIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiHTIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:12:12 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D10BBA9C0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:12:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660983129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uROXnR0FNbtP4K5lfGfX+GsQclYXLCvip69kr6fv6XQ=;
        b=t1mwDFk5LmXG1MqGD5+ZL6X/OvL9+uY3SUKGNBb419kxibz8Hr1r11J9eyM2G0GzUGfbpN
        HlgjB5qgeoop66ToK2ZxJcpenfHRv4zkf2ytfh3gNBGiUWDrI+oL6mSoTAeZhjbdcSBmAi
        6qOx21RGLc1NBmy2Edrxvu3IB5yHQtw=
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220816130553.31406-5-linmiaohe@huawei.com>
Date:   Sat, 20 Aug 2022 16:12:05 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBD5F92C-1D62-4331-A214-5B6D08E35809@linux.dev>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

I found another place where is a similar case. See =
kasan_populate_vmalloc_pte() in
mm/kasan/shadow.c.=20

Should we fix it as well?


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

