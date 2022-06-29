Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D655FA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiF2IIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiF2IH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:07:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791C53BA5D;
        Wed, 29 Jun 2022 01:07:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q18so13348717pld.13;
        Wed, 29 Jun 2022 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26ZIBRUEZIPtCeugGBeQrsgT3aaPi/jFrSW3XtqmO4E=;
        b=LD2k1fnO3PEvw5iSj+odGBaj3uUJ/1bZXafHiHJr8dwAQMh7HAro80QefSH/JLvsY/
         9sVfjCsCTwTv1NgQt+NxnMlz9HWC6fsejYqt30mAbe9+ExgjCwO4Kmmak2r5UC6RsJCL
         8KKLQeTQjogfO0ePGfWqS0wNbZHCQq3mmG1tZQTkntPEPx2ch1LPrxVCROG63Rv0w/Xf
         56VD/0HfdhM9EPbPE2o0Qjsrjh4U6qLgIYafgkpLjc5IWUESAZS4q5EPhmJhUoR7Af1I
         5UrMChIu5XMEHhzVLRVqnYjj24lrm6dtT1PU81wYmPPhJ09bYSI1o61PDN2VphUf/6lI
         EQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26ZIBRUEZIPtCeugGBeQrsgT3aaPi/jFrSW3XtqmO4E=;
        b=NDG4hEKsFpIk6twQf8NdMRFiSfAFbQlqMq1bjIVflbuuVJcDZGzH6mhn5dSQfBu82g
         n3XTH91X2qX3D0KYda1UUDoRrakEWZX8on6RSVQszN9SgToZpvvjgMrqwwSRltPkA3qh
         Sy94EJ4WW03Ln9EoR4exiRxuLQs7Y6qXY0BVnjVrnDJ82PQxMDkRxxrFHHAg5/zq4eem
         cm44ldW1U8QiBfvDAb3k0KdHvf3yF9KECWoWFaS0Vlygufx0d3YAiTn98wMKU9Ck45RT
         BWhU44Guci3bdetfwHB31n74kCWWXX4uSEbI5Taojks1EAPo9lPiwBJGSgK50GDHKrJK
         YLvA==
X-Gm-Message-State: AJIora/t4DTEghgjSji2n9eD/ylNuLPj/t0zphrzVzXSOpicGyW93+fL
        KF9pBOd//hiwHMn7y1PqUW0=
X-Google-Smtp-Source: AGRyM1tilyHqgJTXrJU1LG7dIY6Y7oBwOtiPbyUrYr/8vnrGlc6jHnz2pPhlEKAouHlMINKMc7UTTw==
X-Received: by 2002:a17:90b:4b8c:b0:1ec:c7b8:7cb9 with SMTP id lr12-20020a17090b4b8c00b001ecc7b87cb9mr4345566pjb.86.1656490075939;
        Wed, 29 Jun 2022 01:07:55 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.160.233.84])
        by smtp.gmail.com with ESMTPSA id kk2-20020a17090b4a0200b001cd4989febcsm1398292pjb.8.2022.06.29.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:07:55 -0700 (PDT)
From:   SebinSebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, skhan@linuxfoundation.org,
        Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] usb: gadget: dereference before null check
Date:   Wed, 29 Jun 2022 13:37:25 +0530
Message-Id: <20220629080726.107297-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

Signed-off-by: SebinSebastian <mailmesebin00@gmail.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index d75a4e070bf7..96f8193fca15 100644
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
@@ -356,6 +352,11 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
 		return -EINVAL;
 	}

+	u16 maxpacket = usb_endpoint_maxp(desc);
+	struct ast_udc_ep *ep = to_ast_ep(_ep);
+	struct ast_udc_dev *udc = ep->udc;
+	u8 epnum = usb_endpoint_num(desc);
+
 	if (!udc->driver) {
 		EP_DBG(ep, "bogus device state\n");
 		return -ESHUTDOWN;
--
2.34.1

