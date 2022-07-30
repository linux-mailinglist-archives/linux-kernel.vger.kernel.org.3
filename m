Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2D58586C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 06:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiG3EUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 00:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiG3EUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:20:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E1E08D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:19:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c3so6157887pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=F3IeneTwCJW5d+Il05ySjjZRUCa3E5afzHaOl38agr4=;
        b=QeJEXzzSkp5Q9X6QvWOOHI9mew/nwQrHrEu3MSiTEyBYzenK394pSi2LKAItqbBgZV
         9tMnILRcWu7qGm2kFRRop69UVorKESZapHTZLcRayNM3yKWSxf0fjLTBpdaLeU3MsHJe
         LtWg41YyjX7hhOaZMX3/4rmTwcI/UZzu0np9AY4eeikigInVojeEw0kdbQuqq2imhpoo
         nrjp9eTvW1H8ZBRKe3nwEMoxkVV372RZyOlx2XeDQImIR0HvKTaAA/V1bmFZD24SFmSw
         AHKtX3QRL9sWTUxx5OfH2Bo9N/ELSUm7aPWzpgQzavZ+z2acaCJ1qnhYjDu7jSmKvHvp
         lmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=F3IeneTwCJW5d+Il05ySjjZRUCa3E5afzHaOl38agr4=;
        b=pWrialel485rhhLF9pw3/WuQmm36mwla2nlDe82HrekRnA7hqmnMnN/l9AOI5LzAxu
         ZJj851L/cSnqQ7e+J5/Zz8u88caT23GcLzRdidwZEn4RelhTkXyjAD8eDFup64A7kCo8
         bKjMt9cUYPb7UvXrzec5E0/JyzgjHOGlu8+iYVcSJgf+rwtKWGZwbzvPRhD2Z2jx2eA8
         mNZbyWSxiXE0uvZRrwAgNGFvcqNsCaiG5xI/MVE3OpC5tuSP3gDtM1tj0bGXOLRWbHPO
         bWArgn9Ieu0mp3fJKystkMsX00NHWX9lELcBli6ZLbcI8pn/eHmM0HzK5Q9Y7pVRRfNc
         QYyg==
X-Gm-Message-State: ACgBeo1WRswjPaBkZ6YL8YUolr+eJNX0eKnu+ALDQqoG/qZ3CRaHDNUU
        Kx7qzf9xa11VDYnSbVbh01ZEsZt1NU4fQw==
X-Google-Smtp-Source: AA6agR4U9hol001Jq5temblRnxxjomikjHZdlhAq/raKZws7tXMEe2AGVgVpKM+mJT0HMOBAgRb2Qw==
X-Received: by 2002:aa7:810a:0:b0:52c:e906:e355 with SMTP id b10-20020aa7810a000000b0052ce906e355mr3364470pfi.16.1659154797927;
        Fri, 29 Jul 2022 21:19:57 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709026ac100b0016bee668a5asm4452397plt.161.2022.07.29.21.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 21:19:57 -0700 (PDT)
References: <20220707090501.55483-1-schspa@gmail.com>
 <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
 <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Date:   Sat, 30 Jul 2022 11:49:41 +0800
