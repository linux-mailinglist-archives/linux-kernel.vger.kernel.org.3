Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B165A3FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiH1WTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1WTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:19:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5BA2F3B8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:19:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2461983pjq.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NgYfug8tl0z4enxYMDU8+sCqKO6l+D8m5UuINcNddOQ=;
        b=N4ANluPrjZEqWVcI5ToVYX3lzQrQrtycis9YikCcyNgt6feKRCvUxp01vwwYiba+Tn
         FdkLtuzUgyKWZR+KgtoURKRFssyh6RYV79dEPnd4OdgeE3wY1Fbt6Ps7HiT9yEX2Clyb
         xNI9+Lze0xB/w3dSlvJuc+UFJlIULzlCUtJ+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NgYfug8tl0z4enxYMDU8+sCqKO6l+D8m5UuINcNddOQ=;
        b=NzkSF8Hw1l+XLmcgi3uw7YSrhMU1RyFx5CjN/p0Tu6UlTE5HIjUMMt45MMGxc1e7kJ
         +11b9CI+IXiZPm54RT/aSMqib2lZfbKrYbHkN8/G+XJt4UfYvWPZgoWmorLeZDewp2wm
         AmXlVwov+QMOQ8FTVnXBOCArtRgIcXyQmt6MHdhnxuRzH32YBN6meFGlh6+jFFpdfWrT
         p7LdEdfjBLNad5ioYORkKhNlEcFwSbFGqPstqAFKZSkRk4+dITTozOt4iN+Eqa/5DaIC
         G/pq0hmmrjv8GThCwfxzJt3I2VZai2+eZfAwMuwCgMl64vbzeN0vUcicVTQbrT0v2Zrl
         yABw==
X-Gm-Message-State: ACgBeo3r7CBzt1rQE19d5djDLU9zanKoWb5ITUbwaE7fPvpXKMBoY8cy
        ogph/1V3Gxc1zrvba4T5zCpGhA==
X-Google-Smtp-Source: AA6agR5cJOTNgknm/sg4yIQ7Lakv3kppUSdlmEb9DBCuM4PT6T3bpCrUOSB4lHNeKfv55Kvscz0kPQ==
X-Received: by 2002:a17:902:6b42:b0:174:4308:ce52 with SMTP id g2-20020a1709026b4200b001744308ce52mr11440814plt.81.1661725147636;
        Sun, 28 Aug 2022 15:19:07 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-204-138.sbr2.nsw.optusnet.com.au. [122.107.204.138])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0016b90620910sm5881341plh.71.2022.08.28.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 15:19:07 -0700 (PDT)
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
Subject: [PATCH v8] ufs: core: print UFSHCD capabilities in controller's sysfs node
Date:   Mon, 29 Aug 2022 08:18:58 +1000
Message-Id: <20220829081845.v8.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace may want to manually control when the data should go into
WriteBooster buffer. The control happens via "wb_on" node, but
presently, there is no simple way to check if WriteBooster is supported
and enabled. This change exposes the Write Booster and Clock Scaling
capabilities to be able to determin if the Write Booster is available
and if its manual control is blocked by Clock Scaling mechanism.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

Changes in v8:
* Expand commit message with motiviation.

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

