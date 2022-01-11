Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551B248AA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349144AbiAKJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236605AbiAKJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641891964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HaI/jWbysl58EI15Sr3zu9lR3dI5d3qUoMo2OpLk8Ok=;
        b=eYbwKlao4umicT32VzOSRD7kBlwmSJVLrMOa2QaFHRUt64CDE3OnAmCqJE74l5WWHQ0sDY
        7gLB2Wba53r+MJlkvEDxAFtl/Ae86WowkNOy3ziXxlTenb6rdY3ldJHehIZUyqVIC8VC5f
        0ciJgFsSMKZ4d9BPU83zI7VhZjkq+U8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-aHKdytIiOUK7Izoh_G5LJA-1; Tue, 11 Jan 2022 04:06:02 -0500
X-MC-Unique: aHKdytIiOUK7Izoh_G5LJA-1
Received: by mail-oo1-f70.google.com with SMTP id g2-20020a4a9242000000b002da7c459222so10355017ooh.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HaI/jWbysl58EI15Sr3zu9lR3dI5d3qUoMo2OpLk8Ok=;
        b=V1gGipCHFe9eEh1MhFMSPkf3yW0i3XujbfmPei8BSX9xbqP//hO81NTEObOHwkilZg
         u7venQeWQ4Kf90CzKhFQ2SIAqenJRAtUeBLhMbpawFB4HcfXEVkPgUttGZULDPkd51Z1
         rM2zOj77IT9W1hYLjEfG4ZcF5oKzKMrLyKyO0UCWopqHjx38vbkG1QjoNPWe5yXKfHh+
         r+B6Sggvpq69G2Ajmj8DW6cDJt5qSdMgdIjJ14xurExQ9hIIb1QIoMJMRtVtjbUEhhdO
         nb14ZJau9Xn+ETvTw3aPBuNeVxn1Ehx+iH2l4pl9AEQc8yED6PHO4DhGaTidtVVgU9Ab
         Is9w==
X-Gm-Message-State: AOAM5313hEPysazHoliACgMFhaxu2w+ggXKVKmuUSQ+xlGvzhSC/DWz5
        Z4R9OcbzH0nLOnYBC9TWlIGZ/O4MzulDerxIxWNM3Qrvdxh4JkMaZdWFaFmr60UZnW/K6LhH0/S
        YJ/TK4pOURgfk6+FD8us0uUbEFiT8/PAxmRksep5M
X-Received: by 2002:a4a:d5d5:: with SMTP id a21mr2504378oot.43.1641891960847;
        Tue, 11 Jan 2022 01:06:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj5mn+WcxzRnoeaX/CG7Pxpbr41rDUwEREnj+QXLjzAqfHG+ZL45o+6wiZUcZjbeLLkfxyBMhJk4pttOzyVg0=
X-Received: by 2002:a4a:d5d5:: with SMTP id a21mr2504368oot.43.1641891960531;
 Tue, 11 Jan 2022 01:06:00 -0800 (PST)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 11 Jan 2022 10:05:49 +0100
Message-ID: <CA+QYu4rt2VHWzbOt-SegA9yABqC-D36PoqTZmy6DscWvp+6ZMQ@mail.gmail.com>
Subject: Boot issue on x86_64: kernel 5.16.0 - RIP: 0010:radeon_vm_fini+0x174/0x300
 [radeon]
To:     linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've started to see the issue below when booting on x86_64 on recent
kernel builds. The first occurrence we've hit was from commit:
8d0749b4f83b - Merge tag 'drm-next-2022-01-07'. More logs can be found
on [1] and CKI issue tracker [2].

