Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C34BA06F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiBQM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:57:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiBQM5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:57:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C37273746
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 994A1B82176
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE58DC340E8;
        Thu, 17 Feb 2022 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645102654;
        bh=kgjS5WxgVrvPzinoXteH3mXgOP0TCfzBtzDNqiGy1Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvrdZQFBn72v6oLTS1g5ytXiKTh95tIKNQZlXZ2P10HtrbAc2lpx/rdcUUe1xbkNG
         ukX1M8e6U3zK1Fsdv7439Y6HsyLUjag80AEhMaYaw2ZnjmCIdT8h52X6FI5FN8d/A3
         gCYELIsnagHOkwsj5gE/6YFBVvg3FS0ppr1WZ8k43gXNJKfux+jVpsPY47aYEY3MlJ
         TMbrY+F3GrrQKuHh/0T/Z8jCEd/wxAexZSbPMvB7lMxS+tmZz0LUYRREvfthWT8pkh
         LNiuTNT5M963ntdoV11HXHABnQZiiuJbuo+BPaNMn5SQBRVdUYLaFhTQkRJMfeo2q8
         lZCE8Ss+H1UMw==
Date:   Thu, 17 Feb 2022 13:57:31 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>, tglx@linutronix.de, mingo@kernel.org,
        mingo@redhat.com, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220217125731.GA744754@lothringen>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <YfxVpEO+UJTC+a9e@lorien.usersys.redhat.com>
 <20220216143412.dwxjlkq4w2zeweld@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216143412.dwxjlkq4w2zeweld@ava.usersys.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:34:12PM +0000, Aaron Tomlin wrote:
> On Thu 2022-02-03 17:22 -0500, Phil Auld wrote:
> > As I said earlier, I don't think you want to call quiet_vmstat()
> > unconditionally. And I don't think this will catch the cases you are
> > trying to fix. Once the tick is stopped tick_nohz_stop_tick should not be
> > getting called again until it's been restarted.
> 
> Phil,
> 
> Sorry about the delay. If I understand correctly, I see a scenario by which
> tick_nohz_stop_tick() can be called on transition/or exit from idle (e.g.
> default_idle_call()):
> 
> 	1.	The idle/or scheduling-clock was previously
> 		stopped
> 
> 	2.	It is considered safe for the scheduling-clock
> 	        tick to remain "stopped"/or omitted; no need to
> 		reprogram and enable a periodic tick
> 		(e.g. no queued/or expired pending timer)
> 
> 	  ...
>             do_idle
> 	      cpuidle_idle_call
> 	      {
> 
> 		...
> 
> 	.--     default_idle_call
> 	|         arch_cpu_idle
> 	|         goto exit_idle
>         |
>         |       exit_idle:
> 	|         __current_set_polling()
>         |
> 	|     }
>         |     tick_nohz_idle_exit()
>         |     {
>         |
>         |       tick_stopped = ts->tick_stopped
>         |
>         |       if (tick_stopped)
>         |         tick_nohz_idle_update_tick(ts, now)
>         |           if (tick_nohz_full_cpu(smp_processor_id()))
>         |             __tick_nohz_full_update_tick(ts, now)
>         |             {
>         |               int cpu = smp_processor_id()
>         |
>         |               if (can_stop_full_tick(cpu, ts))
>         |                 tick_nohz_stop_sched_tick(ts, cpu)
>         |                   if (tick_nohz_next_event(ts, cpu))
>         '--                   tick_nohz_stop_tick(ts, cpu)
>                       }
>               }
> 
> If I understand correctly, __tick_nohz_full_update_tick() can return with
> no changes to the current tick (e.g. expire time == KTIME_MAX), no?

Hmm, but does it matter? The issue seem to be that we can enter in idle loop without
flushing vmstat. Or am I missing something else?

Thanks.

> 
> 
> Kind regards,
> 
> -- 
> Aaron Tomlin
> 
