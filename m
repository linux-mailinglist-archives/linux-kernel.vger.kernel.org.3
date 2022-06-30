Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE420561061
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiF3Erc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiF3Er3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:47:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA240A2F;
        Wed, 29 Jun 2022 21:47:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x4so17056404pfq.2;
        Wed, 29 Jun 2022 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/LwGnwJFIJV7K53c+DsH+tZERwXfagasgIpZ1ZeuBA=;
        b=R8G4t3papCLEX6yaZKnb5i3sFJW9qgNgt+VV2xfw1MckXIuCXSSMkA2UTybf9rQInS
         cZ5/t5147kjTqFuxNknpxtCo9tKkWjoupSin1q1PCjfRwOnH7kdXp9W3r+RJOxac4gMW
         TmhwoIxP4I09sILg67g0diaEoeKGQy8EAZUJUCVsUnMe+XUW0E5XrhYpq8CUVTacBnsF
         u9QaoA9m1UwCX/qHJGNZbOZAUQ67e76OekwdAG1Y6Dii93JeCLXo4+dnjJ2CqIjpCsCu
         DpzUKhFr2neaQFgBrXZKJ6GzvYdH6rxGGf1Ztr7oxaiR/sgzvCSDKFWVlh1tgP2bmXHd
         JSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/LwGnwJFIJV7K53c+DsH+tZERwXfagasgIpZ1ZeuBA=;
        b=anpB0kvarcsEkQheatjAPDxxOS8sr26EmqdDCs6YZRqSQ3cG7F2lpdF4JD+EubJBOM
         Y+2KZyoLOe1+NDs8Brv/rDj2Zh2kY2afDuze7ryouBKkNNHhPLohlxQUxxU2rOqZhEih
         3ljPV+ty7K+uqUtR3K92QWib5jBAd1U12JgU2QFBJourJB06bv746FXNm7ni+kSLv2l3
         4Di5Dt+ZRUymK+bY9feOALxdG0cwRehaHHqRjKdmc00w/Ce+fxDLJycuSfiDbfsc7jjm
         65xVfFU4+D7Y88bv1149llw+OasLrlSEq82aAcTPCNE5/q0th3uxF7xrXhd7csGb73kB
         tJxw==
X-Gm-Message-State: AJIora9XOM/8xQVNIn2tPQfflYvhDryCYFEbBJxR7/iIj1C1Mea1qFf0
        FAlVjAvk+wosg9eCE/Pyuuc=
X-Google-Smtp-Source: AGRyM1tsQGgpnsjzd7eEHazroVkuwV6WSmOqUrcHx9dcggU8/XPJ5Ls1MOZs5lzQu983xkCOkPkEqQ==
X-Received: by 2002:a63:8741:0:b0:411:6ef8:18ec with SMTP id i62-20020a638741000000b004116ef818ecmr6217185pge.258.1656564447864;
        Wed, 29 Jun 2022 21:47:27 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.160.233.84])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c2c900b00163ffbc4f74sm12344081pla.49.2022.06.29.21.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 21:47:27 -0700 (PDT)
From:   Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, skhan@linuxfoundation.org,
        kernel test robot <lkp@intel.com>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 -next] usb: gadget: dereference before null check
Date:   Thu, 30 Jun 2022 10:17:06 +0530
Message-Id: <20220630044706.10772-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coverity warning dereferencing before null check. _ep and desc is
dereferenced on all paths until the check for null. Move the
initializations after the check for null.
Coverity issue: 1518209

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 Changes since v1: Fix the build errors and warnings due to first patch.
 Fix the undeclared 'ep' and 'maxpacket' error. Fix the ISO C90 warning.

 drivers/usb/gadget/udc/aspeed_udc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index d75a4e070bf7..a43cf8dde2a8 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -341,26 +341,33 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
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
 	u8 type;
+	u16 maxpacket;
+	struct ast_udc_ep *ep;
+	struct ast_udc_dev *udc;
+	u8 epnum;
 
-	if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
-	    maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
+	if (!_ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
 		EP_DBG(ep, "Failed, invalid EP enable param\n");
 		return -EINVAL;
 	}
-
 	if (!udc->driver) {
 		EP_DBG(ep, "bogus device state\n");
 		return -ESHUTDOWN;
 	}
 
+	maxpacket = usb_endpoint_maxp(desc);
+	ep = to_ast_ep(_ep);
+	udc = ep->udc;
+	epnum = usb_endpoint_num(desc);
+	if (maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
+		EP_DBG(ep, "Failed, invalid EP enable param\n");
+		return -EINVAL;
+	}
+
 	EP_DBG(ep, "maxpacket:0x%x\n", maxpacket);
 
 	spin_lock_irqsave(&udc->lock, flags);
-- 
2.34.1

