Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB9522BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiEKF5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiEKF5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:57:36 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6533C15E772
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:57:35 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id s15so79947wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kMDztchsvO2FrBXhxgQY/C7tNeRj0xaJEBJWMd3x/C8=;
        b=WLi05ZX+IbrWmFjHlphrsvjWlFZjamacvicx+L/k+1sKy6UZNJXhFcKZOo57hUULQl
         K3EKq6kQ0FQyrcMUgFuac5OFAfMG+TjHZpYCBBgR233qWvQT5W5sVxhsqTRwpY0cLSgk
         TeYXCIYDcGKMb/yLkuyKyciEggawqWAvjQh3Ir4m4pbrq9KgMOKgPnJ7VAB4TWBtGz8C
         azQ7aDdKV8uu4SqfRqp8vXiWebuu4JaWjFApIScDhmHHftOw8ufskdkoOxLTER1tqkFR
         FXtfvxaQjU2LJSUxLVMwFhmYCIjjnQYWoIdHUAY7BvRaLAawDCA00MmrR/Cz+EFJXZYI
         2dmw==
X-Gm-Message-State: AOAM530V8X4MBVYxvHm+A6pV/sFO/txMdZ0ODzYol76QrgwOTAI2Th0n
        urcKqLCFCCWtUwOOGIARMZ34zy64q93OzQ==
X-Google-Smtp-Source: ABdhPJxwJYLB4kkcZ17CJt+h9SfktWQ+yMtY209mA79KlFUnWSlD3Ysj2hEaU4nf6jpznnlyUbbA/w==
X-Received: by 2002:a5d:620f:0:b0:20c:c1ba:cf8e with SMTP id y15-20020a5d620f000000b0020cc1bacf8emr13189468wru.426.1652248653609;
        Tue, 10 May 2022 22:57:33 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b003942a244ed2sm1245471wmb.23.2022.05.10.22.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 22:57:32 -0700 (PDT)
Message-ID: <6acd7332-12f6-13ff-f830-973993aace55@kernel.org>
Date:   Wed, 11 May 2022 07:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] tty: fix deadlock caused by calling printk() under
 tty_port->lock
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akinobu.mita@gmail.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        gregkh@linuxfoundation.org, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
 <20220510113809.80626-2-zhengqi.arch@bytedance.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220510113809.80626-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

LGTM:
Acked-by: Jiri Slaby <jirislaby@kernel.org>

Minor comments below.

On 10. 05. 22, 13:38, Qi Zheng wrote:
> The pty_write() invokes kmalloc() which may invoke a normal printk() to
> print failure message. This can cause a deadlock in the scenario reported
> by syz-bot below:
> 
>         CPU0              CPU1                    CPU2
>         ----              ----                    ----
>                           lock(console_owner);
>                                                   lock(&port_lock_key);
>    lock(&port->lock);
>                           lock(&port_lock_key);
>                                                   lock(&port->lock);
>    lock(console_owner);
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

Maybe trim the stack traces a bit, the commit message is unnecessarily 
long...

> -> #2 (&port->lock){-.-.}-{2:2}:
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
>         tty_port_tty_get drivers/tty/tty_port.c:288 [inline]          		<-- lock(&port->lock);
>         tty_port_default_wakeup+0x1d/0xb0 drivers/tty/tty_port.c:47
>         serial8250_tx_chars+0x530/0xa80 drivers/tty/serial/8250/8250_port.c:1767
>         serial8250_handle_irq.part.0+0x31f/0x3d0 drivers/tty/serial/8250/8250_port.c:1854
>         serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1827 [inline] 	<-- lock(&port_lock_key);
>         serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1870
>         serial8250_interrupt+0xfd/0x200 drivers/tty/serial/8250/8250_core.c:126
>         __handle_irq_event_percpu+0x109/0xa50 kernel/irq/handle.c:156

Stop this trace here and trim the rest?

