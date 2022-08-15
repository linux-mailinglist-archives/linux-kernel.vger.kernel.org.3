Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76449592720
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiHOAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHOAsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:48:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC163DA
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:48:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p125so5530351pfp.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=wWwFnOcKNFFMa2I1f4N8kIQ8xtUH0qGmMJMSeLkGgUM=;
        b=cnsvXZscMaGqqVzF6w1PgtzM7sxlYmPPO3j9kGlc8ZXTE2IFn2eOC6wD3VAoVD9TT9
         59/vQySf7Y+OVSRyZKkC2ygpm052htPhd3WkJfrXLhOMKyQli9Nqb5Ggeo520kQOfvwS
         a3XuDvYYcEDbYGm4d3KOWUiKffx/cYnCCpygI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=wWwFnOcKNFFMa2I1f4N8kIQ8xtUH0qGmMJMSeLkGgUM=;
        b=cuFzb7UM5C08/+xgEJilv4wTfEw4RBlgR/x4bg6DlejdMTm7O6j5DJY+TpIx1Gu7eW
         hefotzGuxCi2X6wRkojuyzkBPDOd7qjlAeicja4MHPMzD26UTg178k3NzOEjQuKHuZ8g
         EnUdAA/IrTZt1usBRs02cz/wmxmiZwtbYES9MNDwqp0HlcWkISsgm3UdTgsExoi3SPP3
         Vp6kcj+FHt7J+HQAzlIBeBNy46ZvkK4PsFMXRzK1p6zqReUWt6zHxWNt3WoItUc6QrBL
         oG8GlDCt+SepH3UbDnFVBK5E7qJ/ZZJulaxqP+NUe+o0kZsqjFbWyVktlt7kfprpV2DV
         fJkQ==
X-Gm-Message-State: ACgBeo0OlH3enj43WbKurXzk2ObvxWnkSNv6O9Jjpry2gBUqClQNCqw8
        APde0LqlifnZDRaqfb4GBLFBAw==
X-Google-Smtp-Source: AA6agR4aD0qJ8x85FdyFAvxRUXukVhHntihHkCxj9f7loaP4b/KZC0smqwYjpLfjFAVNOfmK1vowoQ==
X-Received: by 2002:a63:135b:0:b0:41e:928:832c with SMTP id 27-20020a63135b000000b0041e0928832cmr11526135pgt.178.1660524494049;
        Sun, 14 Aug 2022 17:48:14 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902d2d000b001618b70dcc9sm5940776plc.101.2022.08.14.17.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 17:48:13 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v7] ufs: core: print UFSHCD capabilities in controller's sysfs node
Date:   Mon, 15 Aug 2022 10:48:03 +1000
Message-Id: <20220815104739.v7.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows userspace to check if Clock Scaling and Write Booster are
supported.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

Changes in v7:
* Move the comment to the documnetation
* Update the month on the documentation

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

 Documentation/ABI/testing/sysfs-driver-ufs | 37 ++++++++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 35 ++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 6b248abb1bd71..78f3e393d2498 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1591,6 +1591,43 @@ Description:	This entry shows the status of HPB.
 
 		The file is read only.
 
+Contact:	Daniil Lunev <dlunev@chromium.org>
+What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/
+What:		/sys/bus/platform/devices/*.ufs/capabilities/
+Date:		August 2022
+Description:	The group represents the effective capabilities of the
+		host-device pair. i.e. the capabilities which are enabled in the
+		driver for the specific host controller, supported by the host
+		controller and are supported and/or have compatible
+		configuration on the device side.
+
+Contact:	Daniil Lunev <dlunev@chromium.org>
+What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/clock_scaling
+What:		/sys/bus/platform/devices/*.ufs/capabilities/clock_scaling
+Date:		August 2022
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
+Date:		August 2022
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
index 0a088b47d5570..75d4287657c80 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -279,6 +279,40 @@ static const struct attribute_group ufs_sysfs_default_group = {
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
+ * See Documentation/ABI/testing/sysfs-driver-ufs for the semantics of this
+ * group.
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
@@ -1134,6 +1168,7 @@ static const struct attribute_group ufs_sysfs_attributes_group = {
 
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
+	&ufs_sysfs_capabilities_group,
 	&ufs_sysfs_monitor_group,
 	&ufs_sysfs_device_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
-- 
2.31.0

