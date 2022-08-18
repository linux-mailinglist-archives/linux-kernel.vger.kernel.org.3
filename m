Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3EC5985A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiHROWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245552AbiHROWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:22:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F8B0888
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:22:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2669159wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0C4aHcXgWxy6PpVtW7d+ycoPUGyQqm944VNk/U4/NEU=;
        b=PsXnrzMhLsWDUil+KFa5V4r3P1L/3E4kZ0cSF50jUartlrp/clGytZsubYHebiRMe1
         91d4VpZ5GJpPHS+QJPjgNfHXpDtBKEvp7q7/+EdVGK8blNPjCaX1MI8rBokTQn/kfc0i
         /wGf6lIYlaev2k+xgLi8m7pt5pRz60fstTfUIvZ6Q32mQnVzMJDf6KoM28BTgUMrkL6w
         R8IDTMA48lnVrtppWC7EcoJyiRw/kHK4bFJ7ttng9Zi0rcnsi3/djv3n6nC4WPC+aVWw
         G/Uxz+YsncMQsaXUsCvouJnw7UX8lbfV5G8nG1armO5wlo+t/JJMdeYKjey4ySk/WXnn
         kcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0C4aHcXgWxy6PpVtW7d+ycoPUGyQqm944VNk/U4/NEU=;
        b=UcsuOJOi8SGybAjUKWkbnMLfi+FmfHqrJcaXsdwIGknrrnMWyP44987hkyYyuFQ6zz
         ys2tSbmUh1osoBJI2oq+bi5KyjY/DC0hk8hPbH7/+G2UsKbnpNJvSdcJ07oG678peQBC
         z4ZDSEoqHM3lg0Kc41psepswfcYFR2r8SBQGZNGhyHc8EfxlXmN9DUD3kmgNLPP/Uku0
         Wsy2HfQYNYkPGh5Y3GAh5pm2cYp6nTfWwGoI7URvP1s9ZO9g7iudI4CFBDU1exAP7bIz
         Z+RFg/GrfJ4xiIfRJ0DFbSviBRu/i9X8TVNBnv8o7D3ywRVExGl2xxElJUCaiB3J3L+j
         8JqQ==
X-Gm-Message-State: ACgBeo3BRl7JMgCUEGlTHjCT3l0bkXYL2i4TKo+jj8LomrsZ1KG9EyjH
        oBqT0Om1rDpw41HM1dqQDVa7Xw==
X-Google-Smtp-Source: AA6agR44P7ilTfUquQEX1o5MpBOZ1OuPn3FU8J3+aJ/By+VOYXtcqgjwm8k+Jy6ZDhRPTwoDaZvPEg==
X-Received: by 2002:a7b:cb55:0:b0:3a5:41a:829c with SMTP id v21-20020a7bcb55000000b003a5041a829cmr5362465wmj.153.1660832547859;
        Thu, 18 Aug 2022 07:22:27 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003a61306d79dsm2767184wms.41.2022.08.18.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:22:27 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC 2/2] soc: qcom_stats: Add dynamic debugfs entries for subsystems
Date:   Thu, 18 Aug 2022 17:22:15 +0300
Message-Id: <20220818142215.2282365-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220818142215.2282365-1-abel.vesa@linaro.org>
References: <20220818142215.2282365-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register per-subsystem notifier using qcom_register_ssr_notifier().
This will allow the order of between the remoteprocs actually starting and
qcom_stats driver probing to become more relaxed.

When the notifier callback gets called, depending on whether the remoteproc is
starting up or shutting down, either create or remove the related debugfs
entry. Also, in order to make sure we're not missing an already started
remoteproc, after the notifier has been set up, we go though the subsystems
list and try to create the entry for it, as it was doing before, but this time
we store the dentry to use it later on for removal, if necessary.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/qcom_stats.c | 77 ++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index fa30540b6583..baaa820c9a77 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -7,8 +7,10 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/remoteproc/qcom_rproc.h>
 #include <linux/seq_file.h>
 
 #include <linux/soc/qcom/smem.h>
@@ -68,11 +70,20 @@ struct appended_stats {
 	u32 reserved[3];
 };
 
