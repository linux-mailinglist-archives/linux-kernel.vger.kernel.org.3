Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736EE59F1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiHXDWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiHXDVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:21:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EC17EFD5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:21:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 1so8073890pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ntVqCWkbl1KfzGFt4cpcTZjZVHMz1SHqpeAZAtzUVfc=;
        b=dEC8FUpC5wrVO5HalvQsP+lxgGYW8EzxmbPT5ojDUoUK1LT3xiSUqdFMXRB3X5ZL7a
         wEksX+A4QmK5Kg3S6viyJ+MaVP+xtluYBFN9OYNtyvLuxxMMktn5dw3n/avaSCdLDoE6
         gZQzEugFypTWW2Zfp3uN8uxPDdEFnqRDBnXFqKx7OY2poq/HK6x3scyoNeHhd+7LVDKI
         6X+cQonCPp5IvlrfxTnzdayUs67+DG7bkez8PSJgLmtxZY2noFz3rdhh4g7IERkXHg23
         FVoAGFOius152GJlVk9I/ZhSZwcdYejhUvGHxy+BZJ1B+GIm0o/36OnRe3P2Vzit2Qru
         HQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ntVqCWkbl1KfzGFt4cpcTZjZVHMz1SHqpeAZAtzUVfc=;
        b=nrDsLSYVA/zYBkuWnt1e3SxdbdbPZberwPI4f1zJ2malJxmAAXyBMfJ4rQl+EE0hPg
         XeetIWeDqeYQjMejZdqU6Sm/coVL0C9u5DEhiLWqebN1rTT3kjipnyk378J/HzcUZaJy
         WVIpAa/EqaaK8q/TDnqDPdsxjsMdz9X+XUjHrizabHt+W6dWDPz0bqsDPFFPTNL5X3o7
         rfIno/Kn4Jylc6dKeo8tjE8iyFYuPQsbOTVVFXIDpsfK/Ou7vA9dleMZwNHDlB+8AZ+5
         qx1z2ONMhWz7d7n1Lht2a+50Ooe8pITG9Dml0Cr1Ia/sGA8WTk59xulGeB4CJZIrmzaU
         6ZfQ==
X-Gm-Message-State: ACgBeo3hTywm9NshWaa9YLqvXhEuMCGAGISD3oviEMEFEVPgWkqlSM0Z
        T8mUm9AjUCIzKjuN4luZUckLsw==
X-Google-Smtp-Source: AA6agR7sPtlvcm46TBeuUUX4jmbUZwmhI+zRtXyf4QLkmHg/rn3YGQNH3SyHW41z9jIUMjMN60boNA==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c67 with SMTP id d22-20020a056a00199600b0052eb0f78c67mr27725629pfl.20.1661311289648;
        Tue, 23 Aug 2022 20:21:29 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id k23-20020a628417000000b00534bcd63f2fsm11682556pfd.190.2022.08.23.20.21.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2022 20:21:29 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     oliver.sang@intel.com
Cc:     Jason@zx2c4.com, Pavel.Tatashin@microsoft.com,
        akpm@linux-foundation.org, cai@lca.pw, iamjoonsoo.kim@lge.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com, lkp@intel.com, lkp@lists.01.org,
        mark-pk.tsai@mediatek.com, mgorman@techsingularity.net,
        mhiramat@kernel.org, mhocko@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, yang.shi@linaro.org
