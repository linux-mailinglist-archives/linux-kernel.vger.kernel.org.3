Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D051550F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380495AbiD2UDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380477AbiD2UDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:03:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3DB0A79
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:59:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so17402539ejn.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOxgRBVME7mclmuamlr6PIBTUGVRi69KeRfnSyVkfPc=;
        b=bZpA1wzvOK8I6x9HL/0QhdtdW5y7oEMIYpk/A3PJnQU1zXAuQil/KHDWPNQlww2/3A
         CPTiJcwZgKfvqCgY2UklcLjxNwHay2XP1A/Ynm+nDanUCrAqaAuetcyzlNgxLewZutMW
         W5Pp/AcMRBfl83CI85WDbqPC7yLnWjlqiww6vPsaQZpstaP7zmghmEyYYxGRIuWvDIjH
         AuS8XILHLTLOa/0fA3j43ox0Y2i3YAdcuVaNcd3aI7iqLBF0cb8jo0HOTdywBiR2LktG
         W8SArT3SxF8SZuIHTrLhNhUzssL/EFuIJgmxRNxXrvWWn1CWBmldnIFwsGnqhbnqD/f/
         mEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOxgRBVME7mclmuamlr6PIBTUGVRi69KeRfnSyVkfPc=;
        b=BQgjItB1xFMq6+ORz94x+Nc4NA6W58JDkwN/+Xg2NWPxTWooWwZunOY2g2uHMYI4tL
         z+8yho0HRhnFF57RcUUWZDrOEaVjGPgqAHaIj52P+qFk2j11r2i6w1e2gVPDC9VQTcfP
         FEIfDGGqiAml5t7WwZPGdyrE9lU4bq58zWtgwxjys4dEzh8mDShY7sPWBOXfHmTy/rvT
         JjbdDppWz/xl0Mh0cxaeRekbYwiMSsvMGIuYBHW0tonXsDhKnn69PaD7vhG4GrkoB0yZ
         gaDg2ejbVBlupmQa9pqjiSvyIZoCYIt8HFNayNjyMqgTBUtyb/TVrreHynZfb/ma9HRt
         UENQ==
X-Gm-Message-State: AOAM53243Oe8Zi2bL6FdpDSssflbWfF8gcTOYvKhV+waMRtNGMUqYtzg
        ZmE12Ew0lR07nbzJm9EzDyGJPA==
X-Google-Smtp-Source: ABdhPJw9zJe7ujZXVPeCOQ+tlVHyCoS4bz1d93A3Ut0Q4Cnw6LRhStlVFszPwd647YTv55colYrzng==
X-Received: by 2002:a17:906:d54b:b0:6e7:f185:18d5 with SMTP id cr11-20020a170906d54b00b006e7f18518d5mr930627ejc.155.1651262391933;
        Fri, 29 Apr 2022 12:59:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id en8-20020a17090728c800b006f3ef214de7sm929486ejc.77.2022.04.29.12.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:59:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] rpmsg: Fix calling device_lock() on non-initialized device
Date:   Fri, 29 Apr 2022 21:59:45 +0200
Message-Id: <20220429195946.1061725-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429195946.1061725-1-krzysztof.kozlowski@linaro.org>
References: <20220429195946.1061725-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

driver_set_override() helper uses device_lock() so it should not be
called before rpmsg_register_device() (which calls device_register()).
Effect can be seen with CONFIG_DEBUG_MUTEXES:

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582 __mutex_lock+0x1ec/0x430
  ...
  Call trace:
   __mutex_lock+0x1ec/0x430
   mutex_lock_nested+0x44/0x50
   driver_set_override+0x124/0x150
   qcom_glink_native_probe+0x30c/0x3b0
   glink_rpm_probe+0x274/0x350
   platform_probe+0x6c/0xe0
   really_probe+0x17c/0x3d0
   __driver_probe_device+0x114/0x190
   driver_probe_device+0x3c/0xf0
   ...

Refactor the rpmsg_register_device() function to use two-step device
registering (initialization + add) and call driver_set_override() in
proper moment.

