Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B6154283F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiFHHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiFHHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:37:48 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955121182A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:00:39 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c14so18039408pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=Rzd5jHVZ1Np2+0gV097PKobFo2Ug2yArAiRpCWznZks=;
        b=aLh0VWbB1Fj/q9OJtWN0VqMIl/GoZOK4jFT0+fWjl/fewag+xCXgldmWOywnmXnyqw
         k8/+znBJuxwpoV0OzzFobfCWhSWi8eH4mMXPOyQU7mE5uYTLAAKAITieF0WVsO4bus3G
         V4IPKt2znoV5C1/Fey9GH83Ylso9UA8dzOtxM9CF6wOqtbf/AYcbMJaZy6mYf/uMxeGR
         FUkmE2CTFLX4KmlYwK+KA/6tiQL5llBBT7+g/R3yLFy/dLXYnhlapm9jJnxs4oWHyHgz
         uA96F2sTLMvBTaqRNfEIyfnyfmzpDmFV1uili7dTguU4bT/sdEx6ycAiISjicOZPMF7B
         IkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=Rzd5jHVZ1Np2+0gV097PKobFo2Ug2yArAiRpCWznZks=;
        b=zVRSsJTPiPM+n+cd8bLw7Oe9vtZI213kULI/wU7db4I29s3uplCiDXtLSn4X/Tpwfu
         q9pzCjPV2WaAOK4BilSP+QPttpvM8ZJB+CCGR1pFBu6LzVCJfuqFNkoGtoyvtWGrdwb3
         mEDquyBNTgm3zE9VQBvo0hmQSgkYuyaVZSRcSEze1/K//7nXGVPukj79zDkg2qwujCRt
         IrNcnS016dWVqQoxxoavwi0VHXgHl2FbHXYkTfemedmW4fE+Q+4uWo5hRFOF3VB62Ywf
         dYkv8WimbHigYuB1hCwqmt4GpjZDTc5DPielJWagKZPUohu9OgdoY5JBtCti5Ln8Ri1A
         el+Q==
X-Gm-Message-State: AOAM5331bpGmyJMN9lxVhKAjMJZOSITO7guLVw1e1k6RWko28tEpT5v7
        sWLh5frdpXPZVc8+efGJ7Yq0O6oLtPr+NJuh
X-Google-Smtp-Source: ABdhPJyJlGe2LEF3l0HaSM5jSYhC48UeQi8mEwKBpio4r4vYBKy5lMZOyvXD9jCH+FG/RDs4YsVOKg==
X-Received: by 2002:a05:6a00:a16:b0:518:ffe0:7229 with SMTP id p22-20020a056a000a1600b00518ffe07229mr68508072pfh.49.1654671638648;
        Wed, 08 Jun 2022 00:00:38 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b001675991fb7fsm8396425plj.55.2022.06.08.00.00.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 00:00:38 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>, x86@kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/2] x86/mpparse, kexec: Fix kdump/kexec kernel panic with MPTABLE and x2apic
Date:   Wed,  8 Jun 2022 14:43:46 +0800
Message-Id: <20220608064348.66402-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Following kernel panic is observed when doing kdump/kexec on
qemu-kvm VMs that uses MPTABLE, not ACPI MADT, and supports x2apic:

  Intel MultiProcessor Specification v1.4
  MPTABLE: OEM ID: BOCHSCPU
  MPTABLE: Product ID: 0.1
  MPTABLE: APIC at: 0xFEE00000
  BUG: unable to handle page fault for address: ffffffffff5fc020
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 25e15067 P4D 25e15067 PUD 25e17067 PMD 25e18067 PTE 0
  Oops: 0000 [#1] SMP NOPTI
  CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.10-300.fc35.x86_64 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
  RIP: 0010:native_apic_mem_read+0x2/0x10
  Code: 14 25 20 cd e3 82 c3 90 bf 30 08 00 00 ff 14 25 18 cd e3 82 c3 cc cc cc 89 ff 89 b7 00 c0 5f ff c3 0f 1f 80 00 00 00 00 89 ff <8b> 87 00 c0 5f ff c3 0f 1f 80 00 00 00 0
  RSP: 0000:ffffffff82e03e18 EFLAGS: 00010046
  RAX: ffffffff81064840 RBX: ffffffffff240b6c RCX: ffffffff82f17428
  RDX: c0000000ffffdfff RSI: 00000000ffffdfff RDI: 0000000000000020
  RBP: ffff888023200000 R08: 0000000000000000 R09: ffffffff82e03c50
  R10: ffffffff82e03c48 R11: ffffffff82f47468 R12: ffffffffff240b40
  R13: ffffffffff200b30 R14: 0000000000000000 R15: 00000000000000d4
  FS:  0000000000000000(0000) GS:ffffffff8365b000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffff5fc020 CR3: 0000000025e10000 CR4: 00000000000006b0
  Call Trace:
   ? read_apic_id+0x15/0x30
   ? register_lapic_address+0x76/0x97
   ? default_get_smp_config+0x28b/0x42d
   ? dmi_check_system+0x1c/0x60
   ? acpi_boot_init+0x1d/0x4c3
   ? setup_arch+0xb37/0xc2a
   ? slab_is_available+0x5/0x10
   ? start_kernel+0x61/0x980
   ? load_ucode_bsp+0x4c/0xcd
   ? secondary_startup_64_no_verify+0xc2/0xcb
  Modules linked in:
  CR2: ffffffffff5fc020
  random: get_random_bytes called from oops_exit+0x35/0x60 with crng_init=0
  ---[ end trace c9e569df3bdbefd3 ]---

It turns out MPTABLE doesn't play well with pre-enabled x2apic mode,
this series extend the apic driver interface and let MPTABLE parse
probe the driver properly.

This can be easily reproduced with qemu-kvm, use -no-acpi and enable
x2apic, so x2apic with MPTABLE will be in use, then trigger kdump/kexec.

Kairui Song (2):
  x86, apic: add a more generic early_probe
  x86/mpparse, kexec: probe apic driver early for x2apic

 arch/x86/include/asm/apic.h           |  6 ++++++
 arch/x86/kernel/apic/probe_64.c       | 16 ++++++++++++++++
 arch/x86/kernel/apic/x2apic_cluster.c |  8 +++++++-
 arch/x86/kernel/apic/x2apic_phys.c    |  8 +++++++-
 arch/x86/kernel/mpparse.c             |  4 +++-
 5 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.35.2

