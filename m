Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7E4E3537
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiCVADP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiCVADO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:03:14 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2666B5BD18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647907249; x=1679443249;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=UDulXBbHl84BXC6Y9lJgX+jNJtZKcReNo6dsx18aGgo=;
  b=Ismshecq2GTWjApLq96TtNT06OieeRt4nFZE+pjQYNNl9Qcf2JK7y9oA
   O6ADcamAImt96FPFQOKfUez+8R2XVClHuUhiWohE7hoQ8/XPzeg5ysOcl
   kEoomuX9zR633z9hBuoSSWOYG5T/va2/Q8S+gMwgk0f0QNBwveoQK2wXo
   C5bxoJu3V/EX382DB4S+gUeKU0II9M1CUMYHmhfqARugmId4XOv2Wn/gf
   PrjrQPNb6OONfY81YUw4mplCwQgE35UjrM8YFAiUekaILAw3ds5zD9xmf
   2oRv+z7eEYApsbwmAKS/P6/Bsz1tvbqW3VZF9j12cIs9dXfLMabi3ou8b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="318387830"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="318387830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 16:59:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="560104256"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 16:59:03 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [GIT PULL] scheduler updates for v5.18
References: <YjhZUezhnamHAl0H@gmail.com> <Yjh58h8cpcPERVZA@qian>
Date:   Tue, 22 Mar 2022 07:59:01 +0800
In-Reply-To: <Yjh58h8cpcPERVZA@qian> (Qian Cai's message of "Mon, 21 Mar 2022
        09:13:22 -0400")
Message-ID: <8735jac0xm.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
>> Huang Ying (3):
>>       sched/numa-balancing: Move some document to make it consistent with the code
>>       sched/numa: Fix NUMA topology for systems with CPU-less nodes

These 2 patches are good.

>>       sched/numa: Avoid migrating task to CPU-less node

As Qian pointed out, this needs to be updated.

> Linus, I don't think you want to merge this as-is. This will introduce a
> kernel crash on arm64 NUMA as mentioned in this thread,
>
> https://lore.kernel.org/lkml/Yh6H8SPSqpjv1dl7@qian
>
> Ying sent an updated patch to fix the crash but is missing from this pull
> request for some reasons.
>
> https://lore.kernel.org/lkml/87y21lkxlv.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/

This is sent as an UPDATE patch.  Hi, Peter, do you need a new version
of patchset when some patches needs to be updated in general?

Best Regards,
Huang, Ying
