Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709F4BA894
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbiBQSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:43:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244539AbiBQSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:43:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C79FFD13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:43:11 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z17so5256432plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=150I8tSeoQEdnBW/+p+7xnMkqFAoe9hccra7knV3Q/4=;
        b=IYb9C99Nd6cqeKKYhs2ozW0LnPOclIeM4t/tKWk6bkI+Equaz+baO4EDzHyi/JQU0P
         se6ly5U3jlSjwllXuSHZ3QZFzn+CziSet1m6jCRZmVohXCsYhCiAwX8T5gJM69XAyDGy
         zTmMIZ3amYHU83M6ELcTYQrYi9HJu9Fmmo0pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=150I8tSeoQEdnBW/+p+7xnMkqFAoe9hccra7knV3Q/4=;
        b=ufVmSExeuaUWuIgxMSlFOr231nbip+y9aSZGYYKrPMSWz99ww52ctnkIwV6H889fmc
         y2dl0JXey0AKuQgMrHJEVKerdsjiPB5rRIjWNlSgJ+rnCM/d0yrqS5B9B5/jy+9Mm1+/
         USxi4kCnZHQah04VYh0W0K6gdqy9nrrFxPv1502AM/kvJnv2zODBzo3qUWsTLcFcMzI/
         I6hnJJtPR+tRlPm2lelLTKVbxx3V/6n1MgxWZ7yJFbgGy4bh/ONAeExkO4x6XOaJZqYu
         f5iv4BbYhbii+e1sOzsu4afSPoAFFcoQ6ObL7Oja/NCU8V3sRjiv3JnX7iOisHhzAGgA
         SCTw==
X-Gm-Message-State: AOAM531WGxJ9BL1rE85rGowttW4uwE/f9vYKQao1Cz6iYGnOO6aFIQWT
        +PsXP+I2ReNrIEdhqpiLjcFamQ==
X-Google-Smtp-Source: ABdhPJxMRjgoWIhXnCig3kodTead2c1ZzrN0DvXCm90tES5J+jMe+RRD3wJbABP/1Kwa+4t6DsbNxA==
X-Received: by 2002:a17:90a:7845:b0:1b9:159c:148e with SMTP id y5-20020a17090a784500b001b9159c148emr4338987pjl.136.1645123391193;
        Thu, 17 Feb 2022 10:43:11 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b42d:98cc:5dcc:5ef5])
        by smtp.gmail.com with UTF8SMTPSA id l21sm317135pfu.120.2022.02.17.10.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 10:43:10 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Douglas Anderson <dianders@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v21 3/3] usb: core: hcd: Create platform devices for onboard hubs in probe()
Date:   Thu, 17 Feb 2022 10:42:54 -0800
Message-Id: <20220217104219.v21.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
In-Reply-To: <20220217184254.4141705-1-mka@chromium.org>
References: <20220217184254.4141705-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v21:
- none

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
index d9712c2602af..81785072fafb 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/onboard_hub.h>
 #include <linux/usb/otg.h>
 
 #include "usb.h"
@@ -2984,6 +2985,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
 		usb_hcd_poll_rh_status(hcd);
 
+	if (usb_hcd_is_primary_hcd(hcd))
+		onboard_hub_create_pdevs(hcd->self.root_hub, &hcd->onboard_hub_devs);
+
 	return retval;
 
 err_register_root_hub:
@@ -3062,6 +3066,8 @@ void usb_remove_hcd(struct usb_hcd *hcd)
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
2.35.1.473.g83b2b277ed-goog

