Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7913E584887
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiG1XGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiG1XGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:06:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDECE51A2C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:06:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w205so3151725pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=invBG5xMXzjEltsK545VLHu8MZxeoZu1uoiZNi97Phk=;
        b=bPVO6QacKDugDyEDOSaJ3JZwlv385SFV20Ltpu9KZf5M/nCWeCrgUHTks4ehn2nglI
         qpDRdW/WkPcDEUwMst3Kq/kGg6yf9lMRRi9YVN/u65q9eNILxTqzdKUTvD1y6+lqqBnd
         kf2pucKesim8mkcRciv6zS5mlAC7WpSlePmUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=invBG5xMXzjEltsK545VLHu8MZxeoZu1uoiZNi97Phk=;
        b=o419UDxUR/PoOguCKZEjwcSVbw1Akn3DAtzDueUV0mYH810yjtE+LR7B5BE9xB8C/i
         Mq91DJlutnq/nn4DvwFO3q2uWryBE6FRn7axIxk1FIttXbD3VwIdvXjq358K6ByFLFOS
         kqJ4SWGwOd+Z2+RWdPMY5ZOo5hafhMdAtgKIOhc/ljB7JI9MHFQimpEQ5avIh/GATw7p
         PIR4AO9cCUAw4vugd+qYEYc6ItkTRH0iP8aMq4k5GkSfR6lkbFSl0TLM9/rLGz0D0hw9
         pjgPZDn4qEUlFUSm/ax0qGBCokSGu3ir27zkiMCNeC22C9GVHYL8SLcbgBzqDKby4wUW
         BnhA==
X-Gm-Message-State: AJIora8/OZzb9eiTFe/XVhDEug09rnjVcVGt7+rBtz5a0Zpbm3uAMMm6
        q+ljq3Pl48ug6Xv6DacPCuZt0Q==
X-Google-Smtp-Source: AGRyM1swyX1PXVaNHGWEmmfoZ3PHQ20qfpgeOKlJpO4J6WEZqcdZCaOinOJBSc4QsM7+MthkVDMGwA==
X-Received: by 2002:a05:6a00:240e:b0:52c:81cf:8df2 with SMTP id z14-20020a056a00240e00b0052c81cf8df2mr750238pfh.40.1659049561155;
        Thu, 28 Jul 2022 16:06:01 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902680e00b0016d2d2c7df1sm1824656plk.188.2022.07.28.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:06:00 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v2] ufs: core: print capabilities in controller's sysfs node
Date:   Fri, 29 Jul 2022 09:05:50 +1000
Message-Id: <20220729090521.v2.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows userspace to check supported by the controller/device
functionality, e.g. write booster.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

Changes in v2:
* Add documentation entry for the new sysfs node.

 Documentation/ABI/testing/sysfs-driver-ufs |  9 +++++++++
 drivers/ufs/core/ufs-sysfs.c               | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 6b248abb1bd71..97e42e4763eaf 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1591,6 +1591,15 @@ Description:	This entry shows the status of HPB.
 
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/caps
+What:		/sys/bus/platform/devices/*.ufs/caps
+Date:		July 2022
+Contact:	Daniil Lunev <dlunev@chromium.org>
+Description:	Read-only attribute. Enabled capabilities of the UFS driver. The
+		enabled capabilities are determined by what is supported by the
+		host controller and the UFS device.
+		Format: 0x%08llx
+
 What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/activation_thld
 Date:		February 2021
 Contact:	Avri Altman <avri.altman@wdc.com>
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d5570..b0c294c367519 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -254,6 +254,14 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "0x%08llx\n", hba->caps);
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -262,6 +270,7 @@ static DEVICE_ATTR_RO(spm_target_dev_state);
 static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
+static DEVICE_ATTR_RO(caps);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -272,6 +281,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_spm_target_link_state.attr,
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
+	&dev_attr_caps.attr,
 	NULL
 };
 
-- 
2.31.0

