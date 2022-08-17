Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8DD596D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiHQLV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiHQLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:21:57 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D8D5FAFF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:21:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660735313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVxPk6+5X6DJJkwSaX0y9hA+rp5q+PorKKLpJBEA7eE=;
        b=h4rNBVsjUyBLhnBfmD1f1Hb5mRNfq3kgg4G1/r7wUE9ajpVQQMDbwO4I/ThtCZyfxsVc36
        Xh3JyJo8zuS0qNfjknCuUR8o6ZF8VAv6kjCaifiYPlj1+fVCJWKUNL1gfMiHhMsT52+N14
        2J2JPB5yB77Ym29HAQ7D/YcosOTXtfs=
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
Date:   Wed, 17 Aug 2022 19:21:20 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
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



> On Aug 17, 2022, at 16:41, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> On 2022/8/17 10:53, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>=20
>>> The memory barrier smp_wmb() is needed to make sure that preceding =
stores
>>> to the page contents become visible before the below set_pte_at() =
write.
>>=20
>> I=E2=80=99m not sure if you are right. I think it is set_pte_at()=E2=80=
=99s responsibility.
>=20
> Maybe not. There're many call sites do the similar things:
>=20
> hugetlb_mcopy_atomic_pte
> __do_huge_pmd_anonymous_page
> collapse_huge_page
> do_anonymous_page
> migrate_vma_insert_page
> mcopy_atomic_pte
>=20
> Take do_anonymous_page as an example:
>=20
> 	/*
> 	 * The memory barrier inside __SetPageUptodate makes sure that
> 	 * preceding stores to the page contents become visible before
> 	 * the set_pte_at() write.
> 	 */
> 	__SetPageUptodate(page);

IIUC, the case here we should make sure others (CPUs) can see new =
page=E2=80=99s
contents after they have saw PG_uptodate is set. I think commit =
0ed361dec369
can tell us more details.

I also looked at commit 52f37629fd3c to see why we need a barrier before
set_pte_at(), but I didn=E2=80=99t find any info to explain why. I guess =
we want
to make sure the order between the page=E2=80=99s contents and =
subsequent memory
accesses using the corresponding virtual address, do you agree with =
this?

Thanks.

>=20
> So I think a memory barrier is needed before the set_pte_at() write. =
Or am I miss something?
>=20
> Thanks,
> Miaohe Lin
>=20
>> Take arm64 (since it is a Relaxed Memory Order model) as an example =
(the
>> following code snippet is set_pte()), I see a barrier guarantee. So I =
am
>> curious what issues you are facing. So I want to know the basis for =
you to
>> do this change.
>>=20
>> static inline void set_pte(pte_t *ptep, pte_t pte)
>> {
>>        *ptep =3D pte;
>>=20
>>        /*
>>         * Only if the new pte is valid and kernel, otherwise TLB =
maintenance
>>         * or update_mmu_cache() have the necessary barriers.
>>         */
>>        if (pte_valid_not_user(pte)) {
>>               dsb(ishst);
>>               isb();
>>        }
>> }
>>=20
>> Thanks.
>>=20