[    5.270805] [drm] PCI GART of 512M enabled (table at 0x0000000002F00000).
[    5.277630] radeon 0000:01:05.0: WB disabled
[    5.281909] radeon 0000:01:05.0: fence driver on ring 0 use gpu
addr 0x00000000b8000000
[    5.290043] [drm] radeon: irq initialized.
[    5.294169] [drm] Loading R100 Microcode
[    5.299311] [drm] radeon: ring at 0x00000000B8001000
[    5.304319] [drm] ring test succeeded in 0 usecs
[    5.309412] [drm] ib test succeeded in 0 usecs
[    5.314216] [drm] Radeon Display Connectors
[    5.318409] [drm] Connector 0:
[    5.321465] [drm]   VGA-1
[    5.324090] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[    5.330097] [drm]   Encoders:
[    5.333067] [drm]     CRT1: INTERNAL_DAC1
[    5.337104] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    5.344049] #PF: supervisor read access in kernel mode
[    5.349182] #PF: error_code(0x0000) - not-present page
[    5.354325] PGD 0 P4D 0
[    5.356862] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    5.361218] CPU: 0 PID: 89 Comm: kworker/0:2 Not tainted 5.16.0 #1
[    5.367393] Hardware name: Dell Inc. PowerEdge R805/0GX122, BIOS
4.2.1 04/14/2010
[    5.374866] Workqueue: events work_for_cpu_fn
[    5.379223] RIP: 0010:radeon_vm_fini+0x174/0x300 [radeon]
[    5.384794] Code: e8 83 4c 88 d5 eb d1 4c 8b 24 24 4d 8d 74 24 48
49 8b 5c 24 48 49 39 de 74 38 66 2e 0f 1f 84 00 00 00 00 00 66 90 4c
8d 7b a8 <48> 8b 2b 48 8d 7b 18 e8 30 1e f4 ff 48 83 c3 c0 48 89 df e8
34 f3
[    5.403527] RSP: 0018:ffffb641c0c5bc48 EFLAGS: 00010286
[    5.408740] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    5.415866] RDX: 0000000000000001 RSI: ffff892ef3911730 RDI: ffff892ef3911750
[    5.422993] RBP: 0000000000000001 R08: 0000000000200000 R09: 0000000000000000
[    5.430121] R10: 0000000000000000 R11: ffffffffc0412810 R12: ffff892ef3911730
[    5.437248] R13: ffff892ef41f2800 R14: ffff892ef3911778 R15: ffffffffffffffa8
[    5.444385] FS:  0000000000000000(0000) GS:ffff892f3dc00000(0000)
knlGS:0000000000000000
[    5.452456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.458196] CR2: 0000000000000000 CR3: 0000000033896000 CR4: 00000000000006f0
[    5.465333] Call Trace:
[    5.467784]  <TASK>
[    5.469886]  radeon_driver_open_kms+0x118/0x180 [radeon]
[    5.475271]  drm_file_alloc+0x1a8/0x230 [drm]
[    5.479696]  drm_client_init+0x99/0x130 [drm]
[    5.484086]  drm_fb_helper_init+0x32/0x50 [drm_kms_helper]
[    5.489620]  radeon_fbdev_init+0xbc/0x110 [radeon]
[    5.494474]  radeon_modeset_init+0x857/0x9e0 [radeon]
[    5.499588]  radeon_driver_load_kms+0x19b/0x290 [radeon]
[    5.504968]  drm_dev_register+0xf5/0x2d0 [drm]
[    5.509452]  radeon_pci_probe+0xc3/0x120 [radeon]
[    5.514223]  local_pci_probe+0x40/0x90
[    5.517972]  work_for_cpu_fn+0x16/0x20
[    5.521720]  process_one_work+0x1a4/0x350
[    5.525729]  worker_thread+0x32c/0x440
[    5.529477]  kthread+0x18d/0x1b0
[    5.532706]  ? worker_clr_flags+0x50/0x50
[    5.536705]  ? kthread_blkcg+0x30/0x30
[    5.540460]  ret_from_fork+0x22/0x30
[    5.544042]  </TASK>
[    5.546219] Modules linked in: radeon(+) ata_generic drm_ttm_helper
pata_acpi ttm i2c_algo_bit uas drm_kms_helper cec mptsas(+) mptscsih
mptbase drm serio_raw sata_nv scsi_transport_sas usb_storage nv_tco
[    5.564379] CR2: 0000000000000000
[    5.567694] ---[ end trace 9b8d78916aa931d1 ]---
[    5.571540] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.572307] RIP: 0010:radeon_vm_fini+0x174/0x300 [radeon]
[    5.583875] Code: e8 83 4c 88 d5 eb d1 4c 8b 24 24 4d 8d 74 24 48
49 8b 5c 24 48 49 39 de 74 38 66 2e 0f 1f 84 00 00 00 00 00 66 90 4c
8d 7b a8 <48> 8b 2b 48 8d 7b 18 e8 30 1e f4 ff 48 83 c3 c0 48 89 df e8
34 f3
[    5.597666] ata1.00: ATAPI: TEAC DVD-ROM DV28SV, D.0E, max UDMA/100
[    5.602614] RSP: 0018:ffffb641c0c5bc48 EFLAGS: 00010286
[    5.602617] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    5.602619] RDX: 0000000000000001 RSI: ffff892ef3911730 RDI: ffff892ef3911750
[    5.628325] RBP: 0000000000000001 R08: 0000000000200000 R09: 0000000000000000
[    5.635461] R10: 0000000000000000 R11: ffffffffc0412810 R12: ffff892ef3911730
[    5.642578] R13: ffff892ef41f2800 R14: ffff892ef3911778 R15: ffffffffffffffa8
[    5.647647] ata1.00: configured for UDMA/100
[    5.649713] FS:  0000000000000000(0000) GS:ffff892f3dc00000(0000)
knlGS:0000000000000000
[    5.649715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.649717] CR2: 0000000000000000 CR3: 0000000033896000 CR4: 00000000000006f0
[    5.674914] Kernel panic - not syncing: Fatal exception
[    5.680146] Kernel Offset: 0x14000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    5.690915] ---[ end Kernel panic - not syncing: Fatal exception ]---

[1] https://datawarehouse.cki-project.org/kcidb/tests/2231405
[2] https://datawarehouse.cki-project.org/issue/885

Thanks,
Bruno

