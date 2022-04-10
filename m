Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089634FAE5E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiDJPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiDJPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFB886210A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649603321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0fBEBq6RqOmAXN69Pg2n48BAzr3YZ3kkOQrunZvVvGw=;
        b=P57GvXBcpI1hLTPsOcP2WBeqP8WjtMHL9juTy0rwoARNYrRC/ts7BxXnMZIB5MEgSGKHu7
        VZYUcGlnKu2PokJ4lWxltanlIKxpH8d6YYdndFlV+4RPnVYsybWBiVQWr3b+1ozebzPFGR
        KcKteDupwu2lctvAdGRE7uydnZ/MIx0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-WRiUXWB6NeSTeRO4Y8wMCw-1; Sun, 10 Apr 2022 11:08:40 -0400
X-MC-Unique: WRiUXWB6NeSTeRO4Y8wMCw-1
Received: by mail-qv1-f71.google.com with SMTP id a3-20020a056214062300b00443cd6175c8so13830955qvx.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fBEBq6RqOmAXN69Pg2n48BAzr3YZ3kkOQrunZvVvGw=;
        b=vYJDazMD4grFThpFL/FBjGI9qvfUmeNC6Zn+FQNmZ3pOeJDGULXRoDtO5+EL9e30ig
         LIplFczN0WRW5ShtEOvrDHgoPCmRzgOAgyyxZ7sSDOEKyG4dvVaMc8qUhYxkc8QFRxMK
         HL6y4pZUtKoYD28zqMLZFu9av1mfV3CY6ssCrocTzct9vq3/vG0pAiUJQg+iOi1vAt2z
         Jm9AyXcw1jZuNknFVW37onY4Q+zPzVj+lipftiLZJlNdHdiCA7j6fzQXwVAs5y2uoaW2
         jbOIVJqr0YxEfZC6p8y1Vpu5GSxzXriOgF7IIyWSFOLydbiA9zcQsz0PLqeGus96kYwi
         u2mg==
X-Gm-Message-State: AOAM5337SNUQu6s70ldWLBtulU9FyZzzgEdADF96LI7UAbqKW0r9+1ok
        RZ0EpDd7Uinnjau7/jCZF/8GBYR1YJ0N1/rTF11b5wx2biev8Gqqx8je5mCit/UDuN2+IAJYzmE
        AlYbeW0uYgWEAeYtmvIkqBeFY
X-Received: by 2002:a05:622a:1793:b0:2e1:ba41:ed2 with SMTP id s19-20020a05622a179300b002e1ba410ed2mr22788773qtk.238.1649603319867;
        Sun, 10 Apr 2022 08:08:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKeGNEEMC9VIu0CY/yX+G5qpcMSSfbg6/dzIhH0M4SK2dAYg8MtigVjD0z4TpmKs/XK+8K7Q==
X-Received: by 2002:a05:622a:1793:b0:2e1:ba41:ed2 with SMTP id s19-20020a05622a179300b002e1ba410ed2mr22788754qtk.238.1649603319616;
        Sun, 10 Apr 2022 08:08:39 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a00cc00b002ebdd6ef303sm7685357qtw.43.2022.04.10.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 08:08:39 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, joel@jms.id.au,
        andrew@aj.id.au, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        alcooperx@gmail.com, christophe.jaillet@wanadoo.fr,
        cai.huoqing@linux.dev, benh@kernel.crashing.org,
        neal_liu@aspeedtech.com, miles.chen@mediatek.com,
        balamanikandan.gunasundar@microchip.com, macpaul.lin@mediatek.com,
        s.shtylyov@omp.ru, jakobkoschel@gmail.com,
        stern@rowland.harvard.edu, andriy.shevchenko@linux.intel.com,
        quic_wcheng@quicinc.com, yashsri421@gmail.com,
        rdunlap@infradead.org
Cc:     linux-geode@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: gadget: udc: clean up comments
Date:   Sun, 10 Apr 2022 11:08:28 -0400
Message-Id: <20220410150828.1891123-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX
*.h use /* */ style comments

For double words, remove
with, also

Spelling replacements
wayt to way
wakup to wakeup
Contrl to Control
cheks to checks
initiaization to initialization
dyanmic to dynamic

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
 drivers/usb/gadget/udc/at91_udc.c         | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
 drivers/usb/gadget/udc/core.c             | 4 ++--
 drivers/usb/gadget/udc/trace.h            | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc.h b/drivers/usb/gadget/udc/amd5536udc.h
