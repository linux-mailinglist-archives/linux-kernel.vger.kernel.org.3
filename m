Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96D569D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiGGIVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiGGIUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:20:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398A24F64E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:19:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so22141567edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xK6L9kQL/su+qUtSf+q4avn5i0/HUMQbVZpZK/zoTOQ=;
        b=TIQ4acE2XR+YDLnijnmuxoNvn/IXoCYF3tvh2p55MVItZZGqVDvlehlrnTjQdhPsL8
         GgtlVkEptPTHBmPpTYW1cZWmm8UhayN0dN7GGWfvE6j4WsOKyAn3Xfz0T6sLBq1Q2zRX
         d094EZrlUe7reGHGv4BME4f9WPDTQXvHzdBSdWI+6zbKBVhwRX4/dt5gNaFPMe+JUcBr
         06bqQarW2uI6Pn/kUqu1efXSUAtnjialv2TOyS3MGufB3gtZ+gPxAz6ipR7U8seOEgB1
         y6KpVCN1BcwGbzkuJcoxbJ0XJ51m/GTw3tIepBftzSbv+jIy4ia/Ix2kkNgF/cf3fXYl
         Z2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xK6L9kQL/su+qUtSf+q4avn5i0/HUMQbVZpZK/zoTOQ=;
        b=DkrKQtM8Lz8JhqxrIiiJv0jBV82oeYFrszov46Sz/R5ER3tBk5mdz165Igd5Qrjbkn
         aOS58pHwhTgYgyZ9N8/vUlyLEOx3CvEVs6mVGY36Mt0byBlO/bYY390Dmlv4ZAlG+6k0
         Jh8/AeV6vTt9ViLZvq+4+cGtEdJRSJx6aARWi3l6qiJZrj2OSmGtbV4l9O71REIfT383
         kCS5Ge8Vmp/5onCACZRpRsa3lHTGMMqbkRJtwUcl3texWAdQG9bhkOy6SfyaBMYbwfjj
         r4b7W35d9K4B2XKBvRVOaIjOJLxpu3m8922VkRXUXV5v8NsHO/YmuqlAtJmdtH+az6GI
         Ygfw==
X-Gm-Message-State: AJIora9JgrEBU3E+26Rhx3cOmg3Yfzdhu6mLEt83wKM7O7fAsUZleuJM
        LFR5rT/d6GH8O/URsjTjCCkVaRfhU7B0qto3
X-Google-Smtp-Source: AGRyM1tIDL7TShlQb5VPGfvVkaMpDi6zcLKk1STvcR0DpWXiacRbz0pBhiu6c4MxsSOtUSMP7bXTOg==
X-Received: by 2002:aa7:dcd5:0:b0:43a:70f7:8e4d with SMTP id w21-20020aa7dcd5000000b0043a70f78e4dmr21884954edu.85.1657181953398;
        Thu, 07 Jul 2022 01:19:13 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm12871779ejx.173.2022.07.07.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:19:13 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 4/4] regulator: output-supply: Add Notification support
Date:   Thu,  7 Jul 2022 10:18:26 +0200
Message-Id: <20220707081826.953449-5-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add notification support to output-supply driver to receive regulator
events.

During runtime, regulator may encounter events like over/under voltage,
over current etc. & its useful to report to userspace to take necessary
corrective action.

If sysfs notification is desired then that can be enabled using
regulator-notify-enable property.
This is very useful in situation wherein immediate responsive action
needs to be taken upon receiving events & delayed response is not
acceptable depending on criticality of the received event.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 50 ++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index b424a0ddf582..0cf2724b5c37 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -22,14 +22,33 @@
 
 struct userspace_consumer_data {
 	const char *name;
-
+	bool notify_enable;
+	struct notifier_block nb;
 	struct mutex lock;
 	bool enabled;
+	unsigned long events;
+	struct kobject *kobj;
 
 	int num_supplies;
 	struct regulator_bulk_data *supplies;
 };
 
+static DEFINE_MUTEX(events_lock);
+
+static ssize_t events_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct userspace_consumer_data *data = dev_get_drvdata(dev);
+	unsigned long e;
+
+	mutex_lock(&events_lock);
+	e = data->events;
+	data->events = 0;
+	mutex_unlock(&events_lock);
+
+	return sprintf(buf, "0x%lx\n", e);
+}
+
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -88,12 +107,14 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static DEVICE_ATTR_RO(events);
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RW(state);
 
 static struct attribute *attributes[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
+	&dev_attr_events.attr,
 	NULL,
 };
 
@@ -101,6 +122,22 @@ static const struct attribute_group attr_group = {
 	.attrs	= attributes,
 };
 
+static int regulator_userspace_notify(struct notifier_block *nb,
+				      unsigned long event,
+				      void *ignored)
+{
+	struct userspace_consumer_data *data =
+		container_of(nb, struct userspace_consumer_data, nb);
+
+	mutex_lock(&events_lock);
+	data->events |= event;
+	mutex_unlock(&events_lock);
+
+	sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
+
+	return NOTIFY_OK;
+}
+
 static struct regulator_userspace_consumer_data *get_pdata_from_dt_node(
 		struct platform_device *pdev)
 {
@@ -139,7 +176,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
-	int ret;
+	int ret, i;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata && pdev->dev.of_node) {
@@ -159,6 +196,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	drvdata->name = pdata->name;
 	drvdata->num_supplies = pdata->num_supplies;
 	drvdata->supplies = pdata->supplies;
+	drvdata->kobj = &pdev->dev.kobj;
 
 	mutex_init(&drvdata->lock);
 
@@ -183,7 +221,15 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		}
 	}
 
+	drvdata->nb.notifier_call = regulator_userspace_notify;
+	for (i = 0; i < drvdata->num_supplies; i++) {
+		ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
+		if (ret)
+			goto err_enable;
+	}
+
 	drvdata->enabled = pdata->init_on;
+
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
-- 
2.35.3

