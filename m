Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF334C1841
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbiBWQMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiBWQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:12:16 -0500
Received: from outbound-smtp45.blacknight.com (outbound-smtp45.blacknight.com [46.22.136.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E1012604
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:11:45 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 86E3FFAAAD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:11:44 +0000 (GMT)
Received: (qmail 13369 invoked from network); 23 Feb 2022 16:11:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Feb 2022 16:11:44 -0000
Date:   Wed, 23 Feb 2022 16:11:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 00/35] Speculative page faults
Message-ID: <20220223161141.GG4423@techsingularity.net>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:09:31AM -0800, Michel Lespinasse wrote:
> This patchset is my take on speculative page faults (spf).
> It builds on ideas that have been previously proposed by Laurent Dufour,
> Peter Zijlstra and others before. While Laurent's previous proposal
> was rejected around the time of LSF/MM 2019, I am hoping we can revisit
> this now based on what I think is a simpler and more bisectable approach,
> much improved scaling numbers in the anonymous vma case, and the Android
> use case that has since emerged. I will expand on these points towards
> the end of this message.
> 
> The patch series applies on top of linux v5.17-rc1;
> a git tree is also available:
> git fetch https://github.com/lespinasse/linux.git v5.17-rc1-spf-anon
> 
> I would like these patches to be considered for inclusion into v5.18.
> Several android vendors are using Laurent Dufour's previous SPF work into
> their kernel tree in order to improve application startup performance,
> want to converge to an upstream accepted solution, and have reported good
> numbers with previous versions of this patchset. Also, there is a broader
> interest into reducing mmap lock dependencies in critical MM paths,
> and I think this patchset would be a good first step in that direction.
> 

I think there is serious lack of performance data here. The only
performance point offered is the Android Application Startup case.
Unfortunately, that benefit may be specific to the Zygote process that
preloads classes that may be required and listens for new applications to
start. I suspect the benefit wouldn't apply to most Linux distributions
and even JVM-based workloads are not primarily constrained by the startup
cost. Improving application start up costs is not great justification
for this level of code complexity even though I recognise why it is a
key performance indicator for Android given that startup times affect
the user experience.

Laurent's original work was partially motivated by the performance of
a proprietary application. While I cannot replicate a full production
workload as that can only be done by the company, I could do a basic
evaluation commonly conducted on standalone systems. It was extremely
fault intensive with SPF success rates greater than 96% but almost no
change in actual performance. It's perfectly possible that the application
has changed since SPF was first proposed. The developers did spend a fair
amount of effort at making the application NUMA-aware and reusing memory
more aggressively to avoid faults. It's still very fault intensive but
does not appear to suffer due to parallel memory operations guessing from
the data.

On my own tests, the only preliminary test that was a clear winner
was will-it-scale using threads for the page-fault workloads and
page-fault-test for threads. To be far, the increases there are dramatic
with a high success rate of speculative faults.

pft timings
                                 5.17.0-rc3             5.17.0-rc3
                                    vanilla        mm-spfault-v2r1
Amean     elapsed-1        32.66 (   0.00%)       32.77 *  -0.36%*
Amean     elapsed-4         9.17 (   0.00%)        8.89 *   3.07%*
Amean     elapsed-7         5.53 (   0.00%)        5.26 *   4.95%*
Amean     elapsed-12        4.13 (   0.00%)        3.50 *  15.16%*
Amean     elapsed-21        3.93 (   0.00%)        2.79 *  29.03%*
Amean     elapsed-30        4.02 (   0.00%)        2.94 *  26.79%*
Amean     elapsed-48        4.37 (   0.00%)        2.83 *  35.24%*
Amean     elapsed-79        4.13 (   0.00%)        2.17 *  47.36%*
Amean     elapsed-80        4.12 (   0.00%)        2.13 *  48.22%*

Ops SPFault Attempt                        0.00  4734439786.00
Ops SPFault Abort                          0.00     9360014.00
Ops SPFault Success                        0.00          99.80

This is the ideal case for SPF but not very realistic. Interestingly,
ebizzy barely benefitted even though it's threaded because it's not
guaranteed to be address space modification intensive.

Hackbench took a performance hit between 0-5% depending on the exact
configuration and machine used. It is threaded and had high SPF abort rates
(up to 50%). It's not a great example but it shows at least one example
where SPF hurts more than it help and there may be other applications
that are harmed by having to retry faults.

The scope of SPF is narrow relative to the much older discussion of
breaking up mmap_sem. The only time SPF benefits is when faults are racing
against parallel memory address updates holding mmap_sem for write.
That requires a threaded application that is both intense in terms of
address space updates and fault intensive. That is much narrower than
threaded applications that are address space update intensive (e.g.
using mprotect to avoid accidentally leaking data, mapping data files
for IO etc). Have we examples of realistic applications that meet all the
criteria of "threaded", "address-space intensive" and "fault intensive"
that are common enough to justify the complexity?

Admittedly, I initially just threw this series at a collection of
workloads that simply stress the allocator because it stresses faults as
a side-effect but most of them did not match the criteria for "threaded
application that is both address space update intensive and fault
intensive". I'm struggling to think of good examples although redis
is a possibility. HPC workloads like NPB parallelised with OpenMP is a
possibility but I looked at some old results and while it does trap faults,
the vast majority are related to NUMA balancing.  The other ones I normally
consider for scaling purposes are process orientated and not threads.

On the patches themselves, I'm not sure the optimisation for ignoring SPF
is guaranteed to work as mm_users could be temporarily elevated although
probably not enough to matter. I also think patch 5 stands on its own and
could be sent separately. For the others, I didn't read them in sufficient
depth but noted that the level of similar logic between speculative
and non-speculative paths could be a maintenance headache to keep the
speculative and !speculative rules in sync. I didn't see obvious problems
as such but I still think the complexity is high for a corner case.

-- 
Mel Gorman
SUSE Labs
