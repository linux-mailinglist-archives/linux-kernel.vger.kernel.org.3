Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7775567584
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiGERXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiGERXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7A19C29
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891AF617BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F52C341CE;
        Tue,  5 Jul 2022 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657041822;
        bh=br/XBfR32/fjIvDBTZJqpuQE7IF6Crv5lw02/kJda2g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eQ8K87Knz8blqu/JWgzhQBISP4Od/fqxeThAeNAuCzLrZqZS3iACR82TMUJxXiSoY
         KR7UKDINJWt6WiJWRk01j2RU8+Kn979DR0pw0VfmooWlAV7aGkZ5dgFJEgGfDM262b
         SXdmpOj625yh0baR03SVUYn/8e40fLaF0QaiOEJTzJeAB/g1NCMIumytxEPObaOV+2
         or20RO9uG+38T9FFivnIl7FP6LzAvbTtTA6cPr7tUYGL5VNNPrpqrXvRevVR/ODkLe
         cjitZNKD73pJDifX6ChObQaImLy1bVot5rwdWq9IzP+dIUN2f1ptc6bgsPZdX5pya7
         o37NpnYKv+awg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 865395C05ED; Tue,  5 Jul 2022 10:23:42 -0700 (PDT)
Date:   Tue, 5 Jul 2022 10:23:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
Message-ID: <20220705172342.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh1qxkakof.mognet@vschneid.remote.csb>
 <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhy1zr99zt.mognet@vschneid.remote.csb>
 <20220426162445.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220622195856.GA1694215@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhzghof1eo.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhzghof1eo.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:45:35AM +0100, Valentin Schneider wrote:
> Hi Paul,
> 
> On 22/06/22 12:58, Paul E. McKenney wrote:
> >
> > And I hit this on two of fifteen TREE03 runs on a merge of -rcu with
> > yesterday's linus/master.  Might be a fluke, but I thought I should
> > at least report it.  This is the first time since my last email in
> > this thread.
> >
> >                                                       Thanx, Paul
> 
> Did you get anything other than rcu_torture_reader in the task dump this
> time?

I did.  For my future reference, this is devserver rcutorture run
2022.06.21-21.13.37-remote, scenarios TREE03.11 and TREE03.5.

Here are the splats, the first including rcu_torture_reader() as before,
but the second instead containing rcu_torture_fwd():

------------------------------------------------------------------------

TREE03.5:

