Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEE52B64D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiERJJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiERJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:09:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5E413F911;
        Wed, 18 May 2022 02:09:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D1A1042;
        Wed, 18 May 2022 02:09:19 -0700 (PDT)
Received: from pierre123.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B26A3F66F;
        Wed, 18 May 2022 02:09:16 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, dietmar.eggemann@arm.com,
        sudeep.holla@arm.com, Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH v2 1/5] ACPI: CPPC: Check _OSC for flexible address space
Date:   Wed, 18 May 2022 11:08:57 +0200
Message-Id: <20220518090901.2724518-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
  Starting with ACPI Specification 6.2, all _CPC registers can be in
  PCC, System Memory, System IO, or Functional Fixed Hardware address
  spaces. OSPM support for this more flexible register space scheme is
  indicated by the “Flexible Address Space for CPPC Registers” _OSC bit

Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
- PCC or Functional Fixed Hardware address space if defined
- SystemMemory address space (NULL register) if not defined

Add the corresponding _OSC bit and check it when parsing _CPC objects.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/bus.c       | 18 ++++++++++++++++++
 drivers/acpi/cppc_acpi.c |  9 +++++++++
 include/linux/acpi.h     |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3e58b613a2c4..9eca43d1d941 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -278,6 +278,20 @@ bool osc_sb_apei_support_acked;
 bool osc_pc_lpi_support_confirmed;
 EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
 
+/*
+ * ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
+ *   Starting with ACPI Specification 6.2, all _CPC registers can be in
+ *   PCC, System Memory, System IO, or Functional Fixed Hardware address
+ *   spaces. OSPM support for this more flexible register space scheme is
+ *   indicated by the “Flexible Address Space for CPPC Registers” _OSC bit.
+ *
+ * Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
+ * - PCC or Functional Fixed Hardware address space if defined
+ * - SystemMemory address space (NULL register) if not defined
+ */
+bool osc_cpc_flexible_adr_space_confirmed;
+EXPORT_SYMBOL_GPL(osc_cpc_flexible_adr_space_confirmed);
+
 /*
  * ACPI 6.4 Operating System Capabilities for USB.
  */
@@ -321,6 +335,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	}
 #endif
 
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
+
 	if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
 
@@ -366,6 +382,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
 		osc_sb_native_usb4_support_confirmed =
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
+		osc_cpc_flexible_adr_space_confirmed =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
 	}
 
 	kfree(context.ret.pointer);
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index bc1454789a06..6f09fe011544 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -736,6 +736,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 				if (gas_t->address) {
 					void __iomem *addr;
 
+					if (!osc_cpc_flexible_adr_space_confirmed) {
+						pr_debug("Flexible address space capability not supported\n");
+						goto out_free;
+					}
+
 					addr = ioremap(gas_t->address, gas_t->bit_width/8);
 					if (!addr)
 						goto out_free;
@@ -758,6 +763,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 						 gas_t->address);
 					goto out_free;
 				}
+				if (!osc_cpc_flexible_adr_space_confirmed) {
+					pr_debug("Flexible address space capability not supported\n");
+					goto out_free;
+				}
 			} else {
 				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
 					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d7136d13aa44..03465db16b68 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -574,6 +574,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
+#define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 #define OSC_SB_PRM_SUPPORT			0x00200000
 
@@ -581,6 +582,7 @@ extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
 extern bool osc_sb_native_usb4_support_confirmed;
 extern bool osc_sb_cppc_not_supported;
+extern bool osc_cpc_flexible_adr_space_confirmed;
 
 /* USB4 Capabilities */
 #define OSC_USB_USB3_TUNNELING			0x00000001
-- 
2.25.1

