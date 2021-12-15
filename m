Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841F547601D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbhLOSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:02:17 -0500
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:58934 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhLOSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:02:15 -0500
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 13:02:13 EST
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 4713DF40EA6; Wed, 15 Dec 2021 18:55:06 +0100 (CET)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/5] rtc: gamecube: Report low battery as invalid data
Date:   Wed, 15 Dec 2021 18:54:58 +0100
Message-Id: <20211215175501.6761-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215175501.6761-1-linkmauve@linkmauve.fr>
References: <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211215175501.6761-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven’t been able to test this patch as all of my consoles have a
working RTC battery, but according to the documentation it should work
like that.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/rtc/rtc-gamecube.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index e8260c82c07d..98128746171e 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -83,6 +83,10 @@
 #define RTC_CONTROL0	0x21000c
 #define RTC_CONTROL1	0x21000d
 
+/* RTC flags */
+#define RTC_CONTROL0_UNSTABLE_POWER	0x00000800
+#define RTC_CONTROL0_LOW_BATTERY	0x00000200
+
 struct priv {
 	struct regmap *regmap;
 	void __iomem *iob;
@@ -182,9 +186,35 @@ static int gamecube_rtc_set_time(struct device *dev, struct rtc_time *t)
 	return regmap_write(d->regmap, RTC_COUNTER, timestamp - d->rtc_bias);
 }
 
+static int gamecube_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct priv *d = dev_get_drvdata(dev);
+	int value;
+	int control0;
+	int ret;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = regmap_read(d->regmap, RTC_CONTROL0, &control0);
+		if (ret)
+			return ret;
+
+		value = 0;
+		if (control0 & RTC_CONTROL0_UNSTABLE_POWER)
+			value |= RTC_VL_DATA_INVALID;
+		if (control0 & RTC_CONTROL0_LOW_BATTERY)
+			value |= RTC_VL_BACKUP_LOW;
+		return put_user(value, (unsigned int __user *)arg);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct rtc_class_ops gamecube_rtc_ops = {
 	.read_time	= gamecube_rtc_read_time,
 	.set_time	= gamecube_rtc_set_time,
+	.ioctl		= gamecube_rtc_ioctl,
 };
 
 static int gamecube_rtc_read_offset_from_sram(struct priv *d)
-- 
2.34.1

