Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2125466275
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357423AbhLBLkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357384AbhLBLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:40:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E06C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id iq11so20339483pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rgjlIFZQkRh7GP5Q8bdJ0KysvgTv10BpYJ2a+ktomI=;
        b=poLWnZNG7X3up4RqrkA3yKvQlM8HOOeTS+Ui0f4oZUusWrW6M8yguDIRtbXfqdTgCu
         jMqRmywHwn94/O/GQM/5wFpidBxJQDnOjofZFh51HLQiLUT31t9Z5AInKLf49KXNOs0O
         yx+udMhTLAvvRApfkslRbsL+V+lhx0AlAEMDe6oJE7J4s2maGhJZ3zFCMLCgrca0bif+
         9kuKyF/dWLdB9l9vkYRVs2v+bwUmhatgNh1guGgkYOCD9vxPVqMMrdsIw4GtL3f2vg8p
         ywwFYNAh6exTnsJo9eIsD0V99lTMvfGZMMFSauuzaD49ZmA8wdW/BuFfufa2qhi1dRnC
         Wbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rgjlIFZQkRh7GP5Q8bdJ0KysvgTv10BpYJ2a+ktomI=;
        b=wcPIvJ1UbIaGhOoCbISuLE3UFENlU52D54NSJJ9Fv0R4hcAFmWHp1OGAkBfbNrg0Hf
         1n7Fa3cKQBYBq7WDV1xY8TY+6M+kfdNtJas9c/7zIBh/hZh77gijazjTm+dxj/pNaHsX
         bZEj+6prq1WyMiFFo9h0BhbiXcqly+gHzdtav37D1fEaRBmCEk6IrBtlfIkf7wpaO9Zp
         cAXUG1UHgTffOEErNqO0LAd0LN7nnKLbBLkYIbuv99q0TsRtZxtt14EGjw9/I257JH0i
         gpJyRqAenXv+o5evo3JrqzfFopNOIFM9R37HpD99JrE+sqww7EV83O6wsfxdtWpvWa8q
         1o4w==
X-Gm-Message-State: AOAM531s1SdCqg2SKvM3woHEbioYLq/gHE9yuD540ZGUW5Btkw48wnvK
        xFT1WHRCXpZ9Lx5SmYsQI+U9
X-Google-Smtp-Source: ABdhPJycthqRiQJYUCiNautpEHyMOnHDRBBg1ODAfWfzlyQ8UALXECmlmFNItdai2dwXy9Ds0w1AlQ==
X-Received: by 2002:a17:90a:1a55:: with SMTP id 21mr5384068pjl.240.1638445038256;
        Thu, 02 Dec 2021 03:37:18 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:37:17 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/20] bus: mhi: Cleanup the register definitions used in headers
Date:   Thu,  2 Dec 2021 17:05:36 +0530
Message-Id: <20211202113553.238011-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup includes:

1. Moving the MHI register bit definitions to common.h header (only the
   register offsets differ between host and ep not the bit definitions)
2. Using the GENMASK macro for masks
3. Removing brackets for single values
4. Using lowercase for hex values

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/common.h        | 129 ++++++++++++---
 drivers/bus/mhi/host/internal.h | 282 +++++++++++---------------------
 2 files changed, 207 insertions(+), 204 deletions(-)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index 2ea438205617..c1272d61e54e 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -9,32 +9,123 @@
 
 #include <linux/mhi.h>
 
