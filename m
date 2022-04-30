Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113C35160BA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiD3WPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245553AbiD3WPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:15:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCF554690;
        Sat, 30 Apr 2022 15:11:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so9885196plg.5;
        Sat, 30 Apr 2022 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dCo8CMo2v5RYO1RPZD0+ykli4XQwArDVOl1Oec/L0lw=;
        b=lvjESYcogcQfm73Bw1m+yl6xdhB48HDzK6/euhagLHL5CAPe5BCQHL6k03Ovghtlq3
         TehYemoidty+ECmFIlp/Y2nnmzblHJIW3FYrlP9lAvBys1X46eE08xDIgrbUeyLkH+7x
         hyjssu6pH0KuHrj6ZmICJ2fct6J99C0Lrk8u/tYU3A3IxQy7/11PVf+4mlq4TAA2u0vz
         3/fyopDt26Rw4WPDS0g2Ufw29R2dGL8g4RAHwL4OLMDkY7S3hAqX0fAelrsc7Wzita+b
         eOXOYDcfvTHllFVziHBgEhMph1yrG71N3gpSlTIj1L2usfsTpYmwxeNlyoyAUglnmFjx
         TK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dCo8CMo2v5RYO1RPZD0+ykli4XQwArDVOl1Oec/L0lw=;
        b=z9T+yJbkU8CKcOd9z1+6gvhgGZnqD8LKPbd9O1j2Q6rA3wK3BpcPztz3bVCnuVLByW
         fYzvXlRDnI3HSjpXqrC1d8OuJgZxjHVeY9QgenWm+eA1V58/Z0NC7DnW/l52kyqVl17K
         fWV0i/woAW5V+l4ZmyXQMSLmg+ky2ClmSrKI8VODu36S8OEbNOLQHbqkn4kpKGPCUd8M
         RRGRiFcbjut0WanuRCEmhMMOejI4nvRFgTvS5rB4Pj37ZsCE32gd1V5JNW464w1s/miA
         viphsgz3763USUDpLWkx+K3HaNgIHJIT9iX7XSoVyR3q+RqlO+PlLP6tYR4YkFZNhPFZ
         LaNA==
X-Gm-Message-State: AOAM531s6RusBKV/lQBr+9CUkzpePpc9GEGc84uRPW5SwJjZID8e95+F
        UOzbSng9Z7/bVSzSqo0Op2KZIUF+Ju2C8w==
X-Google-Smtp-Source: ABdhPJwA6YIuYHvQqzAFsZ99QOoThAwY/FlKLpIPxldD7qju7HwbZFDeZ84wvjsTVch9b1t1AkpifQ==
X-Received: by 2002:a17:902:8b8a:b0:158:fbd0:45ab with SMTP id ay10-20020a1709028b8a00b00158fbd045abmr5325110plb.110.1651356700152;
        Sat, 30 Apr 2022 15:11:40 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902864a00b0015e8d4eb254sm1918584plt.158.2022.04.30.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:11:39 -0700 (PDT)
Date:   Sun, 1 May 2022 07:11:37 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 11/17] openrisc: account for 0 starting value in
 random_get_entropy()
Message-ID: <Ym20Ga3VsJRzXppd@antec>
References: <20220423212623.1957011-12-Jason@zx2c4.com>
 <20220429001648.1671472-1-Jason@zx2c4.com>
 <YmyOh/YbgGJ3DK79@antec>
 <YmyRATzJBQX+wnIP@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmyRATzJBQX+wnIP@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 03:29:37AM +0200, Jason A. Donenfeld wrote:
> Hi Stafford,
> 
> On Sat, Apr 30, 2022 at 10:19:03AM +0900, Stafford Horne wrote:
> > Hi Jason,
> > 
> > On Fri, Apr 29, 2022 at 02:16:48AM +0200, Jason A. Donenfeld wrote:
> > > As a sanity check, this series makes sure that during early boot, the
> > > cycle counter isn't returning all zeros. However, OpenRISC's TTCR timer
> > > can be rather slow and starts out as zero during stages of early boot.
> > > We know it works, however. So just always add 1 to random_get_entropy()
> > > so that it doesn't trigger these checks.
> > 
> > Just one nit, you might want to qualify that this is related to simulators/qemu:
> >  * "However, in simulators OpenRISC's TTCR timer can be rather slow..."
> 
> Nice catch, will do.

