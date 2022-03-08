Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8814D1ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346830AbiCHRWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348959AbiCHRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91A53E1F;
        Tue,  8 Mar 2022 09:19:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m12so391022edc.12;
        Tue, 08 Mar 2022 09:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5Y06zvKlJUEjDmKObk/clZZO1QM0n1/SCAkFoYndKQ=;
        b=Gd9DBm1dezIaoJ0IY/Q/VLpNml3yDUDKwBaRU0IeGh8DxrfFqBsXZUOqx4x89KIeuw
         Dxhh7KDvlWrhT+IB52yEIwszEj1r2/qfylXJnW0tORNBvXogAl5HBTDJ3iBUbaYjaicg
         y2vHSn99UOSrOMrKShIUmVA8Q/hR2UvqOsYxv4d/4D4oO6ZfAeI1GsLXIXAGEZ81NOBC
         dJIL1kdIF+4TE/1niYe4ewQXYTCRhow7JzZGWBTWSqUVLTN8t8geZO59uF0eNU4HFN/m
         qCXDQbldJrEflaNbeWT3Qg0jU1vSWr576FCoAALf4dn3ta2hx3cp3HWoueLCCwufefzA
         DwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5Y06zvKlJUEjDmKObk/clZZO1QM0n1/SCAkFoYndKQ=;
        b=OCGcMM0cAnGtnFq6G3Bv3Z39fINpduiSjYrQJIyoR+0d6jkxbiSlbSItiuwoYg+qQy
         EB5pDBdJnK0Llo1y//ulC6fARc7gbrUln5W2kc23RbzltzNQWcpCpKxf/RZYypnkwGOL
         z5nQWdBCMp/AwyIbQh5474il4jLLktyVURldXu6OntGEvR6Cm6GS+JkjyUR+CKtDMyUL
         nIrEvBbCTzE0mtBWVzuDO4qltMdkathzBMS2S3IRw+INPQG2NYQCrmYVQyqM1Gh48gU0
         MvRkqwP+9gzxJm7a1op/ztp+3feSLPiF71Q1EgF3cJ7fkwKcfg3zdceIZzE2AIRAZypM
         rgBw==
X-Gm-Message-State: AOAM530ITI/q2guhf7qNM6q6Dmba8/xJDXk+RTnGdar5CaPvwN0rn6/J
        /fOcYqM58Z9NSTsBn9/sLXY=
X-Google-Smtp-Source: ABdhPJx6vcPNNpHlAtzoO0iFHCq6XDejuswT7N0EiUfkMYNL/8Iu1FFDhGZpjnluNiowtI1w2R+Cwg==
X-Received: by 2002:a05:6402:84e:b0:412:e1ac:391b with SMTP id b14-20020a056402084e00b00412e1ac391bmr441811edz.400.1646759974707;
        Tue, 08 Mar 2022 09:19:34 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:34 -0800 (PST)
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
Subject: [PATCH v2 22/26] usb: gadget: pxa27x_udc: replace usage of rc to check if a list element was found
Date:   Tue,  8 Mar 2022 18:18:14 +0100
Message-Id: <20220308171818.384491-23-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308171818.384491-1-jakobkoschel@gmail.com>
References: <20220308171818.384491-1-jakobkoschel@gmail.com>
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

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index f4b7a2a3e711..ac980d6a4740 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1159,7 +1159,7 @@ static int pxa_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct pxa_ep		*ep;
 	struct udc_usb_ep	*udc_usb_ep;
-	struct pxa27x_request	*req;
+	struct pxa27x_request	*req = NULL, *iter;
 	unsigned long		flags;
 	int			rc = -EINVAL;
 
@@ -1173,11 +1173,12 @@ static int pxa_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			rc = 0;
-			break;
-		}
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		req = iter;
+		rc = 0;
+		break;
 	}
 
 	spin_unlock_irqrestore(&ep->lock, flags);
-- 
2.25.1

