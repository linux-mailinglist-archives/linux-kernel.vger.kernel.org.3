Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9D4F2470
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiDEHS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiDEHRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C89FC39
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649142900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0KESFJpFG3i3pxsW2N2ptcGauLCGHf0FWKOD81uiwJA=;
        b=NUBaThkUmT8s5HvTh1S/V6EKCA4T7m09ub48giKL9AQMzqzuRU7+Zws/U5bTwyhtxqlbO7
        jd2dT8+1E94kPGh37xvBK15OY2iCoKeSQX5SHlwHELXQ3m9uAQ9n3B15L2GvfaYPmC5eBi
        9CfUXIpVI34ue5Ytf11RqFqtIstBNYI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-xQMthK6BN7ydxa6XqjIJMQ-1; Tue, 05 Apr 2022 03:14:59 -0400
X-MC-Unique: xQMthK6BN7ydxa6XqjIJMQ-1
Received: by mail-lj1-f198.google.com with SMTP id u23-20020a2e91d7000000b0024af1c6036bso3553476ljg.18
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 00:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0KESFJpFG3i3pxsW2N2ptcGauLCGHf0FWKOD81uiwJA=;
        b=gb9MjoNxNIQXX1MELpkcItRHyeodw/nDCqEBmiILIYCRe+7K11JWKrXIT03AILYdNC
         jE+Jsa8mS1mutf353oTJg5COS7PzR/x2RW43tDcxjtwARlGqauG/etOzIVsRo0q+8s3g
         Z1rLltprx+OhoO13iQC8BokArVZDDLmurujKZ3bVBzcOOnpaVqIED5w/sHip6JALG36p
         5CtuG/4x+YtZkTMzNBDfKe6hCBdyHQbuoLz1Jv7HAG+Jc6u6xTwQfi+aj/a9UWPUEscG
         0lXkBVNoWaydK2sHPvWXo683zsTfa8GjWWOrLTKaJ5mkB3QskC6euie1XcihcXql4jJD
         eTkQ==
X-Gm-Message-State: AOAM531Zi2d2cSql2+hy6Fs4+jjum9q0bD0qkSUiYA8cGsGoJ8ARlKtw
        Lk6LYuDAyEPrJ/W3UDDZLveEZlMgbNurCgbxTkwitdTwW8mN7Tc2U+de6DDgg+gMHJXlGP7PTKN
        JHZ1pC86bw1PbWo5zi+dlT+VoGrJXCzF4LzyV6eZI
X-Received: by 2002:a05:6512:158d:b0:44a:6522:f98f with SMTP id bp13-20020a056512158d00b0044a6522f98fmr1629370lfb.608.1649142897156;
        Tue, 05 Apr 2022 00:14:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXWkIXQ2yaDuZ7xy+aahBe9sSc1J/C82VOMG4OVssTKHeXkE/YjRRRyNyEDzPx6Ke74bqWBT9bQKl4BiUDEWE=
X-Received: by 2002:a05:6512:158d:b0:44a:6522:f98f with SMTP id
 bp13-20020a056512158d00b0044a6522f98fmr1629346lfb.608.1649142896819; Tue, 05
 Apr 2022 00:14:56 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 5 Apr 2022 09:14:46 +0200
Message-ID: <CA+QYu4qTtXgVegAd7S5bjJQye+kmtPaFau4dg3YPU2tH9faBjg@mail.gmail.com>
Subject: RIP: 0010:ahd_init.cold+0x96/0x98 [aic79xx] - 5.17.0
To:     LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've been hitting the panic below when testing mainline kernel. More logs
can be found on [1] and CKI tracker [2].

