Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DDA534E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbiEZLrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbiEZLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:45:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC2D4114
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:45:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h186so1138005pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TICE0sEo29HZevVnLs4kCPjhRnCI25SlD1yVTGEH4+k=;
        b=EaFzUtct3u72LMB2wcd38TcNEH3QSE41xyPZ8SYAwkvb4NBp/UO6oQ76kPQM5sVUqr
         OPGY1Ryvl4luE3l2Bx2HW/Ootx+8vyGDkFIR/P5fC5h0tB2U61+SQB2F3izRnOkuKxmK
         ma3VEKQpHfZ0ISiBK9IANhZcw80iIh9W79P/ihQEhd9u3qRvz2JCBvsNzV2VGpC21n50
         Gi9iFNN4zbPk8732A3C9ymTAyQIucBwc2onCa94c2WmfiiTJdsQOppp3T25qGSgdJYqA
         YrNT3jqzSSsJ4Fhb7zUOAE0QvGPkE/2oXTc9QaRFZbqmgce+v/ywTrXCuH5rMMDum2UF
         icHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TICE0sEo29HZevVnLs4kCPjhRnCI25SlD1yVTGEH4+k=;
        b=q/h4K7o3N3Vi51wdObO+3RF0t1p59fWCOS2OLAZhjN7MPD9pwyb1I1MMChESRk9413
         TeSGCNJ92L/0JIWRJ4n99gMdxcckQBt0rBc/35MGp3cTZE5XQgSLwH9Dccc+pBrJ6KYP
         V2gqKZC7O4rCVp4DtjRZeHa1mATop1gcUlyWdMxQ7X0S9lwep/EkPW7WCTmi+idXDD89
         D3Qym+zkJnjzQQLkMoCQHRjR5A3tgB/PpaeNcR5+ifbZTSES746TBakRriZb/Yupi6e1
         raxB7UWSDYnDremfQBDAk2YVJlvQ53C47D81HxI6/NLozmRIFYY4GOWLheEcUctxwQfm
         1PuQ==
X-Gm-Message-State: AOAM532/DuPrfvrVSw34vMOlCeIyejkT6rgPJHCuezBW8oQfCZ0vRv2U
        /EkJrTOhDrtUidn5y6n/Lf0EYA==
X-Google-Smtp-Source: ABdhPJyQKuH/h9iKeWw8+X8qYznTvkFUak07qMZ+pSwWpk+l4Rye1RtzCrJ0MjlevLV8snQkO9rsCA==
X-Received: by 2002:a63:6a87:0:b0:3f9:c829:796d with SMTP id f129-20020a636a87000000b003f9c829796dmr25675440pgc.232.1653565501748;
        Thu, 26 May 2022 04:45:01 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m5-20020a63f605000000b003faebbb772esm1354503pgh.25.2022.05.26.04.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:45:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/31] OPP: Remove dev_pm_opp_set_prop_name() and friends
Date:   Thu, 26 May 2022 17:12:29 +0530
Message-Id: <d255e60026e183b0331ddd1b4b69c90a22377bfc.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everyone has migrated to dev_pm_opp_set_config(), remove the
public interface for dev_pm_opp_set_prop_name() and friends.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 54 +++++++++++++++---------------------------
 include/linux/pm_opp.h |  9 -------
 2 files changed, 19 insertions(+), 44 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 69c6cf6a0bcc..e6c76b90dbf7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1993,7 +1993,7 @@ static void _opp_put_supported_hw(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_set_prop_name() - Set prop-extn name
+ * _opp_set_prop_name() - Set prop-extn name
  * @dev: Device for which the prop-name has to be set.
  * @name: name to postfix to properties.
  *
@@ -2002,50 +2002,33 @@ static void _opp_put_supported_hw(struct opp_table *opp_table)
  * which the extension will apply are opp-microvolt and opp-microamp. OPP core
  * should postfix the property name with -<name> while looking for them.
  */
-struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+static int _opp_set_prop_name(struct opp_table *opp_table, const char *name)
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
-	if (opp_table->prop_name)
-		return opp_table;
-
-	opp_table->prop_name = kstrdup(name, GFP_KERNEL);
 	if (!opp_table->prop_name) {
-		dev_pm_opp_put_opp_table(opp_table);
-		return ERR_PTR(-ENOMEM);
+		opp_table->prop_name = kstrdup(name, GFP_KERNEL);
+		if (!opp_table->prop_name)
+			return -ENOMEM;
 	}
 
-	return opp_table;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
 
 /**
- * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
- * @opp_table: OPP table returned by dev_pm_opp_set_prop_name().
+ * _opp_put_prop_name() - Releases resources blocked for prop-name
+ * @opp_table: OPP table returned by _opp_set_prop_name().
  *
  * This is required only for the V2 bindings, and is called for a matching
- * dev_pm_opp_set_prop_name(). Until this is called, the opp_table structure
+ * _opp_set_prop_name(). Until this is called, the opp_table structure
  * will not be freed.
  */
-void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
+static void _opp_put_prop_name(struct opp_table *opp_table)
 {
-	if (unlikely(!opp_table))
-		return;
-
-	kfree(opp_table->prop_name);
-	opp_table->prop_name = NULL;
-
-	dev_pm_opp_put_opp_table(opp_table);
+	if (opp_table->prop_name) {
+		kfree(opp_table->prop_name);
+		opp_table->prop_name = NULL;
+	}
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
 /**
  * _opp_set_regulators() - Set regulator names for the device
@@ -2411,9 +2394,11 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 
 	// Configure property names
 	if (config->prop_name) {
-		ret = dev_pm_opp_set_prop_name(dev, config->prop_name);
-		if (IS_ERR(ret))
+		err = _opp_set_prop_name(opp_table, config->prop_name);
+		if (err) {
+			ret = ERR_PTR(err);
 			goto err;
+		}
 	}
 
 	// Configure opp helper
@@ -2487,8 +2472,7 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table)
 
 	_opp_unregister_set_opp_helper(opp_table);
 
-	if (opp_table->prop_name)
-		dev_pm_opp_put_prop_name(opp_table);
+	_opp_put_prop_name(opp_table);
 
 	_opp_put_clkname(opp_table);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a310564ab698..6cf1bbc71ed2 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -184,8 +184,6 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_co
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(struct opp_table *opp_table);
 
-struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
-void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -357,13 +355,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
-
 static inline struct opp_table *dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.31.1.272.g89b43f80a514

