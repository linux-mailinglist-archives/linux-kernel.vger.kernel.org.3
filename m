Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0D523DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbiEKTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbiEKTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B0F3CFDD;
        Wed, 11 May 2022 12:47:04 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZF9U+OmwIP9SueOua4stNQ6rPWiG++IkA2dRrh0Ie44=;
        b=vQF6DQvfCxprVDFqpbg3d8Qqm9RclWHjt8saT6MVijHZSTCz4iiAGVe2vZDBxRKVjpE8ca
        1vJgIKH9JMN++o22m/nj0aF8DjNPLgBQxeFpVhF5vYMHJXCBE20GGiLgn1fyQBloXPVvGV
        PJnL4VEzTVh8jtH5aacdCdtlAfbYmMTiMojAJ9qNxcEmKFTAu9RMFIsrYnxRWq1+CVNpsz
        tEUmJ/Y3ROUrBfzmfcIxnD98PRrmq/N8aUrziBTAI413GIL3/LBqpab3TFppYBKgtLkaHM
        QwJvPoCmrL56jSKmg5oAwl2RN8yizQoWaWsQEvWCaMoHOtyExEFIAj9zIR9B9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZF9U+OmwIP9SueOua4stNQ6rPWiG++IkA2dRrh0Ie44=;
        b=oXEo30ewcKppV1kBuOfsxKKtaHyb+uBaUvBOhVgsnaZVWr9rucvrLyhDb8WbvH3FyxzXiA
        RcQOi51uGpc4SQDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Add new Alder Lake and Raptor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220504194413.1003071-5-kan.liang@linux.intel.com>
References: <20220504194413.1003071-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165229842201.4207.6067979297234885806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f758bc5a91233bb5b5b6994a8e72ba4eba0e9ab2
Gitweb:        https://git.kernel.org/tip/f758bc5a91233bb5b5b6994a8e72ba4eba0e9ab2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 May 2022 12:44:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:09 +02:00

perf/x86/uncore: Add new Alder Lake and Raptor Lake support

>From the perspective of the uncore PMU, there is nothing changed for the
new Alder Lake N and Raptor Lake P.

Add new PCIIDs of IMC.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220504194413.1003071-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |  2 +-
 arch/x86/events/intel/uncore_snb.c | 52 +++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7695dca..db6c31b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1828,7 +1828,9 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index b30890b..ce44001 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -79,10 +79,36 @@
 #define PCI_DEVICE_ID_INTEL_ADL_14_IMC		0x4650
 #define PCI_DEVICE_ID_INTEL_ADL_15_IMC		0x4668
 #define PCI_DEVICE_ID_INTEL_ADL_16_IMC		0x4670
+#define PCI_DEVICE_ID_INTEL_ADL_17_IMC		0x4614
+#define PCI_DEVICE_ID_INTEL_ADL_18_IMC		0x4617
+#define PCI_DEVICE_ID_INTEL_ADL_19_IMC		0x4618
+#define PCI_DEVICE_ID_INTEL_ADL_20_IMC		0x461B
+#define PCI_DEVICE_ID_INTEL_ADL_21_IMC		0x461C
 #define PCI_DEVICE_ID_INTEL_RPL_1_IMC		0xA700
 #define PCI_DEVICE_ID_INTEL_RPL_2_IMC		0xA702
 #define PCI_DEVICE_ID_INTEL_RPL_3_IMC		0xA706
 #define PCI_DEVICE_ID_INTEL_RPL_4_IMC		0xA709
+#define PCI_DEVICE_ID_INTEL_RPL_5_IMC		0xA701
+#define PCI_DEVICE_ID_INTEL_RPL_6_IMC		0xA703
+#define PCI_DEVICE_ID_INTEL_RPL_7_IMC		0xA704
+#define PCI_DEVICE_ID_INTEL_RPL_8_IMC		0xA705
+#define PCI_DEVICE_ID_INTEL_RPL_9_IMC		0xA706
+#define PCI_DEVICE_ID_INTEL_RPL_10_IMC		0xA707
+#define PCI_DEVICE_ID_INTEL_RPL_11_IMC		0xA708
+#define PCI_DEVICE_ID_INTEL_RPL_12_IMC		0xA709
+#define PCI_DEVICE_ID_INTEL_RPL_13_IMC		0xA70a
+#define PCI_DEVICE_ID_INTEL_RPL_14_IMC		0xA70b
+#define PCI_DEVICE_ID_INTEL_RPL_15_IMC		0xA715
+#define PCI_DEVICE_ID_INTEL_RPL_16_IMC		0xA716
+#define PCI_DEVICE_ID_INTEL_RPL_17_IMC		0xA717
+#define PCI_DEVICE_ID_INTEL_RPL_18_IMC		0xA718
+#define PCI_DEVICE_ID_INTEL_RPL_19_IMC		0xA719
+#define PCI_DEVICE_ID_INTEL_RPL_20_IMC		0xA71A
+#define PCI_DEVICE_ID_INTEL_RPL_21_IMC		0xA71B
+#define PCI_DEVICE_ID_INTEL_RPL_22_IMC		0xA71C
+#define PCI_DEVICE_ID_INTEL_RPL_23_IMC		0xA728
+#define PCI_DEVICE_ID_INTEL_RPL_24_IMC		0xA729
+#define PCI_DEVICE_ID_INTEL_RPL_25_IMC		0xA72A
 
 
 #define IMC_UNCORE_DEV(a)						\
@@ -1192,10 +1218,36 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 	IMC_UNCORE_DEV(ADL_14),
 	IMC_UNCORE_DEV(ADL_15),
 	IMC_UNCORE_DEV(ADL_16),
+	IMC_UNCORE_DEV(ADL_17),
+	IMC_UNCORE_DEV(ADL_18),
+	IMC_UNCORE_DEV(ADL_19),
+	IMC_UNCORE_DEV(ADL_20),
+	IMC_UNCORE_DEV(ADL_21),
 	IMC_UNCORE_DEV(RPL_1),
 	IMC_UNCORE_DEV(RPL_2),
 	IMC_UNCORE_DEV(RPL_3),
 	IMC_UNCORE_DEV(RPL_4),
+	IMC_UNCORE_DEV(RPL_5),
+	IMC_UNCORE_DEV(RPL_6),
+	IMC_UNCORE_DEV(RPL_7),
+	IMC_UNCORE_DEV(RPL_8),
+	IMC_UNCORE_DEV(RPL_9),
+	IMC_UNCORE_DEV(RPL_10),
+	IMC_UNCORE_DEV(RPL_11),
+	IMC_UNCORE_DEV(RPL_12),
+	IMC_UNCORE_DEV(RPL_13),
+	IMC_UNCORE_DEV(RPL_14),
+	IMC_UNCORE_DEV(RPL_15),
+	IMC_UNCORE_DEV(RPL_16),
+	IMC_UNCORE_DEV(RPL_17),
+	IMC_UNCORE_DEV(RPL_18),
+	IMC_UNCORE_DEV(RPL_19),
+	IMC_UNCORE_DEV(RPL_20),
+	IMC_UNCORE_DEV(RPL_21),
+	IMC_UNCORE_DEV(RPL_22),
+	IMC_UNCORE_DEV(RPL_23),
+	IMC_UNCORE_DEV(RPL_24),
+	IMC_UNCORE_DEV(RPL_25),
 	{ /* end: all zeroes */ }
 };
 
