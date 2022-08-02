Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0DA5874DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiHBAhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiHBAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:37:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F1357D2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:37:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so11047072pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkSPJ1fGWKwnB6nfWJJpSabwLL8PeTkD8DzYOav9XOM=;
        b=jstM1DFtArIJE4r3dJgJmVB+/wkidSo+wxJa4lXqU5JQeQ1S0J5fiNv9yCe+DI25hp
         HzobHfGoDNXR/ZFg2DSuVTr0rCXMWOx3obERUgT4Ahv/JBGt5RJoPzK4NSMVhOb5+ks4
         5tbSJ1j2DZN3JPAk3Uc5qT1GeI4GaFKf6LpyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkSPJ1fGWKwnB6nfWJJpSabwLL8PeTkD8DzYOav9XOM=;
        b=DM0tpvmUAt8O0bGONSz6TElZo7UtYMZ8hgBRkV7HJFCuJ09af1PwPcm3PDbDUa3Jua
         lL4LBfiG/6J2fBVikc3CJQXcthkaljFHIOU2+sG876DXNp3KD9nHJi3VocozoPyoysDl
         3EluiiMsyuvTaxZtrZ9AkyLgooA3LUGC1hp8DEP8l2j7vtDZ4jSriK3dyS1TAa/XGu1F
         yY0yk4XMTnbvfO5gP4SAkMXoEvvBY4Ez8nT/eYG00SEF9eBPPERdkzo85Xd94ygCROdR
         paY2fcBDho3MegbAN4Jl7oLLws5tNS7k4FGnTmPR9fbzYUiCA5ohJNyw1xVqEbRlsAmz
         MaAQ==
X-Gm-Message-State: ACgBeo0MLUMkCc0R6SDUzXYBL2bjkJRnJ0MVDKS2J8Q1oK0RQFhm6g0t
        puSMpvHmfsbf6VM8buRicdsoFg==
X-Google-Smtp-Source: AA6agR6qACbTp/hM1PKV8p19nlC1Su2CQrDQDk7YaxKNHs5REHWX0QuwjnCCLkjuK3nX1wiOcQkhlQ==
X-Received: by 2002:a62:cec9:0:b0:52d:414b:c70f with SMTP id y192-20020a62cec9000000b0052d414bc70fmr9893287pfg.20.1659400632174;
        Mon, 01 Aug 2022 17:37:12 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016ef1e058e5sm2558806pln.295.2022.08.01.17.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 17:37:11 -0700 (PDT)
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
Subject: [PATCH v5] ufs: core: print UFSHCD capabilities in controller's sysfs node
Date:   Tue,  2 Aug 2022 10:37:02 +1000
Message-Id: <20220802103643.v5.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows userspace to check if Clock Scaling and Write Booster are
supported.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

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

 Documentation/ABI/testing/sysfs-driver-ufs | 26 ++++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 31 ++++++++++++++++++++++
 2 files changed, 57 insertions(+)

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
index 0a088b47d5570..5c53349337dd8 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -279,6 +279,36 @@ static const struct attribute_group ufs_sysfs_default_group = {
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
@@ -1134,6 +1164,7 @@ static const struct attribute_group ufs_sysfs_attributes_group = {
 
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
+	&ufs_sysfs_capabilities_group,
 	&ufs_sysfs_monitor_group,
 	&ufs_sysfs_device_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
-- 
2.31.0

