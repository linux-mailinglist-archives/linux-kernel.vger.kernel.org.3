Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01051DFA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390729AbiEFTcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiEFTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:32:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8846D859
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:28:45 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246EW43t016894;
        Fri, 6 May 2022 19:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=fQjOyeeu4rCXpd/WBXik1+WaR4zHHSl96tEv2uvVn40=;
 b=Oi1Oazhgi0ZyaSf+NXLnYW9uXb7J4hkH4g/8Isd1rDjKUpx7siizzOrtj0bJJw2Iqz2Y
 hGj9CRbRaTBaEjwbfT5TElm4hrKgnnzmO8m+/D2kfBKyhLIJB63NuzXCGyKk6mgqfKrp
 OEF8C0uLgocdRMV1pBmraPeujtPsZy484HPljEkUhvdig1nWSAaR1oJm5VUay/x0MlHN
 pHaQbOSqvYY/rygLgEub8viEFkyc3uHj79DQyCwaicRF5M9OIAXMxMXOjD2WpRvq/onF
 7BR/bpSqn1vYpppq84hfwirI9bGgQ9Sl+c2Q3mHJG1yha7tpLrzlt8dtU2UTVIriGPDT bQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fvys9d591-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 19:28:23 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id CCD4C8D;
        Fri,  6 May 2022 19:28:22 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 25E9645;
        Fri,  6 May 2022 19:28:22 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com, verdun@hpe.com, linux@armlinux.org.uk,
        will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Date:   Fri,  6 May 2022 14:29:57 -0500
Message-Id: <20220506192957.24889-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: Ih6rWAvulyXm1s6NV2OpzpRd42sWzueQ
X-Proofpoint-ORIG-GUID: Ih6rWAvulyXm1s6NV2OpzpRd42sWzueQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_07,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=939 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060097
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Enable the workaround for the 764319 Cortex A-9 erratum.
CP14 read accesses to the DBGPRSR and DBGOSLSR registers generate an
unexpected Undefined Instruction exception when the DBGSWENABLE external
pin is set to 0, even when the CP14 accesses are performed from a
privileged mode. The work around catches the exception in a way
the kernel does not stop execution with the use of undef_hook. This
has been found to effect the HPE GXP SoC.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/Kconfig                | 11 +++++++++++
 arch/arm/kernel/hw_breakpoint.c | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 13f77eec7c40..6944adfb0fae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -974,6 +974,17 @@ config ARM_ERRATA_764369
 	  relevant cache maintenance functions and sets a specific bit
 	  in the diagnostic control register of the SCU.
 
+config ARM_ERRATA_764319
+	bool "ARM errata: Read to DBGPRSR and DBGOSLSR may generate Undefined instruction"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 764319 Cortex A-9 erratum.
+	  CP14 read accesses to the DBGPRSR and DBGOSLSR registers generate an
+	  unexpected Undefined Instruction exception when the DBGSWENABLE
+	  external pin is set to 0, even when the CP14 accesses are performed
+	  from a privileged mode. This work around catches the exception in a
+	  way the kernel does not stop execution.
+
 config ARM_ERRATA_775420
        bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
        depends on CPU_V7
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b1423fb130ea..c41a8436a796 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -941,6 +941,23 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 	return ret;
 }
 
+#ifdef CONFIG_ARM_ERRATA_764319
+int oslsr_fault;
+
+static int debug_oslsr_trap(struct pt_regs *regs, unsigned int instr)
+{
+	oslsr_fault = 1;
+	instruction_pointer(regs) += 4;
+	return 0;
+}
+
+static struct undef_hook debug_oslsr_hook = {
+	.instr_mask  = 0xffffffff,
+	.instr_val = 0xee115e91,
+	.fn = debug_oslsr_trap,
+};
+#endif
+
 /*
  * One-time initialisation.
  */
@@ -974,7 +991,16 @@ static bool core_has_os_save_restore(void)
 	case ARM_DEBUG_ARCH_V7_1:
 		return true;
 	case ARM_DEBUG_ARCH_V7_ECP14:
+#ifdef CONFIG_ARM_ERRATA_764319
+		oslsr_fault = 0;
+		register_undef_hook(&debug_oslsr_hook);
 		ARM_DBG_READ(c1, c1, 4, oslsr);
+		unregister_undef_hook(&debug_oslsr_hook);
+		if (oslsr_fault)
+			return false;
+#else
+		ARM_DBG_READ(c1, c1, 4, oslsr);
+#endif
 		if (oslsr & ARM_OSLSR_OSLM0)
 			return true;
 		fallthrough;
-- 
2.17.1

