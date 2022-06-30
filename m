Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10256234D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiF3Tfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiF3Tfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:35:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E78D43EC0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:35:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m2so283882plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPqBYBlLTOMK1qOOrCVZV8mMsTTnAaW6SeEmmR24dkw=;
        b=JgU/8dDdLh39FOHDtB4AmUWjf7ovmaGZuK/G8C1PG/C/tYs735zbQK0N/MnZlnSPLB
         ZLK10V1TD8tvUZXXl9Ko8jDPOCz8/3m124YGDC9/2FXlcTKGUbo6f+Rex7iF+7A195kQ
         rJ6uJKAq9QbVm/Vk4hmgV2uKn+MTr34Wk+ZPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPqBYBlLTOMK1qOOrCVZV8mMsTTnAaW6SeEmmR24dkw=;
        b=aW4h4NWHPSS79jdgsofQL6VCv7b9wpd/xNeh9kY0jGcH8r6qCVrdnVMTLkQYf7L/e2
         +FYLlJm67PijneotKhUK5zLSt79/aEu0zz6h4UnjKDlZBaKr3CkhU2+63ylGURgPNiQV
         MrHMw71DRHZxmcPEj+h0qMn++elxdHRWoWe57atr68tKL4D1DUKC1EHrft2WQBWCZffz
         M75KCWCG7NUL+pTI4I+qdOFK+BrneQpZls1o6P+u9+LklJwIMlEU44JHLUhyDcsDUTUE
         OGKfwAs1Sog3T2fiDebN/MtlNCXBmNtmKR8kj05pr8E5pSfE7T9Ul96K1ddS0UAcQ99N
         xDig==
X-Gm-Message-State: AJIora+SRsk5a0lCiHmmRrzRcP753ZhTdtGLO/SgdI4Pb5QMH9N20lI1
        YtWTB4q5NY0ff5fKSA/1DH+bZg==
X-Google-Smtp-Source: AGRyM1vKEnFsSb/7xvOUe8N53dVQYfzaU0mqetLQxEbvbMl83VqlJ3+QnERF74meQu8+e3UuCc1hrw==
X-Received: by 2002:a17:902:c950:b0:16b:8ec7:b34 with SMTP id i16-20020a170902c95000b0016b8ec70b34mr16017029pla.143.1656617741784;
        Thu, 30 Jun 2022 12:35:41 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:9fbf:277c:23e1:eabb])
        by smtp.gmail.com with UTF8SMTPSA id be19-20020a056a001f1300b005254c71df0esm13732068pfb.86.2022.06.30.12.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:35:41 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v24 4/4] usb: core: hub: Create platform devices for onboard hubs in hub_probe()
Date:   Thu, 30 Jun 2022 12:35:30 -0700
Message-Id: <20220630123445.v24.4.Ic9dd36078f9d803de82ca01a6700c58b8e4de27e@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220630193530.2608178-1-mka@chromium.org>
References: <20220630193530.2608178-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call onboard_hub_create/destroy_pdevs() from hub_probe/disconnect()
to create/destroy platform devices for onboard USB hubs that may be
connected to the hub. The onboard hubs must have nodes in the
device tree.

onboard_hub_create/destroy_pdevs() are NOPs unless
CONFIG_USB_ONBOARD_HUB=y/m.

Also add a field to struct usb_hub to keep track of the onboard hub
platform devices that are owned by the hub.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v24:
- none

Changes in v23:
- added Doug's 'Reviewed-by' tag

Changes in v22:
- patch added to the series (moved creation/deletion from HCD)

 drivers/usb/core/hub.c | 9 ++++++++-
 drivers/usb/core/hub.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 68e9121c1878..8055130ee602 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -23,6 +23,7 @@
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/onboard_hub.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/quirks.h>
 #include <linux/workqueue.h>
@@ -1752,6 +1753,8 @@ static void hub_disconnect(struct usb_interface *intf)
 	if (hub->quirk_disable_autosuspend)
 		usb_autopm_put_interface(intf);
 
+	onboard_hub_destroy_pdevs(&hub->onboard_hub_devs);
+
 	kref_put(&hub->kref, hub_release);
 }
 
@@ -1869,6 +1872,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	INIT_LIST_HEAD(&hub->onboard_hub_devs);
 	spin_lock_init(&hub->irq_urb_lock);
 	timer_setup(&hub->irq_urb_retry, hub_retry_irq_urb, 0);
 	usb_get_intf(intf);
@@ -1889,8 +1893,11 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		usb_autopm_get_interface_no_resume(intf);
 	}
 
-	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0)
+	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
+		onboard_hub_create_pdevs(hdev, &hub->onboard_hub_devs);
+
 		return 0;
+	}
 
 	hub_disconnect(intf);
 	return -ENODEV;
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 22ea1f4f2d66..ccf90052d12a 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -73,6 +73,7 @@ struct usb_hub {
 	spinlock_t		irq_urb_lock;
 	struct timer_list	irq_urb_retry;
 	struct usb_port		**ports;
+	struct list_head        onboard_hub_devs;
 };
 
 /**
-- 
2.37.0.rc0.161.g10f37bed90-goog

