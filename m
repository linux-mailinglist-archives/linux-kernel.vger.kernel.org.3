Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A500595C77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiHPM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiHPM42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:56:28 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA9923D3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:55:52 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Nw6mosEtPSMw7Nw6mobXRO; Tue, 16 Aug 2022 14:55:49 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Aug 2022 14:55:49 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] driver core: Have dev_err_probe() handle the dev_fmt() macro
Date:   Tue, 16 Aug 2022 14:55:34 +0200
Message-Id: <2cd29680cae15b6b41061dacb16a094ccc20251a.1660654443.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err() and co. functions handle the dev_fmt() macro if it is defined.
This helps to have a common prefix for all messages generated with this
API.

dev_err_probe() looks like dev_err() but, up to now, does not expand the
dev_fmt() macro.

Add it.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Example of where it would be useful is discussed at:
  https://lore.kernel.org/all/aaeba9c12ccdb29f48fe19137cb5abeea85fbb24.1659732652.git.christophe.jaillet@wanadoo.fr/


I've left the kerneldoc in the .c file near _dev_err_probe(). I don't know
if it should be moved in the .h file close to dev_err_probe().
---
 drivers/base/core.c    | 7 +++++--
 include/linux/device.h | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 753e7cca0f40..89cab273a7b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4830,6 +4830,9 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * 	return dev_err_probe(dev, err, ...);
  *
+ * Just as dev_err() does, dev_err_probe() also takes the dev_fmt() macro into
+ * consideration if it is defined.
+ *
  * Note that it is deemed acceptable to use this function for error
  * prints during probe even if the @err is known to never be -EPROBE_DEFER.
  * The benefit compared to a normal dev_err() is the standardized format
@@ -4838,7 +4841,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  * Returns @err.
  *
  */
-int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
+int _dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -4858,7 +4861,7 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(dev_err_probe);
+EXPORT_SYMBOL_GPL(_dev_err_probe);
 
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..412a0ee2d44e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1093,7 +1093,9 @@ void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
 extern __printf(3, 4)
-int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+int _dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+#define dev_err_probe(dev, err, fmt, ...) \
+	_dev_err_probe(dev, err, dev_fmt(fmt), ##__VA_ARGS__)
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
-- 
2.34.1