+/* MHI register bits */
+#define MHIREGLEN_MHIREGLEN_MASK		GENMASK(31, 0)
+#define MHIREGLEN_MHIREGLEN_SHIFT		0
+
+#define MHIVER_MHIVER_MASK			GENMASK(31, 0)
+#define MHIVER_MHIVER_SHIFT			0
+
+#define MHICFG_NHWER_MASK			GENMASK(31, 24)
+#define MHICFG_NHWER_SHIFT			24
+#define MHICFG_NER_MASK				GENMASK(23, 16)
+#define MHICFG_NER_SHIFT			16
+#define MHICFG_NHWCH_MASK			GENMASK(15, 8)
+#define MHICFG_NHWCH_SHIFT			8
+#define MHICFG_NCH_MASK				GENMASK(7, 0)
+#define MHICFG_NCH_SHIFT			0
+
+#define CHDBOFF_CHDBOFF_MASK			GENMASK(31, 0)
+#define CHDBOFF_CHDBOFF_SHIFT			0
+
+#define ERDBOFF_ERDBOFF_MASK			GENMASK(31, 0)
+#define ERDBOFF_ERDBOFF_SHIFT			0
+
+#define BHIOFF_BHIOFF_MASK			GENMASK(31, 0)
+#define BHIOFF_BHIOFF_SHIFT			0
+
+#define BHIEOFF_BHIEOFF_MASK			GENMASK(31, 0)
+#define BHIEOFF_BHIEOFF_SHIFT			0
+
+#define DEBUGOFF_DEBUGOFF_MASK			GENMASK(31, 0)
+#define DEBUGOFF_DEBUGOFF_SHIFT			0
+
+#define MHICTRL_MHISTATE_MASK			GENMASK(15, 8)
+#define MHICTRL_MHISTATE_SHIFT			8
+#define MHICTRL_RESET_MASK			2
+#define MHICTRL_RESET_SHIFT			1
+
+#define MHISTATUS_MHISTATE_MASK			GENMASK(15, 8)
+#define MHISTATUS_MHISTATE_SHIFT		8
+#define MHISTATUS_SYSERR_MASK			4
+#define MHISTATUS_SYSERR_SHIFT			2
+#define MHISTATUS_READY_MASK			1
+#define MHISTATUS_READY_SHIFT			0
+
+#define CCABAP_LOWER_CCABAP_LOWER_MASK		GENMASK(31, 0)
+#define CCABAP_LOWER_CCABAP_LOWER_SHIFT		0
+
+#define CCABAP_HIGHER_CCABAP_HIGHER_MASK	GENMASK(31, 0)
+#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT	0
+
+#define ECABAP_LOWER_ECABAP_LOWER_MASK		GENMASK(31, 0)
+#define ECABAP_LOWER_ECABAP_LOWER_SHIFT		0
+
+#define ECABAP_HIGHER_ECABAP_HIGHER_MASK	GENMASK(31, 0)
+#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT	0
+
+#define CRCBAP_LOWER_CRCBAP_LOWER_MASK		GENMASK(31, 0)
+#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT		0
+
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK	GENMASK(31, 0)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT	0
+
+#define CRDB_LOWER_CRDB_LOWER_MASK		GENMASK(31, 0)
+#define CRDB_LOWER_CRDB_LOWER_SHIFT		0
+
+#define CRDB_HIGHER_CRDB_HIGHER_MASK		GENMASK(31, 0)
+#define CRDB_HIGHER_CRDB_HIGHER_SHIFT		0
+
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK GENMASK(31, 0)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT 0
+
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK GENMASK(31, 0)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT 0
+
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK GENMASK(31, 0)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT 0
+
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK GENMASK(31, 0)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT 0
+
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK GENMASK(31, 0)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT 0
+
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK GENMASK(31, 0)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT 0
+
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK GENMASK(31, 0)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT 0
+
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK GENMASK(31, 0)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT 0
+
 /* Command Ring Element macros */
 /* No operation command */
-#define MHI_TRE_CMD_NOOP_PTR (0)
-#define MHI_TRE_CMD_NOOP_DWORD0 (0)
+#define MHI_TRE_CMD_NOOP_PTR 0
+#define MHI_TRE_CMD_NOOP_DWORD0 0
 #define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
 
 /* Channel reset command */
-#define MHI_TRE_CMD_RESET_PTR (0)
-#define MHI_TRE_CMD_RESET_DWORD0 (0)
+#define MHI_TRE_CMD_RESET_PTR 0
+#define MHI_TRE_CMD_RESET_DWORD0 0
 #define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
 					(MHI_CMD_RESET_CHAN << 16))
 
 /* Channel stop command */
-#define MHI_TRE_CMD_STOP_PTR (0)
-#define MHI_TRE_CMD_STOP_DWORD0 (0)
+#define MHI_TRE_CMD_STOP_PTR 0
+#define MHI_TRE_CMD_STOP_DWORD0 0
 #define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
 				       (MHI_CMD_STOP_CHAN << 16))
 
 /* Channel start command */
-#define MHI_TRE_CMD_START_PTR (0)
-#define MHI_TRE_CMD_START_DWORD0 (0)
+#define MHI_TRE_CMD_START_PTR 0
+#define MHI_TRE_CMD_START_DWORD0 0
 #define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
 					(MHI_CMD_START_CHAN << 16))
 
-#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xff)
+#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xff)
 
 /* Event descriptor macros */
 /* Transfer completion event */
