Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1314D5D50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiCKIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbiCKIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:31:45 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A5F1B98BF;
        Fri, 11 Mar 2022 00:30:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q29so5928343pgn.7;
        Fri, 11 Mar 2022 00:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVR/EXEx8VwYMh+Mq3TbIRbAjTsCwpmkb5RBazMVbfs=;
        b=GNLK00oLX064vIX+r2kYl2hpm4t94e+rXiqn1qZ9hWMFVkY6aHlbSH8BEbBAsY0Ldy
         KB7UpyqDEx+aEAnMxJl6Nl3E9H4wxWU1Knh/dmR4kXxg9JgjkKp2s5gTO7PazmLZm4F5
         ug9oi8DNyH2TidnPshxULWDwMziBs1Mm74UGEhni4KCZZ1F/pvAGs2QLTee/o+NXCoPx
         e1Q8+zNhSL0HH2j5cNAHuMhmyya2h5bpdxFqEFGQOT0lbo0Qt4U+F3IZQRIZLr+ufMzv
         YFN8l03fX2C2ydQiW4D5SBwzqbWJs2F18393kuDS6aObl/l9t9Qp8YIQQ+TU6u5Jq1RJ
         PRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVR/EXEx8VwYMh+Mq3TbIRbAjTsCwpmkb5RBazMVbfs=;
        b=ROxHzxYKwUG7U1MvD9CVgnLhrtel81QgBS4TdwZ8MvfHR8oK1V46peJmfqlt/DZ94j
         3HPNHd1+SaQRXfS6J9FgrJ2ul6TWrViFnyFnMUxbx/36wAPeyI0JIQ2f0L7OpTP9fUeM
         E0bJXtxmqHKPrGIaj655/timaGnNio/jKn9JmQEtGLmy2ceDCHARMmizcXFCsZnLL+YX
         03PWXX6+iGr6Doo9aMnbviTRb/d9GzPbcOLc0fLRkhBSWqEsat+COFKYjKFtE9VPb7i9
         blgztyJjk2LSsmOq2V7ABMZ/7+/3jSaimSYne/aBuBEvt+8JHIYhLQLUiTVRTWAhhEz6
         IN4g==
X-Gm-Message-State: AOAM531aPtMVaw6VcDmEeRCku4sUZdthJHoR7vVGBVhntFTcCX24Rc9u
        tJqRIJxWv7AdP0RdVquCVcXolPjoMvGpCaG4
X-Google-Smtp-Source: ABdhPJwvPShUx/fd22EZnsmFZ7/fjy+OpgeoE43Ls+h/GXbhsRJW42jHfLYkBse6whh+7z/UG3sqSQ==
X-Received: by 2002:a63:5451:0:b0:378:6b6c:ed83 with SMTP id e17-20020a635451000000b003786b6ced83mr7469585pgm.446.1646987441896;
        Fri, 11 Mar 2022 00:30:41 -0800 (PST)
Received: from localhost.localdomain (114-24-95-63.dynamic-ip.hinet.net. [114.24.95.63])
        by smtp.gmail.com with ESMTPSA id q8-20020a056a00150800b004f7948d14e7sm785465pfu.191.2022.03.11.00.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:30:41 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andreyknvl@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH v2] usb: raw-gadget: return -EINVAL if no proper ep address available
Date:   Fri, 11 Mar 2022 16:29:45 +0800
Message-Id: <20220311082944.4881-1-jj251510319013@gmail.com>
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

Changes in v2:
- Rename variable from ep_num_matched to ep_props_matched
- Incorporate the patch from Andrey Konovalov that cover
  the foloowing cases:
    1. If there are no endpoints that match the provided descriptor, return
       EINVAL.
    2. If there are matching endpoints, but they are all already enabled,
       return EBUSY.

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

