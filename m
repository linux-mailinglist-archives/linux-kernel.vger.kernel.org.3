Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54CC5197A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiEDG46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiEDG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:56:36 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6249D20BFF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:53:00 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 9EA25629;
        Tue,  3 May 2022 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651647180;
        bh=82pFgktAlz+Ya9WLKFBYjJeWqPhCiiVLL8JWL4SAXK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2MJt1uJ8QPdLELePPyyROyP/vofajRxWWrl0OOTkl6ag82KXypgahCX+SlAf+3Yp
         MUALxwI70XmJIM77nkCcCIpvJGNVU+D84T9nlYcL8MXKn2e9UzAJaWU6fL7BgBTf/r
         8z6c2of6W+7oqeGSiQVGiy1inh9vx+r0mvLxW8IY=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: [PATCH 3/6] regulator: core: Add error flags to sysfs attributes
Date:   Tue,  3 May 2022 23:52:49 -0700
Message-Id: <20220504065252.6955-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504065252.6955-1-zev@bewilderbeest.net>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a regulator provides a get_error_flags() operation, its sysfs
attributes will now include an entry for each defined
REGULATOR_ERROR_* flag.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../ABI/testing/sysfs-class-regulator         | 81 +++++++++++++++++++
 drivers/regulator/core.c                      | 45 +++++++++++
 2 files changed, 126 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-regulator b/Documentation/ABI/testing/sysfs-class-regulator
index 8516f08806dd..475b9a372657 100644
--- a/Documentation/ABI/testing/sysfs-class-regulator
+++ b/Documentation/ABI/testing/sysfs-class-regulator
@@ -370,3 +370,84 @@ Description:
 
 		'unknown' means software cannot determine the state, or
 		the reported state is invalid.
+
+What:		/sys/class/regulator/.../under_voltage
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		under_voltage.  This indicates if the device reports an
+		under-voltage fault (1) or not (0).
+
+What:		/sys/class/regulator/.../over_current
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		over_current.  This indicates if the device reports an
+		over-current fault (1) or not (0).
+
+What:		/sys/class/regulator/.../regulation_out
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		regulation_out.  This indicates if the device reports an
+		out-of-regulation fault (1) or not (0).
+
+What:		/sys/class/regulator/.../fail
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		fail.  This indicates if the device reports an output failure
+		(1) or not (0).
+
+What:		/sys/class/regulator/.../over_temp
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		over_temp.  This indicates if the device reports an
+		over-temperature fault (1) or not (0).
+
+What:		/sys/class/regulator/.../under_voltage_warn
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		under_voltage_warn.  This indicates if the device reports an
+		under-voltage warning (1) or not (0).
+
+What:		/sys/class/regulator/.../over_current_warn
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		over_current_warn.  This indicates if the device reports an
+		over-current warning (1) or not (0).
+
+What:		/sys/class/regulator/.../over_voltage_warn
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		over_voltage_warn.  This indicates if the device reports an
+		over-voltage warning (1) or not (0).
+
+What:		/sys/class/regulator/.../over_temp_warn
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:
+		Some regulator directories will contain a field called
+		over_temp_warn.  This indicates if the device reports an
+		over-temperature warning (1) or not (0).
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d2553970a67b..9094bd8772e5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -83,6 +83,7 @@ struct regulator_supply_alias {
 
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
+static int _regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags);
 static int _regulator_get_current_limit(struct regulator_dev *rdev);
 static unsigned int _regulator_get_mode(struct regulator_dev *rdev);
 static int _notifier_call_chain(struct regulator_dev *rdev,
@@ -911,6 +912,30 @@ static ssize_t bypass_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bypass);
 
+#define REGULATOR_ERROR_ATTR(name, bit)							\
+	static ssize_t name##_show(struct device *dev, struct device_attribute *attr,	\
+				   char *buf)						\
+	{										\
+		int ret;								\
+		unsigned int flags;							\
+		struct regulator_dev *rdev = dev_get_drvdata(dev);			\
+		ret = _regulator_get_error_flags(rdev, &flags);				\
+		if (ret)								\
+			return ret;							\
+		return sysfs_emit(buf, "%d\n", !!(flags & (bit)));			\
+	}										\
+	static DEVICE_ATTR_RO(name)
+
+REGULATOR_ERROR_ATTR(under_voltage, REGULATOR_ERROR_UNDER_VOLTAGE);
+REGULATOR_ERROR_ATTR(over_current, REGULATOR_ERROR_OVER_CURRENT);
+REGULATOR_ERROR_ATTR(regulation_out, REGULATOR_ERROR_REGULATION_OUT);
+REGULATOR_ERROR_ATTR(fail, REGULATOR_ERROR_FAIL);
+REGULATOR_ERROR_ATTR(over_temp, REGULATOR_ERROR_OVER_TEMP);
+REGULATOR_ERROR_ATTR(under_voltage_warn, REGULATOR_ERROR_UNDER_VOLTAGE_WARN);
+REGULATOR_ERROR_ATTR(over_current_warn, REGULATOR_ERROR_OVER_CURRENT_WARN);
+REGULATOR_ERROR_ATTR(over_voltage_warn, REGULATOR_ERROR_OVER_VOLTAGE_WARN);
+REGULATOR_ERROR_ATTR(over_temp_warn, REGULATOR_ERROR_OVER_TEMP_WARN);
+
 /* Calculate the new optimum regulator operating mode based on the new total
  * consumer load. All locks held by caller
  */
@@ -4971,6 +4996,15 @@ static struct attribute *regulator_dev_attrs[] = {
 	&dev_attr_max_microvolts.attr,
 	&dev_attr_min_microamps.attr,
 	&dev_attr_max_microamps.attr,
+	&dev_attr_under_voltage.attr,
+	&dev_attr_over_current.attr,
+	&dev_attr_regulation_out.attr,
+	&dev_attr_fail.attr,
+	&dev_attr_over_temp.attr,
+	&dev_attr_under_voltage_warn.attr,
+	&dev_attr_over_current_warn.attr,
+	&dev_attr_over_voltage_warn.attr,
+	&dev_attr_over_temp_warn.attr,
 	&dev_attr_suspend_standby_state.attr,
 	&dev_attr_suspend_mem_state.attr,
 	&dev_attr_suspend_disk_state.attr,
@@ -5026,6 +5060,17 @@ static umode_t regulator_attr_is_visible(struct kobject *kobj,
 	if (attr == &dev_attr_bypass.attr)
 		return ops->get_bypass ? mode : 0;
 
+	if (attr == &dev_attr_under_voltage.attr ||
+	    attr == &dev_attr_over_current.attr ||
+	    attr == &dev_attr_regulation_out.attr ||
+	    attr == &dev_attr_fail.attr ||
+	    attr == &dev_attr_over_temp.attr ||
+	    attr == &dev_attr_under_voltage_warn.attr ||
+	    attr == &dev_attr_over_current_warn.attr ||
+	    attr == &dev_attr_over_voltage_warn.attr ||
+	    attr == &dev_attr_over_temp_warn.attr)
+		return ops->get_error_flags ? mode : 0;
+
 	/* constraints need specific supporting methods */
 	if (attr == &dev_attr_min_microvolts.attr ||
 	    attr == &dev_attr_max_microvolts.attr)
-- 
2.36.0

