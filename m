Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3E595835
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiHPK3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiHPK2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:28:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4623AB08
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o18-20020a17090aac1200b001f3252af009so9460334pjq.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=bB93z6epEEktgqWPKqCS2yAkD9gaQQnHEzx7X0wo89k=;
        b=LBUekVZbKwjYB6iREXgnr6/dM7aUHkeeUVgIKavekxJRHMpaR5GmbH36Wo7f35PhMr
         qFed3KzKfZEhK6wbXZCuUJg0wj88/OsxPnGsu7Mx+2hcwgoKib/YEaqtlEdOJRIXaQ6N
         ujLmjUERqv4Xqmb0I3ospKzIO6NkBRgvK1ufjI/hB9DWc3yFWOKtGv1lGx7R2QFL7xmT
         hwx9srMqjWHG4F+T+cXDyL6WffHLHty/vt9nTIa/c7DQuVGJsXphgdSSK5ebrBEIB9Ve
         FCnGXHkRgYzC8TNkBtKXABrWNZYQE69QH2JUsIBGNuav6Ow3IKnI7JLSCIPZSgmNi9e5
         FtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=bB93z6epEEktgqWPKqCS2yAkD9gaQQnHEzx7X0wo89k=;
        b=tc53xyFDL/92lrRDA8RovYj8KadDzceAf1v06XWfFttuOk8y7namNzsPKXtB4dQbhu
         WDy1bcmXiDWJ95nKjB2Mx0EHNkxlT5qK+FU5KL+rlefkfkHZxFS3GSjL7lo8iy+y82LZ
         hkkly5DfMLwGVlyRsZX0Av+KyF164BEJBidDct4JvynRQth+h4HFAlQTA6aSoUtK8JYn
         c9zNleZrU6pAWkK3F3Zy2TzZfMX6PBRQpGdotpUQa9VUXH9FwFx9/aEtLER9hNBU2uEU
         3Tc86vn4VzIClmajXW9fvvKvDh9sLEWM1R8LVrvigcfMFmNu4dpZyZX7pTe1i9AMW7+T
         hKOg==
X-Gm-Message-State: ACgBeo1oOSOQvxhSZHpZaAU2Ye/tVjrGKmj3k+ZN/KFs80eF+Z6JdgTl
        sXVgWFHdz+qobYjQ2LtHDMvWoUwl2NY=
X-Google-Smtp-Source: AA6agR54uF8KKRbV8DX/kPh89GDgFvO2Xmrnjc3ibq1RSfDiZt18v2MUXc+jMD8Q35DJXDMBoxLKFfJ0VuM=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:5bfb:2ce6:1e1b:f496])
 (user=raychi job=sendgmr) by 2002:a05:6a00:10ca:b0:4f7:5af4:47b6 with SMTP id
 d10-20020a056a0010ca00b004f75af447b6mr20152772pfu.6.1660639152696; Tue, 16
 Aug 2022 01:39:12 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:38:54 +0800
In-Reply-To: <20220816083854.1491886-1-raychi@google.com>
Message-Id: <20220816083854.1491886-3-raychi@google.com>
Mime-Version: 1.0
References: <20220816083854.1491886-1-raychi@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH 2/2] usb: xhci: add check_init_status hook support
From:   Ray Chi <raychi@google.com>
To:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        stern@rowland.harvard.edu
Cc:     badhri@google.com, albertccwang@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Chi <raychi@google.com>
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

In general, xHCI didn't do anything for port initialization. However,
there are some requirement or limitation on various platforms, so
vendors need to do some error handlings if the device connected to a
broken USB accessory.

This patch also add the hook to xhci_driver_overrides so that vendors
can add their specific protection easily if needed.

Signed-off-by: Ray Chi <raychi@google.com>
---
 drivers/usb/host/xhci.c | 17 +++++++++++++++++
 drivers/usb/host/xhci.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 65858f607437..f237af9d6e2e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4358,6 +4358,20 @@ static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
 }
 
+/*
+ * The function could get the status of port initialization.
+ */
+static int xhci_check_init_status(struct usb_hcd *hcd, struct usb_device *udev, int r)
+{
+	/*
+	 * In general, this function is not necessory. Some platforms may
+	 * need doing error handling when the port initialization takes a
+	 * long time to do. The device can use the override callback to
+	 * do specific handlings.
+	 */
+	return 0;
+}
+
 /*
  * Transfer the port index into real index in the HW port status
  * registers. Caculate offset between the port's PORTSC register
@@ -5455,6 +5469,7 @@ static const struct hc_driver xhci_hc_driver = {
 	.enable_device =	xhci_enable_device,
 	.update_hub_device =	xhci_update_hub_device,
 	.reset_device =		xhci_discover_or_reset_device,
+	.check_init_status =	xhci_check_init_status,
 
 	/*
 	 * scheduling support
@@ -5503,6 +5518,8 @@ void xhci_init_driver(struct hc_driver *drv,
 			drv->check_bandwidth = over->check_bandwidth;
 		if (over->reset_bandwidth)
 			drv->reset_bandwidth = over->reset_bandwidth;
+		if (over->check_init_status)
+			drv->check_init_status = over->check_init_status;
 	}
 }
 EXPORT_SYMBOL_GPL(xhci_init_driver);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1960b47acfb2..33ce873236e9 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1944,6 +1944,7 @@ struct xhci_driver_overrides {
 			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
+	int (*check_init_status)(struct usb_hcd *hcd, struct usb_device *udev, int r);
 };
 
 #define	XHCI_CFC_DELAY		10
-- 
2.37.1.595.g718a3a8f04-goog