index 055436016503..e670d251e16f 100644
--- a/drivers/usb/gadget/udc/amd5536udc.h
+++ b/drivers/usb/gadget/udc/amd5536udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * amd5536.h -- header for AMD 5536 UDC high/full speed USB device controller
  *
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 7a635c499777..8eba6d744090 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -180,7 +180,7 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
 	* We do *NOT* set the VHUB_CTRL_CLK_STOP_SUSPEND bit
 	* to stop the logic clock during suspend because
 	* it causes the registers to become inaccessible and
-	* we haven't yet figured out a good wayt to bring the
+	* we haven't yet figured out a good way to bring the
 	* controller back into life to issue a wakeup.
 	*/
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
index b4cf46249fea..3c64c00546ec 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
@@ -366,7 +366,7 @@ static int ast_vhub_ep0_queue(struct usb_ep* u_ep, struct usb_request *u_req,
 	struct device *dev = &vhub->pdev->dev;
 	unsigned long flags;
 
-	/* Paranoid cheks */
+	/* Paranoid checks */
 	if (!u_req || (!u_req->complete && !req->internal)) {
 		dev_warn(dev, "Bogus EP0 request ! u_req=%p\n", u_req);
 		if (u_req) {
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 65cd4e46f031..70001decf8c0 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -551,7 +551,7 @@ void ast_vhub_device_connect(struct ast_vhub *vhub,
 					  0, true);
 
 	/*
-	 * If the hub is set to wakup the host on connection events
+	 * If the hub is set to wakeup the host on connection events
 	 * then send a wakeup.
 	 */
 	if (vhub->wakeup_en)
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 6b9dfa6e10eb..81b92d683c35 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -23,9 +23,9 @@
 #define AST_VHUB_USBSTS		0x24	/* USB Status Register */
 #define AST_VHUB_EP_TOGGLE	0x28	/* Programmable Endpoint Pool Data Toggle Value Set */
 #define AST_VHUB_ISO_FAIL_ACC	0x2C	/* Isochronous Transaction Fail Accumulator */
-#define AST_VHUB_EP0_CTRL	0x30	/* Endpoint 0 Contrl/Status Register */
+#define AST_VHUB_EP0_CTRL	0x30	/* Endpoint 0 Control/Status Register */
 #define AST_VHUB_EP0_DATA	0x34	/* Base Address of Endpoint 0 In/OUT Data Buffer Register */
-#define AST_VHUB_EP1_CTRL	0x38	/* Endpoint 1 Contrl/Status Register */
+#define AST_VHUB_EP1_CTRL	0x38	/* Endpoint 1 Control/Status Register */
 #define AST_VHUB_EP1_STS_CHG	0x3C	/* Endpoint 1 Status Change Bitmap Data */
 #define AST_VHUB_SETUP0		0x80	/* Root Device Setup Data Buffer0 */
 #define AST_VHUB_SETUP1		0x84	/* Root Device Setup Data Buffer1 */
diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 728987280373..c80d0902bb30 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -994,7 +994,7 @@ static const struct usb_gadget_ops at91_udc_ops = {
 	.udc_stop		= at91_stop,
 
 	/*
-	 * VBUS-powered devices may also also want to support bigger
+	 * VBUS-powered devices may also want to support bigger
 	 * power budgets after an appropriate SET_CONFIGURATION.
 	 */
 	/* .vbus_power		= at91_vbus_power, */
diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 9849e0c86e23..223e08e53f94 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -296,7 +296,7 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 			for (i = 1; i < bdc->num_eps; ++i)
 				bdc->bdc_ep_array[i]->flags = 0;
 	} else {
-		/* One time initiaization only */
+		/* One time initialization only */
 		/* Enable status report function pointers */
 		bdc->sr_handler[0] = bdc_sr_xsf;
 		bdc->sr_handler[1] = bdc_sr_uspc;
@@ -361,7 +361,7 @@ int bdc_reinit(struct bdc *bdc)
 	return ret;
 }
 
-/* Allocate all the dyanmic memory */
+/* Allocate all the dynamic memory */
 static int bdc_mem_alloc(struct bdc *bdc)
 {
 	u32 page_size;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 85b194011a16..bf472478239b 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(usb_ep_disable);
 
 /**
  * usb_ep_alloc_request - allocate a request object to use with this endpoint
- * @ep:the endpoint to be used with with the request
+ * @ep:the endpoint to be used with the request
  * @gfp_flags:GFP_* flags to use
  *
  * Request objects must be allocated with this call, since they normally
@@ -897,7 +897,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
 /**
  * usb_gadget_giveback_request - give the request back to the gadget layer
- * @ep: the endpoint to be used with with the request
+ * @ep: the endpoint to be used with the request
  * @req: the request being given back
  *
  * This is called by device controller drivers in order to return the
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 98584f6b6c66..75987cae2a15 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * udc.c - Core UDC Framework
  *
-- 
2.27.0

