Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D605236CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbiEKPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiEKPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:12:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE260B83;
        Wed, 11 May 2022 08:12:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-ed9a75c453so3131409fac.11;
        Wed, 11 May 2022 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUCwHnpEBZWvV+TfQ2kOF7vKh2668nns0uSQ/D4T0+w=;
        b=mpa3J5Vld3Dm5QiFIItHCDwdXGMZiJsoXZHFl7q/67GbnFhsG0ZNau9F9hjZigDGyb
         RSqxs+ef/bQI9XSDbDlHlM63Ls97iugjJMcDjj/y9yTAbId2j9m7K7ios4hgxCyjCGGn
         4oqq2B+2CJ9dpKnOyPUW9k8saVXTy6k0RmShLZaMYHZqDh42na32W2H7rkGBK9lQX0UM
         rJ9cr5oPo6z3ILVQ0MQudj1VJnGaM4n6ZDYi56QA5K2pU00DdHE58ohOAkCRZKZRCp3B
         hG28i/Qmuejzx6fxa7sN4VCxp/R8a3joMPI9AWKgiSPyH33F8b+UrpSR97a9BIeGGMON
         uXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DUCwHnpEBZWvV+TfQ2kOF7vKh2668nns0uSQ/D4T0+w=;
        b=p724bCkneK6NHdoIcKbypF0rx/QO/d8fSAazjVoXF6p2hi0Bol0a5dd/ur1haFRt05
         X/GIG0+ZTXst0P6gVt2ABquzkee+B4/bRJFO3t3iOyTO3aaUlbSTLO19rX1T4EXMstBh
         lh7xsdaoV3sXiaoubRbiHcx6JuFMn9B6YpEKEIp7XK66OrTqlNXigGNneXeGWgh6qaYL
         //RDy5ub9bTlt9zogE8DGjlY6uSpMgBUmVcHL36u1oZthm4dBjU3AC+J6krYztSiREs+
         CKyEVcM3C0dOfF/3vZ63UMhK+OP4db57KNEIMl9c+y2MZJ99SE0ZfpLJ9zhbfEyY9Hjh
         9KWQ==
X-Gm-Message-State: AOAM532pHC8bb1pCnia/p2UfjRQGR6klg7UxXifJBQl42vjXMQbYFXki
        eWGuLMfyS421W5N50HButap3dtv1+Nc5Qg==
X-Google-Smtp-Source: ABdhPJxEpONNgy/avRlEVwlFZ58TZazzcu2tObteJMDTfsTabiZm83KhSInAsCeabhGAf0p5TpZ32g==
X-Received: by 2002:a05:6870:648d:b0:ec:b32d:3e1b with SMTP id cz13-20020a056870648d00b000ecb32d3e1bmr2954238oab.283.1652281956136;
        Wed, 11 May 2022 08:12:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a4a0306000000b0035eb4e5a6d0sm984750ooi.38.2022.05.11.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:12:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] hwmon: Introduce hwmon_device_register_for_thermal
Date:   Wed, 11 May 2022 08:12:28 -0700
Message-Id: <20220511151230.2983227-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511151230.2983227-1-linux@roeck-us.net>
References: <20220511151230.2983227-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal subsystem registers a hwmon driver without providing
chip or sysfs group information. This is for legacy reasons and
would be difficult to change. At the same time, we want to enforce
that chip information is provided when registering a hwmon device
using hwmon_device_register_with_info(). To enable this, introduce
a special API for use only by the thermal subsystem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c | 25 +++++++++++++++++++++++++
 include/linux/hwmon.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 5915ccfdb7d9..13053a4edc9e 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -916,6 +916,31 @@ hwmon_device_register_with_info(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
 
+/**
+ * hwmon_device_register_for_thermal - register hwmon device for thermal subsystem
+ * @dev: the parent device
+ * @name: hwmon name attribute
+ * @drvdata: driver data to attach to created device
+ *
+ * The use of this function is restricted. It is provided for legacy reasons
+ * and must only be called from the thermal subsystem.
+ *
+ * hwmon_device_unregister() must be called when the device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new device.
+ */
+struct device *
+hwmon_device_register_for_thermal(struct device *dev, const char *name,
+				  void *drvdata)
+{
+	if (!name || !dev)
+		return ERR_PTR(-EINVAL);
+
+	return __hwmon_device_register(dev, name, drvdata, NULL, NULL);
+}
+EXPORT_SYMBOL_NS_GPL(hwmon_device_register_for_thermal, HWMON_THERMAL);
+
 /**
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 4efaf06fd2b8..14325f93c6b2 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -450,6 +450,9 @@ hwmon_device_register_with_info(struct device *dev,
 				const struct hwmon_chip_info *info,
 				const struct attribute_group **extra_groups);
 struct device *
+hwmon_device_register_for_thermal(struct device *dev, const char *name,
+				  void *drvdata);
+struct device *
 devm_hwmon_device_register_with_info(struct device *dev,
 				const char *name, void *drvdata,
 				const struct hwmon_chip_info *info,
-- 
2.35.1

