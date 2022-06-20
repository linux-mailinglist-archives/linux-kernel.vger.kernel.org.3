Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4A0550FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiFTFog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiFTFoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:44:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D50D10C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:44:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so9251448pjz.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fkJjZtFpVYOf65TntldBV4U1OZuRtYGxCL/Lv1yJa2k=;
        b=Rh29dJvv1DhxvpSE+h2f7/d2EIaBFMIl0XA40VQwA3lwRXoZx9m13M9hDpaR03V02E
         H5ATtqxAtwSWae8Sdr0EzWZhoY+aqrAfExCuq5rZDc1SfhLA72EfvZ5AYRqm5MPla3Vq
         maEknywvz6uofrPcrSby3TXm4XKzqtPwg8sZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkJjZtFpVYOf65TntldBV4U1OZuRtYGxCL/Lv1yJa2k=;
        b=aK3WJmIkCKCLPh8ZqsAF4BUZDZILZSziU5xiAFe5XP3fPorD0Ry/doRU5nNfdpDHEu
         e71gSnjfRhvVo8+Y3SZ2GAjWBn7YSMYwuqA9radBIGT5zDrO6ezLXU8s6eRHMOshqwOQ
         R8Wfd74pKZ+4GhX5YlBsIyfwUHQZu+fTrejEeyVnDev2EbC2xA3QJYsUDZPDXxxK9ocP
         cRWdFZ21Xwsxa/bjvHZhS6T/DsFXaW2udAuAg0ydkfRMR5vozlUKgYCRBgLnwiZ+j1bt
         t8CjorsOfijUYrQ5+Y1B0rXI/cbyjXAqO0kihb99N7sNqV8l08zrqR7W8cE6wH0ThbGb
         M9Cw==
X-Gm-Message-State: AJIora9gCeeSkPXvXMcTXse+7lVIVS/tGvIv7iBQOVoKOQmIOVWSeMN9
        WJKw9XWyzUhJbWOai2nrm11ifw==
X-Google-Smtp-Source: AGRyM1sJTB+7tLxIyTnWkqNohE2VOq0ayizMCINfZFlvpv6pOCVnv2/1UbQjwtaJMuytX87xbxZf5A==
X-Received: by 2002:a17:902:dac7:b0:166:3dfe:f4b8 with SMTP id q7-20020a170902dac700b001663dfef4b8mr22144916plx.55.1655703868741;
        Sun, 19 Jun 2022 22:44:28 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:b60c:9d67:b219:6c6f])
        by smtp.gmail.com with ESMTPSA id m22-20020a638c16000000b003fa95b940bdsm8282619pgd.88.2022.06.19.22.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 22:44:28 -0700 (PDT)
Date:   Mon, 20 Jun 2022 14:44:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in console_lock_spinning_enable (2)
Message-ID: <YrAJNuGg8n6f9Fcw@google.com>
References: <0000000000007ba8cd05d0c1c3b0@google.com>
 <00000000000071951f05e1c4d7c8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000071951f05e1c4d7c8@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/18 20:47), syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit faebd693c59387b7b765fab64b543855e15a91b4
> Author: John Ogness <john.ogness@linutronix.de>
> Date:   Thu Apr 21 21:22:36 2022 +0000
> 
>     printk: rename cpulock functions

I'd rather guess that it was console kthread patch that fixed the problem.
And the problem here is slab fault injection, which triggers printk
under port->lock, which is a reverse locking chain: we usually do
printk, grab console owner and then call into console driver and take
the port->lock.

