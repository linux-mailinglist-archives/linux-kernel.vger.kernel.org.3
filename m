Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7614D1E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241580AbiCHRUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348891AbiCHRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F85554196;
        Tue,  8 Mar 2022 09:19:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h13so13272650ede.5;
        Tue, 08 Mar 2022 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKBqq8H8G0r7u4YOEB6Uo0ujE9phZkj1yTyESdTdeCM=;
        b=ZFc9SayGmZuwBLkbiqoy2iDFk5f3qgEhdtJj3Dv7GHS2ypdaZTjxauZ+hlp0trYtJa
         6M4QEG5riT1if7unqpPROovPT4iZy7DxsyzKiO2keZ0zP9SCUfH7za56UNf4yhEYiR1W
         Zv+nf4lMjwR3fkHJjnmEWcK2WW460qfUBwPOMjkzv3eCkyDQyykoDbItDltUuRcTwrJr
         pG4CP1bXQLDtWdHmUqjSgKORnsAbOU39eGOAbT2p8g3172LnhTr91WyaVlTWNbKBB2zn
         NIRM0BhkmF4hLKwhkuY7VdmK0q5FKA7xmA8wUQfGsEiCXrWBclx4AShbCuvx1pPHky0J
         VNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKBqq8H8G0r7u4YOEB6Uo0ujE9phZkj1yTyESdTdeCM=;
        b=CWBilmSslu5Oi2bneCx+AoGqfJSYyp8V7Lf/icZlvFCqEJhe8083qF0+zt99X8tnHo
         52GUpid3dd8RrMX+L+ZydDd3ZsqvdHopharXixVHwCO7C8g9ij0Ehp1JC7qQZtwG8qD7
         VEOftuHA8tBw8jmXUl1gXkvHz8/qcXkUXPy5AFXd77accdXNlJorPMZvZcoRrtyN4X0D
         HRTsh2hvPpXnQ6AOXBrjh9vJ2tLhONjHQQk3JyQuwkruYOnwyLfH1QZkMqcp6M6s+FL/
         gh/FAENHMhziuBDTM4r5qVYkP1THtvFVLxJiGjaJAjTQEdKfrMwcPqMXWZpetNtfTZvS
         lGng==
X-Gm-Message-State: AOAM530SPcdggP13rsXv/yvz2e8xryZgKd9OZUzkkCwJ5Jb41bbUEmnB
        PlRvzLoiMBHrR0SqsLq0vZU=
X-Google-Smtp-Source: ABdhPJyM1gC52QuGTeL8TtyGBMOIEOKlyECvrtuFR/2dTrbGjWxPBGFVVbIaUboCG3sJrNF8ZedJPg==
X-Received: by 2002:a05:6402:40c4:b0:416:3e66:1825 with SMTP id z4-20020a05640240c400b004163e661825mr12232139edb.284.1646759947785;
        Tue, 08 Mar 2022 09:19:07 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:07 -0800 (PST)
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
Subject: [PATCH v2 02/26] usb: gadget: bdc: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:17:54 +0100
Message-Id: <20220308171818.384491-3-jakobkoschel@gmail.com>
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

If the list representing the request queue does not contain the expected
request, the value of the list_for_each_entry() iterator will not point
to a valid structure. To avoid type confusion in such case, the list
iterator scope will be limited to the list_for_each_entry() loop.

In preparation to limiting scope of the list iterator to the list traversal
loop, use a dedicated pointer to point to the found request object [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_ep.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index 8e2f20b12519..fa88f210ecd5 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -1757,6 +1757,7 @@ static int bdc_gadget_ep_dequeue(struct usb_ep *_ep,
 				  struct usb_request *_req)
 {
 	struct bdc_req *req;
+	struct bdc_req *iter;
 	unsigned long flags;
 	struct bdc_ep *ep;
 	struct bdc *bdc;
@@ -1771,12 +1772,16 @@ static int bdc_gadget_ep_dequeue(struct usb_ep *_ep,
 	dev_dbg(bdc->dev, "%s ep:%s req:%p\n", __func__, ep->name, req);
 	bdc_dbg_bd_list(bdc, ep);
 	spin_lock_irqsave(&bdc->lock, flags);
+
+	req = NULL;
 	/* make sure it's still queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->usb_req == _req)
-			break;
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->usb_req != _req)
+			continue;
+		req = iter;
+		break;
 	}
-	if (&req->usb_req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&bdc->lock, flags);
 		dev_err(bdc->dev, "usb_req !=req n");
 		return -EINVAL;
-- 
2.25.1

