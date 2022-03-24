Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2CB4E6A48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354194AbiCXVgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiCXVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:36:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB9CB6E52
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:34:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e8216c4c46so752867b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jusV/5N4+sovcuqiFtBzuhPIr5GA/l7jX0Honm9Enzk=;
        b=kvUK4bTW6Fq4tVzO/nttC5QBuDK1IGmGGg01y8QxxMlV6V5vrj02A/ll7iGIoD5eMc
         xsdKCZT637Lnp4WOzHddhsWCM2re1GyQ+xqYU1NAullxKO/0zlHS5sAUzN4O0n1VNtfV
         1SSwRucmU7zDbU0XccjP/xVPl7syV3bfi0w4PH6MZPxCARKiWbv4c55xw7LjgKA/tIuq
         Q8V+PvX3HEDtjyMFQn/fbJENVloiMGYSx//m7TV9TRDw9NVTfyUlcAWSo0WNyCnlNPXU
         zXgzEcyk9bs8g8wwxeWEAppouI6z+OAJU6cw1nXOxpg+asB+Xs5F+DzaxmQaY9kjwHQu
         YRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jusV/5N4+sovcuqiFtBzuhPIr5GA/l7jX0Honm9Enzk=;
        b=y4QT1On9B7weqZtc2Cjcgf0szgZ8+bBF2GpMGMqBKv+XgSjlAsQVwU0ki50ZDCV8gK
         D16xqP1wq762wPk1PXjNWnAd4hxwnhsy6aOv+fpNS02bWmu6n4wWM2j8CRJZpoJ2yb07
         A7e9dCC27yJjiTXeax7uwSYYulK2FOl7GNNcTKpLRpdA6EZr6R2WFTLRUbMhyqv1e8Cd
         16a+p8WnXtw258lK0yoVT5ApVtpExtaqMCMDEN9Fz9iQaGWMO4ByIdHtwXZHCOlp8FC4
         YmNYUN7drmdpT9qxxpTa0E6Ize2S+olGNgw8cfWOcj/MxuaGn6773lijy94Ze0OlAkOa
         8Usg==
X-Gm-Message-State: AOAM532zPF3DvncY7cYZm7UoXo3NTUiRLOlo/nX8OMP9HHibaLsqU3Lj
        dFxUOg7SsxXDrZa+esaCxxURqAxh24u8QY8=
X-Google-Smtp-Source: ABdhPJwIOqbGMGMJ9dGB5cHZO4LvwMMaV40YiMrt44Iqi33gGnzw+M+LvFuG0wZ8hCsrLILLv2IjQ4eWMf1BwKw=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:849f:5cb9:7db8:508a])
 (user=tansuresh job=sendgmr) by 2002:a25:5f11:0:b0:633:ee0c:ab79 with SMTP id
 t17-20020a255f11000000b00633ee0cab79mr6344457ybb.491.1648157697039; Thu, 24
 Mar 2022 14:34:57 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:34:45 -0700
Message-Id: <20220324213445.3055538-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 1/3] driver core: Support asynchronous driver shutdown
From:   Tanjore Suresh <tansuresh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the bus driver interface to take in a flag to indicate
whether a bus and associated devices are willing to participate in
the asynchronous shutdown. If this flag is not set bus driver
implementation will follow synchronous shutdown semantics.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h | 10 ++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..359e7067e8b8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(async_shutdown_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4523,7 +4524,14 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
+
+		if (dev->bus && dev->bus->shutdown_pre) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown_pre\n");
+			dev->bus->shutdown_pre(dev);
+			list_add(&dev->kobj.entry,
+				&async_shutdown_list);
+		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
@@ -4543,6 +4551,35 @@ void device_shutdown(void)
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+
+	/*
+	 * Second pass spin for only devices, that have configured
+	 * Asynchronous shutdown.
+	 */
+	while (!list_empty(&async_shutdown_list)) {
+		dev = list_entry(async_shutdown_list.next, struct device,
+				kobj.entry);
+		parent = get_device(dev->parent);
+		get_device(dev);
+		/*
+		 * Make sure the device is off the  list
+		 */
+		list_del_init(&dev->kobj.entry);
+		if (parent)
+			device_lock(parent);
+		device_lock(dev);
+		if (dev->bus && dev->bus->shutdown_post) {
+			if (initcall_debug)
+				dev_info(dev,
+				"shutdown_post called\n");
+			dev->bus->shutdown_post(dev);
+		}
+		device_unlock(dev);
+		if (parent)
+			device_unlock(parent);
+		put_device(dev);
+		put_device(parent);
+	}
 }
 
 /*
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index a039ab809753..e261819601e9 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -49,6 +49,14 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @shutdown_pre:	Called at the shutdown-time to start the shutdown
+ *			process on the device. This entry point will be called
+ *			only when the bus driver has indicated it would like
+ *			to participate in asynchronous shutdown completion.
+ * @shutdown_post:	Called at shutdown-time  to complete the shutdown
+ *			process of the device. This entry point will be called
+ *			only when the bus drive has indicated it would like to
+ *			participate in the asynchronous shutdown completion.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -93,6 +101,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*shutdown_pre)(struct device *dev);
+	void (*shutdown_post)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.35.1.1021.g381101b075-goog

