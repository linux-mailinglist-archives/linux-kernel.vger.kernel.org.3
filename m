Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD34FEB90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiDLXZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiDLXY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:24:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02E718E05
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:44:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ec06f77db8so2787857b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vu+tbewZC1L8tNZcdnISH4xxfmEZ4vDTSNrfXZHLvPE=;
        b=A+K8pYUBsHgL6smGFqlwdaGolyd1WSaLs2CJu781D2KugJNhkIcxatZ/BkJUcRGwsD
         BmMWeCu8OCCkYzco2VjqflXFLm4AzUcmyxBs8n0TaTIOMdjnESI5O2EicQhFPqdp0NN7
         fNiyrKG7UB9dFuczLb0Wysld+4bWa7aodWBsavyrCBP88t2S53hrfnrN7MzPLGFKXvHr
         /YhN1rKHnO9BC7DT3iaP6/lwbF2qGlgqPA2iURWyhzsLr3eeV+hiMP26g5hWkgmt/66H
         sKWrEKFx8HcrbShKcF+wKv41p4dD63z1a0Mbz7JP0apEU6pOYr5sI9IPmD2PxHm6FdIA
         oUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vu+tbewZC1L8tNZcdnISH4xxfmEZ4vDTSNrfXZHLvPE=;
        b=OISqykdTWiwOJVHAiSz9iOtWTBC1hl3lEmM37mP2vksSMY4Idfcm/r2DZwH4TCLAp2
         DFsEOPYAAJY5LmIWngk9PyzvbxtRURIaOw7MJFjd+uglZCbXOhZj1cZydAopOb1H65m5
         ZTAGlyzwwv4gZPBrZRN83EZXTVIXw6SBYbHzLl4LOI87kMh54bo4PTn75xf2dvJ4C4bp
         T+D6TIe9/Zl0JMatXqCLm6d4r62xXxWzHIveExDWFZlsnlTWk/Prkb0iVx/a1r29ba1+
         tNGRBBDE5S3/gssLjMEboM6tq0hl7P2TTlKgMb1XpLh5QkzRqwAmTDKTigPtN46R4DYW
         vMLg==
X-Gm-Message-State: AOAM533/AcH8wXum2YTPEVadomMtvN1sYEGEnxDUNxA9imBzn6eI3WK/
        FPwN2FpUl2yl/npudO9BS+VblcpB4+zL/hM=
X-Google-Smtp-Source: ABdhPJwYB6gmE/AnTTYvT4XgOL27Ob0XRx2o/4au0mtEC42h0VLwXwN0PWba0iF+eWL2UPJd2GUmprS1JHEoLq4=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:8573:aa64:c3e8:ebc])
 (user=tansuresh job=sendgmr) by 2002:a81:1e42:0:b0:2ec:3343:6b3e with SMTP id
 e63-20020a811e42000000b002ec33436b3emr9165499ywe.171.1649803441033; Tue, 12
 Apr 2022 15:44:01 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:43:46 -0700
In-Reply-To: <20220412224348.1038613-1-tansuresh@google.com>
Message-Id: <20220412224348.1038613-2-tansuresh@google.com>
Mime-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
From:   Tanjore Suresh <tansuresh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
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

This changes the bus driver interface with additional entry points
to enable devices to implement asynchronous shutdown. The existing
synchronous interface to shutdown is unmodified and retained for
backward compatibility.

This changes the common device shutdown code to enable devices to
participate in asynchronous shutdown implementation.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h | 12 ++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..ba267ae70a22 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(async_shutdown_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4523,7 +4524,13 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
+		if (dev->bus && dev->bus->async_shutdown_start) {
+			if (initcall_debug)
+				dev_info(dev, "async_shutdown_start\n");
+			dev->bus->async_shutdown_start(dev);
+			list_add_tail(&dev->kobj.entry,
+				&async_shutdown_list);
+		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
@@ -4543,6 +4550,35 @@ void device_shutdown(void)
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
+		if (dev->bus && dev->bus->async_shutdown_end) {
+			if (initcall_debug)
+				dev_info(dev,
+				"async_shutdown_end called\n");
+			dev->bus->async_shutdown_end(dev);
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
index a039ab809753..f582c9d21515 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -49,6 +49,16 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @async_shutdown_start:	Called at the shutdown-time to start
+ *				the shutdown process on the device.
+ *				This entry point will be called only
+ *				when the bus driver has indicated it would
+ *				like to participate in asynchronous shutdown
+ *				completion.
+ * @async_shutdown_end:	Called at shutdown-time  to complete the shutdown
+ *			process of the device. This entry point will be called
+ *			only when the bus drive has indicated it would like to
+ *			participate in the asynchronous shutdown completion.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -93,6 +103,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*async_shutdown_start)(struct device *dev);
+	void (*async_shutdown_end)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.36.0.rc0.470.gd361397f0d-goog