>         handle_irq_event_percpu+0x76/0x170 kernel/irq/handle.c:196
>         handle_irq_event+0xa1/0x130 kernel/irq/handle.c:213
>         handle_edge_irq+0x261/0xd00 kernel/irq/chip.c:833
>         generic_handle_irq_desc include/linux/irqdesc.h:156 [inline]
>         do_IRQ+0xf2/0x2e0 arch/x86/kernel/irq.c:250
>         ret_from_intr+0x0/0x19
>         native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
>         arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
>         default_idle+0x2c/0x1a0 arch/x86/kernel/process.c:572
>         cpuidle_idle_call kernel/sched/idle.c:184 [inline]
>         do_idle+0x44c/0x590 kernel/sched/idle.c:294
>         cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:386
>         start_secondary+0x2d1/0x3e0 arch/x86/kernel/smpboot.c:264
>         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
> 
> -> #1 (&port_lock_key){-.-.}-{2:2}:
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
>         serial8250_console_write+0x184/0xa40 drivers/tty/serial/8250/8250_port.c:3198
> 										<-- lock(&port_lock_key);
>         call_console_drivers kernel/printk/printk.c:1819 [inline]
>         console_unlock+0x8cb/0xd00 kernel/printk/printk.c:2504
>         vprintk_emit+0x1b5/0x470 kernel/printk/printk.c:2024			<-- lock(console_owner);
>         vprintk_func+0x8d/0x250 kernel/printk/printk_safe.c:394
>         printk+0xba/0xed kernel/printk/printk.c:2084
>         register_console+0x8b3/0xc10 kernel/printk/printk.c:2829
>         univ8250_console_init+0x3a/0x46 drivers/tty/serial/8250/8250_core.c:681
>         console_init+0x49d/0x6d3 kernel/printk/printk.c:2915
>         start_kernel+0x5e9/0x879 init/main.c:713
>         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
> 
> -> #0 (console_owner){....}-{0:0}:
>         check_prev_add kernel/locking/lockdep.c:2600 [inline]
>         check_prevs_add kernel/locking/lockdep.c:2705 [inline]
>         validate_chain kernel/locking/lockdep.c:3095 [inline]
>         __lock_acquire+0x27e6/0x4cc0 kernel/locking/lockdep.c:4200

Delete the above 4 lines?

>         lock_acquire+0x127/0x340 kernel/locking/lockdep.c:4734
>         console_trylock_spinning kernel/printk/printk.c:1773 [inline]		<-- lock(console_owner);
>         vprintk_emit+0x307/0x470 kernel/printk/printk.c:2023
>         vprintk_func+0x8d/0x250 kernel/printk/printk_safe.c:394
>         printk+0xba/0xed kernel/printk/printk.c:2084
>         fail_dump lib/fault-inject.c:45 [inline]
>         should_fail+0x67b/0x7c0 lib/fault-inject.c:144
>         __should_failslab+0x152/0x1c0 mm/failslab.c:33
>         should_failslab+0x5/0x10 mm/slab_common.c:1224
>         slab_pre_alloc_hook mm/slab.h:468 [inline]
>         slab_alloc_node mm/slub.c:2723 [inline]
>         slab_alloc mm/slub.c:2807 [inline]
>         __kmalloc+0x72/0x300 mm/slub.c:3871
>         kmalloc include/linux/slab.h:582 [inline]
>         tty_buffer_alloc+0x23f/0x2a0 drivers/tty/tty_buffer.c:175
>         __tty_buffer_request_room+0x156/0x2a0 drivers/tty/tty_buffer.c:273
>         tty_insert_flip_string_fixed_flag+0x93/0x250 drivers/tty/tty_buffer.c:318
>         tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
>         pty_write+0x126/0x1f0 drivers/tty/pty.c:122				<-- lock(&port->lock);
>         n_tty_write+0xa7a/0xfc0 drivers/tty/n_tty.c:2356
>         do_tty_write drivers/tty/tty_io.c:961 [inline]
>         tty_write+0x512/0x930 drivers/tty/tty_io.c:1045
>         __vfs_write+0x76/0x100 fs/read_write.c:494

And stop here?

>         vfs_write+0x268/0x5c0 fs/read_write.c:558
>         ksys_write+0x12d/0x250 fs/read_write.c:611
>         do_syscall_64+0xd7/0x380 arch/x86/entry/common.c:291
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    console_owner --> &port_lock_key --> &port->lock
> 
> Fixes: b6da31b2c07c ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   drivers/tty/tty_buffer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 646510476c30..bfa431a8e690 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -175,7 +175,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>   	 */
>   	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>   		return NULL;
> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
> +		    GFP_ATOMIC | __GFP_NOWARN);
>   	if (p == NULL)
>   		return NULL;
>   


-- 
js
suse labs
