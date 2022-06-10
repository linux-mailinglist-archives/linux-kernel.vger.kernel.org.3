Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15554661F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347278AbiFJL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbiFJLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:55:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4479F301;
        Fri, 10 Jun 2022 04:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB52DB834DC;
        Fri, 10 Jun 2022 11:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F31CC34114;
        Fri, 10 Jun 2022 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654862155;
        bh=q7IRaOcR5N0y4hQ7ul3oj3HKBb/4yIpXXBgpN69y+P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzwmgEiZFFNA+TrqjBWL6C5BfOw2x+48EXK1lfJkATaemiSWtRAK+5cQb/K4YrJj9
         16J6dYCEDwinAucQcLLiZL1k3XqBlcwmkBcYJNHGrTVnZJQJPTdUxhy1DOmlvQJNbZ
         DomPsKZ9OJckCguljg5yLWxzaEmOMZd3rp4VrPHc=
Date:   Fri, 10 Jun 2022 13:55:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Message-ID: <YqMxSQIvHbl/ofWB@kroah.com>
References: <20220530144512.2731-1-daniel.starke@siemens.com>
 <20220530144512.2731-6-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530144512.2731-6-daniel.starke@siemens.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:45:09PM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> The current implementation queues up new control and user packets as needed
> and processes this queue down to the ldisc in the same code path.
> That means that the upper and the lower layer are hard coupled in the code.
> Due to this deadlocks can happen as seen below while transmitting data,
> especially during ldisc congestion. Furthermore, the data channels starve
> the control channel on high transmission load on the ldisc.
> 
> Introduce an additional control channel data queue to prevent timeouts and
> link hangups during ldisc congestion. This is being processed before the
> user channel data queue in gsm_data_kick(), i.e. with the highest priority.
> Put the queue to ldisc data path into a workqueue and trigger it whenever
> new data has been put into the transmission queue. Change
> gsm_dlci_data_sweep() accordingly to fill up the transmission queue until
> TX_THRESH_HI. This solves the locking issue, keeps latency low and provides
> good performance on high data load.
> Note that now all packets from a DLCI are removed from the internal queue
> if the associated DLCI was closed. This ensures that no data is sent by the
> introduced write task to an already closed DLCI.
> 
> BUG: spinlock recursion on CPU#0, test_v24_loop/124
>  lock: serial8250_ports+0x3a8/0x7500, .magic: dead4ead, .owner: test_v24_loop/124, .owner_cpu: 0
> CPU: 0 PID: 124 Comm: test_v24_loop Tainted: G           O      5.18.0-rc2 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x34/0x44
>  do_raw_spin_lock+0x76/0xa0
>  _raw_spin_lock_irqsave+0x72/0x80
>  uart_write_room+0x3b/0xc0
>  gsm_data_kick+0x14b/0x240 [n_gsm]
>  gsmld_write_wakeup+0x35/0x70 [n_gsm]
>  tty_wakeup+0x53/0x60
>  tty_port_default_wakeup+0x1b/0x30
>  serial8250_tx_chars+0x12f/0x220
>  serial8250_handle_irq.part.0+0xfe/0x150
>  serial8250_default_handle_irq+0x48/0x80
>  serial8250_interrupt+0x56/0xa0
>  __handle_irq_event_percpu+0x78/0x1f0
>  handle_irq_event+0x34/0x70
>  handle_fasteoi_irq+0x90/0x1e0
>  __common_interrupt+0x69/0x100
>  common_interrupt+0x48/0xc0
>  asm_common_interrupt+0x1e/0x40
> RIP: 0010:__do_softirq+0x83/0x34e
> Code: 2a 0a ff 0f b7 ed c7 44 24 10 0a 00 00 00 48 c7 c7 51 2a 64 82 e8 2d
> e2 d5 ff 65 66 c7 05 83 af 1e 7e 00 00 fb b8 ff ff ff ff <49> c7 c2 40 61
> 80 82 0f bc c5 41 89 c4 41 83 c4 01 0f 84 e6 00 00
> RSP: 0018:ffffc90000003f98 EFLAGS: 00000286
> RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff82642a51 RDI: ffffffff825bb5e7
> RBP: 0000000000000200 R08: 00000008de3271a8 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000030 R14: 0000000000000000 R15: 0000000000000000
>  ? __do_softirq+0x73/0x34e
>  irq_exit_rcu+0xb5/0x100
>  common_interrupt+0xa4/0xc0
>  </IRQ>
>  <TASK>
>  asm_common_interrupt+0x1e/0x40
> RIP: 0010:_raw_spin_unlock_irqrestore+0x2e/0x50
> Code: 00 55 48 89 fd 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 85 28 36 ff
> 48 89 ef e8 cd 58 36 ff 80 e7 02 74 01 fb bf 01 00 00 00 <e8> 3d 97 33 ff
> 65 8b 05 96 23 2b 7e 85 c0 74 03 5b 5d c3 0f 1f 44
> RSP: 0018:ffffc9000020fd08 EFLAGS: 00000202
> RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000000000
> RDX: 0000000000000004 RSI: ffffffff8257fd74 RDI: 0000000000000001
> RBP: ffff8880057de3a0 R08: 00000008de233000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000100 R14: 0000000000000202 R15: ffff8880057df0b8
>  ? _raw_spin_unlock_irqrestore+0x23/0x50
>  gsmtty_write+0x65/0x80 [n_gsm]
>  n_tty_write+0x33f/0x530
>  ? swake_up_all+0xe0/0xe0
>  file_tty_write.constprop.0+0x1b1/0x320
>  ? n_tty_flush_buffer+0xb0/0xb0
>  new_sync_write+0x10c/0x190
>  vfs_write+0x282/0x310
>  ksys_write+0x68/0xe0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f3e5e35c15c
> Code: 8b 7c 24 08 89 c5 e8 c5 ff ff ff 89 ef 89 44 24 08 e8 58 bc 02 00 8b
> 44 24 08 48 83 c4 10 5d c3 48 63 ff b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff
> ff 76 10 48 8b 15 fd fc 05 00 f7 d8 64 89 02 48 83
> RSP: 002b:00007ffcee77cd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffcee77cd70 RCX: 00007f3e5e35c15c
> RDX: 0000000000000100 RSI: 00007ffcee77cd90 RDI: 0000000000000003
> RBP: 0000000000000100 R08: 0000000000000000 R09: 7efefefefefefeff
> R10: 00007f3e5e3bddeb R11: 0000000000000246 R12: 00007ffcee77ce8f
> R13: 0000000000000001 R14: 000056214404e010 R15: 00007ffcee77cd90
>  </TASK>
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 410 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 280 insertions(+), 130 deletions(-)

This is a bit huge for stable backports, especially given that a huge
number of the previous stable backports have totally failed and no one
has submitted new versions.

So why is this needed for stable?  Same for all of these in the
series...

thanks,

greg k-h
