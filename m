Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C075522C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbiEKGLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiEKGLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:11:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DD1CFF1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:11:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v11so1108997pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7zEvnuaMSilFdVX7eugwhAowLbX45gPNjgjh1KdksyA=;
        b=swI8EyBGd0/VuYvZ0BIZQ9tsqrVM55TP4B6VZWHV4gBVv6o+47782YF8kwB8qUygYa
         JRMwuTbCXxvxBP3jD+o60vybViaK9CuqJsVkHwJ8CckPxVEDbeqsjeIo4pSdImBtZK8H
         Pwy7hWVCM/POt8QPWhdhrbLJgVF2+N8id7gQ90l5Tyw2pp4hKuccOEhAmRXYLKNFQU4g
         Juip73NDdU96oSeYlA5A8xyqldNdKXXbflkMC5x5yyOeDGOfi4+b8UI4d9QmQm+FE4d+
         gMZpASzhcXAHngpP6VcRpYaxd3/+hKsj7VTnQLpSbfR4CRcWBLvgHeYQR9BXfpQDk/pM
         6DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7zEvnuaMSilFdVX7eugwhAowLbX45gPNjgjh1KdksyA=;
        b=IJvVztZL9KHx5nFVr2fNLHWoywUwz6bsqDldqt+hbG5fJA0t8ch6NQX1UcQexW8a+O
         W1olmtZSghsffvgLcJ82NHWNyXRnS/mN9Q/ihOfxx3wU8qqC0SJgUbMaDBPrGzQzS+7P
         uBAcmX8GNGV+vxZkLoxI+5sjiWp/2+dUIK7bkUc1C5cayES+08xjQxw/CUrR5SiCPVQc
         8R10+xK44ZQcpi0Szl+DcZO/+FCvXTJNXSqR9ZRQr/LJAqBt5PITq1B+Agz6wKpkEf39
         +lCrPgRTL/PfVr9vRKEmPgv/WSabq5kbPESW4perRCQ1psYnKBijfZt94P6G4S85vUgU
         tgBg==
X-Gm-Message-State: AOAM5318stMrsYAXbelSCxPD0WVrp9G9ir5gWj4Jdl7T+4lB/gXhfkB5
        MP1fy6wmmjo9F/IPQJ3SgPfci7BpOYvxpw==
X-Google-Smtp-Source: ABdhPJw9B0lPuQr9xIwwjXFaBgCTlo3C6FzcAqtLTWAY3WUjU4OQEGOOx5pKZhyBNRJ/1T+zcOaQJQ==
X-Received: by 2002:a63:8948:0:b0:3da:ec12:1b1c with SMTP id v69-20020a638948000000b003daec121b1cmr5187475pgd.598.1652249501671;
        Tue, 10 May 2022 23:11:41 -0700 (PDT)
Received: from [10.254.203.126] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm649983pfo.74.2022.05.10.23.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:11:41 -0700 (PDT)
Message-ID: <5c9d44c1-7d8d-d955-500b-865a16c60eb6@bytedance.com>
Date:   Wed, 11 May 2022 14:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] tty: fix deadlock caused by calling printk() under
 tty_port->lock
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, akinobu.mita@gmail.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        gregkh@linuxfoundation.org, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
 <20220510113809.80626-2-zhengqi.arch@bytedance.com>
 <6acd7332-12f6-13ff-f830-973993aace55@kernel.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6acd7332-12f6-13ff-f830-973993aace55@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/11 1:57 PM, Jiri Slaby wrote:
> Hi,
> 
> LGTM:
> Acked-by: Jiri Slaby <jirislaby@kernel.org>

Thanks.

