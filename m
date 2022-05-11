Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133A5522CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbiEKGvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbiEKGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151AB263A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51682617FE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55530C385DB;
        Wed, 11 May 2022 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652251848;
        bh=EPtahW9l/Zi0zg2ZV5hZKf+m/NZbM7cRdmVPxgPKIEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=warw4ZV9i+HysSVjSdhNrjzEae4jlsW9+PDmVi2v5/q3+ZItWy8I/CE71a2exbAnd
         DJZIaKkmWhmUIBby4O+XH/Qp5Mv1y+s2NOiPu4bgqvkzUeiYcUoQQKHVhL/V0KweLW
         lNO/mBZIdbh+pB+8ucK6ZjSCuxAxlkoHlwCy3sa8=
Date:   Wed, 11 May 2022 08:50:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        akinobu.mita@gmail.com, vbabka@suse.cz, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] tty: fix deadlock caused by calling printk()
 under tty_port->lock
Message-ID: <YntcxUckMqEp1a2c@kroah.com>
References: <20220511061951.1114-1-zhengqi.arch@bytedance.com>
 <20220511061951.1114-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511061951.1114-2-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:19:51PM +0800, Qi Zheng wrote:
> The pty_write() invokes kmalloc() which may invoke a normal printk() to
> print failure message. This can cause a deadlock in the scenario reported
> by syz-bot below:
> 
>        CPU0              CPU1                    CPU2
>        ----              ----                    ----
>                          lock(console_owner);
>                                                  lock(&port_lock_key);
>   lock(&port->lock);
>                          lock(&port_lock_key);
>                                                  lock(&port->lock);
>   lock(console_owner);
> 
> As commit dbdda842fe96 ("printk: Add console owner and waiter logic to
> load balance console writes") said, such deadlock can be prevented by
> using printk_deferred() in kmalloc() (which is invoked in the section
> guarded by the port->lock). But there are too many printk() on the
> kmalloc() path, and kmalloc() can be called from anywhere, so changing
> printk() to printk_deferred() is too complicated and inelegant.
> 
> Therefore, this patch chooses to specify __GFP_NOWARN to kmalloc(), so
> that printk() will not be called, and this deadlock problem can be avoided.
> 
> Syz-bot reported the following lockdep error:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.4.143-00237-g08ccc19a-dirty #10 Not tainted
> ------------------------------------------------------
> syz-executor.4/29420 is trying to acquire lock:
> ffffffff8aedb2a0 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1752 [inline]
> ffffffff8aedb2a0 (console_owner){....}-{0:0}, at: vprintk_emit+0x2ca/0x470 kernel/printk/printk.c:2023
> 
> but task is already holding lock:
> ffff8880119c9158 (&port->lock){-.-.}-{2:2}, at: pty_write+0xf4/0x1f0 drivers/tty/pty.c:120
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&port->lock){-.-.}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
>        tty_port_tty_get drivers/tty/tty_port.c:288 [inline]          		<-- lock(&port->lock);
>        tty_port_default_wakeup+0x1d/0xb0 drivers/tty/tty_port.c:47
>        serial8250_tx_chars+0x530/0xa80 drivers/tty/serial/8250/8250_port.c:1767
>        serial8250_handle_irq.part.0+0x31f/0x3d0 drivers/tty/serial/8250/8250_port.c:1854
>        serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1827 [inline] 	<-- lock(&port_lock_key);
>        serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1870
>        serial8250_interrupt+0xfd/0x200 drivers/tty/serial/8250/8250_core.c:126
>        __handle_irq_event_percpu+0x109/0xa50 kernel/irq/handle.c:156
>        [...]
> 
> -> #1 (&port_lock_key){-.-.}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
>        serial8250_console_write+0x184/0xa40 drivers/tty/serial/8250/8250_port.c:3198
> 										<-- lock(&port_lock_key);
>        call_console_drivers kernel/printk/printk.c:1819 [inline]
>        console_unlock+0x8cb/0xd00 kernel/printk/printk.c:2504
>        vprintk_emit+0x1b5/0x470 kernel/printk/printk.c:2024			<-- lock(console_owner);
>        vprintk_func+0x8d/0x250 kernel/printk/printk_safe.c:394
>        printk+0xba/0xed kernel/printk/printk.c:2084
>        register_console+0x8b3/0xc10 kernel/printk/printk.c:2829
>        univ8250_console_init+0x3a/0x46 drivers/tty/serial/8250/8250_core.c:681
>        console_init+0x49d/0x6d3 kernel/printk/printk.c:2915
>        start_kernel+0x5e9/0x879 init/main.c:713
>        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
> 
> -> #0 (console_owner){....}-{0:0}:
>        [...]
>        lock_acquire+0x127/0x340 kernel/locking/lockdep.c:4734
>        console_trylock_spinning kernel/printk/printk.c:1773 [inline]		<-- lock(console_owner);
>        vprintk_emit+0x307/0x470 kernel/printk/printk.c:2023
>        vprintk_func+0x8d/0x250 kernel/printk/printk_safe.c:394
>        printk+0xba/0xed kernel/printk/printk.c:2084
>        fail_dump lib/fault-inject.c:45 [inline]
>        should_fail+0x67b/0x7c0 lib/fault-inject.c:144
>        __should_failslab+0x152/0x1c0 mm/failslab.c:33
>        should_failslab+0x5/0x10 mm/slab_common.c:1224
>        slab_pre_alloc_hook mm/slab.h:468 [inline]
>        slab_alloc_node mm/slub.c:2723 [inline]
>        slab_alloc mm/slub.c:2807 [inline]
>        __kmalloc+0x72/0x300 mm/slub.c:3871
>        kmalloc include/linux/slab.h:582 [inline]
>        tty_buffer_alloc+0x23f/0x2a0 drivers/tty/tty_buffer.c:175
>        __tty_buffer_request_room+0x156/0x2a0 drivers/tty/tty_buffer.c:273
>        tty_insert_flip_string_fixed_flag+0x93/0x250 drivers/tty/tty_buffer.c:318
>        tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
>        pty_write+0x126/0x1f0 drivers/tty/pty.c:122				<-- lock(&port->lock);
>        n_tty_write+0xa7a/0xfc0 drivers/tty/n_tty.c:2356
>        do_tty_write drivers/tty/tty_io.c:961 [inline]
>        tty_write+0x512/0x930 drivers/tty/tty_io.c:1045
>        __vfs_write+0x76/0x100 fs/read_write.c:494
>        [...]
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   console_owner --> &port_lock_key --> &port->lock
> 
> Fixes: b6da31b2c07c ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Jiri Slaby <jirislaby@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
