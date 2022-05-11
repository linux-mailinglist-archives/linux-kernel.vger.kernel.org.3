Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166EF523493
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbiEKNqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbiEKNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:46:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0EFE24F3D;
        Wed, 11 May 2022 06:46:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD168ED1;
        Wed, 11 May 2022 06:46:26 -0700 (PDT)
Received: from pierre123.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 080FA3F66F;
        Wed, 11 May 2022 06:46:23 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH v1 2/5] ACPI: bus: Set CPPC _OSC bits for all and when CPPC_LIB is supported
Date:   Wed, 11 May 2022 15:45:56 +0200
Message-Id: <20220511134559.1466925-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511134559.1466925-1-pierre.gondois@arm.com>
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _OSC method allows the OS and firmware to communicate about
supported features/capabitlities. It also allows the OS to take
control of some features.

In ACPI 6.4, s6.2.11.2 Platform-Wide OSPM Capabilities, the CPPC
(resp. v2) bit should be set by the OS if it 'supports controlling
processor performance via the interfaces described in the _CPC
object'.

The OS supports CPPC and parses the _CPC object only if
CONFIG_ACPI_CPPC_LIB is set. Replace the x86 specific
boot_cpu_has(X86_FEATURE_HWP) dynamic check with an arch
generic CONFIG_ACPI_CPPC_LIB build-time check.

Note:
CONFIG_X86_INTEL_PSTATE selects CONFIG_ACPI_CPPC_LIB.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/bus.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a5d08de5d1e9..4fd0ea779441 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -329,10 +329,11 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 #endif
 #ifdef CONFIG_X86
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
-	if (boot_cpu_has(X86_FEATURE_HWP)) {
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
-	}
+#endif
+
+#ifdef CONFIG_ACPI_CPPC_LIB
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
 #endif
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_FLEXIBLE_ADR_SP;
@@ -357,10 +358,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		return;
 	}
 
-#ifdef CONFIG_X86
-	if (boot_cpu_has(X86_FEATURE_HWP))
-		osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &
-				(OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT));
+#ifdef CONFIG_ACPI_CPPC_LIB
+	osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &
+			(OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT));
 #endif
 
 	/*
-- 
2.25.1

