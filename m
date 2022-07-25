Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE9580111
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiGYO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiGYO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AC38E0CC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658760970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fVtWEF7Q3px4xo0k2ANsrekLA6cXdzwzFSOX5iKGoao=;
        b=BWm4G7yb3jrZaQEeOSO0VbEitH6VDHhtBPxQiPXTDlI6d4XNUcilUTbUmweCvi79VNC1R4
        E2bj/qvbiAeuaLNBbXLZFmKs+6rWD8lcV+qCUKcuR4srTebEQ1Oymnnv7VpYkkvbXFY+bt
        WHTv/mbxH6qnwJkp7CYMagfL2xOkl5U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-n9pEuludNzeYz8fLLV_IZA-1; Mon, 25 Jul 2022 10:56:08 -0400
X-MC-Unique: n9pEuludNzeYz8fLLV_IZA-1
Received: by mail-lf1-f70.google.com with SMTP id o20-20020ac24c54000000b0048a286ed00dso3467283lfk.14
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fVtWEF7Q3px4xo0k2ANsrekLA6cXdzwzFSOX5iKGoao=;
        b=2WDyO3G/tI+lQc18vj/vjEVEPxJGDSwWPMq8rIQLPzrJJnGUXsXFtAP4SqNr8sKFY4
         umFd+gaMLpa+hcrepY0/XLXRoDKjKmE9Ff+KVJwrqGt7Y+rhK4SsooNeEIV89wOaee3+
         aOj9Z9fhR3YovP12vZLme/Uis3oRlzck7s7xvOleizun2LEJuQ19cOFe4HOdo2XDpGv/
         OKGed5D88czSKZDxguAbxVVZ8UMbOKNf68AxKFRpDJE2hOkYObW0iCpQFedseoEE0Isb
         gghG0BNNfGgCMXid1/NOf08/YGuNmjSiaDkMx9kyXRdg0VM+/fisHIXAAAmR4+0J1Cvc
         rf8g==
X-Gm-Message-State: AJIora/aZoFln669BO9SSkmGsEFhYv4sWtXy14heiis45aoA0zAtHTcG
        LTUItMoCaezQB9DkmL2bcMKWUiZ1hr6m7S+TRTMZS8ATlKuFWPQEO6USFPYozrmzNhCSeSEn5g5
        y+nkEiSDWDAzs7cuJUQHtJZt3oudwrVG5wjS+qlcJ
X-Received: by 2002:a05:6512:218c:b0:48a:1e1e:7b59 with SMTP id b12-20020a056512218c00b0048a1e1e7b59mr4638675lft.580.1658760966949;
        Mon, 25 Jul 2022 07:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vHb2ab/9z/HB2DbLltHzK8i6dZSOWxXqZXlI7tUobBuwl++rVRWITwJjckJtPlELzgU02vrE6QNUzi32Xj0Yk=
X-Received: by 2002:a05:6512:218c:b0:48a:1e1e:7b59 with SMTP id
 b12-20020a056512218c00b0048a1e1e7b59mr4638670lft.580.1658760966655; Mon, 25
 Jul 2022 07:56:06 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Mon, 25 Jul 2022 16:55:55 +0200
Message-ID: <CA+QYu4pF9X2UwG+UtNmUqAeWX2oZxNTgh2z0DerZ0WdAWAkwBw@mail.gmail.com>
Subject: [i5000_edac] RIP: 0010:i5000_init_one+0x93b/0x9a0 [i5000_edac] - 5.19.0-rc8
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are seeing the following issue when booting up on a machine with i5000_e=
dac.

