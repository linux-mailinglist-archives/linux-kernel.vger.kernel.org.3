Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672704B00DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiBIXAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:00:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiBIXA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5106BE04FF1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644447630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I87WKK2XMvlDBm9jXPfU4m+q1rZaDpFs2yyNoj4YXlg=;
        b=Tvjd1+yDMAE5upUGTWlx5wp4+Z/zM45IiVJUey+UuLnyUtx1gKHOWOAUc5elbrOkYD3rYh
        aQBWilc+0XtyDPVqyrtiLxYZ4V5rfGMjuTQQ9Kx7VrMFWL3CfQcdpbrmC+PiOekhjDQiZ3
        ypwPl3DzNBrHhhbboIF1OnMabBxSqFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-wYAcf0zXMcOW4McwKt1IYw-1; Wed, 09 Feb 2022 18:00:27 -0500
X-MC-Unique: wYAcf0zXMcOW4McwKt1IYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62C461091DA0;
        Wed,  9 Feb 2022 23:00:25 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FA384EE1D;
        Wed,  9 Feb 2022 23:00:23 +0000 (UTC)
Date:   Wed, 9 Feb 2022 18:00:21 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>
Subject: Re: [PATCH 0/1] sched: Use printk_deferred() in __schedule()
Message-ID: <YgRHhb63WhnmqApU@lorien.usersys.redhat.com>
References: <20220209221319.179648-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209221319.179648-1-stephen.s.brennan@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Feb 09, 2022 at 02:13:18PM -0800 Stephen Brennan wrote:
> Hello all,
> 
> I have a customer whose systems are encountering a deadlock due to a
> warning in the perf_cgroup_switch function, which is called during
> __schedule:
> 
>   #5 [ffffa82fd8fd3700] native_queued_spin_lock_slowpath at ffffffff8ef0ef2b
>   #6 [ffffa82fd8fd3708] queued_spin_lock_slowpath at ffffffff8ef0eafb
>   #7 [ffffa82fd8fd3718] _raw_spin_lock at ffffffff8f805a93
>   #8 [ffffa82fd8fd3728] try_to_wake_up at ffffffff8eee1f8e
>   #9 [ffffa82fd8fd3790] wake_up_process at ffffffff8eee2425
>  #10 [ffffa82fd8fd37a0] wake_up_worker at ffffffff8eec67b8
>  #11 [ffffa82fd8fd37b0] insert_work at ffffffff8eec7997
>  #12 [ffffa82fd8fd37f0] __queue_work at ffffffff8eec7af2
>  #13 [ffffa82fd8fd3838] queue_work_on at ffffffff8eec82f8
>  #14 [ffffa82fd8fd3850] drm_fb_helper_dirty at ffffffffc1d3cea5 [drm_kms_helper]
>  #15 [ffffa82fd8fd3890] drm_fb_helper_sys_imageblit at ffffffffc1d3d010 [drm_kms_helper]
>  #16 [ffffa82fd8fd38b0] soft_cursor at ffffffff8f316906
>  #17 [ffffa82fd8fd3900] bit_cursor at ffffffff8f3166da
>  #18 [ffffa82fd8fd39d0] fbcon_cursor at ffffffff8f311e3f
>  #19 [ffffa82fd8fd3a18] hide_cursor at ffffffff8f3c6213
>  #20 [ffffa82fd8fd3a30] vt_console_print at ffffffff8f3c7e42
>  #21 [ffffa82fd8fd3a98] console_unlock at ffffffff8ef1d4ac
>  #22 [ffffa82fd8fd3ae0] vprintk_emit at ffffffff8ef1ecf5
>  #23 [ffffa82fd8fd3b40] vprintk_default at ffffffff8ef1ee29
>  #24 [ffffa82fd8fd3b50] vprintk_func at ffffffff8ef1f8a4
>  #25 [ffffa82fd8fd3b70] printk at ffffffff8ef1bf58
>  #26 [ffffa82fd8fd3bd0] report_bug at ffffffff8f7dbbc5
>  #27 [ffffa82fd8fd3c10] fixup_bug at ffffffff8ee3592c
>  #28 [ffffa82fd8fd3c30] do_error_trap at ffffffff8ee35989
>  #29 [ffffa82fd8fd3c78] do_invalid_op at ffffffff8ee35ac2
>  #30 [ffffa82fd8fd3ca0] invalid_op at ffffffff8fa013b7
>      [exception RIP: perf_cgroup_switch+330]
>      RIP: ffffffff8f01c26a  RSP: ffffa82fd8fd3d58  RFLAGS: 00010086
>      RAX: 0000000000000002  RBX: ffff99013f7b2708  RCX: 000000000000038f
>      RDX: 00000000000105a0  RSI: 0000000000000000  RDI: 000000000000038f
>      RBP: ffffa82fd8fd3d98   R8: 000000000000016e   R9: 0000000000000039
>      R10: 0000000000000000  R11: 0000000000000000  R12: ffff99013f7a8010
>      R13: 0000000000000000  R14: 0000000000000000  R15: ffff99013f7b2700
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #31 [ffffa82fd8fd3d50] perf_cgroup_switch at ffffffff8f01c223
>  #32 [ffffa82fd8fd3da0] __perf_event_task_sched_in at ffffffff8f01c538
>  #33 [ffffa82fd8fd3e18] finish_task_switch at ffffffff8eedd460
>  #34 [ffffa82fd8fd3e50] __schedule at ffffffff8f800794
>  #35 [ffffa82fd8fd3ea0] schedule_idle at ffffffff8f800ebc
>  #36 [ffffa82fd8fd3eb8] do_idle at ffffffff8eee794d
>  #37 [ffffa82fd8fd3f10] cpu_startup_entry at ffffffff8eee7bfd
>  #38 [ffffa82fd8fd3f28] start_secondary at ffffffff8ee6f6e9
>  #39 [ffffa82fd8fd3f50] secondary_startup_64 at ffffffff8ee000e6
> 
> While certainly, the perf bug which results in this warning should be
> fixed, and I am working on tracking it down, it's also clear that this
> sort of warning should not deadlock the kernel. My proposed change is to
> enter a "printk_deferred" section at the beginning of __schedule as the
> rq lock is taken, and then end it as the lock is dropped. This style of
> fix has already been proposed before [1], but was NAK'd.
> 
> I think enough has changed that we should reconsider this change.
> 
> First, one reason for the NAK was that a better printk implementation
> was forthcoming, which would only write to atomic-safe console
> drivers ("sane" drivers as they were called in that discussion),
> delegating the rest to a kthread. This implementation is still not
> upstream, but in the meantime we've had several kernel releases with
> this sort of issue present.
> 
> Second, another reason for the NAK was that WARN statements require
> immediate printing, since the system may not be stable enough to print
> the warning later. Though this is true, warnings are not meant to be
> fatal, and we should hope that the system can limp along long enough to
> exit a single context switch. Even if that's not possible, the printk
> infrastructure contains several ways to allow the buffered messages to
> reach the console even if the system crashes later:
> 
> 1) the log buffer can be written to several places via kmsg_dump()
> 2) panic tries very hard to empty the log buffer to console drivers
> 3) crash dumps contain the full log buffer data, and debug tools can
> readily reconstruct these records
> 
> Third, since the posting of the previous series, commit
> 57116ce17b04 ("workqueue: fix state-dump console deadlock") was
> introduced with no objection, to address the same deadlock in a
> workqueue function.
> 
> Of course, I'm not bound to this particular solution -- I'd be glad to
> discuss alternatives and other ideas. Thanks for reading and
> considering!
> 
> [1]: https://lore.kernel.org/lkml/20200927161130.33172-1-zhouchengming@bytedance.com/
> 

Thanks for raising this. I've got a bug report with the same issue. In this
case we hit the warning in cfs_rq_is_decayed(). That should be less likely
to fire now with recent changes but that's only a bandaid.

I think the printk rework is coming Real Soon Now, but it's not here yet as
you say. It would be helpful to get some visibility back on this issue. This
seems like a reasonable way out in the meantime.


Cheers,
Phil


> 
> Stephen Brennan (1):
>   sched: Use printk_deferred during __schedule()
> 
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> -- 
> 2.30.2
> 

-- 

