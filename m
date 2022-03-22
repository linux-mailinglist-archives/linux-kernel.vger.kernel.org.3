Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B64E35CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiCVA4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiCVA4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:56:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6E0393D4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647910494; x=1679446494;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=vC5XGWgcx/m0ro/Tht7tviD4bm7XAZNYoABd7EquuNw=;
  b=GdRRQiEpJ2aa78+txeKB4r0SP59xkTYaz8UlsTf1ZiJMXInqorhI0gC+
   yWkR5/CEQxHo9Y1N2DjeVh5+UVP0TqqEyDLbLs9Ln5ziyJctWG4MFG5Wp
   Au/6yXLjUDvusNwvHfdTqEAbk8mfgdU1PjpploweC1duqTFnhYZhbo5rm
   exYyJsWzdtrg+JXw8Ih3aTYvJLJrCKZ1zPwPe5ziPUfEk6Gsiooi3Dxsx
   chDWPrZhZO+82GkzD9SNkwlBJcl0dzrW+zv+7T8AUgaLgezWdLCMrcew6
   iMziIgAg04P58aP8lfoTPLIKG2VQhrQhyMBs5R0xE9aeOZoRxozlIhrut
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="239845545"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="239845545"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:54:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560121674"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:54:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Ingo Molnar <mingo@kernel.org>,
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
Date:   Tue, 22 Mar 2022 08:54:45 +0800
In-Reply-To: <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 21 Mar 2022 17:18:33 -0700")
Message-ID: <875yo6ajsa.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Mar 21, 2022 at 6:13 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
>>
>> On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
>> > Huang Ying (3):
>> >       sched/numa-balancing: Move some document to make it consistent with the code
>> >       sched/numa: Fix NUMA topology for systems with CPU-less nodes
>> >       sched/numa: Avoid migrating task to CPU-less node
>>
>> Linus, I don't think you want to merge this as-is. This will introduce a
>> kernel crash on arm64 NUMA as mentioned in this thread,
>
> Ok, dropped from my queue. Thanks,

Can you just drop the last one, that is,

  sched/numa: Avoid migrating task to CPU-less node

That is the patch that has the bug reported by Qian.  The other 2 are
good.

I will work with Peter and Ingo to update the buggy patch.

Best Regards,
Huang, Ying
