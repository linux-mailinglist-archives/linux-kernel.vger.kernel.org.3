Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35E55454CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbiFITUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbiFITUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:20:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9CF31D9F8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:20:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s135so7076759pgs.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8b7P05WgRuIYwqPhhzNq/VzjM3rtntdxY9lSXK6ydQ=;
        b=ac/Uas5+3Wu1KKE3kuEy/kAt6ITRkEoQ7yC/2qNp1WtI3Xfacs5gpUdOdW++EOWreo
         EM9+G2xBm4jmIgEHaDf6sRrw+JYRKxW10sib3Wc8Kwkng6dqaMovAx6OKIJG7uFNhuZU
         NIgNJxspOjlO3Y7HiMNdGAJTZLAcDLpYiqtk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8b7P05WgRuIYwqPhhzNq/VzjM3rtntdxY9lSXK6ydQ=;
        b=5A5MKXcqZLGJkGTm/cHyo/GOU22C2BL94MrKbGGya/kvo7a148LOOVZ+9dG83RadRv
         zsKT6sbidFShd306/HS69n2M8icuKmec/SJLEX/nK+y+w0Pk9qrRCfNq3H/dFtQnwJdu
         8O0sbbtHw7feh35tdl4RXqxNkGR9oTlP/5rr4lRQf+COsniB/m79SGE8xv0cWEkeLoou
         OEUNpKoSMXONJzf8x51VaaqbDof8JRGz+L4CSb8H5E9PBb5tDcqhf5sWc4D8Pz9IQ248
         S5A8OAl7vQNJN8tIME2g3BNRe9+PTR1opY2Vl2srJRXYM6/kZZW8SoQz526AA7i2xjM7
         69uQ==
X-Gm-Message-State: AOAM532iah5qXzBZt5EzYVOiUfHvX4A4sdWhGYaBkh7SDb3jPz4tD1By
        SqMdeZwC9datPtj3nxQAHygjog==
X-Google-Smtp-Source: ABdhPJyxoYBOUHK0qDZHkcI9jLYinlLatrd8P70NTLzdfhtfc8vOtuXi/lHQ55ikaAepgRMX4D4ppA==
X-Received: by 2002:a63:555d:0:b0:3fd:5d54:2708 with SMTP id f29-20020a63555d000000b003fd5d542708mr24870374pgm.92.1654802409924;
        Thu, 09 Jun 2022 12:20:09 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c543:2c9:1206:951b])
        by smtp.gmail.com with UTF8SMTPSA id in9-20020a17090b438900b001e2d2235176sm41048pjb.51.2022.06.09.12.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 12:20:09 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v22 3/3] usb: core: hub: Create platform devices for onboard hubs in hub_probe()
Date:   Thu,  9 Jun 2022 12:20:00 -0700
Message-Id: <20220609121838.v22.3.Ic9dd36078f9d803de82ca01a6700c58b8e4de27e@changeid>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220609192000.990763-1-mka@chromium.org>
References: <20220609192000.990763-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---

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
2.36.1.476.g0c4daa206d-goog

