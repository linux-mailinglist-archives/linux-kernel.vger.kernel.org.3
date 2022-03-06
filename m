Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70C04CECDC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiCFRxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiCFRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF83EF32;
        Sun,  6 Mar 2022 09:51:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f8so16969057edf.10;
        Sun, 06 Mar 2022 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKTcpjYqRS4uQbtkHCNXnLN0vPC/RNRvwxWfOqD2TvU=;
        b=jToVGfKuRLRBrK4ZqfLgc2Zrod2uqO8U9qHRHHzSfQS1clzwMQUCqJ9guwSTqdVsy/
         RaklZeqjcO4OrfixJae0WRU6WG8bqRqhxYCXhB8SKwceqBVE7cR7K1AaFyST7vIDIBtq
         WTZlPjX3jRjdX4ZOo1tT6tdYRTvFhn0IcbZI0AT8sFjka7A+/qw/jF/E6L3p94k/NHYG
         rKcUo/oRI3d7NgLwbPrpmQbWnC0DGHWf1I2p99YLbV4FVpiJLF/rYqzv6X4IwxczmHW2
         yWa/KH3swYpneuO5o1AflJDAYxBq/TB+zrDwaEGQTg4T6DYjXJeIibFJ9rOPzyUs4v+9
         eCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKTcpjYqRS4uQbtkHCNXnLN0vPC/RNRvwxWfOqD2TvU=;
        b=uwY+3ZqlAhOQJYWrAOs8qUm7i1VFc1j8MrawWTc8FUXaP+dbuZMxOzf78hjw0fdo5N
         zZc0qrKWuj082Kcy1XyMrtlrLpnoVvUQRoaEobHhjKKB/cSmpVx+k+MSqWZVoqd6cl5d
         GANruuI7WrCBraHpGA6UXXh9QMIylL2W2CNXjPkKGEK1ysTWNst2Oxjb3Fr0b51/WJZ8
         u+sV+w8WSg0bbgDXZ2goc6cSNltfFWYiZyWZL/YtzBSbq9WCTA26Uv7yiEu5sxddkxG0
         r0E95l2llwq3b6rDnTE2c0EVydLOfqA87j6foxUHz7EGr1e2Tf4vpvp+oTOm3DCoKOux
         dJHg==
X-Gm-Message-State: AOAM530ioChE2mAxvD5ZJgfHhrltYfvqvY7ghCsktvz3WFbtGJ0GLTwG
        /H7FJd7h+8sHFCYiiNRnMe0=
X-Google-Smtp-Source: ABdhPJz+oIZawQWxxP2050yuUydT5hnlPsXvNkl3GbdaPI80qnu1uIORJN5sMFPiAej3oTM6D/euOQ==
X-Received: by 2002:aa7:d505:0:b0:415:9f06:d4f5 with SMTP id y5-20020aa7d505000000b004159f06d4f5mr7840371edq.305.1646589097019;
        Sun, 06 Mar 2022 09:51:37 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:36 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH 22/26] usb: gadget: pxa27x_udc: replace usage of rc to check if a list element was found
Date:   Sun,  6 Mar 2022 18:50:30 +0100
Message-Id: <20220306175034.3084609-23-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220306175034.3084609-1-jakobkoschel@gmail.com>
References: <20220306175034.3084609-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

This removes the need to check the rc value to determine if the
break/goto was hit and can be made more obvious
by checking if the variable was set within the list traversal loop.

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index f4b7a2a3e711..eed793deeda0 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1159,7 +1159,7 @@ static int pxa_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct pxa_ep		*ep;
 	struct udc_usb_ep	*udc_usb_ep;
-	struct pxa27x_request	*req;
+	struct pxa27x_request	*req = NULL, *tmp;
 	unsigned long		flags;
 	int			rc = -EINVAL;
 
@@ -1173,15 +1173,16 @@ static int pxa_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			req = tmp;
 			rc = 0;
 			break;
 		}
 	}
 
 	spin_unlock_irqrestore(&ep->lock, flags);
-	if (!rc)
+	if (req)
 		req_done(ep, req, -ECONNRESET, NULL);
 	return rc;
 }
-- 
2.25.1

