Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44058E6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiHJF07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHJF05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:26:57 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF94785B2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 22:26:56 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-235-229.tukw.qwest.net [97.113.235.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 53851344;
        Tue,  9 Aug 2022 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1660109214;
        bh=CC7nntUX8aC+aGxK3LnvD+EzTXAtWc+ZtVg5B0tO35Q=;
        h=From:To:Cc:Subject:Date:From;
        b=cxSrSJJWHYUbTTRTqFmpSSSKB5UWQ4jd4biI3irWvW5hLE010+JeOfx6XdPpzhI/p
         TtXMUkHOe6N8OBxcc+bkPW6wPDHqpwgvqFURxW9rrAEfKD1+Vx59fvdK2OU0Zl9Ffu
         l+ojgqEssY3Ba1C3glLaJu58wfug9qx/EuWKuh6I=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= 
        <dirty.ice.hu@gmail.com>, stable@kernel.org
Subject: [PATCH] hwmon: (nct6775) Fix platform driver suspend regression
Date:   Tue,  9 Aug 2022 22:26:46 -0700
Message-Id: <20220810052646.13825-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c3963bc0a0cf ("hwmon: (nct6775) Split core and platform
driver") introduced a slight change in nct6775_suspend() in order to
avoid an otherwise-needless symbol export for nct6775_update_device(),
replacing a call to that function with a simple dev_get_drvdata()
instead.

Though the exact details of how this happens aren't yet fully known,
it turns out that this breaks suspend/resume in at least some
circumstances.  To fix this (possibly only temporarily until the
problem is better understood), just add the symbol export and return
to using nct6775_update_device() as was employed previously.

Reported-by: Zoltán Kővágó <dirty.ice.hu@gmail.com>
Tested-by: Zoltán Kővágó <dirty.ice.hu@gmail.com>
Fixes: c3963bc0a0cf ("hwmon: (nct6775) Split core and platform driver")
Cc: stable@kernel.org
Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/nct6775-core.c     | 3 ++-
 drivers/hwmon/nct6775-platform.c | 2 +-
 drivers/hwmon/nct6775.h          | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 446964cbae4c..da9ec6983e13 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1480,7 +1480,7 @@ static int nct6775_update_pwm_limits(struct device *dev)
 	return 0;
 }
 
-static struct nct6775_data *nct6775_update_device(struct device *dev)
+struct nct6775_data *nct6775_update_device(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int i, j, err = 0;
@@ -1615,6 +1615,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 	mutex_unlock(&data->update_lock);
 	return err ? ERR_PTR(err) : data;
 }
+EXPORT_SYMBOL_GPL(nct6775_update_device);
 
 /*
  * Sysfs callback functions
diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index ab30437221ce..41c97cfacfb8 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -359,7 +359,7 @@ static int __maybe_unused nct6775_suspend(struct device *dev)
 {
 	int err;
 	u16 tmp;
-	struct nct6775_data *data = dev_get_drvdata(dev);
+	struct nct6775_data *data = nct6775_update_device(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
diff --git a/drivers/hwmon/nct6775.h b/drivers/hwmon/nct6775.h
index 93f708148e65..be41848c3cd2 100644
--- a/drivers/hwmon/nct6775.h
+++ b/drivers/hwmon/nct6775.h
@@ -196,6 +196,8 @@ static inline int nct6775_write_value(struct nct6775_data *data, u16 reg, u16 va
 	return regmap_write(data->regmap, reg, value);
 }
 
+struct nct6775_data *nct6775_update_device(struct device *dev);
+
 bool nct6775_reg_is_word_sized(struct nct6775_data *data, u16 reg);
 int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		  const struct regmap_config *regmapcfg);
-- 
2.37.1

