Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C450E75E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbiDYRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiDYRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3269495
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A7006148C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE66C385A7;
        Mon, 25 Apr 2022 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650908000;
        bh=5KkkCHMQlKS4LIUUedJqXCNf/v4WgrQgG5Czu2mEFYI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h/Q3XCjShWcJryVc0iyXgeDGTTOuJGUs50y4Sy9oaTtmZhwY7kRtNtixJvE36lhnV
         YAKGDeRFj7quRkhVPn8Xx+J5TVHmx9WcefstSTluqG7xfGl+nbmQ48Z1bgQW873iWy
         W6neIhH54mfYvcXPhaWvGCPSjecpdEVIJ5N+bBOKKCzsxeVRdk6VkieiPvOBu9NSAk
         jVV61HYEB7QYN8aIUv49i1L7PskKwHJesEKxcMB+ORV13tfedhx/c78r0OAEfEV6ll
         Qakyf7Q/YfUhYMkG4bOW7CB0raRyGWxbYb4ViH5a7rJPOpns8eEkwgfUHfdbCHOsk1
         do783ozekP9OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 606C45C042D; Mon, 25 Apr 2022 10:33:20 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:33:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
Message-ID: <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 05:15:13PM +0100, Valentin Schneider wrote:
> 
> Hi Paul,
> 
> On 21/04/22 12:38, Paul E. McKenney wrote:
> > Hello!
> >
> > The rcutorture TREE03 scenario got the following splat, which appears
> > to be a one-off, or if not, having an MTBF in the thousands of hours,
> > even assuming that it is specific to TREE03.  (If it is not specific to
> > TREE03, we are talking tens of thousands of hours of rcutorture runtime.)
> >
> > So just in case this rings any bells or there are some diagnostics I
> > should add in case this ever happens again.  ;-)
> 
> There should be a dump of the enqueued tasks right after the snippet you've
> sent, any chance you could share that if it's there? That should tell us
> which tasks are potentially misbehaving.

And now that I know to look for them, there they are!  Thank you!!!

CPU7 enqueued tasks (2 total):
 pid: 52, name: migration/7
 pid: 135, name: rcu_torture_rea
smpboot: CPU 7 is now offline

So what did rcu_torture_reader() do wrong here?  ;-)

                                                      Thanx, Paul

> > ------------------------------------------------------------------------
> >
> > [29213.585252] ------------[ cut here ]------------
> > [29213.586287] Dying CPU not properly vacated!
> > [29213.586314] WARNING: CPU: 7 PID: 52 at kernel/sched/core.c:9386 sched_cpu_dying.cold.167+0xc/0xc3
> > [29213.589181] Modules linked in:
> > [29213.589864] CPU: 7 PID: 52 Comm: migration/7 Not tainted 5.18.0-rc1-00196-g24f4daa283b8 #5468
> > [29213.591720] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module_el8.5.0+746+bbd5d70c 04/01/2014
> > [29213.593698] Stopper: multi_cpu_stop+0x0/0xf0 <- stop_machine_cpuslocked+0xea/0x120
> > [29213.595333] RIP: 0010:sched_cpu_dying.cold.167+0xc/0xc3
> > [29213.596463] Code: 1f ea 00 49 89 e8 48 8d 93 38 07 00 00 48 c7 c7 60 2b d8 b9 e8 be 2a 00 00 e9 4b 7d 4a ff 48 c7 c7 18 2c d8 b9 e8 80 ed ff ff <0f> 0b 44 8b ab d0 09 00 00 8b 4b 04 48 c7 c6 95 d5 d6 b9 48 c7 c7
> > [29213.600479] RSP: 0018:ffff9cbbc023bd88 EFLAGS: 00010082
> > [29213.601630] RAX: 0000000000000000 RBX: ffff9b98df3e8cc0 RCX: 0000000000000003
> > [29213.603175] RDX: 0000000000000003 RSI: 0000000100021495 RDI: 00000000ffffffff
> > [29213.604699] RBP: 0000000000000086 R08: 0000000000000000 R09: c000000100021495
> > [29213.606230] R10: 000000000081dc88 R11: ffff9cbbc023bba8 R12: ffffffffb889d6c0
> > [29213.607755] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cbbc05bfd01
> > [29213.609297] FS:  0000000000000000(0000) GS:ffff9b98df3c0000(0000) knlGS:0000000000000000
> > [29213.611045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [29213.612279] CR2: 0000000000000000 CR3: 0000000016c0c000 CR4: 00000000000006e0
> > [29213.613821] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [29213.615433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [29213.616972] Call Trace:
> > [29213.617516]  <TASK>
> > [29213.617992]  ? sched_cpu_wait_empty+0x70/0x70
> > [29213.618935]  cpuhp_invoke_callback+0x100/0x4a0
> > [29213.619899]  cpuhp_invoke_callback_range+0x3b/0x80
> > [29213.620933]  take_cpu_down+0x55/0x80
> > [29213.621703]  multi_cpu_stop+0x61/0xf0
> > [29213.622503]  ? stop_machine_yield+0x10/0x10
> > [29213.623408]  cpu_stopper_thread+0x84/0x120
> > [29213.624300]  smpboot_thread_fn+0x181/0x220
> > [29213.625192]  ? sort_range+0x20/0x20
> > [29213.625961]  kthread+0xe3/0x110
> > [29213.626641]  ? kthread_complete_and_exit+0x20/0x20
> > [29213.627777]  ret_from_fork+0x22/0x30
> > [29213.628655]  </TASK>
> > [29213.629185] ---[ end trace 0000000000000000 ]---
> 