> 
> Minor comments below.
> 
> On 10. 05. 22, 13:38, Qi Zheng wrote:
>> The pty_write() invokes kmalloc() which may invoke a normal printk() to
>> print failure message. This can cause a deadlock in the scenario reported
>> by syz-bot below:
>>
>>         CPU0              CPU1                    CPU2
>>         ----              ----                    ----
>>                           lock(console_owner);
>>                                                   lock(&port_lock_key);
>>    lock(&port->lock);
>>                           lock(&port_lock_key);
>>                                                   lock(&port->lock);
>>    lock(console_owner);
>>
>> As commit dbdda842fe96 ("printk: Add console owner and waiter logic to
>> load balance console writes") said, such deadlock can be prevented by
>> using printk_deferred() in kmalloc() (which is invoked in the section
>> guarded by the port->lock). But there are too many printk() on the
>> kmalloc() path, and kmalloc() can be called from anywhere, so changing
>> printk() to printk_deferred() is too complicated and inelegant.
>>
>> Therefore, this patch chooses to specify __GFP_NOWARN to kmalloc(), so
>> that printk() will not be called, and this deadlock problem can be 
>> avoided.
>>
>> Syz-bot reported the following lockdep error:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.4.143-00237-g08ccc19a-dirty #10 Not tainted
>> ------------------------------------------------------
>> syz-executor.4/29420 is trying to acquire lock:
>> ffffffff8aedb2a0 (console_owner){....}-{0:0}, at: 
>> console_trylock_spinning kernel/printk/printk.c:1752 [inline]
>> ffffffff8aedb2a0 (console_owner){....}-{0:0}, at: 
>> vprintk_emit+0x2ca/0x470 kernel/printk/printk.c:2023
>>
>> but task is already holding lock:
>> ffff8880119c9158 (&port->lock){-.-.}-{2:2}, at: pty_write+0xf4/0x1f0 
>> drivers/tty/pty.c:120
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
> 
> Maybe trim the stack traces a bit, the commit message is unnecessarily 
> long...

Agree, will do.

> 
>> -> #2 (&port->lock){-.-.}-{2:2}:
>>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 
>> [inline]
>>         _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
>>         tty_port_tty_get drivers/tty/tty_port.c:288 
>> [inline]                  <-- lock(&port->lock);
>>         tty_port_default_wakeup+0x1d/0xb0 drivers/tty/tty_port.c:47
>>         serial8250_tx_chars+0x530/0xa80 
>> drivers/tty/serial/8250/8250_port.c:1767
>>         serial8250_handle_irq.part.0+0x31f/0x3d0 
>> drivers/tty/serial/8250/8250_port.c:1854
>>         serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1827 
>> [inline]     <-- lock(&port_lock_key);
>>         serial8250_default_handle_irq+0xb2/0x220 
>> drivers/tty/serial/8250/8250_port.c:1870
>>         serial8250_interrupt+0xfd/0x200 
>> drivers/tty/serial/8250/8250_core.c:126
>>         __handle_irq_event_percpu+0x109/0xa50 kernel/irq/handle.c:156
> 
> Stop this trace here and trim the rest?

Will do.

> 
>>         handle_irq_event_percpu+0x76/0x170 kernel/irq/handle.c:196
>>         handle_irq_event+0xa1/0x130 kernel/irq/handle.c:213
>>         handle_edge_irq+0x261/0xd00 kernel/irq/chip.c:833
>>         generic_handle_irq_desc include/linux/irqdesc.h:156 [inline]
>>         do_IRQ+0xf2/0x2e0 arch/x86/kernel/irq.c:250
>>         ret_from_intr+0x0/0x19
>>         native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
>>         arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
>>         default_idle+0x2c/0x1a0 arch/x86/kernel/process.c:572
>>         cpuidle_idle_call kernel/sched/idle.c:184 [inline]
>>         do_idle+0x44c/0x590 kernel/sched/idle.c:294
>>         cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:386
>>         start_secondary+0x2d1/0x3e0 arch/x86/kernel/smpboot.c:264
>>         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
>>
>> -> #1 (&port_lock_key){-.-.}-{2:2}:
>>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 
>> [inline]
>>         _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
>>         serial8250_console_write+0x184/0xa40 
>> drivers/tty/serial/8250/8250_port.c:3198
>>                                         <-- lock(&port_lock_key);
>>         call_console_drivers kernel/printk/printk.c:1819 [inline]
>>         console_unlock+0x8cb/0xd00 kernel/printk/printk.c:2504
>>         vprintk_emit+0x1b5/0x470 
>> kernel/printk/printk.c:2024            <-- lock(console_owner);
>>         vprintk_func+0x8d/0x250 kernel/printk/printk_safe.c:394
>>         printk+0xba/0xed kernel/printk/printk.c:2084
>>         register_console+0x8b3/0xc10 kernel/printk/printk.c:2829
>>         univ8250_console_init+0x3a/0x46 
>> drivers/tty/serial/8250/8250_core.c:681
>>         console_init+0x49d/0x6d3 kernel/printk/printk.c:2915
>>         start_kernel+0x5e9/0x879 init/main.c:713
>>         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
>>
>> -> #0 (console_owner){....}-{0:0}:
>>         check_prev_add kernel/locking/lockdep.c:2600 [inline]
>>         check_prevs_add kernel/locking/lockdep.c:2705 [inline]
>>         validate_chain kernel/locking/lockdep.c:3095 [inline]
>>         __lock_acquire+0x27e6/0x4cc0 kernel/locking/lockdep.c:4200
> 
> Delete the above 4 lines?

Will do.

> 
>>         lock_acquire+0x127/0x340 kernel/locking/lockdep.c:4734
>>         console_trylock_spinning kernel/printk/printk.c:1773 
>> [inline]        <-- lock(console_owner);
>>         vprintk_emit+0x307/0x470 kernel/printk/printk.c:2023
>>         vprintk_func+0x8d/0x250 kernel/printk/printk_safe.c:394
>>         printk+0xba/0xed kernel/printk/printk.c:2084
>>         fail_dump lib/fault-inject.c:45 [inline]
>>         should_fail+0x67b/0x7c0 lib/fault-inject.c:144
>>         __should_failslab+0x152/0x1c0 mm/failslab.c:33
>>         should_failslab+0x5/0x10 mm/slab_common.c:1224
>>         slab_pre_alloc_hook mm/slab.h:468 [inline]
>>         slab_alloc_node mm/slub.c:2723 [inline]
>>         slab_alloc mm/slub.c:2807 [inline]
>>         __kmalloc+0x72/0x300 mm/slub.c:3871
>>         kmalloc include/linux/slab.h:582 [inline]
>>         tty_buffer_alloc+0x23f/0x2a0 drivers/tty/tty_buffer.c:175
>>         __tty_buffer_request_room+0x156/0x2a0 
>> drivers/tty/tty_buffer.c:273
>>         tty_insert_flip_string_fixed_flag+0x93/0x250 
>> drivers/tty/tty_buffer.c:318
>>         tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
>>         pty_write+0x126/0x1f0 drivers/tty/pty.c:122                <-- 
>> lock(&port->lock);
>>         n_tty_write+0xa7a/0xfc0 drivers/tty/n_tty.c:2356
>>         do_tty_write drivers/tty/tty_io.c:961 [inline]
>>         tty_write+0x512/0x930 drivers/tty/tty_io.c:1045
>>         __vfs_write+0x76/0x100 fs/read_write.c:494
> 
> And stop here?

Will do.

> 
>>         vfs_write+0x268/0x5c0 fs/read_write.c:558
>>         ksys_write+0x12d/0x250 fs/read_write.c:611
>>         do_syscall_64+0xd7/0x380 arch/x86/entry/common.c:291
>>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>    console_owner --> &port_lock_key --> &port->lock
>>
>> Fixes: b6da31b2c07c ("tty: Fix data race in 
>> tty_insert_flip_string_fixed_flag")
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   drivers/tty/tty_buffer.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
>> index 646510476c30..bfa431a8e690 100644
>> --- a/drivers/tty/tty_buffer.c
>> +++ b/drivers/tty/tty_buffer.c
>> @@ -175,7 +175,8 @@ static struct tty_buffer *tty_buffer_alloc(struct 
>> tty_port *port, size_t size)
>>        */
>>       if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>>           return NULL;
>> -    p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
>> +    p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
>> +            GFP_ATOMIC | __GFP_NOWARN);
>>       if (p == NULL)
>>           return NULL;
> 
> 

-- 
Thanks,
Qi
