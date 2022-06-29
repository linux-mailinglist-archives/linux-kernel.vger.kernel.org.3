Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF755F5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiF2F4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiF2F4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:56:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0D17584;
        Tue, 28 Jun 2022 22:56:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r1so13098601plo.10;
        Tue, 28 Jun 2022 22:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zysuHUP/InQT5Fi1lB0z6tjNnC0mTo16xnyZM6YuAJw=;
        b=QK/5e2zQieB6A4dmexNIProsq3M79RKCnmora4GTRtVMPjkkvv3D4aT204RFEfBWx4
         nId2C5ed5MHevimldiWc6Cjde/EbequTigTeiNKdBodzJkUX9bD3ohxdMQnuIO16C92c
         cp955TzJcSZV4gQvc+gd9U7cL8BLf4+2kKrf4Hte3bACe8eIPTlrlIg7Ph1vWkIcuXDl
         fIr+vIWPAyjVLyKVR71SZZjibIWSUNaAIDtHoXjlHTCVYvRZ/udaUv5cKICLS4WUOmEz
         Y+mN1BV0/tn9BU7nWku0MgYLRIP8nEaeWD2bIzk+D5O6mxgA5I1AkhOhyH6BrtTW/hZb
         a6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zysuHUP/InQT5Fi1lB0z6tjNnC0mTo16xnyZM6YuAJw=;
        b=Vpa/dVT6+Z17dQBwAOiWJrWzaasz6hjgbl9mL3sF/73Maz/oRONlycL+NFRMt/Jooj
         uT2tJO42ntlu/OtzM4YfBQlB8BWzfguLIZ1mowZ7lhdB1/a28VBXcXoekgdPnp4wr1uU
         sqpU0i3O6ypYI/aRvbni691G0Nd7QLJS0GgKhExti27YVq0e9m7wiZt6D/cURrZEAntz
         3wRy2c4KXDW7ZXD6iOtsylHQYWDTCQYFudzTqdijSKuJcrzi4sOjhO6Kohr6FIJH9+yz
         hW2a1e8Q7KM7sYRmnSbGlXzpHw1povQea0jH3giOgGVUpy153PN8KMVt4wClSUQof4ko
         71+w==
X-Gm-Message-State: AJIora9v1HBaSbtEz8WnJgSMT6irHVXXbzSyLltzMDzYARDEeKJLmR1S
        j0XbhHgsDLV4mGcVp00A49E=
X-Google-Smtp-Source: AGRyM1tXAC4bhW6xMpfXOnI72qyaFcpjuVyN0Ilx++e7/GU7Zz0+Z6//cTeok3vV2AY7ITsad9MSHg==
X-Received: by 2002:a17:90b:4ac7:b0:1ed:21e8:ddb2 with SMTP id mh7-20020a17090b4ac700b001ed21e8ddb2mr1929375pjb.93.1656482181452;
        Tue, 28 Jun 2022 22:56:21 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.160.194.58])
        by smtp.gmail.com with ESMTPSA id p12-20020aa79e8c000000b0050dc7628162sm10587451pfq.60.2022.06.28.22.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:56:20 -0700 (PDT)
From:   SebinSebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, skhan@linuxfoundation.org,
        Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH-next] usb: gadget: dereference before null check
Date:   Wed, 29 Jun 2022 11:26:05 +0530
Message-Id: <20220629055605.102425-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebin Sebastian <mailmesebin00@gmail.com>

Fix coverity warning dereferencing before null check. _ep and desc is
deferenced on all paths until the check for null. Move the
initilizations after the check for null.
Coverity issue: 1518209

Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index d75a4e070bf7..4f158030e2cc 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -341,10 +341,6 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
 static int ast_udc_ep_enable(struct usb_ep *_ep,
 			     const struct usb_endpoint_descriptor *desc)
 {
-	u16 maxpacket = usb_endpoint_maxp(desc);
-	struct ast_udc_ep *ep = to_ast_ep(_ep);
-	struct ast_udc_dev *udc = ep->udc;
-	u8 epnum = usb_endpoint_num(desc);
 	unsigned long flags;
 	u32 ep_conf = 0;
 	u8 dir_in;
@@ -355,6 +351,12 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
 		EP_DBG(ep, "Failed, invalid EP enable param\n");
 		return -EINVAL;
 	}
+
+	u16 maxpacket = usb_endpoint_maxp(desc);
+	struct ast_udc_ep *ep = to_ast_ep(_ep);
+	struct ast_udc_dev *udc = ep->udc;
+	u8 epnum = usb_endpoint_num(desc);
+
 
 	if (!udc->driver) {
 		EP_DBG(ep, "bogus device state\n");
-- 
2.34.1

