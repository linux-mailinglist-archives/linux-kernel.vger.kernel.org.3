Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058B4B3756
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiBLSWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:22:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiBLSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:22:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808C5E152
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y9so10864889pjf.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g49+wFi0+L2EFX9slEZO36BXMBmO9BAHKtkIF7AjIc4=;
        b=Qaj0Oks+qpWWnbjrfPIrbHozo3YeLmLdIG/TvZbU5V6dTbOje+t2Np1msaSIll/jGZ
         fRn3bd46oK30vNMMF+3mmzFg9Mi6CgjKNyQIyKYruUjJXJdl/qLwxHdxZli4GArgp/O/
         eYLnTc4kBSIGs6PxY6IMH5VXSV+6AAXKTnzF/pid6ZTfk+lVeYCgv77UFucBnnLgoXrb
         8e1hGrMPM81vZ5MBQGXLPn3ql+ub/Y9HZiUN4Um7iWlpphmp4yjmGEu4kuGj1VT1WhPq
         AjnRbF1rJgyhuN+n7ibTQZ3AGqW62jAQ988nKYUuMpm2yHII2SkntIPjZ4S23eazPB+0
         HoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g49+wFi0+L2EFX9slEZO36BXMBmO9BAHKtkIF7AjIc4=;
        b=1L13VDcYBJGH5QKMH9JN5o3ltnCP+FGmSohi64r3t88MV9m7anF3Tru1a062KwVo0e
         boBF2Z2icwKeoV+pkTnw15o23jchWsuKZhr3DXA8ZwsC89tkVNLVSaoIiduD/X1Phj1h
         D3ENaAMuq4LirgCneZlGGr0Na2jvexK0bk0rXK7zlrDIC4f02jjZp0IiSJxD1XeW+blE
         HgWlxgwuxlqqpGbBQe9dG6llL/NQyy5/6TTaDI/cpuBzJir/8r00FKMU9ONRM3K/UP3M
         Azq9i9fHZE5cb7MkpnykwY2Nj56FN7l2UL1fBB63lyWCcluxCzWIg20kLcqrqI4lhBdj
         +p7g==
X-Gm-Message-State: AOAM5329ibYsLIDMqnv95KKNgzPWlCdexwRDklYYdRlrB7nQRy3T56ZA
        RUy64wgPcAjVQ8UhFEcR7Igc
X-Google-Smtp-Source: ABdhPJwcmUlXO8ifxo1TZGZofZ1qRsSxT5ttiDr7LbbIKnn76r/wYRjgD2Q7FbM7DaU+VwrkvIGPWg==
X-Received: by 2002:a17:902:d486:: with SMTP id c6mr6965799plg.141.1644690147753;
        Sat, 12 Feb 2022 10:22:27 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:22:27 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 09/25] bus: mhi: ep: Add support for registering MHI endpoint client drivers
Date:   Sat, 12 Feb 2022 23:51:01 +0530
Message-Id: <20220212182117.49438-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
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
 drivers/bus/mhi/ep/main.c | 86 +++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    | 53 ++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b006011d025d..f66404181972 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -196,9 +196,89 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
 
+static int mhi_ep_driver_probe(struct device *dev)
+{
+	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
+	struct mhi_ep_chan *ul_chan = mhi_dev->ul_chan;
+	struct mhi_ep_chan *dl_chan = mhi_dev->dl_chan;
+
+	/* Client drivers should have callbacks for both channels */
+	if (!mhi_drv->ul_xfer_cb || !mhi_drv->dl_xfer_cb)
+		return -EINVAL;
+
+	ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
+	dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
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
@@ -207,6 +287,12 @@ static int mhi_ep_match(struct device *dev, struct device_driver *drv)
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

