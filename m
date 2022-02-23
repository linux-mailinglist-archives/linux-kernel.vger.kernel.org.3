Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8D4C1F25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiBWWxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiBWWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:53:30 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08355BFE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:53:02 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so792889ooi.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73e7wFRPyPw6uhq6xZgSXpWdkqB59x1byfODzh+qh+E=;
        b=DSIFUcARUSCc/bmluMxQF7YI4kmxHK9yXBVit0KSDq7X9UQ0vF6doi0MJeYwo+JCrm
         zxjzXb6rFYGkwNagN+/DOqeKS//xdkINpFZkM6M701W4Upi7qQbasws3gOY36970IykV
         29jET3DPOKlFp9RqOfkC+GTghWzm8KOeHM16/uUSgSTaeHMf5++i/3TFCWOmcdDiu8Un
         EWUsLWaD0iwkj6NMAM4O7vgRpeIlK8gGGLHxgJS2/qUp4q1BkzmwY1AVnisVtr9A/uz0
         YtcRV/idDAuJvORAUo1UomWk1Vh4eAG177Z2UIlaEvIfX5BTCHg7zXBPmwi6HzI3xzlW
         JPhw==
X-Gm-Message-State: AOAM533AGnVrogFT5g09tCiGzTBI+weE5px4BRnxv3u4YJeNMn6nygIE
        sgxuTfxo6KNpMTHqg8HuqTJsQ4Xv7Q==
X-Google-Smtp-Source: ABdhPJzQnlsB8djd/EItWZ8YfgocEbACYakXJElYkVk+P9Dnk9xJbZtYSMTjkziWm9ghJ6nveHTWPg==
X-Received: by 2002:a05:6870:2490:b0:c4:7dc0:d764 with SMTP id s16-20020a056870249000b000c47dc0d764mr909681oaq.311.1645656781851;
        Wed, 23 Feb 2022 14:53:01 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y15sm398775oof.37.2022.02.23.14.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:53:01 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] driver core: Refactor sysfs and drv/bus remove hooks
Date:   Wed, 23 Feb 2022 16:52:57 -0600
Message-Id: <20220223225257.1681968-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223225257.1681968-1-robh@kernel.org>
References: <20220223225257.1681968-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 copies of the same device sysfs cleanup and drv/bus remove()
hooks used for probe failure, testing re-probing, and device unbinding.

Let's refactor the code to its own function.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that driver_sysfs_remove() remains a separate call because in
__device_release_driver() it is called with a pm runtime get/put and
before the unbind notifier. Browsing the history, it doesn't seem like
there's any particular reason for this ordering. We also have other
sysfs teardown done later. It would be more logical to do all the
sysfs teardown at once. Thoughts?
---
 drivers/base/dd.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 19bae32955c1..e7ede3fb1774 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -520,6 +520,17 @@ static void device_unbind_cleanup(struct device *dev)
 	dev_pm_set_driver_flags(dev, 0);
 }
 
+static void device_remove(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_state_synced);
+	device_remove_groups(dev, dev->driver->dev_groups);
+
+	if (dev->bus && dev->bus->remove)
+		dev->bus->remove(dev);
+	else if (dev->driver->remove)
+		dev->driver->remove(dev);
+}
+
 static int call_driver_probe(struct device *dev, struct device_driver *drv)
 {
 	int ret = 0;
@@ -633,14 +644,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (test_remove) {
 		test_remove = false;
 
-		device_remove_file(dev, &dev_attr_state_synced);
-		device_remove_groups(dev, drv->dev_groups);
-
-		if (dev->bus->remove)
-			dev->bus->remove(dev);
-		else if (drv->remove)
-			drv->remove(dev);
-
+		device_remove(dev);
 		driver_sysfs_remove(dev);
 		device_unbind_cleanup(dev);
 
@@ -658,12 +662,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	goto done;
 
 dev_sysfs_state_synced_failed:
-	device_remove_groups(dev, drv->dev_groups);
 dev_groups_failed:
-	if (dev->bus->remove)
-		dev->bus->remove(dev);
-	else if (drv->remove)
-		drv->remove(dev);
+	device_remove(dev);
 probe_failed:
 	driver_sysfs_remove(dev);
 sysfs_failed:
@@ -1196,13 +1196,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		pm_runtime_put_sync(dev);
 
-		device_remove_file(dev, &dev_attr_state_synced);
-		device_remove_groups(dev, drv->dev_groups);
-
-		if (dev->bus && dev->bus->remove)
-			dev->bus->remove(dev);
-		else if (drv->remove)
-			drv->remove(dev);
+		device_remove(dev);
 
 		device_links_driver_cleanup(dev);
 		device_unbind_cleanup(dev);
-- 
2.32.0

