Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56D57B8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiGTOts convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jul 2022 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbiGTOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:49:33 -0400
X-Greylist: delayed 1951 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 07:49:22 PDT
Received: from mail2.intersystems.com (mail2.intersystems.com [38.105.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61214564F3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:49:21 -0700 (PDT)
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
From:   Ray Fucillo <Ray.Fucillo@intersystems.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v4 0/8] hugetlb: Change huge pmd sharing
 synchronization again
Thread-Topic: [RFC PATCH v4 0/8] hugetlb: Change huge pmd sharing
 synchronization again
Thread-Index: AQHYkXZV7rwY/0b1YEWM7yXbYs48gK2HptEA
Date:   Wed, 20 Jul 2022 14:16:46 +0000
Message-ID: <3F53322F-65B0-4DA0-84AB-360CB46769E4@intersystems.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.254.204]
x-c2processedorg: 5d7e5ca7-6395-445f-80da-8568a4fc58e5
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE0E6F4D0660F74FAB27E5074105B122@exchangemail.iscinternal.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 6, 2022, at 4:23 PM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> I am sending this as a RFC once more in the hope of generating comments
> and discussion. While the changes are intrusive, they do show a significant
> performance benefit in my simulated workload. Code is based on next-20220706.
> 
> hugetlb fault scalability regressions have recently been reported [1].
> This is not the first such report, as regressions were also noted when
> commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
> synchronization") was added [2] in v5.7. At that time, a proposal to
> address the regression was suggested [3] but went nowhere.
> 
> The regression and benefit of this patch series is not evident when
> using the vm_scalability benchmark reported in [2] on a recent kernel.
> Results from running,

Mike, thank you for all the work and careful consideration here!  We did find that this patch set addresses the scalability regression that was at the root of critical issues for customers that upgraded to newer Linux distributions (those with commit c0d0381ade79)

Ray
