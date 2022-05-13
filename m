Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B72526CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiEMW03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiEMW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:26:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8465A12E31B;
        Fri, 13 May 2022 15:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A78B1CE3359;
        Fri, 13 May 2022 22:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC76C34100;
        Fri, 13 May 2022 22:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652480779;
        bh=h1HTNw2Wpup2HXDg0STypuPKhlCojdqCFc87Br5/zEY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nd1cVxdwL8kFHWoZXr56OleIH1jaZKxdPeImgQT+USELFTCBpg83BO9aNa8MI9jMo
         1e9jn7UVBPnjgJA006yrm/4U878MZNkqrZPhZvXBIpTQNP3HYABUkGWTn6qSKVZ1EF
         ktVc1PgJGegp3ekxLNepp7KlyIGqcIf9fZnZX94t7c81mpwn69q6e+VCBY5rdImDMT
         vYWPvpUfKoNvQVoOTt9pHAtLY33U7gdoJwsW88BPxqfmJjHY9dtoSidqQUywCERlW9
         Neb15I+XBqcXig3MHyfAwkwv60kNgaThLPW3sy7NJRP7/1ia86rL97qHAfvfK7kvSl
         2p2aUt4fQAVhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E4735C04FD; Fri, 13 May 2022 15:26:19 -0700 (PDT)
Date:   Fri, 13 May 2022 15:26:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Message-ID: <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:03:19AM +0000, Zhang, Qiang1 wrote:
> On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> > Currently, the double call_rcu() detected only need call
> > debug_object_activate() to check whether the rcu head object is 
> > activated, the rcu head object usage state check is not necessary and 
> > when call rcu_test_debug_objects() the debug_object_active_state() 
> > will output same callstack as debug_object_activate(). so remove
> > debug_object_active_state() to reduce the output of repeated callstack.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Could you please post the output of the dmesg output of a failed check with your change?
> >
> 
> Original output:
> 
> [    0.818279] ODEBUG: activate active (active state 1) object type: rcu_head hint: 0x0
> [    0.818296] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_print_object+0xd8/0xf0
> [    0.818301] Modules linked in:
> [    0.818304] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> [    0.818306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.818308] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.818311] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <0f> f
> [    0.818313] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> [    0.818315] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    0.818317] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1020067f4c
> [    0.818319] RBP: ffff88810033fb00 R08: ffffffff9b50d898 R09: fffffbfff3bf5c6d
> [    0.818320] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 0000000000000001
> [    0.818322] R13: ffffffff9ce769a0 R14: ffffffff9d039a80 R15: 0000000000000000
> [    0.818324] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlGS:0000000000000000
> [    0.818327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.818329] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 00000000001506e0
> [    0.818330] Call Trace:
> [    0.818331]  <TASK>
> [    0.818333]  debug_object_activate+0x2b8/0x300
> [    0.818336]  ? debug_object_assert_init+0x220/0x220
> [    0.818340]  ? __kasan_check_write+0x14/0x20
> [    0.818343]  call_rcu+0x98/0x1110
> [    0.818347]  ? vprintk+0x4c/0x60
> [    0.818350]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.818354]  ? strict_work_handler+0x70/0x70
> [    0.818357]  rcu_torture_init+0x18be/0x199e
> [    0.818361]  ? srcu_init+0x133/0x133
> [    0.818364]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.818368]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818371]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818374]  ? srcu_init+0x133/0x133
> [    0.818377]  do_one_initcall+0xb3/0x300
> [    0.818380]  ? initcall_blacklisted+0x150/0x150
> [    0.818382]  ? parameq+0x70/0x90
> [    0.818385]  ? __kasan_check_read+0x11/0x20
> [    0.818389]  kernel_init_freeable+0x2b2/0x310
> [    0.818392]  ? rest_init+0xf0/0xf0
> [    0.818396]  kernel_init+0x1e/0x140
> [    0.818399]  ret_from_fork+0x22/0x30
> [    0.818402]  </TASK>
> [    0.818403] ---[ end trace 0000000000000000 ]---
> [    0.818405] ------------[ cut here ]------------
> [    0.818405] ODEBUG: active_state active (active state 1) object type: rcu_head hint: 0x0
> [    0.818421] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_print_object+0xd8/0xf0
> [    0.818424] Modules linked in:
> [    0.818426] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> [    0.818428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.818430] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.818432] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <0f> f
> [    0.818435] RSP: 0000:ffff88810033fac0 EFLAGS: 00010086
> [    0.818437] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    0.818438] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1020067f4a
> [    0.818440] RBP: ffff88810033faf0 R08: ffffffff9b50d898 R09: fffffbfff3bf5c6d
> [    0.818441] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 0000000000000001
> [    0.818443] R13: ffffffff9ce769a0 R14: ffffffff9d039820 R15: 0000000000000000
> [    0.818445] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlGS:0000000000000000
> [    0.818448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.818449] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 00000000001506e0
> [    0.818451] Call Trace:
> [    0.818452]  <TASK>
> [    0.818453]  debug_object_active_state+0x1d6/0x210
> [    0.818456]  ? debug_object_deactivate+0x210/0x210
> [    0.818460]  ? __kasan_check_write+0x14/0x20
> [    0.818464]  call_rcu+0xb7/0x1110
> [    0.818466]  ? vprintk+0x4c/0x60
> [    0.818469]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.818472]  ? strict_work_handler+0x70/0x70
> [    0.818476]  rcu_torture_init+0x18be/0x199e
> [    0.818479]  ? srcu_init+0x133/0x133
> [    0.818482]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.818486]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818489]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818492]  ? srcu_init+0x133/0x133
> [    0.818495]  do_one_initcall+0xb3/0x300
> [    0.818497]  ? initcall_blacklisted+0x150/0x150
> [    0.818500]  ? parameq+0x70/0x90
> [    0.818503]  ? __kasan_check_read+0x11/0x20
> [    0.818507]  kernel_init_freeable+0x2b2/0x310
> [    0.818510]  ? rest_init+0xf0/0xf0
> [    0.818513]  kernel_init+0x1e/0x140
> [    0.818515]  ret_from_fork+0x22/0x30
> [    0.818519]  </TASK>
> [    0.818520] ---[ end trace 0000000000000000 ]---
> [    0.818521] rcu: call_rcu(): Double-freed CB 00000000e2817fcb->rcu_torture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> 
> 
> After apply this patch:
> 
> [    0.647048] ODEBUG: activate active (active state 0) object type: rcu_head hint: 0x0
> [    0.647068] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_print_object+0xd8/0xf0
> [    0.647073] Modules linked in:
> [    0.647075] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.18.0-rc6-next-20220511-yoctodev-standard+ #77
> [    0.647078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.647080] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.647083] Code: dd 80 9d 43 a2 e8 38 62 a2 ff 4d 89 f9 4d 89 e8 44 89 e1 48 8b 14 dd 80 9d 43 a2 4c 89 f6 48 c7 c7 00 93 43 a2 e8 f6 1a b1 00 <0f> 0b 83 05 7b 62f
> [    0.647085] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> [    0.647088] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [    0.647090] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1020067f4c
> [    0.647091] RBP: ffff88810033fb00 R08: ffffffffa090d898 R09: fffffbfff467586d
> [    0.647093] R10: 0000000000000003 R11: fffffbfff467586c R12: 0000000000000000
> [    0.647095] R13: ffffffffa22769a0 R14: ffffffffa24399c0 R15: 0000000000000000
> [    0.647097] FS:  0000000000000000(0000) GS:ffff88815b880000(0000) knlGS:0000000000000000
> [    0.647100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.647102] CR2: 0000000000000000 CR3: 000000002f20e000 CR4: 00000000001506e0
> [    0.647104] Call Trace:
> [    0.647104]  <TASK>
> [    0.647106]  debug_object_activate+0x2b8/0x300
> [    0.647110]  ? debug_object_assert_init+0x220/0x220
> [    0.647114]  ? __kasan_check_write+0x14/0x20
> [    0.647118]  call_rcu+0x98/0x1100
> [    0.647121]  ? vprintk+0x4c/0x60
> [    0.647125]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.647129]  ? strict_work_handler+0x50/0x50
> [    0.647133]  rcu_torture_init+0x18be/0x199e
> [    0.647136]  ? srcu_init+0x133/0x133
> [    0.647140]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.647144]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.647148]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.647151]  ? srcu_init+0x133/0x133
> [    0.647155]  do_one_initcall+0xb3/0x300
> [    0.647157]  ? initcall_blacklisted+0x150/0x150
> [    0.647160]  ? parameq+0x70/0x90
> [    0.647164]  ? __kasan_check_read+0x11/0x20
> [    0.647167]  kernel_init_freeable+0x2b2/0x310
> [    0.647171]  ? rest_init+0xf0/0xf0
> [    0.647174]  kernel_init+0x1e/0x140
> [    0.647177]  ret_from_fork+0x22/0x30
> [    0.647181]  </TASK>
> [    0.647182] ---[ end trace 0000000000000000 ]---
> [    0.647184] rcu: call_rcu(): Double-freed CB 000000009a684b70->rcu_torture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory

