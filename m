Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47C522C46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiEKGZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiEKGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:25:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01032388C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:25:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 204so1145226pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xqUeZSfFoD6B5kZdRq/wUMJ5p46IreYNcpd8QMwJ/ss=;
        b=dvelAgCcrQ1VVy9kRMtgscsMdb4GQoa6ml90Wv250MAwUPvYajKQ1ShEnzzqEyq8Xx
         XLq226gPI7QW/MkkWCEknwZNexkRdnA/MAjAjYnDxIRTGw1pQzsWGXNwf7pPQgqZUaQK
         tbFOYjUPUzSRZjFPhx2VhjDQiWh7/IT7iXKSENnvDiHkM2I7vnFlVHUNEv31roHYncu+
         WPjdzkC7QvtT0zar72967sbOfbEYb8Cgw47tZRRn5ZdcCeK91x0fHVvFTFf/eKRkhq2j
         dZto3hcoUzViIGki5xqYdp4oPKpb7zDgzKR6mBC6heAS7gzNRAalQdrvGjBG2IYKm9k5
         8eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xqUeZSfFoD6B5kZdRq/wUMJ5p46IreYNcpd8QMwJ/ss=;
        b=5T9kQcUtOC1igJ6rGKkcZMqB87ZSrArjJ1xBZ+iuLi7QOpEK90892CYk4NFXTCMlS4
         m04f6l5SJ3GqQ9wifAT7H3pFHDeu2anHvOHnoxh5RynpW4++4bkncqOqXtz4YtoUKTw+
         vHIuUwjAD/bNZWizeYyLqVqpOFo/GxxTdnLW7T+Jjb3XGVSj5ZGZqbAPxIg+3At2gCrq
         XYYKGX+vffYUUmMLAUZCoGUK4zfOk35SUuWiiWY4QGpMfKrQEBsrvNBxlERHaJHccOZo
         WjisDGa0X9x+lCiwfQzFIsnMAWovNAFRUrSgFHJQd7RwVVI8IkcGJExn8sfFg3vOJZKV
         vF2Q==
X-Gm-Message-State: AOAM531Wwk+FQjpnBIm/pZJKhyJbxPS105w9YQn2OwfdG0y8AJ0Wm5F9
        5rgMtXXmZTfncLKRVtCodvPrLYtrbR+Y4Q==
X-Google-Smtp-Source: ABdhPJxuVSjw05EoAdnPOXoCOx+m9JfxxDZzyE/iUA7/m/nmsyPpNL2FbpCq9WONmh97j/Y+CBb6cA==
X-Received: by 2002:a63:751d:0:b0:3db:2e7b:f93 with SMTP id q29-20020a63751d000000b003db2e7b0f93mr790609pgc.496.1652250340495;
        Tue, 10 May 2022 23:25:40 -0700 (PDT)
Received: from [10.254.203.126] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id z65-20020a623344000000b0050dc7628155sm691725pfz.47.2022.05.10.23.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:25:40 -0700 (PDT)
Message-ID: <53eeae64-4be4-9cdd-77f8-0f51ebf6f907@bytedance.com>
Date:   Wed, 11 May 2022 14:25:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] tty: fix deadlock caused by calling printk() under
 tty_port->lock
Content-Language: en-US
To:     akpm@linux-foundation.org, jirislaby@kernel.org,
        akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220511061951.1114-1-zhengqi.arch@bytedance.com>
 <20220511061951.1114-2-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220511061951.1114-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/11 2:19 PM, Qi Zheng wrote:
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
> 
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
>         [...]
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
>         [...]
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
>         [...]
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    console_owner --> &port_lock_key --> &port->lock
> 
> Fixes: b6da31b2c07c ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Jiri Slaby <jirislaby@kernel.org>
> ---

Changelog in v1 -> v2:
  - Update commit log

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
Thanks,
Qi
