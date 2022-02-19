Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384664BC3B3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiBSAr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:47:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiBSArl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:47:41 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB327790E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:23 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id e19-20020a4ab993000000b0031a98fe3a9dso5617809oop.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0j+T9VasmFWeUqsBn6L9ZQ6Qv99DW8ONEhzwQtqDRFk=;
        b=W8CSVN8s2dohlJRB1FJ3HVV8VwnSRlGhMP6LtrFCLiIEGxdMl6y1QizrlloOoEq4EJ
         9sfkO7VeAFs2DZ+JK9Fvrm50z13bYgJIQTGS+dAyTvKWOAJMWOY9aqEDWQERIFDNE5wU
         kfDcPpOyMPmtGl+WsPmyQMPZWtRaI4LcZAXQo8lKEo27Uw1oIHR6EEVDjE6tUe4eIKEf
         nN/BFYhE92v9nsecjzw7nwN9zzRBzAH72HGRz5MUVmg6PYcgtm//WgyKMbmwnXD0Cp6B
         bvBoR7vDYQWJD4ctKuNVrowu9dh3YYHUtBep71QqYwihFr/ZwOh1SOkcr7QDv2Bleqkb
         J4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0j+T9VasmFWeUqsBn6L9ZQ6Qv99DW8ONEhzwQtqDRFk=;
        b=1b5fnZUJ5xKjoc/yA2VH/IfItqUEBOdZWfl2sOIbMyicDWpOOWF9SntzKPair5dCqz
         Rw+4iP6wh9YuFm3so6SimpSIWYe6pyCpV/61jshVFQ7htqY0uNFII29b5mU9eVWJi5IL
         4xkitaN8/gf5urheyo3PJY1PeC4Pr879BtTLdp7wkCGusiQ1fZvLjUO1RJ4LSkmL8Dgl
         ZJ35Xp7OM2hx90q2DKedr9eh/uKIr4uIvYdww6R7ENviPJzXW8ALqiWIeF+QOY870sMO
         qfqTBk002JMVbVRKmqiKSO+UP8+b8qEHLLIo8iW57I0efIK3EJTCtJoWK9McZBOynY+0
         bmxw==
X-Gm-Message-State: AOAM530zCtD/1LzrwVSseXmARrw4OyOqSS4BIqxBU3f//rDF3Qcl7iQP
        BHIncWb+ejK71oUpxFPbRm3gqB7cpVokkztf
X-Google-Smtp-Source: ABdhPJxAyxuLwuTuXTKj3/VOQR+djzq+LeVnxLMGFdxcc2wCuga4DKoazdnFlrq/5iDDL20rw7Ctjg==
X-Received: by 2002:a4a:7601:0:b0:2e0:3c62:4787 with SMTP id t1-20020a4a7601000000b002e03c624787mr3070173ooc.11.1645231642263;
        Fri, 18 Feb 2022 16:47:22 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id n11sm11360794oal.1.2022.02.18.16.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:47:21 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [v6 5/9] RISC-V: Add RISC-V SBI PMU extension definitions
Date:   Fri, 18 Feb 2022 16:46:56 -0800
Message-Id: <20220219004700.1973682-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220219004700.1973682-1-atishp@rivosinc.com>
References: <20220219004700.1973682-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

This patch adds all the definitions defined by the SBI PMU extension.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 95 ++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d1c37479d828..4a430ae60eaa 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -29,6 +29,7 @@ enum sbi_ext_id {
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
 	SBI_EXT_SRST = 0x53525354,
+	SBI_EXT_PMU = 0x504D55,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -95,6 +96,98 @@ enum sbi_srst_reset_reason {
 	SBI_SRST_RESET_REASON_SYS_FAILURE,
 };
 
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+};
+
+#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
+#define RISCV_PMU_RAW_EVENT_IDX 0x20000
+
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/**
+ * Special "firmware" events provided by the firmware, even if the hardware
+ * does not support performance events. These events are encoded as a raw
+ * event type in Linux kernel perf framework.
+ */
+enum sbi_pmu_fw_generic_events_t {
+	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
+	SBI_PMU_FW_MISALIGNED_STORE	= 1,
+	SBI_PMU_FW_ACCESS_LOAD		= 2,
+	SBI_PMU_FW_ACCESS_STORE		= 3,
+	SBI_PMU_FW_ILLEGAL_INSN		= 4,
+	SBI_PMU_FW_SET_TIMER		= 5,
+	SBI_PMU_FW_IPI_SENT		= 6,
+	SBI_PMU_FW_IPI_RECVD		= 7,
+	SBI_PMU_FW_FENCE_I_SENT		= 8,
+	SBI_PMU_FW_FENCE_I_RECVD	= 9,
+	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
+	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
+	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
+	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
+
+	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
+	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
+
+	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
+	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
+	SBI_PMU_FW_MAX,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_event_type {
+	SBI_PMU_EVENT_TYPE_HW = 0x0,
+	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
+	SBI_PMU_EVENT_TYPE_RAW = 0x2,
+	SBI_PMU_EVENT_TYPE_FW = 0xf,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
+#define SBI_PMU_CFG_FLAG_SET_VSNH	(1 << 4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
@@ -108,6 +201,8 @@ enum sbi_srst_reset_reason {
 #define SBI_ERR_DENIED		-4
 #define SBI_ERR_INVALID_ADDRESS	-5
 #define SBI_ERR_ALREADY_AVAILABLE -6
+#define SBI_ERR_ALREADY_STARTED -7
+#define SBI_ERR_ALREADY_STOPPED -8
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.30.2

