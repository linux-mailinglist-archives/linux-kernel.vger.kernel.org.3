Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98C522DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbiEKID3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbiEKIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:03:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA48CCCF;
        Wed, 11 May 2022 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652256192; x=1683792192;
  h=from:to:cc:subject:date:message-id;
  bh=U5JVmxHUUjxAbxSb6PLM4Nc67GW9UY1orKH/4MwbuNA=;
  b=bCkL1ocYAlLpkbyLN7JZv7gxV/tX0Dq/om1qCxl7BVVBvDJJVxPaBlZP
   NiawT2Qeaot9x461XiMuOIb7Vu7A/gjBPy77+vpCwZcKMjDqVejCuVN/v
   K7DECh5413qPPHPQRyjJGcOeQ+inm46sApQ00A/a/NR3/0bOX5S2jL/ii
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2022 01:03:10 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 May 2022 01:03:09 -0700
X-QCInternal: smtphost
Received: from blr-ubuntu-435.qualcomm.com ([10.79.42.176])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 May 2022 13:32:51 +0530
Received: by blr-ubuntu-435.qualcomm.com (Postfix, from userid 2327845)
        id B31489008AA; Wed, 11 May 2022 13:32:50 +0530 (IST)
From:   Shreyas K K <quic_shrekk@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Shreyas K K <quic_shrekk@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: [PATCH] arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs
Date:   Wed, 11 May 2022 13:32:47 +0530
Message-Id: <20220511080247.1530-1-quic_shrekk@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KRYO4XX gold/big cores to the list of CPUs that need the
repeat TLBI workaround. Apply this to the affected
KRYO4XX cores (rcpe to rdpe).

The variant and revision bits are implementation defined and are
different from the their Cortex CPU counterparts on which they are
based on, i.e., (r0p0 to r1p0) is equivalent to (rcpe to rdpe).

Signed-off-by: Shreyas K K <quic_shrekk@quicinc.com>
---
 Documentation/arm64/silicon-errata.rst | 3 +++
 arch/arm64/kernel/cpu_errata.c         | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 466cb9e89047..d27db84d585e 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -189,6 +189,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo4xx Silver  | N/A             | ARM64_ERRATUM_1024718       |
 +----------------+-----------------+-----------------+-----------------------------+
+| Qualcomm Tech. | Kryo4xx Gold    | N/A             | ARM64_ERRATUM_1286807       |
++----------------+-----------------+-----------------+-----------------------------+
+
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 4c9b5b4b7a0b..2518657e6de1 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -208,6 +208,8 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 #ifdef CONFIG_ARM64_ERRATUM_1286807
 	{
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
+		/* Kryo4xx Gold (rcpe to rdpe) => (r0p0 to r1p0) */
+		ERRATA_MIDR_RANGE(QCOM_CPU_PART_KRYO_4XX_GOLD, 0xc, 0xe, 0xd, 0xe),
 	},
 #endif
 	{},
-- 
2.17.1

