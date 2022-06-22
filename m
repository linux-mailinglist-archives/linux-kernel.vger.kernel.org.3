Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D5556DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiFVVtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiFVVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:49:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E6F3F311
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:49:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e63so15792358pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olYSuR+MOT/ZUshrAp0iattV7CM2ZVM+skfjPn8b2+M=;
        b=UnJpR89QPDuNyRWadElkPWzCatOXAwynUc93UHxb9Fi0VzMdM3en9b4XTodA5dGyeT
         4tktG4+GjSXcpwD9Vo43kMST8RfosfyTZVjpGrxxYDUQ/WIowNwejdM5jgrYQIwvPenb
         UVeST971UNxKkc/KeKIvcKQABx25nQngF5qNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olYSuR+MOT/ZUshrAp0iattV7CM2ZVM+skfjPn8b2+M=;
        b=mU4Q5AUG0D+z38U+PZgOgkh5xetpGoST175DoHQUwLJ8YpCqH9litiM3JfyPUG1opn
         riwTDEOMFglBidFtwGmU9vSc1Vf0ikTYR1j5IiJjbtFvcpduLZBAJnocOAHWVSawitbh
         80SnDORFBi6A8DzHde/5w7IvRZ5FMUUqd4BkM+icaaqr3+j4vqnblok6Yphni/GBBig+
         O5GFjT7QRtiRZYGXHEMvyrzqoK+JwKK5AwQXOAkzx0XbbgVjSx/icrl3hdl5N6liE2sq
         Z+3oBlOWuSRj7Uu/6gBv3Wtg3bkr6ZlTT3ucH1hxLp4hdFjR67MgRTQmF6g8YNbWuVM9
         Y5hQ==
X-Gm-Message-State: AJIora8cOX5H3bjlxXI7Rnp3squKMqTXlCVKyjRAt76uLgU6NyCc2qn9
        cwP/WoUt52ZCDLg8lben7je65w==
X-Google-Smtp-Source: AGRyM1u+5AjOJN51vnRt1dWDCPqyeU1pNqV6ZCu8LdPzElt9SvXUD3brWs5Kvslmp01edq8gY97Ftw==
X-Received: by 2002:a05:6a00:2995:b0:525:398b:8585 with SMTP id cj21-20020a056a00299500b00525398b8585mr9469348pfb.7.1655934583325;
        Wed, 22 Jun 2022 14:49:43 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:83c:92dc:a659:2900])
        by smtp.gmail.com with UTF8SMTPSA id bd15-20020a056a00278f00b0050dc7628182sm14068297pfb.92.2022.06.22.14.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:49:43 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v23 3/3] usb: core: hub: Create platform devices for onboard hubs in hub_probe()
Date:   Wed, 22 Jun 2022 14:49:31 -0700
Message-Id: <20220622144857.v23.3.Ic9dd36078f9d803de82ca01a6700c58b8e4de27e@changeid>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622214931.1914770-1-mka@chromium.org>
References: <20220622214931.1914770-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.0.rc0.104.g0611611a94-goog

