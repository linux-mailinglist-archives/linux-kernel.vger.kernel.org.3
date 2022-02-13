Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC54B3D93
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiBMUud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:50:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiBMUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:50:23 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2453717;
        Sun, 13 Feb 2022 12:50:16 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 53E292012E6;
        Sun, 13 Feb 2022 20:50:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8B45C80A0E; Sun, 13 Feb 2022 21:48:34 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 4/4] hw_random: introduce rng_quality sysfs attribute
Date:   Sun, 13 Feb 2022 21:46:31 +0100
Message-Id: <20220213204631.354247-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213204631.354247-1-linux@dominikbrodowski.net>
References: <20220213204631.354247-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rng_quality sysfs attribute returns the quality setting for the
currently active hw_random device, in entropy bits per 1024 bits of
input. Storing a value between 0 and 1024 to this file updates this
estimate accordingly.

Based on the updates to the quality setting, the rngd kernel thread
may be stopped (if no hw_random device is trusted to return entropy),
may be started (if the quality setting is increased from zero), or
may use a different hw_random source (if that has higher quality
output).

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 64 ++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 8df102b39b35..71eafcc451e1 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -44,7 +44,7 @@ static unsigned short default_quality; /* = 0; default to "off" */
 
 module_param(current_quality, ushort, 0644);
 MODULE_PARM_DESC(current_quality,
-		 "current hwrng entropy estimation per 1024 bits of input -- obsolete");
+		 "current hwrng entropy estimation per 1024 bits of input -- obsolete, use rng_quality instead");
 module_param(default_quality, ushort, 0644);
 MODULE_PARM_DESC(default_quality,
 		 "default entropy content of hwrng per 1024 bits of input");
@@ -402,14 +402,76 @@ static ssize_t rng_selected_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", cur_rng_set_by_user);
 }
 
+static ssize_t rng_quality_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	ssize_t ret;
+	struct hwrng *rng;
+
+	rng = get_current_rng();
+	if (IS_ERR(rng))
+		return PTR_ERR(rng);
+
+	if (!rng) /* no need to put_rng */
+		return -ENODEV;
+
+	ret = sysfs_emit(buf, "%hu\n", rng->quality);
+	put_rng(rng);
+
+	return ret;
+}
+
+static ssize_t rng_quality_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t len)
+{
+	u16 quality;
+	int ret = -EINVAL;
+
+	if (len < 2)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&rng_mutex);
+	if (ret)
+		return -ERESTARTSYS;
+
+	ret = kstrtou16(buf, 0, &quality);
+	if (ret || quality > 1024) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!current_rng) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	current_rng->quality = quality;
+	current_quality = quality; /* obsolete */
+
+	/* the best available RNG may have changed */
+	ret = enable_best_rng();
+
+	/* start/stop rngd if necessary */
+	if (current_rng)
+		hwrng_manage_rngd(current_rng);
+
+out:
+	mutex_unlock(&rng_mutex);
+	return ret ? ret : len;
+}
+
 static DEVICE_ATTR_RW(rng_current);
 static DEVICE_ATTR_RO(rng_available);
 static DEVICE_ATTR_RO(rng_selected);
+static DEVICE_ATTR_RW(rng_quality);
 
 static struct attribute *rng_dev_attrs[] = {
 	&dev_attr_rng_current.attr,
 	&dev_attr_rng_available.attr,
 	&dev_attr_rng_selected.attr,
+	&dev_attr_rng_quality.attr,
 	NULL
 };
 
-- 
2.35.1

