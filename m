Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15568599ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348780AbiHSLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348787AbiHSLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:22:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D7FEC40
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:22:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M8K9P1v8Qz4x1G;
        Fri, 19 Aug 2022 21:22:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1660908155;
        bh=SXvhcATHeAzGrsMP2ajJM02RREFpXI38PV8xlqpBvfk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dj5/0PZNbcvmmBLC1vxc+g8hIrgyxyVrvDiueNMAUKwl+xNjN80XyTFh6mcL3oo88
         JhI4NCwCYx4vx1guEND4xEfN602aY988zTA9BEVr/wBtSUBng7mjVYFRd54CfaNV7L
         AzlxqMoecTz26IeIoVfSYwYkbqdW/dWTJBpg7v+Df9GFmEHhjHTzfNo5Cc+h8jBBGN
         /wTMmny+SRgk1jqhkGFt+qR/9XwyQ8/ZL3licVyZcBan4ftPMvNnrJY4G8bpPi6g62
         boV22S7BcUl47iUzKvn+Zwpcp+K42mIHbBDhssIFl1XIJKxDOfb8hanzYqJ34Hy+qF
         49CXJER8bAuPg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Wang, Haiyue" <haiyue.wang@intel.com>,
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
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
In-Reply-To: <Yv0ku1mn4LBzg/zG@monkey>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-2-haiyue.wang@intel.com>
 <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
 <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
 <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
 <Yv0ku1mn4LBzg/zG@monkey>
Date:   Fri, 19 Aug 2022 21:22:32 +1000
Message-ID: <875yiomq9z.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:
> On 08/16/22 22:43, Andrew Morton wrote:
>> On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com> wrote:
>>
>> > > >  		}
>> > >
>> > > I would be better to fix this for real at those three client code sites?
>> >
>> > Then 5.19 will break for a while to wait for the final BIG patch ?
>>
>> If that's the proposal then your [1/2] should have had a cc:stable and
>> changelog words describing the plan for 6.0.
>>
>> But before we do that I'd like to see at least a prototype of the final
>> fixes to s390 and hugetlb, so we can assess those as preferable for
>> backporting.  I don't think they'll be terribly intrusive or risky?
>
> I will start on adding follow_huge_pgd() support.  Although, I may need
> some help with verification from the powerpc folks, as that is the only
> architecture which supports hugetlb pages at that level.
>
> mpe any suggestions?

I'm happy to test.

I have a system where I can allocate 1GB huge pages.

I'm not sure how to actually test this path though. I hacked up the
vm/migration.c test to allocate 1GB hugepages, but I can't see it going
through follow_huge_pgd() (using ftrace).

Maybe I hacked it up badly, I'll have a closer look on Monday. But if
you have any tips on how to trigger that path let me know :)

cheers
