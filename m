Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190EA4E606A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbiCXIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348945AbiCXIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:36:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAD89BBBF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:34:37 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f38so7201861ybi.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=H9C4iWK8tDBUB2K5MoYQ8IdbBv0hhGC6J226BwafzxE=;
        b=H7odm9u2iOSLi/nihkTQfBQorXUM+ZN70jCp94YAZ3j+ckOqi0H4n6jyrQiYWl2Egr
         IAsZaCKqNrLx46C464qulxmTb1o5WcBGqhKTlFmK+azFulF0rBFzfj/o5p5bSp1uNrgE
         IoUMcTLRd7Cpdsl5GsoKQxZXbwnGAcG4a86yTv4x6CMOALKPhuzCGVADuB8uEcMBfs4I
         V/M+efs8nV+tZ3p3EAbOM2SedtGBpqSB+5uZihZIy0tkmFFpv8BzN0Eubaqvv7hp4zv7
         sd6839XCDs1tMm9XtakWMAjl4QSQbmcHpvBVcgU83FJgtvriKQx2wanW4agjgTg2GyE8
         QfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=H9C4iWK8tDBUB2K5MoYQ8IdbBv0hhGC6J226BwafzxE=;
        b=oVZgBx182YgGwCcagc/W2/EgwlLipRWAyE1hF4nPMhM4/KZ326bjjiWDCstsomCDDY
         vfWCsuqM5eK9ccTzwm7Qj5D7BppUqn9JsdDzZ5FjQ9fIjCYFCpYDefrF++5oou6VGPmA
         ZIE0HlLEzu+0Z/6Cy32ZjNYFBuYz2kSX1RG+4Cf1Y++t3g65lMgUprmkNoEp9+fPOd9x
         PwAmNQSmPao8RGjzVl+O2GchSLvjehE968DsSX0Lc68+S9+LBKfZrn66ASxynWrZXmGO
         27h8n0Hd9PKGhKImu4OJXQ+EeF+qIhbWUoNgL++zJAz3r3Zx0mD5dgJukptykryDcUMA
         CTFw==
X-Gm-Message-State: AOAM533kDuXEKxnsO7jdzYct1qZQ3L809achyZhcJQi/mumDDL6d3mSi
        z+4RFLbqQvelJ5EqVqimeY1Z9t7Mp7MA9uk6YDRhOw==
X-Google-Smtp-Source: ABdhPJzrkUM3IpVhOLboqwyW3cmXm7ecsw+EVoB/yCuf6ABxuBjLQrPhojDDbzjBImQU5zArt++DZ0Fmw9ZG3R0Oahc=
X-Received: by 2002:a25:548:0:b0:633:81bd:e319 with SMTP id
 69-20020a250548000000b0063381bde319mr3600207ybf.603.1648110877037; Thu, 24
 Mar 2022 01:34:37 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 24 Mar 2022 14:04:23 +0530
Message-ID: <CA+G9fYtZpazsDTQo9N-4U=T5QvEKTu_xDi=W+1_7ng51306LYg@mail.gmail.com>
Subject: next: BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
To:     linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running kselftest zram test cases on Linux next-20220324 the kernel BUG
reported on arm64 Qcom db845 development board.

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: b61581ae229d8eb9f21f8753be3f4011f7692384
  git_describe: next-20220323
  kernel_version: 5.17.0
  kernel-config: https://builds.tuxbuild.com/26mKdspULB326eo6s22cXZzYhmt/config

Log:
[    0.000000] Linux version 5.17.0-next-20220323 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils
for Debian) 2.38) #1 SMP PREEMPT @1648023452
[    0.000000] Machine model: Thundercomm Dragonboard 845c

