Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8249523865
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbiEKQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbiEKQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:16:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273E27150;
        Wed, 11 May 2022 09:16:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so2378258pfe.13;
        Wed, 11 May 2022 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oo+xWOyB/yW9hDceUY9ZJG/L2ZB1N/Jc0WPvd/Kp/Sk=;
        b=lD/aGErmGSFF6LS7HM2gBFn5Dgs3TUWq7SBRh0LJ951aAqlSmu07pYqqGc6jV0aebn
         KrDlGykfQPnACbhNu35Hz6SK1qjifM/ANLvvB1vV8oLWmu0CD6fzgNoEpiezjOyKhMqs
         DDfosSULYfqLqcyjfsdGR44R0kUj74XUouPUM87rncZcrheoAomlgcd8whBkwVqIqcVF
         29ZffaUC3zlHRDcPamp0/RVdW4WvFv92q2zWGSlKBceZfMlj3oX3jCVdBMoqbtO+7UEP
         7Mfw4HgVR/QQ5EUH3zpRTrqZtWkQdHxnOb7OtSsYuyzXVMc79DnUgLbUpT0Sl6yjmMvl
         kZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oo+xWOyB/yW9hDceUY9ZJG/L2ZB1N/Jc0WPvd/Kp/Sk=;
        b=zQewMB9gHS9orRi/TB21tjndsZDg/3DY4GhZD4i4048qaRefqny29FTLNyCLk8VgZf
         aPn58Q+q22BI7rgaLGgYEW9GPMbRqhKSkHVIShA/ajZrWd6ICXmsBtAaXpQvo+ZX2wPs
         3nzg6VOS6CFk0IPdMk5eXcpOZlOyXfImV03iOJHQ3WqXfFF4+XFx0YPLIJQAQsGlHcCF
         zWCZofT88gV1/v2phPX0DuU9Qdye6IdTkw6H2caoRvG9nB97JNhuWTP2UFhsWeIU2PxU
         hfLaLUAwqZzP1+jQbo0KbLq0zXiJHkFyJCNcmLuQ9nKBEWWbNHqnNaumWKddqVVjgReo
         c2kg==
X-Gm-Message-State: AOAM531XwfM2qsNbciIV2Utq5lBfbFQhRSPEJyPKunFeAxZ7Ouyg3Yae
        kb8yN5RPMloX/Q2XRpCnwdcGtaX6HJ9zJmi3
X-Google-Smtp-Source: ABdhPJw3iDCRKWuiBpmy3ARg0rqWcyBUVXfoQdVvExCxrEH8K0wsVKCptGWoWIp0QmbHPV6YOySojA==
X-Received: by 2002:a63:6507:0:b0:3c6:d417:914b with SMTP id z7-20020a636507000000b003c6d417914bmr10640678pgb.475.1652285785917;
        Wed, 11 May 2022 09:16:25 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:25 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 2/9] remoteproc: qcom: q6v5-mss: Add modem support on MSM8953