@@ -42,18 +133,18 @@
 #define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
 #define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
 #define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
-#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
-#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xff)
+#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xffff)
+#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xff)
+#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xff)
+#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xff)
+#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xff)
 #define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
 #define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
 #define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
-#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
+#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xff)
+#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xff)
+#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xff)
 
 /* State change event */
 #define MHI_SC_EV_PTR 0
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index a324a76684d0..c882245b9133 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -11,197 +11,109 @@
 
 extern struct bus_type mhi_bus_type;
 
-#define MHIREGLEN (0x0)
-#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
-#define MHIREGLEN_MHIREGLEN_SHIFT (0)
-
-#define MHIVER (0x8)
-#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
-#define MHIVER_MHIVER_SHIFT (0)
-
-#define MHICFG (0x10)
-#define MHICFG_NHWER_MASK (0xFF000000)
-#define MHICFG_NHWER_SHIFT (24)
-#define MHICFG_NER_MASK (0xFF0000)
-#define MHICFG_NER_SHIFT (16)
-#define MHICFG_NHWCH_MASK (0xFF00)
-#define MHICFG_NHWCH_SHIFT (8)
-#define MHICFG_NCH_MASK (0xFF)
-#define MHICFG_NCH_SHIFT (0)
-
-#define CHDBOFF (0x18)
-#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
-#define CHDBOFF_CHDBOFF_SHIFT (0)
-
-#define ERDBOFF (0x20)
-#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
-#define ERDBOFF_ERDBOFF_SHIFT (0)
-
-#define BHIOFF (0x28)
-#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
-#define BHIOFF_BHIOFF_SHIFT (0)
-
-#define BHIEOFF (0x2C)
-#define BHIEOFF_BHIEOFF_MASK (0xFFFFFFFF)
-#define BHIEOFF_BHIEOFF_SHIFT (0)
-
-#define DEBUGOFF (0x30)
-#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
-#define DEBUGOFF_DEBUGOFF_SHIFT (0)
-
-#define MHICTRL (0x38)
-#define MHICTRL_MHISTATE_MASK (0x0000FF00)
-#define MHICTRL_MHISTATE_SHIFT (8)
-#define MHICTRL_RESET_MASK (0x2)
-#define MHICTRL_RESET_SHIFT (1)
-
-#define MHISTATUS (0x48)
-#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
-#define MHISTATUS_MHISTATE_SHIFT (8)
-#define MHISTATUS_SYSERR_MASK (0x4)
-#define MHISTATUS_SYSERR_SHIFT (2)
-#define MHISTATUS_READY_MASK (0x1)
-#define MHISTATUS_READY_SHIFT (0)
-
-#define CCABAP_LOWER (0x58)
-#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
-#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
-
-#define CCABAP_HIGHER (0x5C)
-#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
-#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
-
-#define ECABAP_LOWER (0x60)
-#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
-#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
-
-#define ECABAP_HIGHER (0x64)
-#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
-#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
-
-#define CRCBAP_LOWER (0x68)
-#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
-#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
-
-#define CRCBAP_HIGHER (0x6C)
-#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
-#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
-
-#define CRDB_LOWER (0x70)
-#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
-#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
-
-#define CRDB_HIGHER (0x74)
-#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
-#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
-
-#define MHICTRLBASE_LOWER (0x80)
-#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
-#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
-
-#define MHICTRLBASE_HIGHER (0x84)
-#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
-#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
-
-#define MHICTRLLIMIT_LOWER (0x88)
-#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
-#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
-
-#define MHICTRLLIMIT_HIGHER (0x8C)
-#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
-#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
-
-#define MHIDATABASE_LOWER (0x98)
-#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
-#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
-
-#define MHIDATABASE_HIGHER (0x9C)
-#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
-#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
-
-#define MHIDATALIMIT_LOWER (0xA0)
-#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
-#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
-
-#define MHIDATALIMIT_HIGHER (0xA4)
-#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
-#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
+/* MHI registers */
+#define MHIREGLEN			0x0
+#define MHIVER				0x8
+#define MHICFG				0x10
+#define CHDBOFF				0x18
+#define ERDBOFF				0x20
+#define BHIOFF				0x28
+#define BHIEOFF				0x2c
+#define DEBUGOFF			0x30
+#define MHICTRL				0x38
+#define MHISTATUS			0x48
+#define CCABAP_LOWER			0x58
+#define CCABAP_HIGHER			0x5c
+#define ECABAP_LOWER			0x60
+#define ECABAP_HIGHER			0x64
+#define CRCBAP_LOWER			0x68
+#define CRCBAP_HIGHER			0x6c
+#define CRDB_LOWER			0x70
+#define CRDB_HIGHER			0x74
+#define MHICTRLBASE_LOWER		0x80
+#define MHICTRLBASE_HIGHER		0x84
+#define MHICTRLLIMIT_LOWER		0x88
+#define MHICTRLLIMIT_HIGHER		0x8c
+#define MHIDATABASE_LOWER		0x98
+#define MHIDATABASE_HIGHER		0x9c
+#define MHIDATALIMIT_LOWER		0xa0
+#define MHIDATALIMIT_HIGHER		0xa4
 
 /* Host request register */
