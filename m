Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A88496DCD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiAVT6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiAVT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A53C06175A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 64042CE0AB2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB0C004E1;
        Sat, 22 Jan 2022 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881486;
        bh=jKX6MKcp77T4KW64Q4GVWpkwbwMFbp3uIs3VTjXTL60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZF/vON/egjDvcC/Omuty1qKpaa+uj1VfSPreXF+ujMVjdadSO38nQzu0fZbcSxzq
         fbx9T1Nwd60pTYq4+ULrK7ZJ38A8Hr2+bVsTDTZE39Mb6cTGRj3OSWjakT6LmGKTbs
         Nf2JRmLnRME80qwRC1OKqhA1g4GH9URbNJDMPwap6uDJEjjiaZs9ikZL/qzOfVcxod
         OA0WLSxH9KN6FXbns+TGFgEQN7vtgHHAbBa3N0RAl9VsJbyR9H6MAizA6vj75BtIDf
         644MwcaN5m20y6HbVONUuuyuOyKxe/gSJUgRaemgrYeBKuzsY4DDXyGP9OjLxRJOgn
         0dcTPSj5b5OhQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 23/30] habanalabs: add missing error check in sysfs max_power_show
Date:   Sat, 22 Jan 2022 21:57:24 +0200
Message-Id: <20220122195731.934494-23-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add a missing error check in the sysfs show function for max_power.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 4 ++--
 drivers/misc/habanalabs/common/habanalabs.h  | 2 +-
 drivers/misc/habanalabs/common/sysfs.c       | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 7f76f98154f0..39de9d86ee6c 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2780,7 +2780,7 @@ void hl_fw_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 			used_pll_idx, rc);
 }
 
-u64 hl_fw_get_max_power(struct hl_device *hdev)
+long hl_fw_get_max_power(struct hl_device *hdev)
 {
 	struct cpucp_packet pkt;
 	u64 result;
@@ -2794,7 +2794,7 @@ u64 hl_fw_get_max_power(struct hl_device *hdev)
 
 	if (rc) {
 		dev_err(hdev->dev, "Failed to get max power, error %d\n", rc);
-		return (u64) rc;
+		return rc;
 	}
 
 	return result;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9c8374d88907..995167020c27 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3098,7 +3098,7 @@ int hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr, long *val
 int hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
 int hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
 void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long value);
-u64 hl_fw_get_max_power(struct hl_device *hdev);
+long hl_fw_get_max_power(struct hl_device *hdev);
 void hl_fw_set_max_power(struct hl_device *hdev);
 int hl_set_voltage(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev, int sensor_index, u32 attr, long value);
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index c665a3ac8876..9ebeb18ab85e 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -304,6 +304,8 @@ static ssize_t max_power_show(struct device *dev, struct device_attribute *attr,
 		return -ENODEV;
 
 	val = hl_fw_get_max_power(hdev);
+	if (val < 0)
+		return val;
 
 	return sprintf(buf, "%lu\n", val);
 }
-- 
2.25.1

