Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C55883CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiHBVuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiHBVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:50:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6DD62DD
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:50:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d16so6552776pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hb89G9krB6RKM/pZci++W1IGnnGTFxYNnFvZ3OknFGs=;
        b=k3Teggg8APeevPHASdBY5f2itpnShq02Mcu65hszc5EF41S5RxU0QA17I03FH++ZC0
         ZVzSGXFobmTSYpYudykju17v7k5Dq16V7a7k83w2wQ5oULJ5ulf9O65WpsZhXI4KKgHT
         9prRIi8oFh0LOOznCs8ZrVp44q4xWegLpjLIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hb89G9krB6RKM/pZci++W1IGnnGTFxYNnFvZ3OknFGs=;
        b=bm4k37F7O7hSCI2KcExIYuGWKFRIBiIf4P3uH37dkjyd+QBglPeE2ix4gXyZkpEFxw
         MIblQgIk9s05YOXJMxt+91pT/11QxpKG92DKb5DTnZLx8JB06aMmbs87TKij7v9niICE
         mD+Yrul5PxDVgMjoNboEY7euGJ70fUw00oTVxpZLoO+twhhBdndIZz+GH7yaZcxjjigs
         1eu4AaNYTFxUqA7yYPV3eMi0NqMEDQ4TnKmYdzUwPuJPDBFAov5Eui/KSyb7vWoMW/R6
         VqFWzjCl9LFLG9AU/6wLkPHoCzcZPSSMWHnt3VVjuaOp6OM2OFgWK8rovRBL4sGHRWiY
         YQSg==
X-Gm-Message-State: ACgBeo3ivxqrR5AuI/0MzZ75NJ99DQWVPj8PSMzjyTntErvRBne7isA8
        k3GMGyu1NuFDnPX1/ovscdNJ/Q==
X-Google-Smtp-Source: AA6agR7xtjqmZwo1XewbkN9y3rqgaqhkChFH1KXDhxYO+a3agQiGv9Sf2bftbRpMuWB8yVpO8ykD6Q==
X-Received: by 2002:a17:90b:2241:b0:1f5:2c5e:1080 with SMTP id hk1-20020a17090b224100b001f52c5e1080mr1560747pjb.85.1659477016773;
        Tue, 02 Aug 2022 14:50:16 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a25-20020a634d19000000b00419b66846fcsm9458089pgb.91.2022.08.02.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:50:16 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's sysfs node
Date:   Wed,  3 Aug 2022 07:50:07 +1000
Message-Id: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows userspace to check if Clock Scaling and Write Booster are
supported.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

Changes in v6:
* Add comment to clarify meaning of the "capbilities" sysfs group.

Changes in v5:
* Correct wording for clock scaling.
* Correct wording for the commit message.

Changes in v4:
* Dropped crypto node per Eric Biggers mentioning it can be queried from
  disk's queue node

Changes in v3:
* Expose each capability individually.
* Update documentation to represent new scheme.

Changes in v2:
* Add documentation entry for the new sysfs node.

 Documentation/ABI/testing/sysfs-driver-ufs | 26 +++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 37 ++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 6b248abb1bd71..1750a9b84ce0f 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1591,6 +1591,32 @@ Description:	This entry shows the status of HPB.
 
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/clock_scaling
+What:		/sys/bus/platform/devices/*.ufs/capabilities/clock_scaling
+Date:		July 2022
+Contact:	Daniil Lunev <dlunev@chromium.org>
+Description:	Indicates status of clock scaling.
+
+		== ============================
+		0  Clock scaling is not supported.
+		1  Clock scaling is supported.
+		== ============================
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/write_booster
+What:		/sys/bus/platform/devices/*.ufs/capabilities/write_booster
+Date:		July 2022
+Contact:	Daniil Lunev <dlunev@chromium.org>
+Description:	Indicates status of Write Booster.
+
+		== ============================
+		0  Write Booster can not be enabled.
+		1  Write Booster can be enabled.
+		== ============================
+
+		The file is read only.
+
 What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/activation_thld
 Date:		February 2021
 Contact:	Avri Altman <avri.altman@wdc.com>
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d5570..4149cdf19de92 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -279,6 +279,42 @@ static const struct attribute_group ufs_sysfs_default_group = {
 	.attrs = ufs_sysfs_ufshcd_attrs,
 };
 
+static ssize_t clock_scaling_show(struct device *dev, struct device_attribute *attr,
+				  char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ufshcd_is_clkscaling_supported(hba));
+}
+
+static ssize_t write_booster_show(struct device *dev, struct device_attribute *attr,
+				  char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ufshcd_is_wb_allowed(hba));
+}
+
+static DEVICE_ATTR_RO(clock_scaling);
+static DEVICE_ATTR_RO(write_booster);
+
+/*
+ * The "capabilities" sysfs group represents the effective capabilities of the
+ * host-device pair, i.e. the capabilities which are enabled in the driver for
+ * the specific host controller, supported by the host controller and are
+ * supported and/or have compatible configuration on the device side.
+ */
+static struct attribute *ufs_sysfs_capabilities_attrs[] = {
+	&dev_attr_clock_scaling.attr,
+	&dev_attr_write_booster.attr,
+	NULL
+};
+
+static const struct attribute_group ufs_sysfs_capabilities_group = {
+	.name = "capabilities",
+	.attrs = ufs_sysfs_capabilities_attrs,
+};
+
 static ssize_t monitor_enable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -1134,6 +1170,7 @@ static const struct attribute_group ufs_sysfs_attributes_group = {
 
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
+	&ufs_sysfs_capabilities_group,
 	&ufs_sysfs_monitor_group,
 	&ufs_sysfs_device_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
-- 
2.31.0