In-reply-to: <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
Message-ID: <m2tu6zxme3.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Jul 13, 2022 at 05:52:58PM +0800, Lai Jiangshan wrote:
>> 
>> 
>> CC Peter.
>> Peter has changed the CPU binding code in workqueue.c.
>
> [ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
> [ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
> 									^^^^^^^^^^^^^^^^^^^^^
>
> I think we can ignore this as being some ancient kernel. Please try
> something recent.

Hi peter:

I spent a few days writing a test case and reproduced the problem on
kernel 5.19. I think it's time for us to review the V3 patch for a fix.

The V3 patch is at
https://lore.kernel.org/all/20220714031645.28004-1-schspa@gmail.com/
Please help to review it.

Test branch as:
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tag/?h=v5.19-rc8-rt8

I think this code is new enough to demonstrate that the problem persists.

The log as fellowing:

[ 3103.198684] ------------[ cut here ]------------
[ 3103.198684] Dying CPU not properly vacated!
[ 3103.198684] WARNING: CPU: 1 PID: 23 at kernel/sched/core.c:9575 sched_cpu_dying.cold+0xc/0xc3
[ 3103.198684] Modules linked in: work_test(O)
[ 3103.198684] CPU: 1 PID: 23 Comm: migration/1 Tainted: G           O      5.19.0-rc8-rt8 #1
[ 3103.198684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[ 3103.198684] Stopper: multi_cpu_stop+0x0/0xf0 <- stop_machine_cpuslocked+0x132/0x170
[ 3103.198684] RIP: 0010:sched_cpu_dying.cold+0xc/0xc3
[ 3103.198684] Code: 00 e9 a1 c1 40 ff 48 c7 c7 48 91 94 82 e8 99 29 00 00 48 c7 c7 00 5e 53 83 e9 e3 10 50 ff 48 c7 c7 98 91 94 82 e8 4f ec ff ff <0f> 0b 44 8b ab 10 0a 00 00 8b 4b 04 48 c7 c6 cd 37 93 82 48 c7 c7
[ 3103.198684] RSP: 0000:ffffc900000dbda0 EFLAGS: 00010086
[ 3103.198684] RAX: 0000000000000000 RBX: ffff88813bcaa280 RCX: 0000000000000000
[ 3103.198684] RDX: 0000000000000003 RSI: ffffffff82953971 RDI: 00000000ffffffff
[ 3103.198684] RBP: 0000000000000082 R08: 00000000000021ed R09: ffffc900000dbd38
[ 3103.198684] R10: 0000000000000001 R11: ffffffffffffffff R12: 0000000000000060
[ 3103.198684] R13: ffffffff810a9040 R14: ffffffff82c555c0 R15: 0000000000000000
[ 3103.198684] FS:  0000000000000000(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
[ 3103.198684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3103.198684] CR2: 00007f85acd18010 CR3: 0000000102578000 CR4: 0000000000350ee0
[ 3103.198684] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3103.198684] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3103.198684] Call Trace:
[ 3103.198684]  <TASK>
[ 3103.198684]  ? sched_cpu_wait_empty+0x60/0x60
[ 3103.198684]  cpuhp_invoke_callback+0x3a4/0x5f0
[ 3103.198684]  take_cpu_down+0x71/0xd0
[ 3103.198684]  multi_cpu_stop+0x5c/0xf0
[ 3103.198684]  ? stop_machine_yield+0x10/0x10
[ 3103.198684]  cpu_stopper_thread+0x82/0x130
[ 3103.198684]  smpboot_thread_fn+0x1bb/0x2b0
[ 3103.198684]  ? sort_range+0x20/0x20
[ 3103.198684]  kthread+0xfe/0x120
[ 3103.198684]  ? kthread_complete_and_exit+0x20/0x20
[ 3103.198684]  ret_from_fork+0x1f/0x30
[ 3103.198684]  </TASK>
[ 3103.198684] Kernel panic - not syncing: panic_on_warn set ...
[ 3103.198684] CPU: 1 PID: 23 Comm: migration/1 Tainted: G           O      5.19.0-rc8-rt8 #1
[ 3103.198684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[ 3103.198684] Stopper: multi_cpu_stop+0x0/0xf0 <- stop_machine_cpuslocked+0x132/0x170
[ 3103.198684] Call Trace:
[ 3103.198684]  <TASK>
[ 3103.198684]  dump_stack_lvl+0x34/0x48
[ 3103.198684]  panic+0xf8/0x299
[ 3103.198684]  ? sched_cpu_dying.cold+0xc/0xc3
[ 3103.198684]  __warn.cold+0x43/0xba
[ 3103.198684]  ? sched_cpu_dying.cold+0xc/0xc3
[ 3103.198684]  report_bug+0x9d/0xc0
[ 3103.198684]  handle_bug+0x3c/0x70
[ 3103.198684]  exc_invalid_op+0x14/0x70
[ 3103.198684]  asm_exc_invalid_op+0x16/0x20
[ 3103.198684] RIP: 0010:sched_cpu_dying.cold+0xc/0xc3

-- 
BRs
Schspa Shi
