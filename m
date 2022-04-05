Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F69A4F2AF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbiDEKnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbiDEIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CE17068;
        Tue,  5 Apr 2022 01:29:11 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTiIkow2ryqTVklNzpiJzR+F10fayARIPEQS+s2elLw=;
        b=YyMu2WHzxnskQr9xp56axAbi4y87USBJAc9l073Vk7YjO4zChlUyGXODMgYdKFowyUkecx
        OY1KMKj8CVjmcTOXjPZWugxuGRQK1TP4vVKIU2tWjIUbDcJmib1k8M13wgOWbag0vLT3e6
        +5rugYTh/9zLEgB/ohVekcdXikMECHKCX4lCmOz/asKxmx3pZEpmz9RvoCZNfp3cnnxOTl
        OjSaYcSbVm49lN8F8n3tvedyxbXu5+xTFn0H3QBAgPFZ0VaeHWs32GhjpU9ELpazl704tJ
        X7daiNS8hSw270i2elpsDrOn8m+LvWST3k8ZYlB7YzrSjU4yXZRClrzhPTRyIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTiIkow2ryqTVklNzpiJzR+F10fayARIPEQS+s2elLw=;
        b=a0V7NhJaLUUJnvqIVmizf2nM8FgsLGndrx30zyJf8TgqJ/4WRcWa9fOBI0gv9gdDlcYRH4
        523XIpjjwdl/unCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/uncore: Add Raptor Lake uncore support
Cc:     Kan Liang <kan.liang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1647366360-82824-4-git-send-email-kan.liang@linux.intel.com>
References: <1647366360-82824-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164914734933.389.1180080603366707375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ad4878d4d71d9ada913be2ad5b6d7f526a695b6f
Gitweb:        https://git.kernel.org/tip/ad4878d4d71d9ada913be2ad5b6d7f526a695b6f
Author:        Kan Liang <kan.liang@intel.com>
AuthorDate:    Tue, 15 Mar 2022 10:46:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:43 +02:00

perf/x86/uncore: Add Raptor Lake uncore support

The uncore PMU of the Raptor Lake is the same as Alder Lake.
Add new PCIIDs of IMC for Raptor Lake.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/1647366360-82824-4-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |  1 +
 arch/x86/events/intel/uncore_snb.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e497da9..7695dca 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1828,6 +1828,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index f698a55..4262351 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -79,6 +79,10 @@
 #define PCI_DEVICE_ID_INTEL_ADL_14_IMC		0x4650
 #define PCI_DEVICE_ID_INTEL_ADL_15_IMC		0x4668
 #define PCI_DEVICE_ID_INTEL_ADL_16_IMC		0x4670
+#define PCI_DEVICE_ID_INTEL_RPL_1_IMC		0xA700
+#define PCI_DEVICE_ID_INTEL_RPL_2_IMC		0xA702
+#define PCI_DEVICE_ID_INTEL_RPL_3_IMC		0xA706
+#define PCI_DEVICE_ID_INTEL_RPL_4_IMC		0xA709
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -1406,6 +1410,22 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_16_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_4_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ }
 };
 