Subject: Re: [page_ext]  a02a0e703b: Kernel_panic-not_syncing:Out_of_memory
Date:   Wed, 24 Aug 2022 11:21:15 +0800
Message-Id: <20220824032115.76008-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YwHmXLu5txij+p35@xsang-OptiPlex-9020>
References: <YwHmXLu5txij+p35@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2022 16:01:32, kernel test robot <oliver.sang@intel.com> wrote:
>Greeting,
>
>FYI, we noticed the following commit (built with gcc-11):
>
>commit: a02a0e703b59a6fdd1b8ae50b47396621a03fc1f ("page_ext: move up page_ext_init() to catch early page allocation if DEFERRED_STRUCT_PAGE_INIT is n")
>https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
>in testcase: boot
>
>on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
>caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>+----------------------------------------+------------+------------+
>|                                        | 3be3989b3b | a02a0e703b |
>+----------------------------------------+------------+------------+
>| boot_successes                         | 70         | 0          |
>| boot_failures                          | 0          | 66         |
>| Mem-Info                               | 0          | 66         |
>| Kernel_panic-not_syncing:Out_of_memory | 0          | 66         |
>+----------------------------------------+------------+------------+
>
>
>If you fix the issue, kindly add following tag
>Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
>[    0.541637][    T0] Memory: 3927672K/4193784K available (11206K kernel code, 4497K rwdata, 3820K rodata, 1008K init, 1332K bss, 266112K reserved, 0K
>cma-reserved, 3432328K highmem)
>[    0.545125][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
>[    0.546120][    T0] swapper: vmalloc error: size 7864320, vm_struct allocation failed, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=(nul
>l),mems_allowed=0-7
>[    0.548152][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00121-ga02a0e703b59 #1
>[    0.549286][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
>[    0.550662][    T0] Call Trace:
>[    0.551108][    T0]  ? show_stack+0x3d/0x45
>[    0.551694][    T0]  dump_stack_lvl+0x34/0x44
>[    0.552299][    T0]  dump_stack+0xd/0x10
>[    0.552841][    T0]  warn_alloc.cold+0x55/0xaf
>[    0.553454][    T0]  __vmalloc_node_range+0x87/0x140
>[    0.554139][    T0]  vzalloc_node+0x64/0x80
>[    0.554716][    T0]  ? _page_ext_init+0x119/0x1e7
>[    0.555382][    T0]  _page_ext_init+0x119/0x1e7
>[    0.556010][    T0]  start_kernel+0x213/0x49a
>[    0.556615][    T0]  ? early_idt_handler_common+0x44/0x44
>[    0.557358][    T0]  i386_start_kernel+0x48/0x4a
>[    0.557995][    T0]  startup_32_smp+0x161/0x164
>[    0.558622][    T0] Mem-Info:
>[    0.559039][    T0] active_anon:0 inactive_anon:0 isolated_anon:0
>[    0.559039][    T0]  active_file:0 inactive_file:0 isolated_file:0
>[    0.559039][    T0]  unevictable:0 dirty:0 writeback:0
>[    0.559039][    T0]  slab_reclaimable:0 slab_unreclaimable:25
>[    0.559039][    T0]  mapped:0 shmem:0 pagetables:0 bounce:0
>[    0.559039][    T0]  kernel_misc_reclaimable:0
>[    0.559039][    T0]  free:981893 free_pcp:0 free_cma:0
>[    0.564216][    T0] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:0kB pagetables:0kB all_unreclaimable? no
>[    0.567976][    T0] Node 0 DMA free:15360kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>[    0.571575][    T0] lowmem_reserve[]: 0 0 0 0
>[    0.572172][    T0] Node 0 Normal free:479884kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:745464kB managed:479984kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>[    0.575803][    T0] lowmem_reserve[]: 0 0 0 0
>[    0.576395][    T0] Node 0 HighMem free:3432328kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3432328kB managed:3432328kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>[    0.580081][    T0] lowmem_reserve[]: 0 0 0 0
>[    0.580668][    T0] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
>[    0.582377][    T0] Node 0 Normal: 3*4kB (UM) 2*8kB (UM) 1*16kB (U) 1*32kB (M) 1*64kB (M) 2*128kB (UM) 3*256kB (UM) 1*512kB (U) 1*1024kB (U) 3*2048kB (UM) 115*4096kB (M) = 479884kB
>[    0.584609][    T0] Node 0 HighMem: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 1*128kB (M) 1*256kB (M) 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 837*4096kB (M) = 3432328kB
>[    0.586543][    T0] 0 total pagecache pages
>[    0.587121][    T0] 0 pages in swap cache
>[    0.587680][    T0] Free swap  = 0kB
>[    0.588170][    T0] Total swap = 0kB
>[    0.588664][    T0] 1048446 pages RAM
>[    0.589165][    T0] 858082 pages HighMem/MovableOnly
>[    0.589850][    T0] 66528 pages reserved
>[    0.590394][    T0] 0 pages cma reserved
>[    0.590947][    T0] page ext allocation failure
>[    0.591574][    T0] Kernel panic - not syncing: Out of memory
>[    0.592360][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00121-ga02a0e703b59 #1
>[    0.593520][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
>[    0.594937][    T0] Call Trace:
>[    0.595370][    T0]  ? show_stack+0x3d/0x45
>[    0.595952][    T0]  dump_stack_lvl+0x34/0x44
>[    0.596560][    T0]  dump_stack+0xd/0x10
>[    0.597098][    T0]  panic+0xdd/0x251
>[    0.597602][    T0]  _page_ext_init+0x131/0x1e7
>[    0.598223][    T0]  start_kernel+0x213/0x49a
>[    0.598830][    T0]  ? early_idt_handler_common+0x44/0x44
>[    0.599530][    T0]  i386_start_kernel+0x48/0x4a
>[    0.600152][    T0]  startup_32_smp+0x161/0x164
>
>
>
>To reproduce:
>
>        # build kernel
>	cd linux
>	cp config-6.0.0-rc1-00121-ga02a0e703b59 .config
>	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
>	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>	cd <mod-install-dir>
>	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>        # if come across any failure that blocks the test,
>        # please remove ~/.lkp and /lkp dir to run from a clean state.

The reaon of this problem is we call page_ext_init() before vmap initialization.
Moving page_ext_init() behind vmalloc_init() will solve this problem. Suggusted
by Michal Hocko <mhocko@suse.com>, I will send another patch using a cmd line
parameter to achieve the idea and solve the oom problem. Thanks for reporting
this bug.