# running zram tests
# --------------------
# create '1' zram device(s)
# zram load module successful
# set max_comp_streams to zram device(s)
# FAIL can't set max_streams '2', get
# /sys/block/zram0/max_comp_streams = '8' (1/1)
# z[  626.759707] zram0: detected capacity change from 0 to 4096
ram max streams: OK
# test that we can set compression algorithm
# supported algs: lzo [lzo-rle] lz4 lz4hc 842
# /sys/block/zram0/comp_algorithm = 'lzo' (1/1)
# zram set compression algorithm: OK
# set disk size to zram device(s)
# /sys/block/zram0/disksize = '2097152' (1/1)
# zram set disksizes: OK
# set memory limit to zram device(s)
# /sys/block/zram0/mem_limit = '2M' (1/1)
# zram set memory limit: OK
# make ext4 filesystem on /dev/zram0
# zram mkfs.ext4: OK
# mount /dev/zram0
[  626.812708] EXT4-fs (zram0): mounted filesystem without journal.
Quota mode: none.
[  626.820412] ext4 filesystem being mounted at
/opt/kselftests/default-in-kernel/zram/zram0 supports timestamps until
2038 (0x7fffffff)
# zram mount of zram device(s): OK
# fill zram0...
# zram0 can be filled with '1932' KB
# zram used 12M, zram disk sizes 2097152M
# zram compression ratio: 174762.66:1: OK
# zram cleanup
[  636.589363] zram0: detected capacity change from 4096 to 0
# zram rmmod zram
[  636.607315] zram: Removed device: zram0
[  636.682510] BUG: sleeping function called from invalid context at
block/blk-sysfs.c:766
[  636.690716] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
0, name: swapper/0
[  636.698836] preempt_count: 101, expected: 0
[  636.703169] RCU nest depth: 0, expected: 0
[  636.707410] INFO: lockdep is turned off.
[  636.711471] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-next-20220323 #1
[  636.718729] Hardware name: Thundercomm Dragonboard 845c (DT)
[  636.724485] Call trace:
[  636.726988]  dump_backtrace+0xc0/0x134
[  636.730823]  show_stack+0x24/0x7c
[  636.734210]  dump_stack_lvl+0x8c/0xb8
[  636.737949]  dump_stack+0x18/0x34
[  636.741333]  __might_resched+0x1c8/0x240
[  636.745334]  __might_sleep+0x5c/0x94
[  636.748981]  blk_release_queue+0x38/0x100
[  636.753070]  kobject_put+0xa4/0x210
[  636.756631]  blk_put_queue+0x20/0x30
[  636.760278]  blkg_free.part.0+0x68/0xa0
[  636.764191]  __blkg_release+0x50/0x74
[  636.767926]  rcu_core+0x410/0xb90
[  636.771316]  rcu_core_si+0x1c/0x2c
[  636.774789]  __do_softirq+0x14c/0x654
[  636.778522]  __irq_exit_rcu+0x17c/0x1b0
[  636.782436]  irq_exit_rcu+0x1c/0x44
[  636.785998]  el1_interrupt+0x38/0x64
[  636.789645]  el1h_64_irq_handler+0x18/0x24
[  636.793813]  el1h_64_irq+0x64/0x68
[  636.797284]  cpuidle_enter_state+0xe4/0x380
[  636.801544]  cpuidle_enter+0x44/0x5c
[  636.805191]  do_idle+0x240/0x2d0
[  636.808484]  cpu_startup_entry+0x34/0x3c
[  636.812479]  rest_init+0x1c8/0x2d0
[  636.815951]  arch_call_rest_init+0x1c/0x28
[  636.820126]  start_kernel+0x73c/0x77c
[  636.823861]  __primary_switched+0xc0/0xc8
# zram01 : [PASS]
#
# create '1' zram device(s)
[  636.859790] zram: Added device: zram0
# zram load module successful
# set max_comp_streams to zram device(s)
# FAIL can't set max_streams '2', get
# /sys/block/zram0/max_comp_streams = '[  637.901396] zram0: detected
capacity change from 0 to 2048
8' (1/1)
# zram max streams: OK
# set disk size to zram device(s)
# /sys/block/zram0/disksize = '1048576' (1/1)
# zram set disksizes: OK
# set memory limit to zram device(s)
# /sys/block/zram0/mem_limit = '1M' (1/1)
# zram set memory limit: OK
# make swap with zram device(s)
[  637.935258] Adding 1020k swap on /dev/zram0.  Priority:-2 extents:1
across:1020k SS
# done with /dev/zram0
# zram making zram mkswap and swapon: OK
# zram swapoff: OK
# zram cleanup
[  637.995603] zram0: detected capacity change from 2048 to 0
# zram rmmod zram
[  638.012764] zram: Removed device: zram0
[  638.110836] BUG: sleeping function called from invalid context at
block/blk-sysfs.c:766
[  638.118965] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
0, name: swapper/7
[  638.126928] preempt_count: 101, expected: 0
[  638.131179] RCU nest depth: 0, expected: 0
[  638.135349] INFO: lockdep is turned off.
[  638.139350] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W
  5.17.0-next-20220323 #1
[  638.147964] Hardware name: Thundercomm Dragonboard 845c (DT)
[  638.153687] Call trace:
[  638.156170]  dump_backtrace+0xc0/0x134
[  638.159977]  show_stack+0x24/0x7c
[  638.163332]  dump_stack_lvl+0x8c/0xb8
[  638.167049]  dump_stack+0x18/0x34
[  638.170408]  __might_resched+0x1c8/0x240
[  638.174387]  __might_sleep+0x5c/0x94
[  638.178004]  blk_release_queue+0x38/0x100
[  638.182071]  kobject_put+0xa4/0x210
[  638.185599]  blk_put_queue+0x20/0x30
[  638.189216]  blkg_free.part.0+0x68/0xa0
[  638.193106]  __blkg_release+0x50/0x74
[  638.196811]  rcu_core+0x410/0xb90
[  638.200168]  rcu_core_si+0x1c/0x2c
[  638.203612]  __do_softirq+0x14c/0x654
[  638.207314]  __irq_exit_rcu+0x17c/0x1b0
[  638.211196]  irq_exit_rcu+0x1c/0x44
[  638.214727]  el1_interrupt+0x38/0x64
[  638.218346]  el1h_64_irq_handler+0x18/0x24
[  638.222493]  el1h_64_irq+0x64/0x68
[  638.225934]  cpuidle_enter_state+0xe4/0x380
[  638.230170]  cpuidle_enter+0x44/0x5c
[  638.233787]  do_idle+0x240/0x2d0
[  638.237060]  cpu_startup_entry+0x34/0x3c
[  638.241034]  secondary_start_kernel+0x148/0x170
[  638.245616]  __secondary_switched+0xa0/0xa4
# zram02 : [PASS]

steps to produce:
   # cd  /opt/kselftests/default-in-kernel/zram/
   # ./zram.sh

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org

[1] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220323/testrun/8654494/suite/linux-log-parser/test/check-kernel-bug-4772266/log
[2] https://lkft.validation.linaro.org/scheduler/job/4772266#L5186