-#define MHI_SOC_RESET_REQ_OFFSET (0xB0)
-#define MHI_SOC_RESET_REQ BIT(0)
+#define MHI_SOC_RESET_REQ_OFFSET	0xb0
+#define MHI_SOC_RESET_REQ		BIT(0)
 
 /* MHI BHI offfsets */
-#define BHI_BHIVERSION_MINOR (0x00)
-#define BHI_BHIVERSION_MAJOR (0x04)
-#define BHI_IMGADDR_LOW (0x08)
-#define BHI_IMGADDR_HIGH (0x0C)
-#define BHI_IMGSIZE (0x10)
-#define BHI_RSVD1 (0x14)
-#define BHI_IMGTXDB (0x18)
-#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHI_TXDB_SEQNUM_SHFT (0)
-#define BHI_RSVD2 (0x1C)
-#define BHI_INTVEC (0x20)
-#define BHI_RSVD3 (0x24)
-#define BHI_EXECENV (0x28)
-#define BHI_STATUS (0x2C)
-#define BHI_ERRCODE (0x30)
-#define BHI_ERRDBG1 (0x34)
-#define BHI_ERRDBG2 (0x38)
-#define BHI_ERRDBG3 (0x3C)
-#define BHI_SERIALNU (0x40)
-#define BHI_SBLANTIROLLVER (0x44)
-#define BHI_NUMSEG (0x48)
-#define BHI_MSMHWID(n) (0x4C + (0x4 * (n)))
-#define BHI_OEMPKHASH(n) (0x64 + (0x4 * (n)))
-#define BHI_RSVD5 (0xC4)
-#define BHI_STATUS_MASK (0xC0000000)
-#define BHI_STATUS_SHIFT (30)
-#define BHI_STATUS_ERROR (3)
-#define BHI_STATUS_SUCCESS (2)
-#define BHI_STATUS_RESET (0)
+#define BHI_BHIVERSION_MINOR		0x00
+#define BHI_BHIVERSION_MAJOR		0x04
+#define BHI_IMGADDR_LOW			0x08
+#define BHI_IMGADDR_HIGH		0x0c
+#define BHI_IMGSIZE			0x10
+#define BHI_RSVD1			0x14
+#define BHI_IMGTXDB			0x18
+#define BHI_TXDB_SEQNUM_BMSK		GENMASK(29, 0)
+#define BHI_TXDB_SEQNUM_SHFT		0
+#define BHI_RSVD2			0x1c
+#define BHI_INTVEC			0x20
+#define BHI_RSVD3			0x24
+#define BHI_EXECENV			0x28
+#define BHI_STATUS			0x2c
+#define BHI_ERRCODE			0x30
+#define BHI_ERRDBG1			0x34
+#define BHI_ERRDBG2			0x38
+#define BHI_ERRDBG3			0x3c
+#define BHI_SERIALNU			0x40
+#define BHI_SBLANTIROLLVER		0x44
+#define BHI_NUMSEG			0x48
+#define BHI_MSMHWID(n)			(0x4c + (0x4 * (n)))
+#define BHI_OEMPKHASH(n)		(0x64 + (0x4 * (n)))
+#define BHI_RSVD5			0xc4
+#define BHI_STATUS_MASK			GENMASK(31, 30)
+#define BHI_STATUS_SHIFT		30
+#define BHI_STATUS_ERROR		3
+#define BHI_STATUS_SUCCESS		2
+#define BHI_STATUS_RESET		0
 
 /* MHI BHIE offsets */
