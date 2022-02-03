Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356FC4A8746
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351655AbiBCPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbiBCPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:08:22 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A7AC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:08:22 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id k31so9895342ybj.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E1ZrT3nLPqfEfRCxZGg+hZozRugpSOUTLsqqU6sZy4k=;
        b=DU0T67twNivLwY8tdXhMQ2+JrQXVanp4KlD6gz7ipbcMPHzdAM7npObfjKvkcEAx34
         Tne9URm4gbEolgcRiMstOXMSWjHSHzjsv2WHez5VmP/ne/JhFkeZIUQ9LHN6x3TnioWV
         yStSX4A8S7JBgAiZSCEsHU8b+x3Abjjh6kg15ucrRMsNHtutUkoscziQWGJpDjsaa0N6
         PV24XGUxzHhYe28+DFoL9izQLrRNn07n0NzGMvn8zH/11/CrVWYm0pzuju6FXIJ0KGIR
         Oy5y68/Ej5RNMwWGvMvxJRMI4u6iQpd8T4+SrI/3W+bGI/Rx+EeHYL+5olOOYzg00uRv
         oaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E1ZrT3nLPqfEfRCxZGg+hZozRugpSOUTLsqqU6sZy4k=;
        b=jU7XIc7Yt3RF37AtDGXg9XCUiSOJYqiR59cJ2wltwU/FwhOeRfvDbNgaQjz9GhnypB
         EmGEcmR6eYm2SzzrHTFbSrm35e0DFuh39YrIo6RV1ZIrEbyT2tm0OwrIDssoc4FVymj1
         vK4n/dHgByHXkS+mRuhxZzL9xjeOZB8QsO35wVocNtoprsNWF6Z0PPDiytKX6PfWF/mq
         HNDgb11ZRddpPsIDOpxP47pM7woB5HoEs4e0iw9pPPP+himBL/jna9GQGp2yrmNrGiYo
         AFNMtcw82pU8ngv4KWckoDJdyzS/AGEwrEqik5paqczleUeHWCA61wpPStIeETIukzaj
         YYyw==
X-Gm-Message-State: AOAM533TkBisHbxTbyNympOmnpeElw1gWUZIQnp9SrM9+0GKuK2UfWVK
        29U1rJUR4F4KaPtEjC57CI3NzTFloD2Z2/7/0PmELVHXlBoWvA==
X-Google-Smtp-Source: ABdhPJwrISjiWx5NrKsp+xwk0y09S4cihgDnrFrGi7IZHTd7ny6cO3vVk2wUU6GgYiSPGofKfX8zKlg3LxBEdjgYwu0=
X-Received: by 2002:a25:97c4:: with SMTP id j4mr48866296ybo.108.1643900900938;
 Thu, 03 Feb 2022 07:08:20 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 3 Feb 2022 20:38:09 +0530
Message-ID: <CA+G9fYtWKVPA_hGR6xyusf34=2vYE7qj4=739dOJDVUYJdkG8w@mail.gmail.com>
Subject: [next] qemu-arm: kasan: Unable to handle kernel NULL pointer
 dereference at virtual address 00000002
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While booting linux next 20220203 on qemu-arm the following
kernel crash was noticed with

CONFIG_KASAN=y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: 2d3d8c7643a56bfe2e808f97d5a4360d49f3b45b
  git describe: next-20220203
  make_kernelversion: 5.17.0-rc2
  kernel-config: https://builds.tuxbuild.com/24aNqQLzNsoEZKVK35BoE32uqLM/config


# crash log
 Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
         Starting Apply Kernel Variables...
         Mounting Kernel Configuration File System...
