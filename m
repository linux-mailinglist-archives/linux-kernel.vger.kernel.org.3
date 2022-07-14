Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B534B575708
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiGNVaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240844AbiGNVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213396EE8B;
        Thu, 14 Jul 2022 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834207; x=1689370207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nafIjV4kL1CtsV7LjTclQU8SdUN5WtDpotMOesG1y/c=;
  b=MaJqftEVRlZQzdulqY0TqgFY/Ol/AuGhkqOMt4SWGZx7YgZ3OFfeqkqU
   TOwxB7dO199SoEtKNoQVRcvVnNhI02LNY6mG8fXZp2CNpW7M11UTb744U
   cqyeX+RddWEBYz+yEaY0tyyEi0qyJhyUHp2sl3eHYG/ApWbR9f9FuKCi0
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:06 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:06 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:04 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 03/11] arm64: gunyah: Add Gunyah hypercalls ABI
Date:   Thu, 14 Jul 2022 14:29:32 -0700
Message-ID: <20220714212940.2988436-4-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714212940.2988436-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220714212940.2988436-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support to perform Gunyah hypercalls. The arm64 ABI for
Gunyah hypercalls generally follows the SMC Calling Convention.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                     |   1 +
 arch/arm64/include/asm/gunyah.h | 134 ++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 arch/arm64/include/asm/gunyah.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b36bd47bcaaa..1d098bdba5c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8742,6 +8742,7 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