-#define BHIE_MSMSOCID_OFFS (0x0000)
-#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
-#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
-#define BHIE_TXVECSIZE_OFFS (0x0034)
-#define BHIE_TXVECDB_OFFS (0x003C)
-#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_TXVECDB_SEQNUM_SHFT (0)
-#define BHIE_TXVECSTATUS_OFFS (0x0044)
-#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
-#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
-#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
-#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
-#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
-#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
-#define BHIE_RXVECSIZE_OFFS (0x0068)
-#define BHIE_RXVECDB_OFFS (0x0070)
-#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_RXVECDB_SEQNUM_SHFT (0)
-#define BHIE_RXVECSTATUS_OFFS (0x0078)
-#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
-#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
-#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
-#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
-
-#define SOC_HW_VERSION_OFFS (0x224)
-#define SOC_HW_VERSION_FAM_NUM_BMSK (0xF0000000)
-#define SOC_HW_VERSION_FAM_NUM_SHFT (28)
-#define SOC_HW_VERSION_DEV_NUM_BMSK (0x0FFF0000)
-#define SOC_HW_VERSION_DEV_NUM_SHFT (16)
-#define SOC_HW_VERSION_MAJOR_VER_BMSK (0x0000FF00)
-#define SOC_HW_VERSION_MAJOR_VER_SHFT (8)
-#define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
-#define SOC_HW_VERSION_MINOR_VER_SHFT (0)
+#define BHIE_MSMSOCID_OFFS		0x0000
+#define BHIE_TXVECADDR_LOW_OFFS		0x002c
+#define BHIE_TXVECADDR_HIGH_OFFS	0x0030
+#define BHIE_TXVECSIZE_OFFS		0x0034
+#define BHIE_TXVECDB_OFFS		0x003c
+#define BHIE_TXVECDB_SEQNUM_BMSK	GENMASK(29, 0)
+#define BHIE_TXVECDB_SEQNUM_SHFT	0
+#define BHIE_TXVECSTATUS_OFFS		0x0044
+#define BHIE_TXVECSTATUS_SEQNUM_BMSK	GENMASK(29, 0)
+#define BHIE_TXVECSTATUS_SEQNUM_SHFT	0
+#define BHIE_TXVECSTATUS_STATUS_BMSK	GENMASK(31, 30)
+#define BHIE_TXVECSTATUS_STATUS_SHFT	30
+#define BHIE_TXVECSTATUS_STATUS_RESET	0x00
+#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL 0x02
+#define BHIE_TXVECSTATUS_STATUS_ERROR	0x03
+#define BHIE_RXVECADDR_LOW_OFFS		0x0060
+#define BHIE_RXVECADDR_HIGH_OFFS	0x0064
+#define BHIE_RXVECSIZE_OFFS		0x0068
+#define BHIE_RXVECDB_OFFS		0x0070
+#define BHIE_RXVECDB_SEQNUM_BMSK	GENMASK(29, 0)
+#define BHIE_RXVECDB_SEQNUM_SHFT	0
+#define BHIE_RXVECSTATUS_OFFS		0x0078
+#define BHIE_RXVECSTATUS_SEQNUM_BMSK	GENMASK(29, 0)
+#define BHIE_RXVECSTATUS_SEQNUM_SHFT	0
+#define BHIE_RXVECSTATUS_STATUS_BMSK	GENMASK(31, 30)
+#define BHIE_RXVECSTATUS_STATUS_SHFT	30
+#define BHIE_RXVECSTATUS_STATUS_RESET	0x00
+#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL 0x02
+#define BHIE_RXVECSTATUS_STATUS_ERROR	0x03
+
+#define SOC_HW_VERSION_OFFS		0x224
+#define SOC_HW_VERSION_FAM_NUM_BMSK	GENMASK(31, 28)
+#define SOC_HW_VERSION_FAM_NUM_SHFT	28
+#define SOC_HW_VERSION_DEV_NUM_BMSK	GENMASK(27, 16)
+#define SOC_HW_VERSION_DEV_NUM_SHFT	16
+#define SOC_HW_VERSION_MAJOR_VER_BMSK	GENMASK(15, 8)
+#define SOC_HW_VERSION_MAJOR_VER_SHFT	8
+#define SOC_HW_VERSION_MINOR_VER_BMSK	GENMASK(7, 0)
+#define SOC_HW_VERSION_MINOR_VER_SHFT	0
 
 struct mhi_ctxt {
 	struct mhi_event_ctxt *er_ctxt;
-- 
2.25.1