[   43.701521] kauditd_printk_skb: 39 callbacks suppressed
[   43.701531] audit: type=3D1130 audit(1658745813.705:136): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd=
"
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   43.702452] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   43.702463] CPU: 1 PID: 540 Comm: systemd-udevd Not tainted 5.19.0-rc8 #=
1
[   43.702469] Hardware name: HP ProLiant BL480c G1, BIOS I14 10/04/2007
[   43.702471] RIP: 0010:i5000_init_one+0x93b/0x9a0 [i5000_edac]
[   43.702485] Code: 00 00 bf 86 80 00 00 e8 93 8c 8c f3 48 85 c0 0f
84 68 01 00 00 48 89 45 20 e9 96 f8 ff ff c7 45 52 00 00 00 00 e9 b8
f9 ff ff <0f> 0b 48 8b ab 38 05 00 00 48 8b 7d 08 e8 23 67 8c f3 48 8b
7d 10
[   43.702489] RSP: 0018:ffffbc6c0036baf8 EFLAGS: 00010202
[   43.702496] RAX: 0000000000000000 RBX: ffff91178a9d1000 RCX: ffff9117847=
10800
[   43.702499] RDX: 0000000000000004 RSI: 0000000000040000 RDI: 00000000000=
00004
[   43.702502] RBP: 0000000000000008 R08: ffff911780e79c00 R09: ffff911780e=
79c46
[   43.702505] R10: 0000000000000018 R11: 0000000000000004 R12: ffff911784d=
05700
[   43.702508] R13: ffff911788bc7040 R14: 0000000000000004 R15: ffff9117810=
94000
[   43.702512] FS:  00007f8506c29b40(0000) GS:ffff9117aba40000(0000)
knlGS:0000000000000000
[   43.702516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.702519] CR2: 00007f85060c01a2 CR3: 0000000104ff8000 CR4: 00000000000=
006e0
[   43.702524] Call Trace:
[   43.702526]  <TASK>
[   43.702537]  ? _raw_spin_unlock+0x41/0x50
[   43.702551]  local_pci_probe+0x41/0x80
[   43.702559]  pci_device_probe+0xc3/0x240
[   43.702568]  really_probe+0x1cc/0x390
[   43.706803]  __driver_probe_device+0x10c/0x180
[   43.706814]  driver_probe_device+0x1f/0xb0
[   43.706821]  __driver_attach+0xcc/0x1d0
[   43.707326]  ? __device_attach_driver+0x100/0x100
[   43.707501]  bus_for_each_dev+0x79/0xc0
[
  OK   [[   43.707633]  bus_add_driver+0x183/0x230
0m] Reached targ[   43.707805]  driver_register+0x89/0xe0
et
loca[   43.707973]  ? 0xffffffffc0098000
l-fs-pr=C3=A2=E2=82=AC=C2=A6repara[   43.708201]  i5000_init+0x30/0x1000 [i=
5000_edac]
tion for Local F[   43.708404]  do_one_initcall+0x5d/0x320
[   43.708580]  ? rcu_read_lock_sched_held+0x3f/0x80
ile Systems.
[   43.708743]  ? trace_kmalloc+0x33/0xf0
[   43.708906]  ? kmem_cache_alloc_trace+0x1ad/0x280
[   43.709071]  do_init_module+0x4a/0x200
[   43.709302]  __do_sys_finit_module+0xb1/0x120
[   43.709467]  do_syscall_64+0x5b/0x80
[   43.709599]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   43.709765] RIP: 0033:0x7f8506f2807d
[   43.709891] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 dd 0c 00 f7 d8 64 89
01 48
[   43.710525] RSP: 002b:00007ffdb03c6e88 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   43.710829] RAX: ffffffffffffffda RBX: 000056036113b260 RCX: 00007f8506f=
2807d
[   43.711072] RDX: 0000000000000000 RSI: 00007f850750f453 RDI: 00000000000=
0000f
[   43.711311] RBP: 00007f850750f453 R08: 0000000000000000 R09: 00000000000=
00000
[   43.711627] R10: 000000000000000f R11: 0000000000000246 R12: 00000000000=
20000
[   43.711870] R13: 0000560361139a40 R14: 0000000000000000 R15: 00005603611=
3bd50
[   43.712119]  </TASK>
[   43.712194] Modules linked in: acpi_cpufreq(+) i5000_edac(+)
ipmi_si(+) i5k_amb ipmi_devintf ipmi_msghandler fuse zram xfs amdgpu
iommu_v2 gpu_sched radeon hpsa i2c_algo_bit drm_ttm_helper
scsi_transport_sas ttm drm_display_helper drm_kms_helper drm hpwdt cec
serio_raw
[   43.713116] ---[ end trace 0000000000000000 ]---
[   43.713290] RIP: 0010:i5000_init_one+0x93b/0x9a0 [i5000_edac]
[   43.713499] Code: 00 00 bf 86 80 00 00 e8 93 8c 8c f3 48 85 c0 0f
84 68 01 00 00 48 89 45 20 e9 96 f8 ff ff c7 45 52 00 00 00 00 e9 b8
f9 ff ff <0f> 0b 48 8b ab 38 05 00 00 48 8b 7d 08 e8 23 67 8c f3 48 8b
7d 10
[   43.714168] RSP: 0018:ffffbc6c0036baf8 EFLAGS: 00010202
[   43.714341] RAX: 0000000000000000 RBX: ffff91178a9d1000 RCX: ffff9117847=
10800
[   43.714587] RDX: 0000000000000004 RSI: 0000000000040000 RDI: 00000000000=
00004
[   43.714901] RBP: 0000000000000008 R08: ffff911780e79c00 R09: ffff911780e=
79c46
[   43.715140] R10: 0000000000000018 R11: 0000000000000004 R12: ffff911784d=
05700
[   43.715377] R13: ffff911788bc7040 R14: 0000000000000004 R15: ffff9117810=
94000
[   43.715623] FS:  00007f8506c29b40(0000) GS:ffff9117aba40000(0000)
knlGS:0000000000000000
[   43.715956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.716155] CR2: 00007f85060c01a2 CR3: 0000000104ff8000 CR4: 00000000000=
006e0
[   43.716508] Kernel panic - not syncing: Fatal exception
[   43.716718] Kernel Offset: 0x33000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   43.717096] ---[ end Kernel panic - not syncing: Fatal exception ]---

More logs:
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawa=
rehouse-public/2022/07/25/redhat:595514219/build_x86_64_redhat:595514219_x8=
6_64_debug/tests/2/results_0001/console.log/console.log

https://datawarehouse.cki-project.org/kcidb/tests/4509036

CKI issue tracker: https://datawarehouse.cki-project.org/issue/1426

Thanks,
Bruno Goncalves