+F:	arch/arm64/include/asm/gunyah.h
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
new file mode 100644
index 000000000000..2dbef08d58d7
--- /dev/null
+++ b/arch/arm64/include/asm/gunyah.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef __ASM_GUNYAH_H
+#define __ASM_GUNYAH_H
+
+#include <linux/arm-smccc.h>
+#include <linux/types.h>
+
+#define GH_CALL_TYPE_PLATFORM_CALL		0
+#define GH_CALL_TYPE_HYPERCALL			2
+#define GH_CALL_TYPE_SERVICE			3
+#define GH_CALL_TYPE_SHIFT			14
+#define GH_CALL_FUNCTION_NUM_MASK		0x3fff
+
+#define GH_SERVICE(fn)		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
+						   ARM_SMCCC_OWNER_VENDOR_HYP, \
+						   (GH_CALL_TYPE_SERVICE << GH_CALL_TYPE_SHIFT) \
+							| ((fn) & GH_CALL_FUNCTION_NUM_MASK))
+
+#define GH_HYPERCALL(fn)	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+						   ARM_SMCCC_OWNER_VENDOR_HYP, \
+						   (GH_CALL_TYPE_HYPERCALL << GH_CALL_TYPE_SHIFT) \
+							| ((fn) & GH_CALL_FUNCTION_NUM_MASK))
+
+#define ___gh_count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
+
+#define __gh_count_args(...)						\
+	___gh_count_args(_, ## __VA_ARGS__, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+
+#define __gh_skip_0(...)		__VA_ARGS__
+#define __gh_skip_1(a, ...)	__VA_ARGS__
+#define __gh_skip_2(a, b, ...)	__VA_ARGS__
+#define __gh_skip_3(a, b, c, ...)	__VA_ARGS__
+#define __gh_skip_4(a, b, c, d, ...)	__VA_ARGS__
+#define __gh_skip_5(a, b, c, d, e, ...)	__VA_ARGS__
+#define __gh_skip_6(a, b, c, d, e, f, ...)	__VA_ARGS__
+#define __gh_skip_7(a, b, c, d, e, f, g, ...)	__VA_ARGS__
+#define __gh_skip_8(a, b, c, d, e, f, g, h, ...)	__VA_ARGS__
+#define __gh_to_res(nargs, ...)		__gh_skip_ ## nargs (__VA_ARGS__)
+
+#define __gh_declare_arg_0(...)
+
+#define __gh_declare_arg_1(arg1, ...)						\
+	.a1 = (arg1)
+
+#define __gh_declare_arg_2(arg1, arg2, ...)					\
+	__gh_declare_arg_1(arg1),						\
+	.a2 = (arg2)
+
+#define __gh_declare_arg_3(arg1, arg2, arg3, ...)				\
+	__gh_declare_arg_2(arg1, arg2),						\
+	.a3 = (arg3)
+
+#define __gh_declare_arg_4(arg1, arg2, arg3, arg4, ...)				\
+	__gh_declare_arg_3(arg1, arg2, arg3),					\
+	.a4 = (arg4)
+
+#define __gh_declare_arg_5(arg1, arg2, arg3, arg4, arg5, ...)			\
+	__gh_declare_arg_4(arg1, arg2, arg3, arg4),				\
+	.a5 = (arg5)
+
+#define __gh_declare_arg_6(arg1, arg2, arg3, arg4, arg5, arg6, ...)		\
+	__gh_declare_arg_5(arg1, arg2, arg3, arg4, arg5),			\
+	.a6 = (arg6)
+
+#define __gh_declare_arg_7(arg1, arg2, arg3, arg4, arg5, arg6, arg7, ...)	\
+	__gh_declare_arg_6(arg1, arg2, arg3, arg4, arg5, arg6),			\
+	.a7 = (arg7)
+
+#define __gh_declare_arg_8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, ...)	\
+	__gh_declare_arg_7(arg1, arg2, arg3, arg4, arg5, arg6, arg7),		\
+	.a8 = (arg8)
+
+#define ___gh_declare_args(nargs)	__gh_declare_arg_ ## nargs
+#define __gh_declare_args(nargs)	___gh_declare_args(nargs)
+#define _gh_declare_args(nargs, ...) __gh_declare_args(nargs)(__VA_ARGS__)
+
+#define __gh_assign_res_0(...)
+
+#define __gh_assign_res_1(r1)					\
+	r1 = res.a0
+
+#define __gh_assign_res_2(r1, r2)				\
+	__gh_assign_res_1(r1);					\
+	r2 = res.a1
+
+#define __gh_assign_res_3(r1, r2, r3)				\
+	__gh_assign_res_2(r1, r2);				\
+	r3 = res.a2
+
+#define __gh_assign_res_4(r1, r2, r3, r4)			\
+	__gh_assign_res_3(r1, r2, r3);				\
+	r4 = res.a3
+
+#define __gh_assign_res_5(r1, r2, r3, r4, r5)			\
+	__gh_assign_res_4(r1, r2, r3, r4);			\
+	r5 = res.a4
+
+#define __gh_assign_res_6(r1, r2, r3, r4, r5, r6)		\
+	__gh_assign_res_5(r1, r2, r3, r4, r5);			\
+	r6 = res.a5
+
+#define __gh_assign_res_7(r1, r2, r3, r4, r5, r6, r7)		\
+	__gh_assign_res_6(r1, r2, r3, r4, r5, r6);		\
+	r7 = res.a6
+
+#define __gh_assign_res_8(r1, r2, r3, r4, r5, r6, r7, r8)	\
+	__gh_assign_res_7(r1, r2, r3, r4, r5, r6, r7);		\
+	r8 = res.a7
+
+#define ___gh_assign_res(nargs)	__gh_assign_res_ ## nargs
+#define __gh_assign_res(nargs)	___gh_assign_res(nargs)
+#define _gh_assign_res(...) __gh_assign_res(__gh_count_args(__VA_ARGS__))(__VA_ARGS__)
+
+/**
+ * arch_gh_hypercall() - Performs an AArch64-specific call into hypervisor using Gunyah ABI
+ * @hcall_num: Hypercall function ID to invoke
+ * @nargs: Number of input arguments
+ * @...: First nargs are the input arguments. Remaining arguments are output variables.
+ */
+#define arch_gh_hypercall(hcall_num, nargs, ...)				\
+	do {									\
+		struct arm_smccc_1_2_regs res;					\
+		struct arm_smccc_1_2_regs args = {				\
+			.a0 = hcall_num,					\
+			_gh_declare_args(nargs, __VA_ARGS__)			\
+		};								\
+		arm_smccc_1_2_hvc(&args, &res);					\
+		_gh_assign_res(__gh_to_res(nargs, __VA_ARGS__));		\
+	} while (0)
+
+#endif
-- 
2.25.1

