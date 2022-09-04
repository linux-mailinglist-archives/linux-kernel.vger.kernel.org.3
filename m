Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC15AC42A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiIDLts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 07:49:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5717E04;
        Sun,  4 Sep 2022 04:49:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ML91C2gWQz4xD3;
        Sun,  4 Sep 2022 21:49:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662292176;
        bh=bKqRG6bbjWf4+zXv++X3GOUqHw+5BEUesl1XOH03L+I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Uw7YffOgZPnmgBp6TK63LEy7ghgapx/1/o+S2lrTttIriH8Uf6Aw+fA0CvnhCfJob
         QR5u4nvxWn4iof9YBgdEMN6abL3KvBiuubuLIpoqLE4PWNBwj7YCF3LL6NGY5wK+YF
         2/eEjU3GK4QyMwwYACESiGHFBBPg2ZYnDq8y3pTSwi6HXQUOoxRiirooaSCPbAhcGt
         rBKeM1INkwFt3rs1V9zpJLnJzZJAEJ/B4/tmHUlJ0scCd1B/0szive/CEac8iTLdal
         VdAGUPRkl+tNL1Bzryy54iXUXYEvcZVziJGYwmtCJR7FeXamkFuhYZYYFRB/FHnNnf
         j0Jy4shd5wK1Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
In-Reply-To: <c6f3d408-e050-c1dc-9864-c1b2c92369ed@csgroup.eu>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <608934d4-466d-975e-6458-34a91ccb4669@redhat.com>
 <Yw5AOZ/Kc5f3UP+s@monkey> <Yw6Bpsow+gUMlHCU@monkey>
 <739dc825-ece3-a59f-adc5-65861676e0ae@redhat.com>
 <YxJQfGSsbXd3W4m/@monkey>
 <323fdb0f-c5a5-e0e5-1ff4-ab971bc295cc@redhat.com>
 <c6f3d408-e050-c1dc-9864-c1b2c92369ed@csgroup.eu>
Date:   Sun, 04 Sep 2022 21:49:34 +1000
Message-ID: <87ilm3tl4h.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> +Resending with valid powerpc list address
>
> Le 02/09/2022 =C3=A0 20:52, David Hildenbrand a =C3=A9crit=C2=A0:
>>>>> Adding Christophe on Cc:
>>>>>
>>>>> Christophe do you know if is_hugepd is true for all hugetlb entries, =
not
>>>>> just hugepd?
>
> is_hugepd() is true if and only if the directory entry points to a huge=20
> page directory and not to the normal lower level directory.
>
> As far as I understand if the directory entry is not pointing to any=20
> lower directory but is a huge page entry, pXd_leaf() is true.

Yes.

Though historically it's pXd_huge() which is used to test that, which is
gated by CONFIG_HUGETLB_PAGE.

The leaf versions are newer and test whether the entry is a PTE
regardless of whether CONFIG_HUGETLB_PAGE is enabled. Which is needed
for PTDUMP if the kernel mapping uses huge pages independently of
CONFIG_HUGETLB_PAGE, which is true on at least powerpc.

>>>>>
>>>>> On systems without hugepd entries, I guess ptdump skips all hugetlb e=
ntries.
>>>>> Sigh!
>
> As far as I can see, ptdump_pXd_entry() handles the pXd_leaf() case.
>
>>>>
>>>> IIUC, the idea of ptdump_walk_pgd() is to dump page tables even outside
>>>> VMAs (for debugging purposes?).
>>>>
>>>> I cannot convince myself that that's a good idea when only holding the
>>>> mmap lock in read mode, because we can just see page tables getting
>>>> freed concurrently e.g., during concurrent munmap() ... while holding
>>>> the mmap lock in read we may only walk inside VMA boundaries.
>>>>
>>>> That then raises the questions if we're only calling this on special M=
Ms
>>>> (e.g., init_mm) whereby we cannot really see concurrent munmap() and
>>>> where we shouldn't have hugetlb mappings or hugepd entries.
>
> At least on powerpc, PTDUMP handles only init_mm.
>
> Hugepage are used at least on powerpc 8xx for linear memory mapping, see
>
> commit 34536d780683 ("powerpc/8xx: Add a function to early map kernel=20
> via huge pages")
> commit cf209951fa7f ("powerpc/8xx: Map linear memory with huge pages")
>
> hugepds may also be used in the future to use huge pages for vmap and=20
> vmalloc, see commit a6a8f7c4aa7e ("powerpc/8xx: add support for huge=20
> pages on VMAP and VMALLOC")
>
> As far as I know, ppc64 also use huge pages for VMAP and VMALLOC, see
>
> commit d909f9109c30 ("powerpc/64s/radix: Enable HAVE_ARCH_HUGE_VMAP")
> commit 8abddd968a30 ("powerpc/64s/radix: Enable huge vmalloc mappings")

64-bit also uses huge pages for the kernel linear mapping (aka. direct
mapping), and on newer systems (>=3D Power9) those also appear in the
kernel page tables.

cheers
