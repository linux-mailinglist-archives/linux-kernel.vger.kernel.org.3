Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296BC4AEEEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiBIKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiBIKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:06:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF8EE0F9D92
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:06:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso3531143pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2zAynmnJ2vluM0NT51EBhK/dYC4nsi3jGuGUKuxzwGM=;
        b=UHrKTDJRIpX3t+5tLMwEKH3f+3hrEl7CrvVtX23Y9yJwSQ8nKVkasY2n1lavFgcEsO
         2FkGjWI00xmwP2ns+eLGDVBmaMCWBIEQwNhYVtlF2k1SNvLqV/72Esp2xK6atrdTaFz2
         wDIwQgcCV0jd09QWxlHqBKqY4Q9hvWC6U6Xc8olojMoBbVzf51nrK5x/jqagsRFbaMo3
         IqBG6t+sz9cCDQrs3+1gdgmLpF4Hl6jsSbLnSrgGEVsAWzPw/FvD0920Mvy9DNZzbKXN
         zrRUetvzm/CP/N1Jqi5WpRtalUWuCufntb1oPGl/Ri45X5VCcRZAnJUEm+dYwvssFuVz
         J46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zAynmnJ2vluM0NT51EBhK/dYC4nsi3jGuGUKuxzwGM=;
        b=3CYQCPxe1femYDbN56rWBd4XjqAEc+tl1cuC+GfLKS6MH8GzMmFpC5FPJre7Vbbq1G
         KlzqgOsqOQmRnVSlgjzfOPJbcbrmyhwK54lChSWa/FZdP0r6t6pVJ0mcL9lkY24N2udU
         VVQM5OA45YtEOrJoPJwemRPainu167ZyxmlWIEzkLSYl/lCrDvfZW20a2n74e50011lJ
         NEAUn6+UDMonb4fdYuZyUCk0M/slEax2sp3C0uqnqzAOxIMy6nOq3m7GsaD0bkFRvj8x
         EqGRPJz8UtzmsYOqCgZKPfmBLzXkjN9QuOPq4W4qzcpFidKPFSgy6UUAJ6FAKkLj1WuV
         YAtg==
X-Gm-Message-State: AOAM531i7FzMi54C1eu6jMoqoSHaxwjutbc9x/8NPg+r7oIZy50wfpwe
        oUY68QT58lwnrl34YW8WHhED
X-Google-Smtp-Source: ABdhPJwa4doH8/c+JzkmI2FWFULjkY9vcSsnNgFPDIOUsz0QP+QoZeF2HOKz53H+Qz5eGEVmg9vOyg==
X-Received: by 2002:a17:90a:5295:: with SMTP id w21mr2619771pjh.84.1644401161321;
        Wed, 09 Feb 2022 02:06:01 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/23] bus: mhi: ep: Add support for registering MHI endpoint client drivers
Date:   Wed,  9 Feb 2022 15:26:10 +0530
Message-Id: <20220209095624.26389-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for registering MHI endpoint client drivers
with the MHI endpoint stack. MHI endpoint client drivers binds to one
or more MHI endpoint devices inorder to send and receive the upper-layer
protocol packets like IP packets, modem control messages, and diagnostics
messages over MHI bus.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 88 +++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    | 53 +++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b006011d025d..de7d52d15da4 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -196,9 +196,91 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
 
