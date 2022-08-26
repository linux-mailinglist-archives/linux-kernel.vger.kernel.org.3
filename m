Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21F5A283B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbiHZNH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:07:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34426804A9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:07:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDg8y2l3Gz4xD1;
        Fri, 26 Aug 2022 23:07:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1661519235;
        bh=0i+s5wxpP3IqnwJK7XUXPlQWahZWLjBPLn3YDuffA54=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RC+rHNrEU+ZD62VNj83ycZeTbgzHNj1aRUikYH+jRDEO2osPaEgMu9JAOgFUyvM01
         BP0heyCS3o+FIJwtzn7Ih98HxwvCYkoTQUN4YZUi8h8pXoGb2eg9x7YVwPMsWwvYFZ
         fgsTJpelo5tv4jwUOzJ2wc6IyhA5VM3sMQmtNaOMyXQ1DC4Uikm5XE/3JJRvnK0ft1
         lKGzPqX6zCFIGqkriGV9KxVqKLEtiMJ/gFJMkUMZ53sMnocEfbxY9dsEuA601dNwgm
         OqA2qV1TLO7m2Vf4BWyjw/Q95CbqhPcKTD569gA6pva6qyJsVjgtLRUY00tDs0bMYt
         ylSD2JRLy1Itw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Wang, Haiyue" <haiyue.wang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
In-Reply-To: <Yv/AdwdID9rr9xOL@monkey>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-2-haiyue.wang@intel.com>
 <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
 <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
 <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
 <Yv0ku1mn4LBzg/zG@monkey> <875yiomq9z.fsf@mpe.ellerman.id.au>
 <Yv/AdwdID9rr9xOL@monkey>
Date:   Fri, 26 Aug 2022 23:07:12 +1000
Message-ID: <87r113jgqn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:
> On 08/19/22 21:22, Michael Ellerman wrote:
>> Mike Kravetz <mike.kravetz@oracle.com> writes:
>> > On 08/16/22 22:43, Andrew Morton wrote:
>> >> On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com> wrote:
>> >>
>> >> > > >  		}
>> >> > >
>> >> > > I would be better to fix this for real at those three client code sites?
>> >> >
>> >> > Then 5.19 will break for a while to wait for the final BIG patch ?
>> >>
>> >> If that's the proposal then your [1/2] should have had a cc:stable and
>> >> changelog words describing the plan for 6.0.
>> >>
>> >> But before we do that I'd like to see at least a prototype of the final
>> >> fixes to s390 and hugetlb, so we can assess those as preferable for
>> >> backporting.  I don't think they'll be terribly intrusive or risky?
>> >
>> > I will start on adding follow_huge_pgd() support.  Although, I may need
>> > some help with verification from the powerpc folks, as that is the only
>> > architecture which supports hugetlb pages at that level.
>> >
>> > mpe any suggestions?
>>
>> I'm happy to test.
>>
>> I have a system where I can allocate 1GB huge pages.
>>
>> I'm not sure how to actually test this path though. I hacked up the
>> vm/migration.c test to allocate 1GB hugepages, but I can't see it going
>> through follow_huge_pgd() (using ftrace).
>
> I thing you needed to use 16GB to trigger this code path.  Anshuman introduced
> support for page offline (and migration) at this level in commit 94310cbcaa3c
> ("mm/madvise: enable (soft|hard) offline of HugeTLB pages at PGD level").
> When asked about the use case, he mentioned:
>
> "Yes, its in the context of 16GB pages on POWER8 system where all the
>  gigantic pages are pre allocated from the platform and passed on to
>  the kernel through the device tree. We dont allocate these gigantic
>  pages on runtime."

That was true, but isn't anymore.

I must have been insufficently caffeinated the other day. On our newer
machines 1GB is the largest huge page size, but it's obviously way too
small to sit at the PGD level. So that was a waste of my time :)

We used to support 16GB at the PGD level, but we reworked the page table
geometry a few years ago, and now they sit at the PUD level on machines
that support 16GB pages:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba95b5d0359609b4ec8010f77c40ab3c595a6ac6

Note the author :}

So the good news is we no longer have any configuration where a huge
page entry is expected in the PGD. So we can drop our pgd_huge()
definitions, and ours are the last non-zero definitions, so it can all
go away I think.

I'll send a patch to remove the powerpc pgd_huge() definitions after
I've run it through some tests.

cheers
