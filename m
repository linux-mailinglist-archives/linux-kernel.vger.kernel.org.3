Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8A55052B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiFRNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiFRNtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:49:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EDC51D0FF;
        Sat, 18 Jun 2022 06:49:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070C5113E;
        Sat, 18 Jun 2022 06:49:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.35.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5DA93F792;
        Sat, 18 Jun 2022 06:49:07 -0700 (PDT)
Date:   Sat, 18 Jun 2022 14:49:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: READ_ONCE() usage in perf_mmap_read_self()
Message-ID: <Yq3Xzz2XebvEJFcJ@FVFF77S0Q05N>
References: <f26be5e-af31-a996-9c7-86d9d1ed4b2@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26be5e-af31-a996-9c7-86d9d1ed4b2@maine.edu>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 04:13:22PM -0400, Vince Weaver wrote:
> Hello

Hi Vince,

> Is the perf_mmap__read_self() interface as found in tools/lib/perf/mmap.c
> the "official" interface for accessing the perf mmap info from
> userspace?

The tools/lib/perf stuff is *a* library for accessing it, but no-one's mandated
to use that, and in that sense it's not the "official" interface. The
"official" interface is whatever's documented in the UAPI headers, e.g.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/perf_event.h?h=v5.19-rc2#n517

... though I admit that's not as clear as it ideally would be, and we could
improve that and/or add some other documentation that's earier to consume.

> Are the READ_ONCE() calls required?  If they are left out, will accessing 
> the mmap interface potentially fail?  Has this ever been seen in practice?

There's a bunch of subtlety here. The gist is:
 
1) Here we use READ_ONCE() to make the loads single-copy-atomic (i.e. not torn
   into separate accesses). There are other ways that can be achieved without
   using READ_ONCE().

   In practice, compilers don't generally tear loads of less than the machine
   word size when used in "simple" sequences, but they can often replay loads
   assuming that the value hasn't changed. For the sequences here, I suspect
   it's very unlikely the compiler would tear accesses or replay them.

2) The reads of pc->lock need to be single-copy-atomic, or the loop may not
   correctly protect reads within the sequence. In the absnece of that, the
   result could be bogus (and as below, accesses to the counters could trigger
   unexpected exceptions).

3) Compiler barriers are necessary to ensure that loads within the loop are
   protected by pc->lock and not pulled out of the loop or cached over multiple
   iterations of the loop.

4) Data loaded *and consumed* within the loop may need to be loaded with
   single-copy-atomic accesses depending on how they are used. For example,
   pc->index needs to be loaded in a single-copt-atomic way or an erroeous
   counter index could be used, and the access to that counter might cause an
   exception.

   In contrast, dor data where we just perform some maths without side-effects,
   that wouldn't be important.

5) Data merely loaded within the loop doesn't strictly need to be loaded in a
   single-copy-atomic way. If there's concurrent modification, pc->lock will
   have changed, causing it to be diescarded, and if there's no concurrent
   modification the tearing is benign.

IIUC we marked everything with READ_ONCE() because that was simpler to reason
about (and very unlikely to be detrimental) rather than it being strictly
necessary.

Does that make sense and does that answer your questions?

> Part of why I am asking is both
>  	tools/lib/perf/mmap.c
> and
>  	tools/linux/compiler.h (which defines READ_ONCE)
> have SPDX headers indicating they are GPL-2.0 licensed, which means it 
> seems like it would not be possible to easily use the perf mmap interface 
> from BSD-licensed code.  Would it be possible to get those two files 
> re-licensed?

I suspect that's likely to be difficult since (IIUC) those are derived from
other kernel code licensed as GPL-2.0, and we'd need to get all relevant
contributors to agree to the relicensing.

> The (BSD-licensed) PAPI is currently using a mmap reading interface 
> based on early documentation for the feature, but it isn't 100% the same 
> as the version from libperf (and isn't using READ_ONCE).  Life would be 
> easier if we could use the perf version of the code because then we would 
> have one less variable to deal with when trying to track down issues.

Would clarifying the documentation be helpful here? We might be able to
document this more clearly and precisely, then align the tools/lib/perf/ code
with the documentation, even if we can't necessarily relicense that code as-is.

Thanks,
Mark.
