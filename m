Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D78553FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355526AbiFVBLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiFVBLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:11:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622913204E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:11:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eq6so14389942edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DqCQfjcZfJ+ruuhSkMvBw9XJIfHviZVa7mY8XvJJhLs=;
        b=SLJUM6trAm7TO3ucIxX1VwKotldGWdIAwF+2+JPs2Rb0WOT0Pr/irD+RaeaoLh5JlF
         7cg+MqVf+Q/vRVER8umKWFwcv3kIwOWvUlkppgehx1QccUh1aBLc6RZtwVeAUrDGuvoJ
         XotRir3ilnfjGIaPMcya2V+71wHnW6EiqQOyncKdeL2kIvo0aGypjxI0xXUMgfVkNDAu
         34FeQjL9DskkkzzelvXLpFB8oLATx1gewBJCCvcOOSgNQIfIhuP/Y13HCTfLLCXFDbcj
         ZRq9SkWY52ag/wVbAynwp4Bp5h4TrHeuRmBgLHVz5HMHy6DZFG/0jLykm0uaTyAZ9PSm
         oNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DqCQfjcZfJ+ruuhSkMvBw9XJIfHviZVa7mY8XvJJhLs=;
        b=4logeEv1KvN48wCP1tdn3VKzfsA2GUJ0f4Z7bLF0VZDLYjtdmNQdjeJKiRoWPlGD8z
         GDDxqz1yqiScO2ruhn23nqpEh0+wlH54Vyt+yqv0sQeW6ObA2IiXHx/wxVQ7vwaX/4NR
         0nCHTLm+YH1bAvxdDbQZ80oqZIWeZmTRTAQE9B7DmBzdrcNdwlb9sEpTUj5zMNGYO0s6
         aMhCtA/IACHK3T2VB2QkkDEZJZx6lr8XKB5gwxeyI+0Tfq5fKFiKQXGhRUcXT2tefUZM
         lZg2Ry63BruSg8Jakmhkpw8n1y5pt1rxMYBFBiiOsPA5wDywC/5oRUMDTXmCFT7KkBTX
         Eaqg==
X-Gm-Message-State: AJIora9XR3zfD9RQfSTCb1Bjlq9vfXTmN6QTh60cU82CLwY2IzWTwe7B
        TjV7LHJ4d+sw3x+k82Bz143Yws9IKxKUy3aVA0xtDA==
X-Google-Smtp-Source: AGRyM1uz/tRqIq8YRugq2/2SBCewMkEcozj0l41jEk/kpZwBaB6ESrqjTZhYh/C3AJm3TktK1Xu3vGPzCwJawitcA/s=
X-Received: by 2002:a05:6402:249c:b0:431:3883:967a with SMTP id
 q28-20020a056402249c00b004313883967amr1135089eda.264.1655860301822; Tue, 21
 Jun 2022 18:11:41 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Jun 2022 06:41:30 +0530
Message-ID: <CA+G9fYv4S2TqZ53oH5FEK07qHV+LwkZEx7+KNiCa5wZWruDSfA@mail.gmail.com>
Subject: [next] Unable to handle kernel execute from non-executable memory at
 virtual address - devm_clk_release
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Peng Fan <peng.fan@nxp.com>
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

The following kernel crash was noticed on arm64 Raspberry Pi 4 Model B
devices while booting. This crash is always reproducible.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 1e502319853ceebfe7480a436ba22ab01372fa0c
  git_describe: next-20220620
  kernel_version: 5.19.0-rc3
  kernel-config: https://builds.tuxbuild.com/2ApqivCh2DP6v2QxI17B2GnWiUk/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/567830223
  artifact-location: https://builds.tuxbuild.com/2ApqivCh2DP6v2QxI17B2GnWiUk
  toolchain: gcc-11

Crash log:
----------
[    0.000000] Linux version 5.19.0-rc3-next-20220620
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU
ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1655717238
[    0.000000] Machine model: Raspberry Pi 4 Model B
<trim>