+struct subsystem_priv {
+	const struct subsystem_data *subsystem;
+	struct dentry *root;
+	struct dentry *dentry;
+	struct notifier_block nb;
+	void *notifier;
+};
+
 struct qcom_stats_priv {
 	struct device dev;
 	struct stats_data *data;
 	struct dentry *root;
 	const struct stats_config *config;
+	struct subsystem_priv ss_priv[ARRAY_SIZE(subsystems)];
 };
 
 static void qcom_print_stats(struct seq_file *s, const struct sleep_stats *stat)
@@ -177,6 +188,57 @@ static void qcom_create_soc_sleep_stat_files(struct qcom_stats_priv *stats,
 	}
 }
 
+static int qcom_stats_subsys_ssr_notify(struct notifier_block *nb,
+				    unsigned long action,
+				    void *data)
+{
+	struct subsystem_priv *ss_priv = container_of(nb, struct subsystem_priv, nb);
+
+	switch (action) {
+	case QCOM_SSR_AFTER_POWERUP:
+		ss_priv->dentry = debugfs_create_file(ss_priv->subsystem->name, 0400, ss_priv->root,
+							(void *)ss_priv->subsystem,
+							&qcom_subsystem_sleep_stats_fops);
+		break;
+	case QCOM_SSR_BEFORE_SHUTDOWN:
+		debugfs_remove(ss_priv->dentry);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static void qcom_register_subsystem_notifiers(struct qcom_stats_priv *stats)
+{
+	struct device *dev = &stats->dev;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
+		const struct subsystem_data *subsystem = &subsystems[i];
+		struct subsystem_priv *ss_priv = &stats->ss_priv[i];
+
+		ss_priv->subsystem = subsystem;
+		ss_priv->root = stats->root;
+		ss_priv->nb.notifier_call = qcom_stats_subsys_ssr_notify;
+		ss_priv->notifier = qcom_register_ssr_notifier(subsystem->name, &ss_priv->nb);
+		if (IS_ERR(ss_priv->notifier))
+			dev_err(dev, "failed to register ssr notifier for %s (%ld)",
+				subsystem->name, PTR_ERR(ss_priv->notifier));
+	}
+}
+
+static void qcom_unregister_subsystem_notifiers(struct qcom_stats_priv *stats)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(subsystems); i++)
+		if (stats->ss_priv[i].notifier)
+			qcom_unregister_ssr_notifier(stats->ss_priv[i].notifier,
+							&stats->ss_priv[i].nb);
+}
+
 static void qcom_create_subsystem_stat_files(struct qcom_stats_priv *stats)
 {
 	const struct sleep_stats *stat;
@@ -188,12 +250,20 @@ static void qcom_create_subsystem_stat_files(struct qcom_stats_priv *stats)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
+		struct subsystem_priv *ss_priv = &stats->ss_priv[i];
+
 		stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
 		if (IS_ERR(stat))
 			continue;
 
-		debugfs_create_file(subsystems[i].name, 0400, root, (void *)&subsystems[i],
-				    &qcom_subsystem_sleep_stats_fops);
+		/*
+		 * At this point some subsystems have already started
+		 * and so we already missed the startup notification,
+		 * so let's create the entry post-startup.
+		 */
+		ss_priv->dentry = debugfs_create_file(&subsystems[i]->name, 0400, root,
+							(void *)&subsystems[i],
+							&qcom_subsystem_sleep_stats_fops);
 	}
 }
 
@@ -232,6 +302,7 @@ static int qcom_stats_probe(struct platform_device *pdev)
 	stats->data = d;
 	stats->root = root;
 
+	qcom_register_subsystem_notifiers(stats);
 	qcom_create_subsystem_stat_files(stats);
 	qcom_create_soc_sleep_stat_files(stats, reg);
 
@@ -245,6 +316,8 @@ static int qcom_stats_remove(struct platform_device *pdev)
 	struct qcom_stats_priv *stats = platform_get_drvdata(pdev);
 	struct dentry *root = stats->root;
 
+	qcom_unregister_subsystem_notifiers(stats);
+
 	debugfs_remove_recursive(root);
 
 	return 0;
-- 
2.34.1

