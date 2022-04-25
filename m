Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E973150DCDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbiDYJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiDYJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:38:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CF425582
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:32:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y2so7044863ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OTqbuIK1DgIN+t+AFXWclaCcT0XLUB+s5HyNp+CHk6E=;
        b=IgA93w9hDvtV0/h1s0VTS2eXZgqTiGHdWlaQd0dIvM439QjjNcU7UMs2GqvQD50zNl
         HCf3GRMaKJZLKG1uCJrtvVPV1cEXl+SvQO51K6AGtOYEYf++0h2W0Rqr33sqv8y6Rz6C
         fCxY1Izx8yw2OsIvK52b0FEV3x2NlPynM3tvc5Yx4SUtxfYB0rSl58wz6L7jJjwPabcX
         Id9bUqa+jCbX9QZ7UrhC+XEjEVisvVKoVCiIx6QeJI0KMP2UU3VkkT5wjTConyLVZzPd
         QTlPVUwqou5Ge+7NfOgoDFXKNuANaAxQ/WBlDOaocV4kWfL+Syvb1sXZ89mvInfJQpw5
         SL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OTqbuIK1DgIN+t+AFXWclaCcT0XLUB+s5HyNp+CHk6E=;
        b=cK+xGcwkF2wkwaCj3lNTAgyqzTGcsGVx8ENw4vSJJn5tTr73uEFsv9WaN4h9iaIQK5
         URzdFUY+n+hG+WgADZQzAJ8zizhJDSsuMBLrS2Gl0Oe9HbhCsBmDZjmQULJBzzODST+E
         2VgQNyyeZaticp4/kclAuWurR7Kv0/aaXmxv+fZibW3rPH9i5ozN+Wuy9KPVPsgOJMsJ
         3rcjY4Cwzx5lSuVRjtW8UPxfTeL+0X9psbpe7mf2916Q8j0C939T5FMD5mexiG80AKQZ
         tw2Rss7Q7GksZPv4Cd5L2ivP8tODvCR9yPqLyadyPPYnJHb5vDw/uhzjGnOKWDnVdHJi
         yfWA==
X-Gm-Message-State: AOAM532UtpVJrqb3OXDsVrw42x8nG4BqQAAg86/3JGJX0H6ojga8mg8g
        g1MWBEz8jHRVm4K08OV11vdUm5vFLKeBF7/nCsV5oqNdPGM=
X-Google-Smtp-Source: ABdhPJzuRTkXGTWadoEgv2SRtbljYVTgRysWX1dMJy4PeDwIlB5WnSjMK5PBwe5nTtD2EhbiRIqaGNrHC430LC0anmo=
X-Received: by 2002:a81:2d03:0:b0:2f4:d064:6d26 with SMTP id
 t3-20020a812d03000000b002f4d0646d26mr15308983ywt.397.1650879158410; Mon, 25
 Apr 2022 02:32:38 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Mon, 25 Apr 2022 17:32:27 +0800
Message-ID: <CAAJw_Zu-PLbM3SGaJVFgGjJUm5y6Ptt9Fd5C1QgNP3_eixS7-Q@mail.gmail.com>
Subject: Linux 5.18.0-rc4 ... only 256 entropy on Intel Tiger Lake i9-11950H
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I need some help.  I can't increase the entropy on this new system. It
only returns 256, with or without haveged. This is not just -rc4 issue
... more of a Tiger Lake issue or just specific to i9-11950H.

# cat /proc/sys/kernel/random/entropy_avail
256

# git log
commit af2d861d4cd2a4da5137f795ee3509e6f944a25b (HEAD -> master, tag:
v5.18-rc4, origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Apr 24 14:51:22 2022 -0700
    Linux 5.18-rc4


On other systems, I don't recall seeing this issue. This is a new
system with Intel Tiger Lake i9-11950H.


# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 141
model name      : 11th Gen Intel(R) Core(TM) i9-11950H @ 2.60GHz
stepping        : 1
microcode       : 0x3c
cpu MHz         : 2601.000
cache size      : 24576 KB
physical id     : 0
siblings        : 16
core id         : 0
cpu cores       : 8
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 27
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq
pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
cpuid_fault epb cat_l2 invpcid_single cdp_l2 ssbd ibrs ibpb stibp
ibrs_enhanced tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdt_a avx512f avx512dq
rdseed adx smap avx512ifma clflushopt clwb intel_pt avx512cd sha_ni
avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves split_lock_detect
dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
hwp_pkg_req avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes
vpclmulqdq avx512_vnni avx512_bitalg tme avx512_vpopcntdq rdpid
movdiri movdir64b fsrm avx512_vp2intersect md_clear ibt flush_l1d
arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only
ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid
unrestricted_guest vapic_reg vid ple shadow_vmcs pml
ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs
bogomips        : 5222.40
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:



My best,
Jeff




My best.,
Jeff
