Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E04E3A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiCVIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiCVIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:20:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3B5EDD4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647937145; x=1679473145;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=x1YD9my+L35IteAZDqbEgYROw0JzwAUiseR0i+LHqww=;
  b=klcKSWF5u/G108lMJoCoYQOgv7gtk+DtBISSeRMwko8rQig9mXsFBLqZ
   7kzPXeVvZG52iUPZIMSZJVGU4S/1U+cjZWr8+UjK5mch7126jGcvbjX51
   BkclN2LbEi0CUtn+0qq0Yq85fuob/T7bPYow1vHbgQv/HGnvhNg0bEofl
   6AqgSkNIBnA5W+XAAYL47yPFAh2uVM4Y4c8iaS53LM5ck583XqURB0jKy
   CM00Qay4lEJkLiln5SKALd3nqmC1HEWjjignRTH/Y0fJUiCn+/4yQXfAm
   A9rGHcNLX0kBy7ebaLZ7ULyLsarPmIW+Cv7pTS5rvMyVNthh+cFwDOx8P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257708565"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="257708565"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:19:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="518789896"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:18:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] scheduler updates for v5.18
References: <YjhZUezhnamHAl0H@gmail.com> <Yjh58h8cpcPERVZA@qian>
        <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
        <Yjl8Lk2uPiZkXoM9@gmail.com> <Yjl/T0SBCo1zfkkS@gmail.com>
Date:   Tue, 22 Mar 2022 16:18:57 +0800
In-Reply-To: <Yjl/T0SBCo1zfkkS@gmail.com> (Ingo Molnar's message of "Tue, 22
        Mar 2022 08:48:31 +0100")
Message-ID: <871qyu5rim.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo,

Ingo Molnar <mingo@kernel.org> writes:

> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> 
>> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> 
>> > On Mon, Mar 21, 2022 at 6:13 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
>> > >
>> > > On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
>> > > > Huang Ying (3):
>> > > >       sched/numa-balancing: Move some document to make it consistent with the code
>> > > >       sched/numa: Fix NUMA topology for systems with CPU-less nodes
>> > > >       sched/numa: Avoid migrating task to CPU-less node
>> > >
>> > > Linus, I don't think you want to merge this as-is. This will introduce a
>> > > kernel crash on arm64 NUMA as mentioned in this thread,
>> > 
>> > Ok, dropped from my queue. Thanks,
>> 
>> I've reverted the broken commit & will send another pull request after 
>> some testing. Sorry about that!
>
> Ended up using the fix below instead - it's tested already on the affected 
> system.
>

Thanks a lot for your help!

Is it a general rule to send a fixing patch for the bug of a patch
merged by tip tree?  Or a new version of the patch is acceptable too?

Best Regards,
Huang, Ying
