Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4115985A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbiHROWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiHROW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:22:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C1B07E5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:22:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i129-20020a1c3b87000000b003a62f19b453so123674wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=aIyech5h/+UXGvGLsMrbDOfgSWvv8J2d6bGJqyRKLIs=;
        b=O9v21FbbSfqHPvVquF/flI5r+QPmlmjFivxMpnAQKTKf/tlVK4A8HkVHCo76oD0Du6
         +nzZhpGwvPhccFE1y3N4NVu0heVFDjMRNWA/H03f+zJtu8Wd4b2DI9D1Jbeuwgs+6Akh
         1Cvva9kQlwjAgQFTyk74mpaddNLHNbSUnFQ4z/xfgRr+uP7iXZy5EckH7p2W6Rw2JGjL
         uaAsUDDxsA0tloBc+Cip81Yl4qczuIQgXrh5V/E5wRyHuhKtKhLRts4kO8SbjFaFVJUt
         Q6gEP6FXEvIH0VUwv72sHRzK5JDpiQa4c9hZwSNjIj3vAYZZvnBgkbIMeZat59kfNdIV
         DDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=aIyech5h/+UXGvGLsMrbDOfgSWvv8J2d6bGJqyRKLIs=;
        b=IdAFfvLEj8KyrsKUzPIDnD2sl1c4unqX5uARgVIkoiRy+yRYKsOOTOfanlCvp0AWbX
         D8gmlqq6m8CJHhqKYdhqu6IiYlJOgvqon7kz2e/o7/EBiaRhjKa07iZ8rRFWNPe60yKo
         nPqw51g23oWIOsf7AvV6SBwyLrVrm6UitMdLVt+sQ3CSiD+bKMyr7TOfNwL2HMZd+k2/
         TAAVLUUdF8pgcdjc4AfUWFj/XTVqbP8jo4ouB9JH1ZlAKS1pgySENo4QMhPZ+BeHg4RM
         7NbT1moNVJgUBTHT/aeL0aSOv+MrLdhgOZqyjv7VyhejK1dOi0AEVEJla0CU4fjY20q4
         /0gA==
X-Gm-Message-State: ACgBeo3FjGqvZyzgTlWyv6km+Mm37Skjfz0b6vYOOv0LsCc3Bcqv/Dyv
        Ply22V/MZKRfmonKJ1a/8WSDVQ==
X-Google-Smtp-Source: AA6agR67lNyCP6PU22sf32+TiEHnPS75sfs2dClSXmIvi0DyXi1vN8TTIy5FUefyOu3N8LHeF1OOnw==
X-Received: by 2002:a05:600c:4d15:b0:3a5:b3fe:75dd with SMTP id u21-20020a05600c4d1500b003a5b3fe75ddmr5384209wmp.116.1660832546392;
        Thu, 18 Aug 2022 07:22:26 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003a61306d79dsm2767184wms.41.2022.08.18.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:22:25 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC 1/2] soc: qcom_stats: Add state container
Date:   Thu, 18 Aug 2022 17:22:14 +0300
Message-Id: <20220818142215.2282365-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow the dynamic creation of debugfs subsystem entries,
the notifier and the notifier_block need to be stored in a per-subsystem
fashion. For that we need some kind of state container, so add it and group
everything related to the probing device into it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/qcom_stats.c | 39 +++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index d6bfd1bbdc2a..fa30540b6583 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -68,6 +68,13 @@ struct appended_stats {
 	u32 reserved[3];
 };
 
+struct qcom_stats_priv {
+	struct device dev;
+	struct stats_data *data;
+	struct dentry *root;
+	const struct stats_config *config;
+};
+
 static void qcom_print_stats(struct seq_file *s, const struct sleep_stats *stat)
 {
 	u64 accumulated = stat->accumulated;
@@ -121,10 +128,13 @@ static int qcom_soc_sleep_stats_show(struct seq_file *s, void *unused)
 DEFINE_SHOW_ATTRIBUTE(qcom_soc_sleep_stats);
 DEFINE_SHOW_ATTRIBUTE(qcom_subsystem_sleep_stats);
 
-static void qcom_create_soc_sleep_stat_files(struct dentry *root, void __iomem *reg,
-					     struct stats_data *d,
-					     const struct stats_config *config)
+static void qcom_create_soc_sleep_stat_files(struct qcom_stats_priv *stats,
+						void __iomem *reg)
 {
+	struct dentry *root = stats->root;
+	struct stats_data *d = stats->data;
+	const struct stats_config *config = stats->config;
+
 	char stat_type[sizeof(u32) + 1] = {0};
 	size_t stats_offset = config->stats_offset;
 	u32 offset = 0, type;
@@ -167,10 +177,11 @@ static void qcom_create_soc_sleep_stat_files(struct dentry *root, void __iomem *
 	}
 }
 
-static void qcom_create_subsystem_stat_files(struct dentry *root,
-					     const struct stats_config *config)
+static void qcom_create_subsystem_stat_files(struct qcom_stats_priv *stats)
 {
 	const struct sleep_stats *stat;
+	const struct stats_config *config = stats->config;
+	struct dentry *root = stats->root;
 	int i;
 
 	if (!config->subsystem_stats_in_smem)
@@ -188,12 +199,17 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,
 
 static int qcom_stats_probe(struct platform_device *pdev)
 {
+	struct qcom_stats_priv *stats = NULL;
 	void __iomem *reg;
 	struct dentry *root;
 	const struct stats_config *config;
 	struct stats_data *d;
 	int i;
 
+	stats = devm_kzalloc(&pdev->dev, sizeof(*stats), GFP_KERNEL);
+	if (!stats)
+		return -ENOMEM;
+
 	config = device_get_match_data(&pdev->dev);
 	if (!config)
 		return -ENODEV;
@@ -212,17 +228,22 @@ static int qcom_stats_probe(struct platform_device *pdev)
 
 	root = debugfs_create_dir("qcom_stats", NULL);
 
-	qcom_create_subsystem_stat_files(root, config);
-	qcom_create_soc_sleep_stat_files(root, reg, d, config);
+	stats->config = config;
+	stats->data = d;
+	stats->root = root;
+
+	qcom_create_subsystem_stat_files(stats);
+	qcom_create_soc_sleep_stat_files(stats, reg);
 
-	platform_set_drvdata(pdev, root);
+	platform_set_drvdata(pdev, stats);
 
 	return 0;
 }
 
 static int qcom_stats_remove(struct platform_device *pdev)
 {
-	struct dentry *root = platform_get_drvdata(pdev);
+	struct qcom_stats_priv *stats = platform_get_drvdata(pdev);
+	struct dentry *root = stats->root;
 
 	debugfs_remove_recursive(root);
 
-- 
2.34.1

