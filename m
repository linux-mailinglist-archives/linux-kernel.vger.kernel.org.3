Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68204494209
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357509AbiASUoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357395AbiASUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:44:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC04C061401
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:44:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id br22-20020a17090b0f1600b001b50eaa9e8bso1587963pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLI5uHzLJX9BhzFSIqWpwYSyzOLcVU04ghKiiMsJQ7E=;
        b=WVjgtmQc1OAcrX8BDpCfRRvHTIVt+7VDPBV1sILej0bCFo0gssayqOA79ortD/cz8Q
         fazWVAWOXRm2On+qImSPzC1SmzEWjYvEP6Wj39bEnW8QB/Zr5th6Q9MbBgYV2UDJupn1
         40vhXatO5FV8fgxXVBUJvzz8NWZk/c0qMtrrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLI5uHzLJX9BhzFSIqWpwYSyzOLcVU04ghKiiMsJQ7E=;
        b=xwCXfpO4PRZO3KCXzmfokZZM68z7typ6g5DxAHvaelDJGqoUesItFffe2jDIP/jUXP
         Ax4edyR5LWPE19ZAx9nzbxwKaWuNsIDwkESbWZeGP03y3Og0I0x2goCpZQgQxKorA1Vb
         UJpfNJ1bpMM8wLXrr5m5UEOiU+Wl4CgGzFOTPnPlZyojNYIOjJdUTLTwMIVZP2UNNo3Y
         Z1fDpeGC2Gm4XJc76QcMQHuvEiNiSv4uGiikHjs15lGY+/xbojxNnOVkykhSMKD2CxJs
         fCQtcl0voAjZG0umEKEuqvW+9UElSHnTpgxmTDBu/9ZWoyKrhVaUTqYVrxHiwYxxOX39
         U5FA==
X-Gm-Message-State: AOAM533DZ5AwzFiPB6auNlOmMpGg363Y26T8evT9x/lZpAST5V3OvRRJ
        KWUNfjZ+gLMueZzbd3qlBMxXFQ==
X-Google-Smtp-Source: ABdhPJwNgJA5a+22JMacSNrKazbWDTgGPTKljjGzSNrAt4lgDDxKu1xSV764PaEYjZt64RiX47xiXQ==
X-Received: by 2002:a17:902:c64b:b0:14a:94ba:763e with SMTP id s11-20020a170902c64b00b0014a94ba763emr25709980pls.63.1642625044277;
        Wed, 19 Jan 2022 12:44:04 -0800 (PST)
Received: from localhost ([2620:15c:202:201:618e:efc:c014:d89c])
        by smtp.gmail.com with UTF8SMTPSA id l21sm491572pfu.120.2022.01.19.12.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:44:03 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v20 4/5] usb: core: hcd: Create platform devices for onboard hubs in probe()
Date:   Wed, 19 Jan 2022 12:43:44 -0800
Message-Id: <20220119124327.v20.4.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220119204345.3769662-1-mka@chromium.org>
References: <20220119204345.3769662-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call onboard_hub_create/destroy_pdevs() from usb_add/remove_hcd()
for primary HCDs to create/destroy platform devices for onboard
USB hubs that may be connected to the root hub of the controller.
These functions are a NOP unless CONFIG_USB_ONBOARD_HUB=y/m.

Also add a field to struct usb_hcd to keep track of the onboard hub
platform devices that are owned by the HCD.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v20:
- added 'Reviewed-by' tags from Doug and Stephen

Changes in v19:
- none

Changes in v18:
- none

Changes in v17:
- create the platform devices in the generic HCD code instead of
  the xhci_platform driver
- updated subject and commit message to reflect the above change
- dropped initialization of platform device list, which is now
  done in onboard_hub_create_pdevs()

Changes in v16:
- none

Changes in v15:
- none

Changes in v14:
- none

Changes in v13:
- added comment for 'depends on USB_ONBOARD_HUB || !USB_ONBOARD_HUB'
  construct

Changes in v12:
- none

Changes in v11:
- use onboard_hub_create/destroy_pdevs() to support multiple onboard
  hubs that are connected to the same root hub
- moved field/list to keep track of platform devices from struct
  usb_hcd to struct xhci_hcd
- updated commit message

Changes in v10:
- none

Changes in v9:
- added dependency on USB_ONBOARD_HUB (or !!USB_ONBOARD_HUB) to
  USB_XHCI_PLATFORM

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- patch added to the series

 drivers/usb/core/hcd.c  | 6 ++++++
 include/linux/usb/hcd.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 4d326ee12c36..b8220e411e07 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/onboard_hub.h>
 #include <linux/usb/otg.h>
 
 #include "usb.h"
@@ -2963,6 +2964,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
 		usb_hcd_poll_rh_status(hcd);
 
+	if (usb_hcd_is_primary_hcd(hcd))
+		onboard_hub_create_pdevs(hcd->self.root_hub, &hcd->onboard_hub_devs);
+
 	return retval;
 
 err_register_root_hub:
@@ -3041,6 +3045,8 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		if (hcd->irq > 0)
 			free_irq(hcd->irq, hcd);
+
+		onboard_hub_destroy_pdevs(&hcd->onboard_hub_devs);
 	}
 
 	usb_deregister_bus(&hcd->self);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 548a028f2dab..4ebc91c09182 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -198,6 +198,7 @@ struct usb_hcd {
 	struct usb_hcd		*shared_hcd;
 	struct usb_hcd		*primary_hcd;
 
+	struct list_head	onboard_hub_devs;
 
 #define HCD_BUFFER_POOLS	4
 	struct dma_pool		*pool[HCD_BUFFER_POOLS];
-- 
2.34.1.703.g22d0c6ccf7-goog

