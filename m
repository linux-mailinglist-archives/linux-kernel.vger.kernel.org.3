Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC3542852
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiFHHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiFHHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:37:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F938BE1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:00:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u18so16870814plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=0Y71+75qvfs0BWzL6gBfrDn2lzjlHUL6hjQyt+wNtxI=;
        b=lFEEkahv8QX0NmHlMpbpwU3DLBoViwvS4Bkf2xwRJvGyqHFcvwgcjk+29VrBH/HQ0Y
         u0vev6U6R6NGWWY+5hhqbnvFYCLMBjlbwCUdjeEmeV0BjtdobRy6VRHrADqEiQkC5/CN
         4TbqzIu9w0iAUgpRStiIJANJO5mYmsnsmuRmNSyCSrkPUkR38bgV3oGaenT8prRz4wQV
         wFRYSLtZ/+LseV5K4es+xa5RfcL3ueOtoSi9HJGtCtDhF5dlrKNfvlTiegxbbiCk4vCb
         qGsNB986MXJUCxJnXwRLo9xxzl/LSoh7xEfFLlQKUD35OPJYxdViOcXpsgMnRnEXaXtm
         HgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=0Y71+75qvfs0BWzL6gBfrDn2lzjlHUL6hjQyt+wNtxI=;
        b=HyafTWjL8U4LN7CdaU5KDPd9wLsd6V3mmP+5G04R37a+iu9lRd4ieEdn68jbUaWshp
         OYzsBdkTpz46/cdzuNLcTQ5C6iEN9gzR4dbXOHtglpyJoc9zUjDJOQOHRd3GYXOStqse
         gECP1bUSws2yqMCGcErmVYpZmN0rbGT0HrVOQBAGRqAg6hcCJ2te5zXPBgqhAW/YiEaw
         KOMNAKyMZ3ccv0HEHRHe9ldc33KHmaUmpAsGQvMGzbmx6yg9ZkgFRIh+GoyWNfqMMPu0
         G6jsKV/Bm5LI4msxfdJ+nLBpsCmagSetrlHvoP4bgvfx/fYz4MZYaoJ7qdQThFaSxvZZ
         nR9w==
X-Gm-Message-State: AOAM532eBYVTsOOxNnWFtZGhww+5VvgyafKPJ8BdBWV4n55C375EXXLU
        bdvfkDcwFJnC9vl1d07DIQgK3pjNXCiqAh8x
X-Google-Smtp-Source: ABdhPJx7+Tm4FFC4r7PiYQy5839YKi2Ajm/KYt944nHUrPqCBYGoBDa99piJ/g1V0Xo5JM25LyktVw==
X-Received: by 2002:a17:902:f687:b0:167:58bb:c43f with SMTP id l7-20020a170902f68700b0016758bbc43fmr22706267plg.136.1654671644069;
        Wed, 08 Jun 2022 00:00:44 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b001675991fb7fsm8396425plj.55.2022.06.08.00.00.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 00:00:43 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>, x86@kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/2] x86/mpparse, kexec: probe apic driver early for x2apic
Date:   Wed,  8 Jun 2022 14:43:48 +0800
Message-Id: <20220608064348.66402-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220608064348.66402-1-ryncsn@gmail.com>
References: <20220608064348.66402-1-ryncsn@gmail.com>
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
virtual machines that uses MPTABLE, not ACPI MADT, and supports x2apic:

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

The panic happens within following init code:
setup_arch()
  ....
  check_x2apic()     <-- x2apic is enabled by first kernel before kexec,
                         this set x2apic_mode = 1, make sure later probes
                         will recognize pre-enabled x2apic.
  ....
  acpi_boot_init();  <-- If ACPI MADT is in use, this will switch apic driver
                         to x2apic, but it will do nothing with MPTABLE.
  x86_dtb_init();
  get_smp_config();
    default_get_smp_config();  <-- MPTABLE setup.
      check_physptr();
        smp_read_mpc();
          register_lapic_address(); <-- * panic here *
  init_apic_mappings();
  ....

The problem here is MPTABLE setup calls register_lapic_address(), which
is still using apic_flat driver, and access the apic MMIO interface. But
the address is never mapped for pre-enabled x2apic, since commit
0450193bffed6 ("x86, x2apic: Don't map lapic addr for preenabled x2apic systems"),
then it panics.

Simply map it won't work either, in x2apic mode the MMIO interface is
not usable (Intel SDM Volume 3A 10.12.2), later setups will still fail with
other errors. So it needs do a proper apic driver probe and switch to
x2apic driver to perform MSR operation instead.

Such issue is currently only seen with kdump/kexec, kernel enabled the
x2apic in first kernel and kept it enabled to 2nd kernel.

This can be easily reproduced with qemu-kvm, use -no-acpi and enable
x2apic, so x2apic with MPTABLE will be in use, then trigger kdump/kexec.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/x86/kernel/mpparse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..7658c8184e8c 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -202,8 +202,10 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 		return 0;
 
 	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
+	if (!acpi_lapic) {
+		apic_early_probe();
 		register_lapic_address(mpc->lapic);
+	}
 
 	if (early)
 		return 1;
-- 
2.35.2