+static int mhi_ep_driver_probe(struct device *dev)
+{
+	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
+	struct mhi_ep_chan *ul_chan = mhi_dev->ul_chan;
+	struct mhi_ep_chan *dl_chan = mhi_dev->dl_chan;
+
+	if (!ul_chan && !dl_chan)
+		return -ENODEV;
+
+	if (ul_chan)
+		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
+
+	if (dl_chan)
+		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
+
+	return mhi_drv->probe(mhi_dev, mhi_dev->id);
+}
+
+static int mhi_ep_driver_remove(struct device *dev)
+{
+	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
+	struct mhi_result result = {};
+	struct mhi_ep_chan *mhi_chan;
+	int dir;
+
+	/* Skip if it is a controller device */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	/* Disconnect the channels associated with the driver */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		mutex_lock(&mhi_chan->lock);
+		/* Send channel disconnect status to the client driver */
+		if (mhi_chan->xfer_cb) {
+			result.transaction_status = -ENOTCONN;
+			result.bytes_xferd = 0;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
+
+		/* Set channel state to DISABLED */
+		mhi_chan->state = MHI_CH_STATE_DISABLED;
+		mhi_chan->xfer_cb = NULL;
+		mutex_unlock(&mhi_chan->lock);
+	}
+
+	/* Remove the client driver now */
+	mhi_drv->remove(mhi_dev);
+
+	return 0;
+}
+
+int __mhi_ep_driver_register(struct mhi_ep_driver *mhi_drv, struct module *owner)
+{
+	struct device_driver *driver = &mhi_drv->driver;
+
+	if (!mhi_drv->probe || !mhi_drv->remove)
+		return -EINVAL;
+
+	driver->bus = &mhi_ep_bus_type;
+	driver->owner = owner;
+	driver->probe = mhi_ep_driver_probe;
+	driver->remove = mhi_ep_driver_remove;
+
+	return driver_register(driver);
+}
+EXPORT_SYMBOL_GPL(__mhi_ep_driver_register);
+
+void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv)
+{
+	driver_unregister(&mhi_drv->driver);
+}
+EXPORT_SYMBOL_GPL(mhi_ep_driver_unregister);
+
 static int mhi_ep_match(struct device *dev, struct device_driver *drv)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(drv);
+	const struct mhi_device_id *id;
 
 	/*
 	 * If the device is a controller type then there is no client driver
@@ -207,6 +289,12 @@ static int mhi_ep_match(struct device *dev, struct device_driver *drv)
 	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
 		return 0;
 
+	for (id = mhi_drv->id_table; id->chan[0]; id++)
+		if (!strcmp(mhi_dev->name, id->chan)) {
+			mhi_dev->id = id;
+			return 1;
+		}
+
 	return 0;
 };
 
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 20238e9df1b3..da865f9d3646 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -122,7 +122,60 @@ struct mhi_ep_device {
 	enum mhi_device_type dev_type;
 };
 
+/**
+ * struct mhi_ep_driver - Structure representing a MHI Endpoint client driver
+ * @id_table: Pointer to MHI Endpoint device ID table
+ * @driver: Device driver model driver
+ * @probe: CB function for client driver probe function
+ * @remove: CB function for client driver remove function
+ * @ul_xfer_cb: CB function for UL data transfer
+ * @dl_xfer_cb: CB function for DL data transfer
+ */
+struct mhi_ep_driver {
+	const struct mhi_device_id *id_table;
+	struct device_driver driver;
+	int (*probe)(struct mhi_ep_device *mhi_ep,
+		     const struct mhi_device_id *id);
+	void (*remove)(struct mhi_ep_device *mhi_ep);
+	void (*ul_xfer_cb)(struct mhi_ep_device *mhi_dev,
+			   struct mhi_result *result);
+	void (*dl_xfer_cb)(struct mhi_ep_device *mhi_dev,
+			   struct mhi_result *result);
+};
+
 #define to_mhi_ep_device(dev) container_of(dev, struct mhi_ep_device, dev)
+#define to_mhi_ep_driver(drv) container_of(drv, struct mhi_ep_driver, driver)
+
+/*
+ * module_mhi_ep_driver() - Helper macro for drivers that don't do
+ * anything special other than using default mhi_ep_driver_register() and
+ * mhi_ep_driver_unregister().  This eliminates a lot of boilerplate.
+ * Each module may only use this macro once.
+ */
+#define module_mhi_ep_driver(mhi_drv) \
+	module_driver(mhi_drv, mhi_ep_driver_register, \
+		      mhi_ep_driver_unregister)
+
+/*
+ * Macro to avoid include chaining to get THIS_MODULE
+ */
+#define mhi_ep_driver_register(mhi_drv) \
+	__mhi_ep_driver_register(mhi_drv, THIS_MODULE)
+
+/**
+ * __mhi_ep_driver_register - Register a driver with MHI Endpoint bus
+ * @mhi_drv: Driver to be associated with the device
+ * @owner: The module owner
+ *
+ * Return: 0 if driver registrations succeeds, a negative error code otherwise.
+ */
+int __mhi_ep_driver_register(struct mhi_ep_driver *mhi_drv, struct module *owner);
+
+/**
+ * mhi_ep_driver_unregister - Unregister a driver from MHI Endpoint bus
+ * @mhi_drv: Driver associated with the device
+ */
+void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv);
 
 /**
  * mhi_ep_register_controller - Register MHI Endpoint controller
-- 
2.25.1

