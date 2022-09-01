Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205625A9520
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiIAKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiIAKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:54:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579521321E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:54:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 76so17124195pfy.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JUQCoAsOqHp/dubozy2ybfyMmZNRsIHeStZD6k/cN8k=;
        b=pEHoyzdBfl05pa53IbQHgeW5T2Pk8XlmAmTFxk2pg4HL/nrmtoC975q8j2ZDRANdNv
         Co4fEWnThatHt8+F6pTwPDv4/sLtMi2cDLupK0G6zsFZd9Z2SPyy8ZAhJEwwU8Hl9ZYh
         msAX2J4/xLFzGPNKgh2znuo8frcPgb8APsDbgcF3G347i2VqUN/GZccYTTb9GDnawbhq
         77WMY/iP53dNcAo6iSvT8BVwsox8r2g/4P70wJrbQRCQG6DrzyYew63m1jl/GIGoNkWy
         RhFpHtLewIltZoSklyakFdiBYNwYUa2jlrHAfy0GKdiaIFB//dMH9xfkE2814WdTL06F
         RFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JUQCoAsOqHp/dubozy2ybfyMmZNRsIHeStZD6k/cN8k=;
        b=Z3VzF8nn6ZZf38ZkkSGw/lYDINRh+3wL4XnlHVPCFvl+Hc+F6r6NosFC+4cbsNFBeU
         MzW4jbuAP67VgFEpQLO1HmEAYPcFvyDU7hiA5Bp5trMdDH4/MotUwS9Z7UfHZhytcDLC
         g2jsDTYtCz3dOmsSdU23ny3pqFhSc/ei2u9zkeQHGG8c75+a9Soh3HPW+EylfhruS7Rx
         4gjoy6xVDCa7mhmAn4xoOkYX1BhN/F61cA9u0AoOCa0zuLDHnk4t67n6hdGXLXL/iGMs
         LbgTeEORcTtBXpjqhOgc2+sZQ8Nfik5+3RTgPzIVTc7KVSMUduwYcAMmB8PKei4GAleR
         H1tw==
X-Gm-Message-State: ACgBeo12FFi8iqoyywYkIEZ47UY6SkHseuZbd2GnO3T1itK1Muwuv5tK
        C3oxLBI0/4lnwIeGzeuEK58wvtSvBLNX3w==
X-Google-Smtp-Source: AA6agR42SHfyY0313yjJ+yTynSdioV4ONB04qGKCcLNFL7OWBmLXKp2Mj65GLrNmOCcD22FWobLf/Q==
X-Received: by 2002:a62:1ac5:0:b0:538:3332:d531 with SMTP id a188-20020a621ac5000000b005383332d531mr19601658pfa.46.1662029673282;
        Thu, 01 Sep 2022 03:54:33 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:8069:f46:34af:eb19])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0016c57657977sm13508910plb.41.2022.09.01.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 03:54:33 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v4 1/4] firmware: qcom: scm: Add support for tsens reinit workaround
Date:   Thu,  1 Sep 2022 16:24:11 +0530
Message-Id: <20220901105414.1171813-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
References: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some versions of Qualcomm tsens controller might enter a
'bad state' while running stability tests causing sensor
temperatures/interrupts status to be in an 'invalid' state.

It is recommended to re-initialize the tsens controller
via trustzone (secure registers) using scm call(s) when that
happens.

Add support for the same in the qcom_scm driver.

Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/firmware/qcom_scm.c | 15 +++++++++++++++
 drivers/firmware/qcom_scm.h |  4 ++++
 include/linux/qcom_scm.h    |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54c8146..93adcc046a62 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -858,6 +858,21 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
 }
 EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
 
+int qcom_scm_tsens_reinit(void)
+{
+	int ret;
+	const struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_TSENS,
+		.cmd = QCOM_SCM_TSENS_INIT_ID,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	return ret ? : res.result[0];
+}
+EXPORT_SYMBOL(qcom_scm_tsens_reinit);
+
 static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 				 size_t mem_sz, phys_addr_t src, size_t src_sz,
 				 phys_addr_t dest, size_t dest_sz)
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 0d51eef2472f..5762f02dde7c 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -94,6 +94,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
 #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
 
+/* TSENS Services and Function IDs */
+#define QCOM_SCM_SVC_TSENS		0x1e
+#define QCOM_SCM_TSENS_INIT_ID		0x5
+
 #define QCOM_SCM_SVC_IO			0x05
 #define QCOM_SCM_IO_READ		0x01
 #define QCOM_SCM_IO_WRITE		0x02
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f8335644a01a..5c37e1658cef 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 extern int qcom_scm_lmh_profile_change(u32 profile_id);
 extern bool qcom_scm_lmh_dcvsh_available(void);
 
+extern int qcom_scm_tsens_reinit(void);
+
 #endif
-- 
2.37.1