[    3.383096] EXT4-fs (vda): re-mounted. Quota mode: disabled.
[    3.434068] 8<--- cut here ---
[    3.435503] Unable to handle kernel NULL pointer dereference at
virtual address 00000002
[    3.439760] [00000002] *pgd=00000000
[    3.441612] Internal error: Oops: 5 [#1] SMP ARM
[    3.443779] Modules linked in:
[    3.445175] CPU: 0 PID: 157 Comm: systemd-journal Not tainted
5.17.0-rc2-next-20220203 #1
[    3.449337] Hardware name: Generic DT based system
[    3.452222] PC is at __read_once_word_nocheck+0x0/0x8
[    3.453068] 8<--- cut here ---
[    3.455077] LR is at unwind_frame+0x64c/0xa70
[    3.456562] Unable to handle kernel NULL pointer dereference at
virtual address 00000002
[    3.459046] pc : [<c0313ffc>]    lr : [<c03147f8>]    psr: 600d0013
[    3.459068] sp : c73e39e8  ip : c34d61e0  fp : 00000000
[    3.459087] r10: c73e3a70  r9 : 00000000  r8 : c73e3b00
[    3.459108] r7 : 809b47af  r6 : c28fa258  r5 : 00000002  r4 : 00000022
[    3.462628] [00000002] *pgd=00000000
[    3.466034] r3 : 00000022  r2 : 00000007  r1 : 00000000  r0 : 00000002
[    3.468728]
[    3.471490] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    3.484888] Control: 10c5383d  Table: 4764c06a  DAC: 00000051
[    3.488137] Register r0 information: non-paged memory
[    3.491155] Register r1 information: NULL pointer
[    3.493582] Register r2 information: non-paged memory
[    3.496629] Register r3 information: non-paged memory
[    3.499303] Register r4 information: non-paged memory
[    3.502290] Register r5 information: non-paged memory
[    3.504797] Register r6 information: non-slab/vmalloc memory
[    3.507951] Register r7 information: non-paged memory
[    3.510684] Register r8 information: non-slab/vmalloc memory
[    3.513940] Register r9 information: NULL pointer
[    3.516434] Register r10 information: non-slab/vmalloc memory
[    3.519805] Register r11 information: NULL pointer
[    3.522486] Register r12 information: non-slab/vmalloc memory
[    3.525701] Process systemd-journal (pid: 157, stack limit = 0x(ptrval))
[    3.529238] Stack: (0xc73e39e8 to 0xc73e4000)
[    3.531416] 39e0:                   c4084bb8 c73e3cb0 00000001
c59c5e80 c34d61e0 00004000
[    3.536285] 3a00: 00000002 c73e3b40 c73e3b4c c73e3b44 b7e7c748
c59c5e80 c73e3b48 c28fa258
[    3.540834] 3a20: 00000003 00000022 c73e3d90 c73e3ba0 c59c5e80
c0385928 c040c734 c288f4e0
[    3.545456] 3a40: 41b58ab3 c2772e74 c03141ac c59c65e4 c415dc90
c0570d00 c34d61e0 c73e4000
[    3.549942] 3a60: c73e3c28 c73e3ba0 c73e3bac c73e3ba4 e82aaa80
c5762030 c5762000 c59c7380
[    3.554343] 3a80: c6582a00 00000000 00000000 00000022 c4084cd0
00000002 c0394274 00000000
[    3.558939] 3aa0: 41b58ab3 c2772e74 c03141ac 00000064 000d000d
0000000e 000d000d 0000000d
[    3.563299] 3ac0: 0000000d c08c9c9c c4084c80 c4084cd0 00000001
c59c5e80 c098f0ac 00000cc0
[    3.567948] 3ae0: 00000000 c05610b4 c73e3bc0 c73e3bc4 c8d2b708
c73e3c28 c73e3d90 c73e3d90
[    3.572250] 3b00: 00000000 3d17bd2a c8d2b700 c59c5e80 b7e7c770
c59c5e80 00000000 c0394274
[    3.576874] 3b20: c5762000 c288f4e0 c73e3b64 c030da48 00000103
c73e3ba0 00000000 00000000
[    3.581392] 3b40: 00000022 c73e3d68 c0394274 c0394274 c73e3d38
3d17bd2a 00000000 c73e3be0
[    3.585961] 3b60: c73e3db4 c040c734 c03cd130 c59c5e80 b7e7c77c
c59c5e80 00000000 c0535938
[    3.590620] 3b80: 41b58ab3 c2784b1c c040c6b0 c030da48 c73e3cc0
c73e3c00 00000000 00000000
[    3.594827] 3ba0: 00000005 00000040 c73e3c00 00000001 c73e3b90
3d17bd2a 00600004 c73e3c40
[    3.599437] 3bc0: c412c938 c040c734 c03141ac c6427f84 00000001
3d17bd2a c0552084 3d17bd2a
[    3.603873] 3be0: c7653000 3d17bd2a c388eb80 c5762004 00000800
00000000 00000000 c0518a34
[    3.608502] 3c00: c04f13c4 c04cb360 c0518e38 c05175a0 c0394274
00000001 00000000 c59c5e80
[    3.613124] 3c20: b7e7c788 c388ec00 c73e3ca0 c0570d00 00000000
3d17bd2a 00000000 c8e74404
[    3.617461] 3c40: 41b58ab3 c278184c c03a784c c044e998 c8e74400
c288f4e0 c412c938 c04f13c4
[    3.622051] 3c60: 00000000 eff49240 e82ae5f8 25707000 00020d78
600f0093 c59c6154 c04f13c4
[    3.626495] 3c80: 00000002 ee5d5774 e82ae5ac 25707000 00020d78
00000000 eff49260 00000000
[    3.631247] 3ca0: 41b58ab3 c278c79c c04f1260 00000000 c3541780
c356f9e0 00000004 00000000
[    3.635850] 3cc0: 00000000 c0518b08 ee5d5c80 00000002 00000004
c04efd50 ffc00000 00000000
[    3.640440] 3ce0: 00000000 ee5d5c80 00000002 c3541780 00000022
c04cb360 c5762000 c3840400
[    3.645112] 3d00: ee5bd9c8 c5762000 c3840400 c051a320 c5762000
c0518e38 c5762000 c3840400
[    3.649694] 3d20: c0394274 000c49c8 ee5bd9c8 c3541240 c288f4e0
c05175a0 c1945ec0 00000000
[    3.654103] 3d40: 00000000 c0352894 e82aaa80 c5762030 c5762000
c59c7380 c6582a00 00000000
[    3.658541] 3d60: 00000000 c0394274 c3840900 c051a320 c8e74400
c0518e38 c8e74400 25707000
[    3.662916] 3d80: 00000080 c5762000 c59c7380 c59c5e80 ffffffff
c2ba0044 c388e900 c59c5e80
[    3.667693] 3da0: 25707000 c6582a00 00000000 c59c5e80 c73e3e9c
c18217a0 c8d2b700 00000020
[    3.672253] 3dc0: c4084c80 c0535938 00000000 c1822120 25707000
c2ba3a80 00000000 00000000
[    3.676873] 3de0: c59c6098 c59c5e88 b7e7c7c0 00000000 c73e3e60
e82ab0ac c73e3e60 c35110e0
[    3.681265] 3e00: 41b58ab3 c27811ac c1821204 c0996fe0 c2c669c0
b7e7c7c8 c73e3ea0 c59c5e80
[    3.685720] 3e20: 41b58ab3 00000000 c08c1660 00000000 00000000
c051a0dc c2ce47c0 c424bf40
[    3.690320] 3e40: 41b58ab3 c2780f04 c03904d4 c6427f90 00200004
c052cb64 00000011 c8e74400
[    3.694985] 3e60: 3d17bd2a 00000000 b7e7c7d8 c73e3f30 c59c5e80
3d17bd2a 005009c9 c59c5e80
[    3.699645] 3e80: c59c60a4 c03002c4 00000002 5ac3c35a c59c5e80
c73e3fb0 c73e3eac c1822120
[    3.704065] 3ea0: c59c5e80 c73e3ff0 b7e7c7dc c030d1c0 c73e3f80
c59c662c 5ac3c35a 00000000
[    3.708666] 3ec0: 41b58ab3 c278fa34 c0535ee8 c73e3f80 c73e3f40
00000000 ffffff9c c0532cc0
[    3.713135] 3ee0: 41b58ab3 c27725c0 c030d124 00000000 00000000
00000000 c7690840 b7e7c7e4
[    3.717788] 3f00: 41b58ab3 c279002c c0541f58 00000000 00000000
00000000 00000000 00000000
[    3.722331] 3f20: 00288000 00000000 00000000 00000000 00000000
00000000 c3510ba0 c03923e0
[    3.726739] 3f40: c642b010 c424bed8 c8d2b400 c59c5e80 c3510ba0
00000001 b68cc4ec c03855cc
[    3.731331] 3f60: c8d2b400 c59c5e80 00000001 00000006 c03002c4
c59c5e80 00000006 3d17bd2a
[    3.735933] 3f80: c8d2b400 3d17bd2a b68cb4f0 004fc3f4 005009c8
005009c9 00000142 c03002c4
[    3.740521] 3fa0: c59c5e80 00000142 b68ca36c c030012c 00000011
005009c9 002a8000 00000000
[    3.744964] 3fc0: 004fc3f4 005009c8 005009c9 00000142 00000000
00000000 00000010 b68ca36c
[    3.749357] 3fe0: 00000000 b68ca210 aeb3b000 aeabda08 600f0010
00000010 00000000 00000000
[    3.753837]  __read_once_word_nocheck from unwind_frame+0x64c/0xa70
[    3.757514]  unwind_frame from __save_stack_trace+0x70/0x94
[    3.760647]  __save_stack_trace from stack_trace_save+0x84/0xac
[    3.763890]  stack_trace_save from kasan_set_track+0x2c/0x4c
[    3.767299]  kasan_set_track from kasan_set_free_info+0x20/0x34
[    3.770511]  kasan_set_free_info from __kasan_slab_free+0xf8/0x12c
[    3.773754]  __kasan_slab_free from kmem_cache_free+0xb0/0x45c
[    3.777330]  kmem_cache_free from finish_task_switch+0x22c/0x3b4
[    3.780783]  finish_task_switch from __schedule+0x59c/0xeb4
[    3.783925]  __schedule from schedule+0x68/0xe0
[    3.786596]  schedule from do_work_pending+0x9c/0x6f8
[    3.789592]  do_work_pending from slow_work_pending+0xc/0x20
[    3.792690] Code: e8bd8070 eec11e10 e3a00000 e12fff1e (e5900000)
[    3.795729] Internal error: Oops: 5 [#2] SMP ARM
[    3.795842] ---[ end trace 0000000000000000 ]---
[    3.798610] Modules linked in:


full test log link,
https://lkft.validation.linaro.org/scheduler/job/4461318#L535

-- 
Linaro LKFT
https://lkft.linaro.org
