Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1A0542854
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiFHHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiFHHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:37:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD9512D2A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:00:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y187so18094187pgd.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=RsEt277LJhdNT3xgMfY4gmplIMtfLCGqPexhdZhIrR0=;
        b=d6qBRChW8ulGWplHIzV46CI9b5RKkIJPp2HqlmEFqabpHl5NTecOeFQVHV20tjr67q
         fu7v7e96Z3OElFaKbcENm/q6Q6uk3AYgTZrMvk32XNCbRJX1r+NF1rr9LF9iA7TVULSm
         Wz4qoK560ZD9joKpd/xRhfDZe9iocv98u4/9+TxxbLdG56p0N77Rk1DDlMVc9c1SQsfY
         bVGHHxn5WDqEVNS9hZuqnCbHN37DDEzkNZTrBemRzBDasV3jXY086V0YHLwItlRkz0BV
         librgxUzv84dcxeNY/+k38jQspS/LnRXrszfdWWIjbuHEHtEVTWUsicUHt9iJRqkK/Eb
         J1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=RsEt277LJhdNT3xgMfY4gmplIMtfLCGqPexhdZhIrR0=;
        b=3Z8wwqW4vPHNllDpoFz4tIY+JDwCgjq6jl/lWXNsRLqBd0QjWSg0DhbQU+dV0rIMbr
         DD+wUK0WBtOiAoF3T2tmcqHyvGEGz5GgTIdkmn5yQBrvKylToH/iov5kGRr3GtpE/FCA
         L03MBpVAjP93R8ldhdl1ja5+C+XEhlJ+6daHXG7PDzy0TwqUXNL12atPUHgW4W8s4koK
         tFXl45c/V+D4AW1AfxLh2P/gxWtesyaL9XC2VhiETXyGM7hqtLZzcLqZbwkZlHVTSpya
         rJ5OIf9jiF18idxHHbXBoirt62pVebJJ1wYXoGrQDWFM2pjVAsh2tbkVm2jkDnTeuyvt
         ckeQ==
X-Gm-Message-State: AOAM5333+18BzqzJSTsCAbmTCPTmb7FU5VBKjXvqtoYlv36AhMbB7LeO
        52BWqabSnt+CTBp1WskcJEmo1MdZ7Fekxie6
X-Google-Smtp-Source: ABdhPJwFNHuUrEjh3QfVOTfDQIGZtXmcqAi/MrpL6pTxDNf7qcGDbiGiFK559NNiaxMOz0OPhJJkqQ==
X-Received: by 2002:a63:551e:0:b0:3fe:3f58:7ffb with SMTP id j30-20020a63551e000000b003fe3f587ffbmr436507pgb.248.1654671641317;
        Wed, 08 Jun 2022 00:00:41 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b001675991fb7fsm8396425plj.55.2022.06.08.00.00.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 00:00:40 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>, x86@kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/2] x86/apic: add a more generic early_probe
Date:   Wed,  8 Jun 2022 14:43:47 +0800
Message-Id: <20220608064348.66402-2-ryncsn@gmail.com>
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

There is only one early apic driver probe method: acpi_madt_oem_check,
which is used by ACPI MADT init path only.

Some apic drivers' early probe doesn't need ACPI info. Even when probed
from ACPI subsystem, the ACPI info is simply ignored. So add a more generic
early_probe method, which can be used by MPTABLE parse later.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/x86/include/asm/apic.h           |  6 ++++++
 arch/x86/kernel/apic/probe_64.c       | 16 ++++++++++++++++
 arch/x86/kernel/apic/x2apic_cluster.c |  8 +++++++-
 arch/x86/kernel/apic/x2apic_phys.c    |  8 +++++++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index bd8ae0a7010a..cd3266fbfa63 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -310,6 +310,7 @@ struct apic {
 
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
+	int	(*early_probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
 	int	(*apic_id_valid)(u32 apicid);
 	int	(*apic_id_registered)(void);
@@ -498,6 +499,11 @@ extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
 extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
+#ifdef CONFIG_X86_64
+extern void apic_early_probe(void);
+#else
+static inline void apic_early_probe(void) { }
+#endif
 
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index c46720f185c0..3f600c421f07 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -13,6 +13,22 @@
 
 #include "local.h"
 
+void __init apic_early_probe(void)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
+		if ((*drv)->early_probe && (*drv)->early_probe()) {
+			if (apic != *drv) {
+				apic = *drv;
+				pr_info("Switched to APIC driver %s.\n",
+					apic->name);
+			}
+			break;
+		}
+	}
+}
+
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
  */
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index e696e22d0531..02eb8ea9a5b5 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -26,11 +26,16 @@ static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
 static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
 static struct cluster_mask *cluster_hotplug_mask;
 
-static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static int x2apic_early_probe(void)
 {
 	return x2apic_enabled();
 }
 
+static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	return x2apic_early_probe();
+}
+
 static void x2apic_send_IPI(int cpu, int vector)
 {
 	u32 dest = x86_cpu_to_logical_apicid[cpu];
@@ -197,6 +202,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 
 	.name				= "cluster x2apic",
 	.probe				= x2apic_cluster_probe,
+	.early_probe			= x2apic_early_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..c4dd4ec0f1ac 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -34,11 +34,16 @@ static bool x2apic_fadt_phys(void)
 	return false;
 }
 
-static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static int x2apic_early_probe(void)
 {
 	return x2apic_enabled() && (x2apic_phys || x2apic_fadt_phys());
 }
 
+static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	return x2apic_early_probe();
+}
+
 static void x2apic_send_IPI(int cpu, int vector)
 {
 	u32 dest = per_cpu(x86_cpu_to_apicid, cpu);
@@ -156,6 +161,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
 	.probe				= x2apic_phys_probe,
+	.early_probe			= x2apic_early_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
-- 
2.35.2