[[13599.132723] ------------[ cut here ]------------
[13599.132725] Dying CPU not properly vacated!
[13599.132740] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:9494 sched_cpu_dyi
ng.cold.167+0xc/0xc3
[13599.132756] Modules linked in:
[13599.132759] CPU: 3 PID: 31 Comm: migration/3 Not tainted 5.19.0-rc3-00143-g16
22bc5a1d51-dirty #64
[13599.132766] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-1.module_el8.7.0+
1140+ff0772f9 04/01/2014
[13599.132768] Stopper: multi_cpu_stop+0x0/0xf0 <- __stop_cpus.constprop.9+0x3c/
0x80
[13599.132777] RIP: 0010:sched_cpu_dying.cold.167+0xc/0xc3
[13599.132782] Code: b9 e8 00 49 89 e8 48 8d 93 38 07 00 00 48 c7 c7 70 60 99 b3
 e8 f4 2d 00 00 e9 ed 65 49 ff 48 c7 c7 28 61 99 b3 e8 0e ee ff ff <0f> 0b 44 8b
 ab d0 09 00 00 8b 4b 04 48 c7 c6 35 0b 98 b3 48 c7 c7
[13599.132785] RSP: 0000:ffff9e4080183d88 EFLAGS: 00010082
[13599.132788] RAX: 0000000000000000 RBX: ffff8b641f2e8cc0 RCX: 0000000000000003
[13599.132790] RDX: 0000000000000003 RSI: 4000000100010677 RDI: 00000000ffffffff
[13599.132791] RBP: 0000000000000086 R08: ffffffffb3c55d00 R09: 727020746f6e2055
[13599.132793] R10: ffffffffb3c55d00 R11: 2164657461636176 R12: ffffffffb249ed00
[13599.132794] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9e40805c7c01
[13599.132796] FS:  0000000000000000(0000) GS:ffff8b641f2c0000(0000) knlGS:00000
00000000000
[13599.132800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[13599.132801] CR2: 0000000000000000 CR3: 000000000d00c000 CR4: 00000000000006e0
[13599.132803] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[13599.132804] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[13599.132805] Call Trace:
[13599.132813]  <TASK>
[13599.132822]  ? sched_cpu_wait_empty+0x70/0x70
[13599.132828]  cpuhp_invoke_callback+0x100/0x4a0
[13599.132832]  cpuhp_invoke_callback_range+0x3b/0x80
[13599.132835]  take_cpu_down+0x55/0x80
[13599.132837]  multi_cpu_stop+0x61/0xf0
[13599.132840]  ? stop_machine_yield+0x10/0x10
[13599.132843]  cpu_stopper_thread+0x84/0x120
[13599.132847]  smpboot_thread_fn+0x181/0x220
[13599.132851]  ? sort_range+0x20/0x20
[13599.132853]  kthread+0xe3/0x110
[13599.132857]  ? kthread_complete_and_exit+0x20/0x20
[13599.132860]  ret_from_fork+0x22/0x30
[13599.132865]  </TASK>
[13599.132866] ---[ end trace 0000000000000000 ]---
[13599.132868] CPU3 enqueued tasks (2 total):
[13599.132873]  pid: 31, name: migration/3
[13599.132883]  pid: 127, name: rcu_torture_rea

TREE03.11:

[14440.605298] ------------[ cut here ]------------
[14440.605300] Dying CPU not properly vacated!
[14440.605316] WARNING: CPU: 8 PID: 58 at kernel/sched/core.c:9494 sched_cpu_dyi
ng.cold.167+0xc/0xc3
[14440.610797] Modules linked in:
[14440.611395] CPU: 8 PID: 58 Comm: migration/8 Not tainted 5.19.0-rc3-00143-g16
22bc5a1d51-dirty #64
[14440.613116] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-1.module_el8.7.0+
1140+ff0772f9 04/01/2014
[14440.614895] Stopper: multi_cpu_stop+0x0/0xf0 <- __stop_cpus.constprop.9+0x3c/
0x80
[14440.616341] RIP: 0010:sched_cpu_dying.cold.167+0xc/0xc3
[14440.617360] Code: b9 e8 00 49 89 e8 48 8d 93 38 07 00 00 48 c7 c7 70 60 19 a8
 e8 f4 2d 00 00 e9 ed 65 49 ff 48 c7 c7 28 61 19 a8 e8 0e ee ff ff <0f> 0b 44 8b
 ab d0 09 00 00 8b 4b 04 48 c7 c6 35 0b 18 a8 48 c7 c7
[14440.620974] RSP: 0000:ffffb68a0026fd88 EFLAGS: 00010082
[14440.621990] RAX: 0000000000000000 RBX: ffffa20adf428cc0 RCX: 0000000000000003
[14440.623386] RDX: 0000000080000003 RSI: 4000000100011647 RDI: 00000000ffffffff
[14440.624770] RBP: 0000000000000086 R08: ffffffffa8455d00 R09: 727020746f6e2055
[14440.626151] R10: ffffffffa8455d00 R11: 2164657461636176 R12: ffffffffa6c9ed00
[14440.627528] R13: 0000000000000000 R14: 0000000000000000 R15: ffffb68a005bfc01
[14440.628912] FS:  0000000000000000(0000) GS:ffffa20adf400000(0000) knlGS:00000
00000000000
[14440.630479] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14440.631599] CR2: 0000000000000000 CR3: 000000001dc0c000 CR4: 00000000000006e0
[14440.632987] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[14440.634368] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[14440.635754] Call Trace:
[14440.636244]  <TASK>
[14440.636676]  ? sched_cpu_wait_empty+0x70/0x70
[14440.637529]  cpuhp_invoke_callback+0x100/0x4a0
[14440.638410]  cpuhp_invoke_callback_range+0x3b/0x80
[14440.639347]  take_cpu_down+0x55/0x80
[14440.640056]  multi_cpu_stop+0x61/0xf0
[14440.640774]  ? stop_machine_yield+0x10/0x10
[14440.641584]  cpu_stopper_thread+0x84/0x120
[14440.642386]  smpboot_thread_fn+0x181/0x220
[14440.643187]  ? sort_range+0x20/0x20
[14440.643917]  kthread+0xe3/0x110
[14440.644535]  ? kthread_complete_and_exit+0x20/0x20
[14440.645466]  ret_from_fork+0x22/0x30
[14440.646170]  </TASK>
[14440.646599] ---[ end trace 0000000000000000 ]---
[14440.647495] CPU8 enqueued tasks (2 total):
[14440.647506]  pid: 58, name: migration/8
[14440.647518]  pid: 161, name: rcu_torture_fwd

------------------------------------------------------------------------

The second of these occurred near shutdown, but the first was quite some
time before shutdown.  In case that makes a difference.

I have not seen this since.

Any other diagnostics I should add?

							Thanx, Paul