Date:   Wed, 11 May 2022 21:45:55 +0530
Message-Id: <20220511161602.117772-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modem on the MSM8953 platform is similar to the modem on the MSM8996
platform in terms of set up. It differs primarily in the way it needs SCM
to bless the MPSS firmware region.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 64 +++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index af217de75e4d..a73fdcddeda4 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -234,6 +234,7 @@ struct q6v5 {
 
 enum {
 	MSS_MSM8916,
+	MSS_MSM8953,
 	MSS_MSM8974,
 	MSS_MSM8996,
 	MSS_MSM8998,
@@ -687,12 +688,14 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 		}
 		goto pbl_wait;
 	} else if (qproc->version == MSS_MSM8996 ||
-		   qproc->version == MSS_MSM8998) {
+		   qproc->version == MSS_MSM8998 ||
+		   qproc->version == MSS_MSM8953) {
 		int mem_pwr_ctl;
 
 		/* Override the ACC value if required */
-		writel(QDSP6SS_ACC_OVERRIDE_VAL,
-		       qproc->reg_base + QDSP6SS_STRAP_ACC);
+		if (qproc->version != MSS_MSM8953)
+			writel(QDSP6SS_ACC_OVERRIDE_VAL,
+					qproc->reg_base + QDSP6SS_STRAP_ACC);
 
 		/* Assert resets, stop core */
 		val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
@@ -734,7 +737,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
 
 		/* Turn on L1, L2, ETB and JU memories 1 at a time */
-		if (qproc->version == MSS_MSM8996) {
+		if (qproc->version == MSS_MSM8996 ||
+			qproc->version == MSS_MSM8953) {
 			mem_pwr_ctl = QDSP6SS_MEM_PWR_CTL;
 			i = 19;
 		} else {
@@ -1314,7 +1318,16 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			max_addr = ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
 	}
 
-	/*
+	if (qproc->version == MSS_MSM8953) {
+		ret = qcom_scm_pas_mem_setup(5, qproc->mpss_phys, qproc->mpss_size);
+		if (ret) {
+			dev_err(qproc->dev,
+					"setting up mpss memory failed: %d\n", ret);
+			goto release_firmware;
+		}
+	}
+
+	/**
 	 * In case of a modem subsystem restart on secure devices, the modem
 	 * memory can be reclaimed only after MBA is loaded.
 	 */
@@ -1413,7 +1426,6 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			writel(RMB_CMD_LOAD_READY, qproc->rmb_base + RMB_MBA_COMMAND_REG);
 		}
 		writel(size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
-
 		ret = readl(qproc->rmb_base + RMB_MBA_STATUS_REG);
 		if (ret < 0) {
 			dev_err(qproc->dev, "MPSS authentication failed: %d\n",
@@ -1422,6 +1434,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 		}
 	}
 
+
 	/* Transfer ownership of modem ddr region to q6 */
 	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false, true,
 				      qproc->mpss_phys, qproc->mpss_size);
@@ -2198,6 +2211,44 @@ static const struct rproc_hexagon_res msm8996_mss = {
 	.version = MSS_MSM8996,
 };
 
+static const struct rproc_hexagon_res msm8953_mss = {
+	.hexagon_mba_image = "mba.mbn",
+	.proxy_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "pll",
+			.uA = 100000,
+		},
+		{}
+	},
+	.proxy_pd_names = (char*[]) {
+			"cx",
+			"mx",
+			NULL
+	},
+	.active_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "mss",
+			.uV = 1050000,
+			.uA = 100000,
+		},
+		{}
+	},
+	.proxy_clk_names = (char*[]){
+			"xo",
+			NULL
+	},
+	.active_clk_names = (char*[]){
+			"iface",
+			"bus",
+			"mem",
+			NULL
+	},
+	.need_mem_protection = false,
+	.has_alt_reset = false,
+	.has_spare_reg = false,
+	.version = MSS_MSM8953,
+};
+
 static const struct rproc_hexagon_res msm8916_mss = {
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_supply = (struct qcom_mss_reg_res[]) {
@@ -2301,6 +2352,7 @@ static const struct of_device_id q6v5_of_match[] = {
 	{ .compatible = "qcom,msm8916-mss-pil", .data = &msm8916_mss},
 	{ .compatible = "qcom,msm8974-mss-pil", .data = &msm8974_mss},
 	{ .compatible = "qcom,msm8996-mss-pil", .data = &msm8996_mss},
+	{ .compatible = "qcom,msm8953-mss-pil", .data = &msm8953_mss},
 	{ .compatible = "qcom,msm8998-mss-pil", .data = &msm8998_mss},
 	{ .compatible = "qcom,sc7180-mss-pil", .data = &sc7180_mss},
 	{ .compatible = "qcom,sc7280-mss-pil", .data = &sc7280_mss},
-- 
2.36.0

