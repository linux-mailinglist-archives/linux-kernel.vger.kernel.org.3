Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE49B4D58DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbiCKD2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbiCKD2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:28:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36B71A2735;
        Thu, 10 Mar 2022 19:27:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h5so5269279plf.7;
        Thu, 10 Mar 2022 19:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5IT3PbDgaeY8qmsercAMGNkkxjzO2Aj3HUs/2+UID8=;
        b=I8gC/ZR5OTbu1QF7F/SSzj98hGkRp/bJfRkJTANyUlPrycfofYDfEF2fvzXH092+ki
         +7t3oiMEjkt54UlIHrGLn4ZVbIAmOTLcFBb7ahVfHdNgLxWeA7vAbUR8BQSnooiXwQmy
         xB6n606rXuBGu/GMhzRLGTjID8INq8IM/9Ds3CDjSlluyANsf6hs7eEyos+PIFd62b37
         5PTPS8DY733+m4n61+1rLqwp49OP65JVyi4JFaa3YejC+nW6Q3o/j1k+zm4VAyzqcbRe
         5WAlijr6xqwBZfBiI5uSH47YKANt+dPTm9itnVe4JUTEzt/1ukzM5sLsiuaslbWcZ5ow
         c5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5IT3PbDgaeY8qmsercAMGNkkxjzO2Aj3HUs/2+UID8=;
        b=Cdpyx/HTpGAGtaNyEL9Nx1boTmvw97Vd2cb554Nq6EKXvAqNoBj6J0ebD/g5ocq3ZX
         mojkj9EoHlL6qPHIms3+WajsYxY7dCRdqq0z/U+RNbcfvvkStga+FCDwXNlD+ZNFrWtR
         POhL0OizJFgjk8l0SJqb8lnpBPpOecge2KjeP5h+2O/J4M903QhTPzgThwNOSQI2KX3X
         p72GRxBRo++0f64YS/tJqyaD5tHI+ERc8W1ZjRGnNAFP4nzsfoDFkj+9xoQi3AKbYF1r
         C02yaO/8HDQ0dta88CwOlffmSfIf7xXQ8t9+M1TzgHI92ubiKdG68nWMJD6bgRcfdsqu
         HdRQ==
X-Gm-Message-State: AOAM532uXX9s6tsTt3CM8Xc7XXh2pGLXUejKYLxruBTN1fkmmQ9cT6aa
        3dBtvV5JXVNRJ3phT6yBZfyfdCnLk49tcRvt
X-Google-Smtp-Source: ABdhPJwpvxCPs2SW8c9kqutTJ7xqv6gUDFeCA7BBGdhC1jO22UCHLln3YDQPc/LJ6hMCC41F7Q2w0w==
X-Received: by 2002:a17:902:ea0d:b0:151:df90:779f with SMTP id s13-20020a170902ea0d00b00151df90779fmr8608184plg.1.1646969238816;
        Thu, 10 Mar 2022 19:27:18 -0800 (PST)
Received: from localhost.localdomain (114-24-95-63.dynamic-ip.hinet.net. [114.24.95.63])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm9204254pfl.135.2022.03.10.19.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 19:27:18 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andreyknvl@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH v2] usb: raw-gadget: return -EINVAL if no proper ep address available
Date:   Fri, 11 Mar 2022 11:22:38 +0800
Message-Id: <20220311032238.3978-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+fCnZd2GoU6LVvT4eBT3w7TigRrp_9XcAGyL55K5nbi3yt4sA@mail.gmail.com>
References: <CA+fCnZd2GoU6LVvT4eBT3w7TigRrp_9XcAGyL55K5nbi3yt4sA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we try to use raw_ioctl_ep_enable() for ep5in on a hardware that
only support from ep1-ep4 for both in and out direction, it will return
-EBUSY originally.

I think it will be more intuitive if we return -EINVAL, because -EBUSY
sounds like ep5in is not available now, but might be available in the
future.

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index d86c3a36441e..e5707626c4d4 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -758,6 +758,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 	unsigned long flags;
 	struct usb_endpoint_descriptor *desc;
 	struct raw_ep *ep;
+	bool ep_props_matched = false;
 
 	desc = memdup_user((void __user *)value, sizeof(*desc));
 	if (IS_ERR(desc))
@@ -787,13 +788,14 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 
 	for (i = 0; i < dev->eps_num; i++) {
 		ep = &dev->eps[i];
-		if (ep->state != STATE_EP_DISABLED)
-			continue;
 		if (ep->addr != usb_endpoint_num(desc) &&
 				ep->addr != USB_RAW_EP_ADDR_ANY)
 			continue;
 		if (!usb_gadget_ep_match_desc(dev->gadget, ep->ep, desc, NULL))
 			continue;
+		ep_props_matched = true;
+		if (ep->state != STATE_EP_DISABLED)
+			continue;
 		ep->ep->desc = desc;
 		ret = usb_ep_enable(ep->ep);
 		if (ret < 0) {
@@ -815,8 +817,13 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 		goto out_unlock;
 	}
 
-	dev_dbg(&dev->gadget->dev, "fail, no gadget endpoints available\n");
-	ret = -EBUSY;
+	if (!ep_props_matched) {
+		dev_dbg(&dev->gadget->dev, "fail, bad endpoint descriptor\n");
+		ret = -EINVAL;
+	} else {
+		dev_dbg(&dev->gadget->dev, "fail, no endpoints available\n");
+		ret = -EBUSY;
+	}
 
 out_free:
 	kfree(desc);
-- 
2.25.1

