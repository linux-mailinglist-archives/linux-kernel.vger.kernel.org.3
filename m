Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1086053DB42
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351022AbiFEKdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245617AbiFEKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:33:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5912C205FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DA97B80B83
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABB6C385A5;
        Sun,  5 Jun 2022 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654425201;
        bh=UATuJy/9oNY4ZU95eveoO+ujyt4gg6+HJ332NeCE2mk=;
        h=From:To:Cc:Subject:Date:From;
        b=rBID41qNIlFp64ocJql3lcBQ1ZN6Yf8ur4l3tQ9iRCIYolDhD+txKCDHN4BTVk1tN
         D+/4tcsuiEEVdOxJcfsMS218rl+tWkTYCwkox0NKevDioSSTZ4dEr/rv84gu098Piu
         5F/kIlw5MtAXU/z3n+xYOsvc/zn8no48mibvjevd7CnaLahfm4R1Del5+9JN72SYsM
         +2n/PgMADCMS7BkzA/qQTdnHDO0oe23e7Gh+ly87xBLbNCRrLho9g78pGGDE+fxAW4
         sOTjZphso++LZWn9u0yjDKzOFdJI5beWrhjN+m1uNdMoZRXbvyNeuxP0hi63ue7ypl
         tDI3wjFCW2eGw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 1/7] habanalabs: add terminating NULL to attrs arrays
Date:   Sun,  5 Jun 2022 13:33:10 +0300
Message-Id: <20220605103316.3414541-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

Arrays of struct attribute are expected to be NULL terminated.
This is required by API methods such as device_add_groups.
This fixes a crash when loading the driver for Goya device.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/sysfs.c    | 2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c     | 1 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 9ebeb18ab85e..da8181068895 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -73,6 +73,7 @@ static DEVICE_ATTR_RO(clk_cur_freq_mhz);
 static struct attribute *hl_dev_clk_attrs[] = {
 	&dev_attr_clk_max_freq_mhz.attr,
 	&dev_attr_clk_cur_freq_mhz.attr,
+	NULL,
 };
 
 static ssize_t vrm_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -93,6 +94,7 @@ static DEVICE_ATTR_RO(vrm_ver);
 
 static struct attribute *hl_dev_vrm_attrs[] = {
 	&dev_attr_vrm_ver.attr,
+	NULL,
 };
 
 static ssize_t uboot_ver_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index fba322241096..25d735aee6a3 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9187,6 +9187,7 @@ static DEVICE_ATTR_RO(infineon_ver);
 
 static struct attribute *gaudi_vrm_dev_attrs[] = {
 	&dev_attr_infineon_ver.attr,
+	NULL,
 };
 
 static void gaudi_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 6580fc6a486a..b595721751c1 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -359,6 +359,7 @@ static struct attribute *goya_clk_dev_attrs[] = {
 	&dev_attr_pm_mng_profile.attr,
 	&dev_attr_tpc_clk.attr,
 	&dev_attr_tpc_clk_curr.attr,
+	NULL,
 };
 
 static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -375,6 +376,7 @@ static DEVICE_ATTR_RO(infineon_ver);
 
 static struct attribute *goya_vrm_dev_attrs[] = {
 	&dev_attr_infineon_ver.attr,
+	NULL,
 };
 
 void goya_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
-- 
2.25.1

