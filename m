Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB7482EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiACIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:17:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:16909 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232126AbiACIRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641197866; x=1672733866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yvWnEn5dGLnWI55Cxx7VOwO1VMtztk3f9jyVD07iN8o=;
  b=HLfxP7cfsmywH3eAD9BXCtqzfGX7QgGEpsKqBwbaD/Nh1JYRK6ZaAylm
   Mz+5VdyedwGkc7yuPoNkXLwr9g25LNHtii/xXSoxFvDPaI34U46cDjYHG
   +u5mfWyjhHH71NcydP1T3bzIjvoxH9NqYD5wIGK1iZpdeejdeYYS+vVzn
   +3b4OgnOhNpvlWkWd0HaBfmFzBgIpL9fGfWo42f8RuVZr1HG9Z/iSr7V7
   jrkLd5VvTXiorhqPUpdLAMmQiRmUhbqesYVZ+0UeEB3NJpLegkfh5z66Q
   gtysWoAdFXvUADmQeYdWdLZ7B3Bwsxfb7TLR4qA+X6ojBbD98mO7EJ17J
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="266290049"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="266290049"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 00:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="471581466"
Received: from inlubt0246.iind.intel.com ([10.67.198.165])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2022 00:17:39 -0800
From:   vishakha.joshi@intel.com
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        vijayakannan.ayyathurai@intel.com, bala.senthil@intel.com,
        tamal.saha@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        vishakha.joshi@intel.com
Subject: [PATCH v1 1/2] pwm: Add count to sysfs for Intel PWM driver
Date:   Mon,  3 Jan 2022 13:46:09 +0530
Message-Id: <20220103081610.6656-2-vishakha.joshi@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103081610.6656-1-vishakha.joshi@intel.com>
References: <20220103081610.6656-1-vishakha.joshi@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishakha Joshi <vishakha.joshi@intel.com>

The number of cycles in the PWM waveform is generated according to the
count value configured in the sysfs interface.
This helps to control the duration of the PWM waveform in the KeemBay
SoC.
In case of default count value which is zero, the PWM waveform repeats
indefinitely.

Signed-off-by: Vishakha Joshi <vishakha.joshi@intel.com>
---
 Documentation/ABI/testing/sysfs-class-pwm |  8 ++++++
 drivers/pwm/sysfs.c                       | 34 +++++++++++++++++++++++
 include/linux/pwm.h                       |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-pwm b/Documentation/ABI/testing/sysfs-class-pwm
index 3d65285bcd5f..dde57b5a359f 100644
--- a/Documentation/ABI/testing/sysfs-class-pwm
+++ b/Documentation/ABI/testing/sysfs-class-pwm
@@ -86,3 +86,11 @@ Description:
 		Capture information about a PWM signal. The output format is a
 		pair unsigned integers (period and duty cycle), separated by a
 		single space.
+
+What:		/sys/class/pwm/pwmchip<N>/pwmX/count
+Date:		December 2021
+KernelVersion:  5.17
+Contact:	Vishakha Joshi <vishakha.joshi@intel.com>
+Description:
+		The PWM repeat count of the number of cycles in the waveform.
+		The default value for the count is zero with infinite repetition.
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9903c3a7eced..4d8fbd134f1d 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -215,11 +215,44 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t count_store(struct device *child, struct device_attribute *attr, const char *buf,
+			   size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	unsigned int count;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &count);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.count = count;
+	ret = pwm_apply_state(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ?: size;
+}
+
+static ssize_t count_show(struct device *child, struct device_attribute *attr, char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sysfs_emit(buf, "%d\n", state.count);
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
+static DEVICE_ATTR_RW(count);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -227,6 +260,7 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_count.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e6dac95e4960..dc0612867e65 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -52,6 +52,7 @@ enum {
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
+ * @count: PWM repeat count
  * @polarity: PWM polarity
  * @enabled: PWM enabled status
  * @usage_power: If set, the PWM driver is only required to maintain the power
@@ -62,6 +63,7 @@ enum {
 struct pwm_state {
 	u64 period;
 	u64 duty_cycle;
+	u32 count;
 	enum pwm_polarity polarity;
 	bool enabled;
 	bool usage_power;
-- 
2.17.1