This moves the code around, so while at it also NULL-ify the
rpdev->driver_override in error path to be sure it won't be kfree()
second time.

Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Commit SHA from linux-next - Greg's tree.
---
 drivers/rpmsg/rpmsg_core.c     | 33 ++++++++++++++++++++++++++++++---
 drivers/rpmsg/rpmsg_internal.h | 14 +-------------
 drivers/rpmsg/rpmsg_ns.c       | 14 +-------------
 include/linux/rpmsg.h          |  8 ++++++++
 4 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 95fc283f6af7..4938fc4eff00 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -593,24 +593,51 @@ static struct bus_type rpmsg_bus = {
 	.remove		= rpmsg_dev_remove,
 };
 
-int rpmsg_register_device(struct rpmsg_device *rpdev)
+/*
+ * A helper for registering rpmsg device with driver override and name.
+ * Drivers should not be using it, but instead rpmsg_register_device().
+ */
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override)
 {
 	struct device *dev = &rpdev->dev;
 	int ret;
 
+	if (driver_override)
+		strcpy(rpdev->id.name, driver_override);
+
 	dev_set_name(&rpdev->dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
 
 	rpdev->dev.bus = &rpmsg_bus;
 
-	ret = device_register(&rpdev->dev);
+	device_initialize(dev);
+	if (driver_override) {
+		ret = driver_set_override(dev, &rpdev->driver_override,
+					  driver_override,
+					  strlen(driver_override));
+		if (ret) {
+			dev_err(dev, "device_set_override failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = device_add(dev);
 	if (ret) {
-		dev_err(dev, "device_register failed: %d\n", ret);
+		dev_err(dev, "device_add failed: %d\n", ret);
+		kfree(rpdev->driver_override);
+		rpdev->driver_override = NULL;
 		put_device(&rpdev->dev);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL(rpmsg_register_device_override);
+
+int rpmsg_register_device(struct rpmsg_device *rpdev)
+{
+	return rpmsg_register_device_override(rpdev, NULL);
+}
 EXPORT_SYMBOL(rpmsg_register_device);
 
 /*
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3e81642238d2..a22cd4abe7d1 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -94,19 +94,7 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
  */
 static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
 {
-	int ret;
-
-	strcpy(rpdev->id.name, "rpmsg_ctrl");
-	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
-				  rpdev->id.name, strlen(rpdev->id.name));
-	if (ret)
-		return ret;
-
-	ret = rpmsg_register_device(rpdev);
-	if (ret)
-		kfree(rpdev->driver_override);
-
-	return ret;
+	return rpmsg_register_device_override(rpdev, "rpmsg_ctrl");
 }
 
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 8eb8f328237e..c70ad03ff2e9 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -20,22 +20,10 @@
  */
 int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 {
-	int ret;
-
-	strcpy(rpdev->id.name, "rpmsg_ns");
-	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
-				  rpdev->id.name, strlen(rpdev->id.name));
-	if (ret)
-		return ret;
-
 	rpdev->src = RPMSG_NS_ADDR;
 	rpdev->dst = RPMSG_NS_ADDR;
 
-	ret = rpmsg_register_device(rpdev);
-	if (ret)
-		kfree(rpdev->driver_override);
-
-	return ret;
+	return rpmsg_register_device_override(rpdev, "rpmsg_ns");
 }
 EXPORT_SYMBOL(rpmsg_ns_register_device);
 
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 20c8cd1cde21..523c98b96cb4 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -165,6 +165,8 @@ static inline __rpmsg64 cpu_to_rpmsg64(struct rpmsg_device *rpdev, u64 val)
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override);
 int rpmsg_register_device(struct rpmsg_device *rpdev);
 int rpmsg_unregister_device(struct device *parent,
 			    struct rpmsg_channel_info *chinfo);
@@ -192,6 +194,12 @@ ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
 
 #else
 
+static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+						 const char *driver_override)
+{
+	return -ENXIO;
+}
+
 static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
 {
 	return -ENXIO;
-- 
2.32.0