[   11.285026] megaraid: fw version:[1N39] bios version:[G119]
[   11.287477] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   11.295683] CPU: 2 PID: 268 Comm: systemd-udevd Not tainted 5.17.0 #1
[   11.302135] Hardware name: Intel MP Server/S5000VSA  , BIOS
S5000.86B.02.00.0054.061520062205 06/15/2006
[   11.311613] RIP: 0010:ahd_init.cold+0x96/0x98 [aic79xx]
[   11.316870] Code: d8 36 00 00 48 c7 c7 20 35 22 c0 e8 7b 03 c3 fa
e9 ca 91 ff ff 48 8b b5 d8 36 00 00 48 c7 c7 e8 34 22 c0 e8 63 03 c3
fa eb b0 <0f> 0b 48 8b b3 d8 36 00 00 89 c2 48 c7 c7 68 36 22 c0 e8 4a
03 c3
[   11.335624] RSP: 0018:ffffa5548052ba70 EFLAGS: 00010282
[   11.340863] RAX: ffff97d20093bbb0 RBX: 0000000000000009 RCX: 0000000000000001
[   11.348002] RDX: 0000000000000000 RSI: ffffffffbb83b4f5 RDI: ffffffffbb8c61b6
[   11.355144] RBP: ffff97d2024d0000 R08: 0000000000000a20 R09: 0000000000000000
[   11.362285] R10: ffff97d20093bbb0 R11: 000000006fb8abda R12: 0000000000000008
[   11.369424] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   11.376564] FS:  00007fdb263c1580(0000) GS:ffff97d25bc80000(0000)
knlGS:0000000000000000
[   11.384658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.390411] CR2: 000056514f8c6358 CR3: 0000000108bca000 CR4: 00000000000006e0
[   11.397552] Call Trace:
[   11.400014]  <TASK>
[   11.402132]  ahd_pci_config+0x3e7/0x690 [aic79xx]
[   11.406890]  ahd_linux_pci_dev_probe+0xe7/0x220 [aic79xx]
[   11.412324]  ? preempt_count_sub+0x9b/0xd0
[   11.416444]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[   11.421429]  local_pci_probe+0x41/0x80
[   11.425200]  pci_device_probe+0xc3/0x240
[   11.429145]  really_probe+0x1fc/0x3c0
[   11.432831]  __driver_probe_device+0x108/0x180
[   11.437291]  driver_probe_device+0x1f/0xb0
[   11.441407]  __driver_attach+0xc8/0x1b0
[   11.445264]  ? __device_attach_driver+0x100/0x100
[   11.449982]  bus_for_each_dev+0x79/0xc0
[   11.453848]  bus_add_driver+0x168/0x210
[   11.457702]  driver_register+0x89/0xd0
[   11.461468]  ? 0xffffffffc0231000
[   11.464801]  ahd_linux_init+0x318/0x1000 [aic79xx]
[   11.469631]  ? 0xffffffffc0231000
[   11.472966]  do_one_initcall+0x5d/0x320
[   11.476819]  ? rcu_read_lock_sched_held+0x3b/0x70
[   11.481544]  ? trace_kmalloc+0x2f/0xf0
[   11.485307]  ? kmem_cache_alloc_trace+0x19a/0x290
[   11.490031]  do_init_module+0x4a/0x270
[   11.493802]  __do_sys_finit_module+0xac/0x120
[   11.498194]  do_syscall_64+0x5b/0x80
[   11.501793]  ? do_syscall_64+0x67/0x80
[   11.505558]  ? lockdep_hardirqs_on+0x7d/0x100
[   11.509936]  ? do_syscall_64+0x67/0x80
[   11.513576] scsi host4: LSI Logic MegaRAID driver
[   11.513702]  ? do_syscall_64+0x67/0x80
[   11.518834] scsi[4]: scanning scsi channel 0 [Phy 0]
[   11.522156]  for non-raid devices
[   11.522156]  ? lockdep_hardirqs_on+0x7d/0x100
[   11.534804]  ? do_syscall_64+0x67/0x80
[   11.538575]  ? lockdep_hardirqs_on+0x7d/0x100
[   11.542954]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   11.548024] RIP: 0033:0x7fdb26f71dcd
[   11.551617] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 33 80 0e 00 f7 d8 64 89
01 48
[   11.570379] RSP: 002b:00007fff43010448 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   11.577967] RAX: ffffffffffffffda RBX: 000056514f8c6c70 RCX: 00007fdb26f71dcd
[   11.585116] RDX: 0000000000000000 RSI: 00007fdb270d443c RDI: 000000000000000d
[   11.592261] RBP: 00007fdb270d443c R08: 0000000000000000 R09: 000056514f8c3db0
[   11.599400] R10: 000000000000000d R11: 0000000000000246 R12: 0000000000020000
[   11.606551] R13: 000056514f8c1a90 R14: 0000000000000000 R15: 000056514f8c4530
[   11.613718]  </TASK>
[   11.615923] Modules linked in: ata_generic aic79xx(+) pata_acpi
scsi_transport_spi megaraid_mbox megaraid_mm
[   11.625913] ---[ end trace 0000000000000000 ]---


[1] https://datawarehouse.cki-project.org/kcidb/tests/2888521
[2] https://datawarehouse.cki-project.org/issue/1094

Thanks,
Bruno Goncalves

