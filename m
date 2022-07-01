Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80187562E02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiGAIYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiGAIXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:23:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F3B7125B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:21:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h15-20020a17090a648f00b001ef3c529d77so4477145pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99kWlkiHu2hHhG+VivUNv2hFuFfBll5HWzikFasPu24=;
        b=DMaYsD3mTetExcF9rZkyMXNTFgskw2W7VSCO8XpnMcV+BdXpzuSIQjoYmJQcMb+Fgb
         /u+ShdYfU/zOZnM8Hd0M0regAz38Pp+lLJBG/LJzISbR4/GQZ9hzgshm5Nub24UvbQUv
         85yy1hpSkgH/FDzQntvMivKB5pSIzJ26BWPuPSOlPdhRAnSlAIltLBhvhoyPD4TznYVk
         ogwISgBoDoHTWHazKomPCKky6bffH2CaFP2WtfImiQJ0Q8P1oscuQ2EzpEoP8ZDe/SMA
         7vj35XhP0RmmvzpP/QWJGCINfCca7g+ZjypphBPBxPvo8EORDoNgUNnVHOSKPGy0QRa0
         N/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99kWlkiHu2hHhG+VivUNv2hFuFfBll5HWzikFasPu24=;
        b=kTh1OjdhVjRi6Phbk4N0LP6jGeZfq2lTixf2Z0ojS1Pl271Clx6ezW81VMbIRFjmDd
         HwgcMjqcsNdeUxG+zJ1/ZVX/XU/ZgdcuIbVbgFaA0Wx8uI39+HVoxPuovrbFF7fiXA26
         kl5MkTeiUZadoVqNdxVe40Lt1aVIeSRX4Jb3dkDkx08ZuUjnxgJ1zAphz6gM1zcqgvGZ
         TnR9N2m/ae9bp65nAp9ef5xxLgFDQWXtkFtUMWp7pNHa3j18n6Z+JmrIqJpAMKKdcrhf
         Z1N6FwXqdl2AqgITAaqmjLfJCfM7jZkwnTZIvT/AaX9oTg1K92jF7cIpksFz+NP3Mfut
         /1oA==
X-Gm-Message-State: AJIora+8wxwtEpnDR04dHtBHL74+vhNW+DcNU4Cae5CMN2I/+9Hh+ovi
        UCn5JmLLnfKOZpZejvjF0PPm3A==
X-Google-Smtp-Source: AGRyM1sh7RUfMx1CByYxFCx6CKvOSwM+Hwx5URm4/ODCBI+SqFSCoFTooP0GZDqY/CpgUpBkjBL/sw==
X-Received: by 2002:a17:902:8309:b0:167:9a4c:cd58 with SMTP id bd9-20020a170902830900b001679a4ccd58mr19716789plb.166.1656663717968;
        Fri, 01 Jul 2022 01:21:57 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b0015e8d4eb2ddsm9372325pln.295.2022.07.01.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 26/30] OPP: Remove dev_pm_opp_set_supported_hw() and friends
Date:   Fri,  1 Jul 2022 13:50:21 +0530
Message-Id: <a653b598ad68f40499750f2d86b266eeac27bd4a.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

Now that everyone has migrated to dev_pm_opp_set_config(), remove the
public interface for dev_pm_opp_set_supported_hw() and friends.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 87 ++++++++++--------------------------------
 include/linux/pm_opp.h | 19 ---------
 2 files changed, 20 insertions(+), 86 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fc3cd87ee7df..66ffe501a7c8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1952,7 +1952,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 }
 
 /**
- * dev_pm_opp_set_supported_hw() - Set supported platforms
+ * _opp_set_supported_hw() - Set supported platforms
  * @dev: Device for which supported-hw has to be set.
  * @versions: Array of hierarchy of versions to match.
  * @count: Number of elements in the array.
@@ -1962,84 +1962,39 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
  * OPPs, which are available for those versions, based on its 'opp-supported-hw'
  * property.
  */
-struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
-			const u32 *versions, unsigned int count)
+static int _opp_set_supported_hw(struct opp_table *opp_table,
+				 const u32 *versions, unsigned int count)
 {
-	struct opp_table *opp_table;
-
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	/* Another CPU that shares the OPP table has set the property ? */
 	if (opp_table->supported_hw)
-		return opp_table;
+		return 0;
 
 	opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
 					GFP_KERNEL);
-	if (!opp_table->supported_hw) {
-		dev_pm_opp_put_opp_table(opp_table);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!opp_table->supported_hw)
+		return -ENOMEM;
 
 	opp_table->supported_hw_count = count;
 
-	return opp_table;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
 
 /**
- * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
- * @opp_table: OPP table returned by dev_pm_opp_set_supported_hw().
+ * _opp_put_supported_hw() - Releases resources blocked for supported hw
+ * @opp_table: OPP table returned by _opp_set_supported_hw().
  *
  * This is required only for the V2 bindings, and is called for a matching
- * dev_pm_opp_set_supported_hw(). Until this is called, the opp_table structure
+ * _opp_set_supported_hw(). Until this is called, the opp_table structure
  * will not be freed.
  */
-void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
+static void _opp_put_supported_hw(struct opp_table *opp_table)
 {
-	if (unlikely(!opp_table))
-		return;
-
-	kfree(opp_table->supported_hw);
-	opp_table->supported_hw = NULL;
-	opp_table->supported_hw_count = 0;
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
-
-static void devm_pm_opp_supported_hw_release(void *data)
-{
-	dev_pm_opp_put_supported_hw(data);
-}
-
-/**
- * devm_pm_opp_set_supported_hw() - Set supported platforms
- * @dev: Device for which supported-hw has to be set.
- * @versions: Array of hierarchy of versions to match.
- * @count: Number of elements in the array.
- *
- * This is a resource-managed variant of dev_pm_opp_set_supported_hw().
- *
- * Return: 0 on success and errorno otherwise.
- */
-int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
-				 unsigned int count)
-{
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_set_supported_hw(dev, versions, count);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_supported_hw_release,
-					opp_table);
+	if (opp_table->supported_hw) {
+		kfree(opp_table->supported_hw);
+		opp_table->supported_hw = NULL;
+		opp_table->supported_hw_count = 0;
+	}
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_supported_hw);
 
 /**
  * dev_pm_opp_set_prop_name() - Set prop-extn name
@@ -2575,7 +2530,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_REGULATOR)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
-		dev_pm_opp_put_supported_hw(data->opp_table);
+		_opp_put_supported_hw(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
 		dev_pm_opp_unregister_set_opp_helper(data->opp_table);
 	if (data->flags & OPP_CONFIG_PROP_NAME)
@@ -2671,12 +2626,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure supported hardware */
 	if (config->supported_hw) {
-		err = dev_pm_opp_set_supported_hw(dev, config->supported_hw,
-						  config->supported_hw_count);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_supported_hw(opp_table, config->supported_hw,
+					    config->supported_hw_count);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_SUPPORTED_HW;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0dc45d4403ce..dfbb07b871a8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -187,9 +187,6 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(int token);
 
-struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
-void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
-int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -372,22 +369,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
-							    const u32 *versions,
-							    unsigned int count)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_supported_hw(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_set_supported_hw(struct device *dev,
-					       const u32 *versions,
-					       unsigned int count)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
-- 
2.31.1.272.g89b43f80a514