[   18.462465] Bluetooth: HCI UART protocol Broadcom registered
[   18.462543] Bluetooth: HCI UART protocol QCA registered
[   18.462633] Bluetooth: HCI UART protocol Marvell registered
[   18.464172] hci_uart_bcm serial0-0: supply vbat not found, using
dummy regulator
[   18.464478] hci_uart_bcm serial0-0: supply vddio not found, using
dummy regulator
[   18.464942] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   18.465655] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[   18.465683] cfg80211: failed to load regulatory.db
[   18.465928] bcm2835-power bcm2835-power: Timeout waiting for grafx power OK
[   18.472964] bcm2835-power bcm2835-power: Timeout waiting for grafx power OK
[   18.475203] raspberrypi-firmware soc:firmware: Request 0x00030066
returned status 0x80000001
[   18.475231] vc4-drm gpu: [drm] Couldn't stop firmware display driver: -22
[   18.490782] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])
[   18.500428] Unable to handle kernel execute from non-executable
memory at virtual address ffff000040241c10
[   18.500455] Mem abort info:
[   18.500465]   ESR = 0x000000008600000f
[   18.500477]   EC = 0x21: IABT (current EL), IL = 32 bits
[   18.500491]   SET = 0, FnV = 0
[   18.500503]   EA = 0, S1PTW = 0
[   18.500514]   FSC = 0x0f: level 3 permission fault
[   18.500527] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000020b6000
[   18.500542] [ffff000040241c10] pgd=18000000fbff8003,
p4d=18000000fbff8003, pud=18000000fbe2a003, pmd=18000000fbe28003,
pte=0068000040241707
[   18.500612] Internal error: Oops: 8600000f [#1] PREEMPT SMP
[   18.500624] Modules linked in: hci_uart vc4(+) btqca btbcm cec
bluetooth drm_display_helper cfg80211 crct10dif_ce v3d drm_cma_helper
clk_raspberrypi drm_shmem_helper reset_raspberrypi raspberrypi_hwmon
drm_kms_helper gpu_sched rfkill bcm2711_thermal iproc_rng200
pwm_bcm2835 i2c_bcm2835 drm rng_core pcie_brcmstb fuse
[   18.500752] CPU: 0 PID: 246 Comm: systemd-udevd Not tainted
5.19.0-rc3-next-20220620 #1
[   18.500765] Hardware name: Raspberry Pi 4 Model B (DT)
[   18.500772] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.500785] pc : 0xffff000040241c10
[   18.500800] lr : devm_clk_release+0x30/0x50
[   18.500817] sp : ffff80000b42b6f0
[   18.500823] x29: ffff80000b42b6f0 x28: ffff0000423bad50 x27: 0000000000000000
[   18.500845] x26: 00000000fffffdfb x25: ffff800009cc7d80 x24: ffff80000a98ea78
[   18.500866] x23: ffff80000a0d7008 x22: ffff000040241c10 x21: ffff80000b42b7a8
[   18.500886] x20: ffff00004893c600 x19: ffff00004893d300 x18: 000000003957dc32
[   18.500906] x17: 000000000000001c x16: 000000005d75779c x15: 00000000c3027b0d
[   18.500926] x14: 000000000000001a x13: 0000000000000000 x12: ffff000042d25338
[   18.500946] x11: 0000000000000040 x10: ffff000042d25240 x9 : ffff800008a4d774
[   18.500965] x8 : ffff000042d25268 x7 : 0000000000000000 x6 : ffff80000a98f000
[   18.500984] x5 : ffff800008a4d780 x4 : fffffc0001224f20 x3 : ffff00004893c700
[   18.501003] x2 : ffff80000886d9d0 x1 : ffff000040241c10 x0 : ffff000040104700
[   18.501022] Call trace:
[   18.501028]  0xffff000040241c10
[   18.501037]  release_nodes+0x64/0x104
[   18.501052]  devres_release_group+0xd8/0x14c
[   18.501063]  component_bind_all+0x144/0x290
[   18.501079]  vc4_drm_bind+0x118/0x2f4 [vc4]
[   18.501181]  try_to_bring_up_aggregate_device+0x230/0x320
[   18.501198]  component_master_add_with_match+0xbc/0x10c
[   18.501212]  vc4_platform_drm_probe+0xcc/0x10c [vc4]
[   18.501300]  platform_probe+0x74/0xf0
[   18.501318]  really_probe+0xc8/0x3f0
[   18.501331]  __driver_probe_device+0x11c/0x190
[   18.501344]  driver_probe_device+0x44/0x100
[   18.501357]  __driver_attach+0xd8/0x200
[   18.501370]  bus_for_each_dev+0x7c/0xe0
[   18.501381]  driver_attach+0x30/0x40
[   18.501393]  bus_add_driver+0x154/0x240
[   18.501405]  driver_register+0x84/0x140
[   18.501419]  __platform_driver_register+0x34/0x40
[   18.501434]  vc4_drm_register+0x5c/0x1000 [vc4]
[   18.501520]  do_one_initcall+0x50/0x2b0
[   18.501533]  do_init_module+0x50/0x200
[   18.501544]  load_module+0x1b80/0x1f40
[   18.501553]  __do_sys_finit_module+0xac/0x12c
[   18.501562]  __arm64_sys_finit_module+0x2c/0x40
[   18.501571]  invoke_syscall+0x50/0x120
[   18.501588]  el0_svc_common.constprop.0+0x104/0x124
[   18.501604]  do_el0_svc+0x3c/0xcc
[   18.501619]  el0_svc+0x38/0xc0
[   18.501633]  el0t_64_sync_handler+0xbc/0x140
[   18.501647]  el0t_64_sync+0x18c/0x190
[   18.501663] Code: 40a43e00 ffff0000 ffffffff 00000000 (40a43e00)
[   18.501674] ---[ end trace 0000000000000000 ]---


URL:
[1] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220620/testrun/10270853/suite/ltp-sched-tests/test/cfs_bandwidth01/details/
[2] https://lkft.validation.linaro.org/scheduler/job/5191948#L810


--
Linaro LKFT
https://lkft.linaro.org
