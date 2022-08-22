Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62D759C132
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiHVOB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiHVOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:00:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213DC31DFE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:00:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u6so8972023eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=1xFTGxtPnY5rz14UsZfYBsBqowiRgdh5xBnWEgT36ds=;
        b=v59zmBDYtRB+lVZpv+1Ag5zbMri2KBagr6ZKeFVLQy75tNiPJ1rM0ZhbeQHALFySWH
         IFO9pDQMz/bE10arladkmQA5wsuS5Nbf1fbmbYX3IpQNtfmhkGmX1pWOpfWMzRNZpU6X
         Jfix+MLXkkmL8r0nTh4WlJm8Ipe4vGqx0AiOlJi3fUBSVNJ7exJzk6FZ6BCa2EPk8hgx
         +XDVJeYCN8TGn7XjsfrMLjemNKBEjBxil1chEIk6j2SYxVPQ+YOORLgF7PqrPZ8prHmV
         XxucP/m3bqqlGNLwvSordUuZQVxhOdyIsbBKBcgnQuVP+KJhQ8yos6MyBM94EvAhcOBm
         tICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=1xFTGxtPnY5rz14UsZfYBsBqowiRgdh5xBnWEgT36ds=;
        b=SQgZFHGnqQfKD7HcBvGtqKS/WYqoLuP2sQ3gT+jJW7vAe0A83HT2H8KCVHJCG3w/zi
         RHsM5VqUyeDdlBWNAzXo0AQU1/wO/Yq8WHNyT0hzh4MqL1kWZSkOQfgMLAgHE/3hNBom
         ua0htJ3hNBe+SgtCCJ5z20pBkQQrzBBZ6XqO0vC43/LgWgpJdl+V+vl+7X4woxDqsC7/
         qj9V+kNBiIlYsLXkUk4Us1XuN3HhBfq5ZQtLseTqvqO03JJkGZ6UfY/Y47NnfOGzWeu0
         kZq02eHtuNfzmovTWMoXz+6OXaEyYLAU/Sz/1l9NPRXz6KOVvd1GYznIuu5k+6PWOxgw
         0rug==
X-Gm-Message-State: ACgBeo3S7qj0tnaU1pNHuEOpJBuV+/qFXXCJfH/b6q4c26hxk5t+DQfE
        NFmszCjBDx+66Ns27WFAGS4JrUZmr0i14BkoLaqfdBFMuphg2A==
X-Google-Smtp-Source: AA6agR5cRiKE8XqOz+NcGgEGpahFtal3270yjgEmkMdeEf7MFInCL5IdrjTe14coVeo/FF3SC8RjmC/D0lBogqHTLCM=
X-Received: by 2002:a05:6402:353:b0:446:2d2c:3854 with SMTP id
 r19-20020a056402035300b004462d2c3854mr13843348edw.193.1661176822067; Mon, 22
 Aug 2022 07:00:22 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Aug 2022 19:30:10 +0530
