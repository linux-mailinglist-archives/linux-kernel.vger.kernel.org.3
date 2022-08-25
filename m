Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313745A11D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiHYNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiHYNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72EEAA37A;
        Thu, 25 Aug 2022 06:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 829BC61CD3;
        Thu, 25 Aug 2022 13:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E229AC433D6;
        Thu, 25 Aug 2022 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661433572;
        bh=FO3o/vDoP9XtmRQXXKxIgPtLa05j7400CrUZvjFU5GM=;
        h=From:To:Cc:Subject:Date:From;
        b=X2hz5ehw79Z6abk+ajVRkSathM2xiXRPLCyieuOcBe/Ol7VgZgQrb70178DjIB8uU
         9fx8WJMOmkx7tD6y+KMinJBCSz3U3v/a1t4elWmQ6eKJeu9w+VyHEYGqNcani7rMZ7
         OmnXKZK1w6dscdqeUZytFOx2k/EeQiJIhjhMXp8Wl+dJL9hQI5TnEwIEc/kfuZch1O
         0h+BqH49dhkXmb9WszaFxcd1E0E+UY8wGOiOBJLYMbjBmSMbkYydteViboo5+oy6FY
         jE+/5o+d7Wa9JKG5UHRVkn71wkm02xVD0q7ItjhGzA4kLIS4bBdLLz5q+a0/TJbkTK
         dhH7CviSbkYBA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oRClm-00059W-DK; Thu, 25 Aug 2022 15:19:39 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] usb: dwc3: disable USB core PHY management
Date:   Thu, 25 Aug 2022 15:18:36 +0200
Message-Id: <20220825131836.19769-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 driver manages its PHYs itself so the USB core PHY management
needs to be disabled.

Use the struct xhci_plat_priv hack added by commits 46034a999c07 ("usb:
host: xhci-plat: add platform data support") and f768e718911e ("usb:
host: xhci-plat: add priv quirk for skip PHY initialization") to
propagate the setting for now.

Fixes: 4e88d4c08301 ("usb: add a flag to skip PHY initialization to struct usb_hcd")
Fixes: 178a0bce05cb ("usb: core: hcd: integrate the PHY wrapper into the HCD core")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f6f13e7f1ba1..a7154fe8206d 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -11,8 +11,13 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include "../host/xhci-plat.h"
 #include "core.h"
 
+static const struct xhci_plat_priv dwc3_xhci_plat_priv = {
+	.quirks = XHCI_SKIP_PHY_INIT,
+};
+
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
 					int irq, char *name)
 {
@@ -92,6 +97,11 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err;
 	}
 
+	ret = platform_device_add_data(xhci, &dwc3_xhci_plat_priv,
+					sizeof(dwc3_xhci_plat_priv));
+	if (ret)
+		goto err;
+
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
 	if (dwc->usb3_lpm_capable)
-- 
2.35.1