Very good, and thank you!

Now suppose that someone passes a pointer to call_rcu(), but then
invokes kfree() on that same object before the grace period ends.
Is the offending kfree() flagged?

							Thanx, Paul

> Thanks,
> Zqiang
> 
> 
> 
> >							Thanx, Paul
> >
> > ---
> >  kernel/rcu/rcu.h | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index 
> > 15b96f990774..0604ecd16627 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsigned long new, unsigned long old)
> >   */
> >  
> >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > -# define STATE_RCU_HEAD_READY	0
> > -# define STATE_RCU_HEAD_QUEUED	1
> >  
> >  extern const struct debug_obj_descr rcuhead_debug_descr;
> >  
> >  static inline int debug_rcu_head_queue(struct rcu_head *head)  {
> > -	int r1;
> > -
> > -	r1 = debug_object_activate(head, &rcuhead_debug_descr);
> > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > -				  STATE_RCU_HEAD_READY,
> > -				  STATE_RCU_HEAD_QUEUED);
> > -	return r1;
> > +	return debug_object_activate(head, &rcuhead_debug_descr);
> >  }
> >  
> >  static inline void debug_rcu_head_unqueue(struct rcu_head *head)  {
> > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > -				  STATE_RCU_HEAD_QUEUED,
> > -				  STATE_RCU_HEAD_READY);
> >  	debug_object_deactivate(head, &rcuhead_debug_descr);  }
> >  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > --
> > 2.25.1
> > 
