Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5B4EA364
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiC1XCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiC1XCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:02:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04A424F01
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:00:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j133-20020a25d28b000000b006337bb01016so11904077ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HE+KJmElkBiRdLqH+GjHP+Rl3V6ftUnhFGl2WadF25Q=;
        b=MWRcatLqV8jhdG9ohWm7mM4E3R/YbC1/FIFzwNDD6TlY6EYMe/xuHPFJHuooAj3aXf
         4fJnfu9sk+tQmJn/OsEvJ644ufB1KJUyOS57p1Kr1FoZ2LkMV+NcO2Tn61yRVx0vSZ02
         As2kMTmHM3+2vcZPWir+uiPFUfpWiidfUOVa+5s0fN+X+T9z4gpHxuLcE4GCGTO2yUBG
         E/YhxqmsZ3PfScXtfw7d4xHeWcdVdSlZuDFK0jHSsZq/Rn8vo+L4KVzXyuxl9W3E33RA
         Tfd62IaObJUTQy+NaMZBs9PavgPC+FdcHfKDuvN8hcAamVIJRXhLmFfvIuDTIza+ZbO7
         XpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HE+KJmElkBiRdLqH+GjHP+Rl3V6ftUnhFGl2WadF25Q=;
        b=whV+3eW2RdauBbtJaGVOV6kWh5+ozCKJHT3AAow/KClasjbCvyZdHvj/7S9fa865q3
         +IftEkpsVLlE/q1ttM2HzJpT7MHxulTr+nT2YgIF4L29hC8+r3kzQyOZ0ejOZ7QryR83
         oOawnsPgh/nKdy95aIzzSV3molDnIaxwgXpStSqTA4ZsHHqbGBGikMG53eAmsjf4iU6c
         MONwvg0NpB2cg1rveW8SKrPjU2HJNKrn9SKuhtTbqrLmomtySk8tG4oF+F0m8bHZ6D0v
         4L4iFn5n0kPPaOmXMAXuxV4Z0rbvtol73CgCBGPQ82BZPdmfnfYj+1uo++UsiWELxx/b
         reRg==
X-Gm-Message-State: AOAM530tdS00o65PSTWwzj65SU86k0wNw4Uqcv3v7pjLRV9HymvRUO0e
        GdFmgsk8AFNqsms8L1OxUfDQorDam3r+Ry0=
X-Google-Smtp-Source: ABdhPJyJLGwD6p/MqUDfw8nEh0DJ9s5L0oPyAGDvmxNwqd6Cp0ER8bUrxaaN8M+8r2L4xk3m5KFU7Ql3rq3c7tw=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:3dbb:6bbc:98be:a31e])
 (user=tansuresh job=sendgmr) by 2002:a81:4ed6:0:b0:2e6:aee7:6b7a with SMTP id
 c205-20020a814ed6000000b002e6aee76b7amr28282562ywb.399.1648508418228; Mon, 28
 Mar 2022 16:00:18 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:00:06 -0700
In-Reply-To: <20220328230008.3587975-1-tansuresh@google.com>
Message-Id: <20220328230008.3587975-2-tansuresh@google.com>
Mime-Version: 1.0
References: <20220328230008.3587975-1-tansuresh@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
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

