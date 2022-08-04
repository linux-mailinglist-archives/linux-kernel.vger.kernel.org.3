Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7358976B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiHDFrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiHDFq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:46:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ECC60513
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:46:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a8so5077123pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 22:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=knYZVAmP/Bzeklaj6dd4onpv7s/0aWzK0OLPNMow6Oo=;
        b=oiGAb3nZTqAVeXKC2q6OSWCPTc2TCwaOu7pIy42JBHWMdbOup1bH7+dXP2juucOS5n
         FbkkPrG/mSFKvSpKiK5ISWDaklAZEo1lFUvwFekKW4y9Gq5BE3p2OGEdCegu5+aLbbWy
         FRyzxNryrI3UY5ffGkPQUZEq/9PBZlbW/oZgAPS6s+p4mqlt8AcmStBSQoGUk2xigfa1
         blvJYU+NoTrHKLPMcDXQFk0xNQKyg8q2e2Q9EhBwP/aPEWASzFFIEb6O79DnbMKjqeL4
         4HI4H3d9fdjIZ5a552bOFZTHw42akmTulEvBoMe4aqMN4sDuCIbgclx2sAzW50vXzyl+
         2pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=knYZVAmP/Bzeklaj6dd4onpv7s/0aWzK0OLPNMow6Oo=;
        b=z5pJPOryK5fidMmmgXHxtu8ht+zZ/nWLT3YsTivmThDSf9t8QWpuUchi5WoY6VysF2
         Lk05Zvl3SKdR0JDI3UITMRK7U/EMces6j1PiYQKJNTvp2MnXw6FkqEjkWz67ZBvnKXiB
         zSr/DDNBBzWF01GMsAYYUnJMKfeu3VdmtPl36mdpSEjJqJIB07let5aDh7Ug1gMlCP2B
         MunNAsuDou3QKppYlhJw3bzMCYQswgKJEKJCrU2bPFbv/AGan2003HMHA3PFa2pq3V3v
         6goGinWFboC9WHT80ryTB27aB9cI7IB44Cbev9+ksifzYGvOwqQcx0lgzUJ9zfs2J0Jd
         9F4Q==
X-Gm-Message-State: ACgBeo1NJ4lMgfIBdyRQkM2nhEWqslmOUvgdPG8JIlJ1qBWXWaadmPqw
        72WgrowQWlsWNpTOVrpo6fc9/A==
X-Google-Smtp-Source: AA6agR55jjSTxfauACZeG1uHaAeE7Jy3PPM7lEUupraiPkCM09k1TEDaA147tE7lp6cjcYkBOexUcQ==
X-Received: by 2002:a17:90b:1645:b0:1f5:67f:ff84 with SMTP id il5-20020a17090b164500b001f5067fff84mr307254pjb.86.1659592014546;
        Wed, 03 Aug 2022 22:46:54 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:ddbf:1bd6:4443:9e5b:2aa2])
        by smtp.gmail.com with ESMTPSA id q25-20020aa78439000000b0052dcd14e3desm5375636pfn.183.2022.08.03.22.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:46:54 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v3 1/4] firmware: qcom: scm: Add support for tsens reinit workaround
Date:   Thu,  4 Aug 2022 11:16:35 +0530
Message-Id: <20220804054638.3197294-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
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
index 0d51eef2472f..495fa00230c7 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -94,6 +94,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
 #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
 
+/* TSENS Services and Function IDs */
+#define QCOM_SCM_SVC_TSENS		0x1E
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
2.35.3