I was thinking about this, the reason the tick timer is returing 0 is because
the timer is not started.  It's getting initialized right after the random
number generator.

A patch like this helps to startup the timer during intial startup, but I am not
sure its the best thing:

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 15f1b38dfe03..a9b3b5614e13 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -521,6 +521,9 @@ _start:
        l.ori   r3,r0,0x1
        l.mtspr r0,r3,SPR_SR
 
+       l.movhi r3,hi(SPR_TTMR_CR)
+       l.mtspr r0,r3,SPR_TTMR
+
        CLEAR_GPR(r1)
        CLEAR_GPR(r2)
        CLEAR_GPR(r3)

I was testing this by removing the get_cycles() + 1 patch and I get the
following warning. Starting the tick timer early on in kernel boot helps fix
this issue as well.

But I wonder:
 - Why don't any other architectures have similar issues.
 - Is there any more correct place to do an early timer kick off.

    exec: /home/shorne/work/openrisc/qemu/build/or1k-softmmu/qemu-system-or1k -cpu or1200 -M or1k-sim -kernel /home/shorne/work/linux/vmlinux -initrd /home/shorne/work/linux/initramfs.cpio.gz -serial mon:stdi
    o -nographic -gdb tcp::10001 -m 64

    [    0.000000] OpenRISC Linux -- http://openrisc.io
    [    0.000000] percpu: Embedded 5 pages/cpu s11584 r8192 d21184 u40960
    [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8160
    [    0.000000] Kernel command line:
    [    0.000000] Dentry cache hash table entries: 8192 (order: 2, 32768 bytes, linear)
    [    0.000000] Inode-cache hash table entries: 4096 (order: 1, 16384 bytes, linear)
    [    0.000000] Sorting __ex_table...
    [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
    [    0.000000] mem_init_done ...........................................
    [    0.000000] Memory: 57424K/65536K available (4595K kernel code, 157K rwdata, 976K rodata, 195K init, 89K bss, 8112K reserved, 0K cma-reserved)
    [    0.000000] rcu: Hierarchical RCU implementation.
    [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
    [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
    [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
    [    0.000000] NR_IRQS: 32, nr_irqs: 32, preallocated irqs: 0

(Warning for get_cycles returning 0)

    [    0.000000] ------------[ cut here ]------------
    [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/char/random.c:1016 rand_initialize+0x15c/0x18c
    [    0.000000] Missing cycle counter and fallback timer; RNG entropy collection will consequently suffer.
    [    0.000000] Modules linked in:
    [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc4-17398-gc576c8ccdc30-dirty #724
    [    0.000000] Call trace:
    [    0.000000] [<(ptrval)>] dump_stack_lvl+0x78/0xa0
    [    0.000000] [<(ptrval)>] dump_stack+0x1c/0x2c
    [    0.000000] [<(ptrval)>] __warn+0x100/0x13c
    [    0.000000] [<(ptrval)>] ? rand_initialize+0x15c/0x18c
    [    0.000000] [<(ptrval)>] warn_slowpath_fmt+0x84/0x9c
    [    0.000000] [<(ptrval)>] rand_initialize+0x15c/0x18c
    [    0.000000] [<(ptrval)>] ? start_kernel+0x5dc/0x7c4
    [    0.000000] [<(ptrval)>] ? start_kernel+0x0/0x7c4
    [    0.000000] ---[ end trace 0000000000000000 ]---

(Start of OpenRISC tick timer)

    [    0.000000] clocksource: openrisc_timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 95563022313 ns
    [    0.000000] 40.00 BogoMIPS (lpj=200000)
    [    0.000000] pid_max: default: 32768 minimum: 301
    [    0.000000] random: get_random_bytes called from net_ns_init+0x94/0x3f8 with crng_init=0
    [    0.000000] Mount-cache hash table entries: 2048 (order: 0, 8192 bytes, linear)
    [    0.000000] Mountpoint-cache hash table entries: 2048 (order: 0, 8192 bytes, linear)
    [    0.010000] rcu: Hierarchical SRCU implementation.


