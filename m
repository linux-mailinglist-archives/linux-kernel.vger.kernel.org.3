Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0B4D164B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbiCHLcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiCHLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:32:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232842A34;
        Tue,  8 Mar 2022 03:31:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso1946350pjj.2;
        Tue, 08 Mar 2022 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwYw6UCyoABQdRBRd1yhW2c7K50Bveoo4+Wjmoa50zo=;
        b=dM6KzRJGdqy0RZKW65Mmi00X1hYAe56e/tarN+bZUJiIEmmQYK3TnQGUmZdgZuzZ7X
         ncQGosXHgJslwJJTthS1skxibiQF0/m5woIiTSXnmPLiBM556leLnwotm6S44wGNstER
         r2oc2IrgQ0g7SA57xnNRIXuME8F8FymVEox+vMIRvFPouUbKQ1HbBBezZ2EvRwhvtGiX
         6cl+IbVVaC3cveWq97fV9bnn2PvgWGe8kTg2nPAMQTSomhzHjkzS2O1m9q7t5m+mZqa/
         2EL1CBsozUzKyntfzFEllD8zYlUNU899SihgT1O3ZSQWWtZMmDvgkfVVrQyt7boeN/zl
         9aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwYw6UCyoABQdRBRd1yhW2c7K50Bveoo4+Wjmoa50zo=;
        b=xvv7XJdp1kdRHnExcdt6RKgyPScRCry/MrD3qBpVNsAtA+I+i9ATUfhMavCHl0d+v9
         U+xhHsifZ6BBBC0nt/khhiHglG06EXdh2g02hRZBicqOzPIqQRWPmLOAC4PSf/45FVRJ
         vB5AADrRaULIyEzld/dHArh4zhmSoz/Zlv8WyDhTcaVt69jzz9NUB8pPwntOi3WrfNQO
         oyrJ2/RRifFYI04zc3pBdtpUpCkpCVOAZpjXn4aPMTRxdAOLXL4WqfanJ6SbAKLV39lj
         9Qr6U28mH9aD7r22AzZ/SNKoB91VcgOAM1ifjyI9lmzA7StEuUWjAMBurRJeeNqJYdpf
         Euxg==
X-Gm-Message-State: AOAM533w1So9tACyQdy7zM9YM7/pbpVq6pELqReE1LFN9FaWorkYssEA
        W+ecnOpSZKirJkXMLY4j4x4squot/wjqfQ==
X-Google-Smtp-Source: ABdhPJzi3HS2uJRqE1jJb7DSwpJAxEqdJJejAJYKA+rLIfRPZeMYyrmR806+7//fUQz3sqZsY6F0gw==
X-Received: by 2002:a17:902:d505:b0:151:9e65:b844 with SMTP id b5-20020a170902d50500b001519e65b844mr17452429plg.49.1646739071793;
        Tue, 08 Mar 2022 03:31:11 -0800 (PST)
Received: from localhost.localdomain (114-24-142-127.dynamic-ip.hinet.net. [114.24.142.127])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b004f129e7767fsm18470726pfv.130.2022.03.08.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:31:11 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andreyknvl@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: return -EINVAL if no proper ep address available
Date:   Tue,  8 Mar 2022 19:28:32 +0800
Message-Id: <20220308112832.6170-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
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

I think it will be more intuitive if we return -EINVAL, Cuz -EBUSY sounds
like ep5in is not available now, but might be available in the future.

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index d86c3a36441e..b4cc083a7ca6 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -758,6 +758,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 	unsigned long flags;
 	struct usb_endpoint_descriptor *desc;
 	struct raw_ep *ep;
+	bool ep_num_matched = false;
 
 	desc = memdup_user((void __user *)value, sizeof(*desc));
 	if (IS_ERR(desc))
@@ -792,6 +793,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 		if (ep->addr != usb_endpoint_num(desc) &&
 				ep->addr != USB_RAW_EP_ADDR_ANY)
 			continue;
+		ep_num_matched = true;
 		if (!usb_gadget_ep_match_desc(dev->gadget, ep->ep, desc, NULL))
 			continue;
 		ep->ep->desc = desc;
@@ -815,6 +817,12 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 		goto out_unlock;
 	}
 
+	if (!ep_num_matched) {
+		dev_dbg(&dev->gadget->dev, "fail, no proper ep address available\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	dev_dbg(&dev->gadget->dev, "fail, no gadget endpoints available\n");
 	ret = -EBUSY;
 
-- 
2.25.1