[  302.408357][ T6160] isofs_fill_super: get root inode failed
[  302.447591][ T6181] FAULT_INJECTION: forcing a failure.
[  302.447591][ T6181] name failslab, interval 1, probability 0, space 0, times 0
[  302.447761][ T6181] 
[  302.447764][ T6181] ======================================================
[  302.447767][ T6181] WARNING: possible circular locking dependency detected
[  302.447770][ T6181] 5.18.0-rc7-syzkaller-00048-gf993aed406ea #0 Not tainted
[  302.447776][ T6181] ------------------------------------------------------
[  302.447779][ T6181] syz-executor.5/6181 is trying to acquire lock:
[  302.447784][ T6181] ffffffff8cb0f4a0 (console_owner){....}-{0:0}, at: console_lock_spinning_enable+0x2d/0x60
[  302.447841][ T6181] 
[  302.447841][ T6181] but task is already holding lock:
[  302.447843][ T6181] ffff88801b67f958 (&port->lock){-.-.}-{2:2}, at: pty_write+0xc5/0x170
[  302.447874][ T6181] 
[  302.447874][ T6181] which lock already depends on the new lock.
[  302.447874][ T6181] 
[  302.447877][ T6181] 
[  302.447877][ T6181] the existing dependency chain (in reverse order) is:
[  302.447880][ T6181] 
[  302.447880][ T6181] -> #2 (&port->lock){-.-.}-{2:2}:
[  302.447892][ T6181]        lock_acquire+0x1a7/0x400
[  302.447902][ T6181]        _raw_spin_lock_irqsave+0xd1/0x120
[  302.447911][ T6181]        tty_port_default_wakeup+0x21/0x100
[  302.447921][ T6181]        serial8250_tx_chars+0x60e/0x810
[  302.447962][ T6181]        serial8250_handle_irq+0x32f/0x410
[  302.447972][ T6181]        serial8250_default_handle_irq+0xaf/0x190
[  302.447980][ T6181]        serial8250_interrupt+0xa3/0x1e0
[  302.447990][ T6181]        __handle_irq_event_percpu+0x200/0x620
[  302.448001][ T6181]        handle_irq_event+0x83/0x1e0
[  302.448010][ T6181]        handle_edge_irq+0x245/0xbe0
[  302.448017][ T6181]        __common_interrupt+0xce/0x1e0
[  302.448056][ T6181]        common_interrupt+0x9f/0xc0
[  302.448065][ T6181]        asm_common_interrupt+0x1e/0x40
[  302.448074][ T6181]        acpi_idle_enter+0x42d/0x790
[  302.448112][ T6181]        cpuidle_enter_state+0x517/0xed0
[  302.448149][ T6181]        cpuidle_enter+0x59/0x90
[  302.448157][ T6181]        do_idle+0x3d2/0x640
[  302.448177][ T6181]        cpu_startup_entry+0x15/0x20
[  302.448186][ T6181]        rest_init+0x24f/0x270
[  302.448194][ T6181]        start_kernel+0x0/0x56e
[  302.448224][ T6181]        start_kernel+0x4bf/0x56e
[  302.448232][ T6181]        secondary_startup_64_no_verify+0xc4/0xcb
[  302.448247][ T6181] 
[  302.448247][ T6181] -> #1 (&port_lock_key){-.-.}-{2:2}:
[  302.448262][ T6181]        lock_acquire+0x1a7/0x400
[  302.448275][ T6181]        _raw_spin_lock_irqsave+0xd1/0x120
[  302.448289][ T6181]        serial8250_console_write+0x19c/0xf60
[  302.448304][ T6181]        console_unlock+0xa98/0x1150
[  302.448319][ T6181]        vprintk_emit+0xd1/0x1e0
[  302.448334][ T6181]        _printk+0xcf/0x10f
[  302.448349][ T6181]        register_console+0x6e2/0x9c0
[  302.448362][ T6181]        univ8250_console_init+0x41/0x43
[  302.448390][ T6181]        console_init+0x5d/0xa8
[  302.448406][ T6181]        start_kernel+0x328/0x56e
[  302.448421][ T6181]        secondary_startup_64_no_verify+0xc4/0xcb
[  302.448440][ T6181] 
[  302.448440][ T6181] -> #0 (console_owner){....}-{0:0}:
[  302.448462][ T6181]        validate_chain+0x185c/0x65c0
[  302.448479][ T6181]        __lock_acquire+0x129a/0x1f80
[  302.448492][ T6181]        lock_acquire+0x1a7/0x400
[  302.448500][ T6181]        console_lock_spinning_enable+0x52/0x60
[  302.448509][ T6181]        console_unlock+0x7f4/0x1150
[  302.448518][ T6181]        vprintk_emit+0xd1/0x1e0
[  302.448526][ T6181]        _printk+0xcf/0x10f
[  302.448534][ T6181]        should_fail+0x366/0x4b0
[  302.448544][ T6181]        should_failslab+0x5/0x20
[  302.448554][ T6181]        __kmalloc+0x8b/0x370
[  302.448562][ T6181]        __tty_buffer_request_room+0x1f0/0x540
[  302.448572][ T6181]        tty_insert_flip_string_fixed_flag+0x91/0x2c0
[  302.448582][ T6181]        pty_write+0xe9/0x170
[  302.448589][ T6181]        n_tty_write+0x665/0x13b0
[  302.448597][ T6181]        file_tty_write+0x5a5/0x960
[  302.448605][ T6181]        vfs_write+0xa22/0xd40
[  302.448613][ T6181]        ksys_write+0x19b/0x2c0
[  302.448620][ T6181]        do_syscall_64+0x2b/0x70
[  302.448628][ T6181]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  302.448637][ T6181] 
[  302.448637][ T6181] other info that might help us debug this:
[  302.448637][ T6181] 
[  302.448640][ T6181] Chain exists of:
[  302.448640][ T6181]   console_owner --> &port_lock_key --> &port->lock
[  302.448640][ T6181] 
[  302.448653][ T6181]  Possible unsafe locking scenario:
[  302.448653][ T6181] 
[  302.448655][ T6181]        CPU0                    CPU1
[  302.448657][ T6181]        ----                    ----
[  302.448659][ T6181]   lock(&port->lock);
[  302.448664][ T6181]                                lock(&port_lock_key);
[  302.448670][ T6181]                                lock(&port->lock);
[  302.448675][ T6181]   lock(console_owner);
[  302.448680][ T6181] 
[  302.448680][ T6181]  *** DEADLOCK ***
[  302.448680][ T6181] 
[  302.448682][ T6181] 6 locks held by syz-executor.5/6181:
[  302.448687][ T6181]  #0: ffff88804d6c2098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70
[  302.448709][ T6181]  #1: ffff88804d6c2130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: file_tty_write+0x26e/0x960
[  302.448731][ T6181]  #2: ffff88804d6c22e8 (&tty->termios_rwsem){++++}-{3:3}, at: n_tty_write+0x244/0x13b0
[  302.448752][ T6181]  #3: ffffc90010d81378 (&ldata->output_lock){+.+.}-{3:3}, at: n_tty_write+0x61a/0x13b0
[  302.448774][ T6181]  #4: ffff88801b67f958 (&port->lock){-.-.}-{2:2}, at: pty_write+0xc5/0x170
[  302.448793][ T6181]  #5: ffffffff8c9f71a0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0xb8/0x1e0
[  302.448813][ T6181] 
[  302.448813][ T6181] stack backtrace:
[  302.448817][ T6181] CPU: 0 PID: 6181 Comm: syz-executor.5 Not tainted 5.18.0-rc7-syzkaller-00048-gf993aed406ea #0
[  302.448827][ T6181] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  302.448832][ T6181] Call Trace:
[  302.448836][ T6181]  <TASK>
[  302.448840][ T6181]  dump_stack_lvl+0x1e3/0x2cb
[  302.448853][ T6181]  ? bfq_pos_tree_add_move+0x436/0x436
[  302.448866][ T6181]  ? print_circular_bug+0x13e/0x1c0
[  302.448876][ T6181]  check_noncircular+0x2f7/0x3b0
[  302.448887][ T6181]  ? add_chain_block+0x850/0x850
[  302.448897][ T6181]  ? lockdep_lock+0x11d/0x2a0
[  302.448910][ T6181]  validate_chain+0x185c/0x65c0
[  302.448924][ T6181]  ? vsnprintf+0x1ce0/0x1ce0
[  302.448934][ T6181]  ? reacquire_held_locks+0x680/0x680
[  302.448943][ T6181]  ? memset+0x1f/0x40
[  302.448980][ T6181]  ? vsnprintf+0x1fa/0x1ce0
[  302.448990][ T6181]  ? memcpy+0x3c/0x60
[  302.448999][ T6181]  ? vsnprintf+0x1c02/0x1ce0
[  302.449009][ T6181]  ? reacquire_held_locks+0x680/0x680
[  302.449030][ T6181]  ? sprintf+0xd6/0x120
[  302.449040][ T6181]  ? _prb_read_valid+0xbb9/0xbd0
[  302.449051][ T6181]  ? mark_lock+0x98/0x350
[  302.449061][ T6181]  __lock_acquire+0x129a/0x1f80
[  302.449081][ T6181]  lock_acquire+0x1a7/0x400
[  302.449094][ T6181]  ? console_lock_spinning_enable+0x2d/0x60
[  302.449113][ T6181]  ? read_lock_is_recursive+0x10/0x10
[  302.449130][ T6181]  ? console_lock_spinning_enable+0x2d/0x60
[  302.449147][ T6181]  ? __lock_acquire+0x1f80/0x1f80
[  302.449162][ T6181]  ? do_raw_spin_lock+0x148/0x360
[  302.449183][ T6181]  ? _raw_spin_unlock+0x40/0x40
[  302.449200][ T6181]  console_lock_spinning_enable+0x52/0x60
[  302.449217][ T6181]  ? console_lock_spinning_enable+0x2d/0x60
[  302.449238][ T6181]  console_unlock+0x7f4/0x1150
[  302.449257][ T6181]  ? vprintk_emit+0xb8/0x1e0
[  302.449273][ T6181]  ? console_trylock_spinning+0x450/0x450
[  302.449288][ T6181]  ? vprintk_emit+0xb8/0x1e0
[  302.449297][ T6181]  ? console_trylock+0x70/0x70
[  302.449305][ T6181]  ? register_lock_class+0xfe/0x9d0
[  302.449315][ T6181]  ? reacquire_held_locks+0x680/0x680
[  302.449326][ T6181]  ? register_lock_class+0xfe/0x9d0
[  302.449336][ T6181]  ? is_dynamic_key+0x1f0/0x1f0
[  302.449345][ T6181]  vprintk_emit+0xd1/0x1e0
[  302.449355][ T6181]  _printk+0xcf/0x10f
[  302.449365][ T6181]  ? panic+0x76e/0x76e
[  302.449382][ T6181]  should_fail+0x366/0x4b0
[  302.449401][ T6181]  ? __tty_buffer_request_room+0x1f0/0x540
[  302.449427][ T6181]  should_failslab+0x5/0x20
[  302.449446][ T6181]  __kmalloc+0x8b/0x370
[  302.449465][ T6181]  __tty_buffer_request_room+0x1f0/0x540
[  302.449478][ T6181]  tty_insert_flip_string_fixed_flag+0x91/0x2c0
[  302.449491][ T6181]  ? _raw_spin_unlock_irqrestore+0xd9/0x130
[  302.449507][ T6181]  ? _raw_spin_unlock+0x40/0x40
[  302.449524][ T6181]  pty_write+0xe9/0x170
[  302.449540][ T6181]  n_tty_write+0x665/0x13b0
[  302.449559][ T6181]  ? _copy_from_iter+0x429/0xec0
[  302.449584][ T6181]  ? n_tty_read+0x1c90/0x1c90
[  302.449599][ T6181]  ? wait_woken+0x1b0/0x1b0
[  302.449621][ T6181]  ? check_heap_object+0x13c/0x310
[  302.449633][ T6181]  ? 0xffffffff81000000
[  302.449639][ T6181]  ? __check_object_size+0x15a/0x210
[  302.449650][ T6181]  file_tty_write+0x5a5/0x960
[  302.449660][ T6181]  ? n_tty_read+0x1c90/0x1c90
[  302.449671][ T6181]  vfs_write+0xa22/0xd40
[  302.449679][ T6181]  ? __lock_acquire+0x1f80/0x1f80
[  302.449689][ T6181]  ? file_end_write+0x230/0x230
[  302.449700][ T6181]  ? __fget_files+0x3d0/0x440
[  302.449710][ T6181]  ? __fdget_pos+0x1d7/0x2e0
[  302.449718][ T6181]  ? ksys_write+0x77/0x2c0
[  302.449727][ T6181]  ksys_write+0x19b/0x2c0
[  302.449736][ T6181]  ? print_irqtrace_events+0x220/0x220
[  302.449745][ T6181]  ? __ia32_sys_read+0x80/0x80
[  302.449754][ T6181]  ? syscall_enter_from_user_mode+0x2e/0x1a0
[  302.449765][ T6181]  ? syscall_enter_from_user_mode+0x2e/0x1a0
[  302.449775][ T6181]  do_syscall_64+0x2b/0x70
[  302.449783][ T6181]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  302.449793][ T6181] RIP: 0033:0x7f2630c890e9
[  302.449801][ T6181] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
[  302.449809][ T6181] RSP: 002b:00007f2631df9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  302.449819][ T6181] RAX: ffffffffffffffda RBX: 00007f2630d9bf60 RCX: 00007f2630c890e9
[  302.449827][ T6181] RDX: 000000000000ff2e RSI: 00000000200000c0 RDI: 0000000000000004
[  302.449833][ T6181] RBP: 00007f2631df91d0 R08: 0000000000000000 R09: 0000000000000000
[  302.449839][ T6181] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  302.449845][ T6181] R13: 00007ffe692c072f R14: 00007f2631df9300 R15: 0000000000022000
[  302.449856][ T6181]  </TASK>
[  303.425580][ T6181] CPU: 0 PID: 6181 Comm: syz-executor.5 Not tainted 5.18.0-rc7-syzkaller-00048-gf993aed406ea #0
[  303.435966][ T6181] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  303.445999][ T6181] Call Trace:
[  303.449261][ T6181]  <TASK>
[  303.452173][ T6181]  dump_stack_lvl+0x1e3/0x2cb
[  303.456838][ T6181]  ? bfq_pos_tree_add_move+0x436/0x436
[  303.462275][ T6181]  ? panic+0x76e/0x76e
[  303.466333][ T6181]  should_fail+0x384/0x4b0
[  303.470756][ T6181]  ? __tty_buffer_request_room+0x1f0/0x540
[  303.476557][ T6181]  should_failslab+0x5/0x20
[  303.481042][ T6181]  __kmalloc+0x8b/0x370
[  303.485179][ T6181]  __tty_buffer_request_room+0x1f0/0x540
[  303.490801][ T6181]  tty_insert_flip_string_fixed_flag+0x91/0x2c0
[  303.497028][ T6181]  ? _raw_spin_unlock_irqrestore+0xd9/0x130
[  303.502902][ T6181]  ? _raw_spin_unlock+0x40/0x40
[  303.507731][ T6181]  pty_write+0xe9/0x170
[  303.511866][ T6181]  n_tty_write+0x665/0x13b0
[  303.516353][ T6181]  ? _copy_from_iter+0x429/0xec0
[  303.521277][ T6181]  ? n_tty_read+0x1c90/0x1c90
[  303.525944][ T6181]  ? wait_woken+0x1b0/0x1b0
[  303.530439][ T6181]  ? check_heap_object+0x13c/0x310
[  303.535546][ T6181]  ? 0xffffffff81000000
[  303.539687][ T6181]  ? __check_object_size+0x15a/0x210
[  303.544962][ T6181]  file_tty_write+0x5a5/0x960
[  303.549632][ T6181]  ? n_tty_read+0x1c90/0x1c90
[  303.554294][ T6181]  vfs_write+0xa22/0xd40
[  303.558519][ T6181]  ? __lock_acquire+0x1f80/0x1f80
[  303.563524][ T6181]  ? file_end_write+0x230/0x230
[  303.568357][ T6181]  ? __fget_files+0x3d0/0x440
[  303.573016][ T6181]  ? __fdget_pos+0x1d7/0x2e0
[  303.577588][ T6181]  ? ksys_write+0x77/0x2c0
[  303.581995][ T6181]  ksys_write+0x19b/0x2c0
[  303.586311][ T6181]  ? print_irqtrace_events+0x220/0x220
[  303.591763][ T6181]  ? __ia32_sys_read+0x80/0x80
[  303.596506][ T6181]  ? syscall_enter_from_user_mode+0x2e/0x1a0
[  303.602470][ T6181]  ? syscall_enter_from_user_mode+0x2e/0x1a0
[  303.608438][ T6181]  do_syscall_64+0x2b/0x70
[  303.612834][ T6181]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  303.618709][ T6181] RIP: 0033:0x7f2630c890e9
[  303.623108][ T6181] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
[  303.642692][ T6181] RSP: 002b:00007f2631df9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
