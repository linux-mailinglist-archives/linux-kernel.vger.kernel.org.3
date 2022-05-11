Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7368B5236CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbiEKPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiEKPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:12:41 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC819D06D;
        Wed, 11 May 2022 08:12:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q8so3016109oif.13;
        Wed, 11 May 2022 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JX+KNvsq9d1yikcsx1hZpdGq5xppixGCVbpyE6im6I=;
        b=kCGrRCJGNI+WeRLn77rZwlRWumPJr2+bP75SMWO0fNDZL16qg349h5SG2al9dBdry4
         WRaLRx6hxSI0pWXjVJcCRMG6s2IEaRilbQN1UXR3ni0cCT3x7r+VMUMFyUVyupXcG7XM
         iKLUUZlmtLi0Fbn0Mr2IwCCFXhbDKLslZ/L7h78h2ybHEPp0ZHEK4Xc078GCRT40/Ktv
         p5eU3sIDwCSNB84IWL57LMwOSL9+FmVptp/YmRNNcrnqFQ9apiqCk1CmXxX/dcK65YiA
         z/tbjUHjz4CmTsLUjrk9N3K6IeAScYM6Kx6vfJuyvPKoV3prghhtfl+b+PQFNL417vkP
         h7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2JX+KNvsq9d1yikcsx1hZpdGq5xppixGCVbpyE6im6I=;
        b=NXx2NWtm8l34RE8+yy4jLZlcdUJKmEpbEZ0CqRep51ShZce+inxeKLCxDBpJFli4xE
         F09XYGaw9qWJ4/ZQjPm/+BGqTR0j30CWO22IZPPm83knp1K0qilLw4xIq6fNyOFW7weN
         ArWglLcQy2lw/8LEpVyJGFVIwpmGeKpzD6KCv4pdzzTzlE+D1UZA9khUPJ8gtRn/nZ/G
         E7Sh8G+Of2hzfWxH8rVFPedhFMZQJmxnboQMSyt+cz+Z3hh1aTjzP2N5udFbhEMeS8EE
         8rFS0Qj84v7A/+wJF6gR391Dv9DBQqa5Hq/AX8HbS8eYg+uaqC47JTaTyH6Lx/x5BHjA
         gmUA==
X-Gm-Message-State: AOAM531s1vxfODflYtP33h5cdIeCHSWg6yEELmqsXP7WBeF2gGQ7wZI5
        i3PERDE9IRVTFZUlyfn0zGk=
X-Google-Smtp-Source: ABdhPJz+eElEIyCPFZ77pMdbL315KuHzBSvEQ+BtjifhttYf8bNjDK2dbzTQRO81BzhIC6h3AfWGaA==
X-Received: by 2002:a05:6808:1250:b0:2da:39df:1f92 with SMTP id o16-20020a056808125000b002da39df1f92mr2728045oiv.27.1652281959974;
        Wed, 11 May 2022 08:12:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17-20020a056870e0d100b000e932746d33sm710336oab.28.2022.05.11.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:12:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] hwmon: Make chip parameter for with_info API mandatory
Date:   Wed, 11 May 2022 08:12:30 -0700
Message-Id: <20220511151230.2983227-4-linux@roeck-us.net>
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

Various attempts were made recently to "convert" the old
hwmon_device_register() API to devm_hwmon_device_register_with_info()
by just changing the function name without actually converting the
driver. Prevent this from happening by making the 'chip' parameter of
devm_hwmon_device_register_with_info() mandatory.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/hwmon-kernel-api.rst |  2 +-
 drivers/hwmon/hwmon.c                    | 16 +++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index e2975d5caf34..f3276b3a381a 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -76,7 +76,7 @@ hwmon_device_register_with_info is the most comprehensive and preferred means
 to register a hardware monitoring device. It creates the standard sysfs
 attributes in the hardware monitoring core, letting the driver focus on reading
 from and writing to the chip instead of having to bother with sysfs attributes.
-The parent device parameter cannot be NULL with non-NULL chip info. Its
+The parent device parameter as well as the chip parameter must not be NULL. Its
 parameters are described in more detail below.
 
 devm_hwmon_device_register_with_info is similar to
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 13053a4edc9e..22de7a9e7ba7 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -886,11 +886,12 @@ EXPORT_SYMBOL_GPL(hwmon_device_register_with_groups);
 
 /**
  * hwmon_device_register_with_info - register w/ hwmon
- * @dev: the parent device
- * @name: hwmon name attribute
- * @drvdata: driver data to attach to created device
- * @chip: pointer to hwmon chip information
+ * @dev: the parent device (mandatory)
+ * @name: hwmon name attribute (mandatory)
+ * @drvdata: driver data to attach to created device (optional)
+ * @chip: pointer to hwmon chip information (mandatory)
  * @extra_groups: pointer to list of additional non-standard attribute groups
+ *	(optional)
  *
  * hwmon_device_unregister() must be called when the device is no
  * longer needed.
@@ -903,13 +904,10 @@ hwmon_device_register_with_info(struct device *dev, const char *name,
 				const struct hwmon_chip_info *chip,
 				const struct attribute_group **extra_groups)
 {
-	if (!name)
-		return ERR_PTR(-EINVAL);
-
-	if (chip && (!chip->ops || !chip->ops->is_visible || !chip->info))
+	if (!dev || !name || !chip)
 		return ERR_PTR(-EINVAL);
 
-	if (chip && !dev)
+	if (!chip->ops || !chip->ops->is_visible || !chip->info)
 		return ERR_PTR(-EINVAL);
 
 	return __hwmon_device_register(dev, name, drvdata, chip, extra_groups);
-- 
2.35.1