Message-ID: <CA+G9fYuecPu-n-ujLsv7vL8RjEJA-6rOZjc363+p1oo6v-FKKQ@mail.gmail.com>
Subject: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Rob Herring <robh@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 Qualcomm db410c device boot failed intermittently on
Linux next-20220822 and Linux mainline 6.0.0-rc1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    0.000000] Linux version 6.0.0-rc1 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils
for Debian) 2.38.90.20220713) #1 SMP PREEMPT @1661110347
[    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
<trim>
[    3.609382] Loading compiled-in X.509 certificates
[    3.702306] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[    3.702380] Mem abort info:
[    3.710225]   ESR = 0x0000000096000004
[    3.711454] s3: Bringing 0uV into 375000-375000uV
[    3.712713]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.717378] s4: Bringing 0uV into 1800000-1800000uV
[    3.721289]   SET = 0, FnV = 0
[    3.727634] l1: Bringing 0uV into 375000-375000uV
[    3.731266]   EA = 0, S1PTW = 0
[    3.731278]   FSC = 0x04: level 0 translation fault
[    3.735046] l2: Bringing 0uV into 1200000-1200000uV
[    3.739166] Data abort info:
[    3.742737] l4: Bringing 0uV into 1750000-1750000uV
[    3.746980]   ISV = 0, ISS = 0x00000004
[    3.746991]   CM = 0, WnR = 0
[    3.752504] l5: Bringing 0uV into 1750000-1750000uV
[    3.754966] [0000000000000008] user address but active_mm is swapper
[    3.754981] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    3.754991] Modules linked in:
[    3.755002] CPU: 1 PID: 10 Comm: kworker/u8:1 Not tainted 6.0.0-rc1 #1
[    3.760279] l6: Bringing 0uV into 1800000-1800000uV
[    3.763370] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    3.763378] Workqueue: events_unbound deferred_probe_work_func
[    3.767152] l7: Bringing 0uV into 1750000-1750000uV
[    3.771188] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.771199] pc : pl011_probe+0x30/0x154
[    3.778480] l8: Bringing 0uV into 1750000-1750000uV
[    3.783073] lr : amba_probe+0x11c/0x1b0
[    3.783086] sp : ffff800008073b50
[    3.783090] x29: ffff800008073b50 x28: 0000000000000000
[    3.787102] l9: Bringing 0uV into 1750000-1750000uV
[    3.792712]  x27: 0000000000000000
[    3.792720] x26: ffff80000af7a368 x25: ffff00000341f00d x24: ffff00003fcdce60
[    3.798382] l10: Bringing 0uV into 1750000-1750000uV
[    3.804432] x23: ffff80000adf0fb8 x22: 0000000000000000 x21: ffff000003c02800
[    3.804449] x20: ffff000003c029b0 x19: 0000000000000000
[    3.811003] l11: Bringing 0uV into 1750000-1750000uV
[    3.814850]  x18: ffffffffffffffff
[    3.814858] x17: 0000000000000000 x16: ffff00003fc4d040 x15: ffff000003c6fb8a
[    3.814874] x14: ffffffffffffffff
[    3.822730] l12: Bringing 0uV into 1750000-1750000uV
[    3.825611]  x13: 00000000000005cf x12: 071c71c71c71c71c
[    3.825623] x11: 00000000000005cf x10: 0000000000000c00 x9 : ffff8000088ead60
[    3.831391] l13: Bringing 0uV into 1750000-1750000uV
[    3.834290]
[    3.834293] x8 : ffff00000367ad60 x7 : ffff00003fc69ccc x6 : 0000000000000001
[    3.834310] x5 : ffff80000aa8f000
[    3.838735] l14: Bringing 0uV into 1750000-1750000uV
[    3.842798]  x4 : ffff80000aa8f2e8 x3 : 0000000000000000
[    3.842810] x2 : ffff80000b035380 x1 : 0000000000000000 x0 : ffff000003c02800
[    3.848640] l15: Bringing 0uV into 1750000-1750000uV
[    3.851134]
[    3.851138] Call trace:
[    3.859837] l16: Bringing 0uV into 1750000-1750000uV
[    3.863375]  pl011_probe+0x30/0x154
[    3.863389]  amba_probe+0x11c/0x1b0
[    3.863400]  really_probe+0xc8/0x3e0
[    3.871415] l17: Bringing 0uV into 3300000-3300000uV
[    3.875438]  __driver_probe_device+0x84/0x190
[    3.875450]  driver_probe_device+0x44/0x100
[    3.881633] l18: Bringing 0uV into 1750000-1750000uV
[    3.883860]  __device_attach_driver+0xa4/0x150
[    3.989109]  bus_for_each_drv+0x84/0xe0
[    3.992982]  __device_attach+0xb0/0x1f0
[    3.996714]  device_initial_probe+0x20/0x30
[    4.000533]  bus_probe_device+0xa4/0xb0
[    4.004699]  deferred_probe_work_func+0xa8/0xfc
[    4.008521]  process_one_work+0x1dc/0x450
[    4.013034]  worker_thread+0x2d0/0x450
[    4.017200]  kthread+0x108/0x110
[    4.020844]  ret_from_fork+0x10/0x20
[    4.024237] Code: 910e0042 d2800013 a9025bf5 aa0003f5 (f9400436)
[    4.027801] ---[ end trace 0000000000000000 ]---
[  137.808813] random: crng init done

ref:
https://lkft.validation.linaro.org/scheduler/job/5419258#L2278

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: e3f259d33c0ebae1b6e4922c7cdb50e864c81928
  git_describe: v6.0-rc1-409-ge3f259d33c0e
  kernel_version: 6.0.0-rc1
  kernel-config: https://builds.tuxbuild.com/2DgA4YUQ8t1rgsLXKtyXRLM7wdg/config
  vmlinux: https://builds.tuxbuild.com/2DgA4YUQ8t1rgsLXKtyXRLM7wdg/vmlinux.xz
  System.map: https://builds.tuxbuild.com/2DgA4YUQ8t1rgsLXKtyXRLM7wdg/System.map
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/618915641
  artifact-location: https://builds.tuxbuild.com/2DgA4YUQ8t1rgsLXKtyXRLM7wdg
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org
