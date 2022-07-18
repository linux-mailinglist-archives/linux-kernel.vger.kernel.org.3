Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34355786E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiGRQBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiGRQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:01:19 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519425E86;
        Mon, 18 Jul 2022 09:01:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 594DE40737DF;
        Mon, 18 Jul 2022 16:01:11 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()
Date:   Mon, 18 Jul 2022 19:00:52 +0300
Message-Id: <20220718160052.4188-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'ep' is NULL, result of ep_to_cdns3_ep(ep) is invalid pointer
and its dereference with priv_ep->cdns3_dev may cause panic.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
---
 drivers/usb/cdns3/cdns3-gadget.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 5c15c48952a6..aea5db0ec72d 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2285,13 +2285,14 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	int val;

 	priv_ep = ep_to_cdns3_ep(ep);
-	priv_dev = priv_ep->cdns3_dev;
-	comp_desc = priv_ep->endpoint.comp_desc;
 
 	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
 		dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
 		return -EINVAL;
 	}
+
+	comp_desc = priv_ep->endpoint.comp_desc;
+	priv_dev = priv_ep->cdns3_dev;

 	if (!desc->wMaxPacketSize) {
 		dev_err(priv_dev->dev, "usbss: missing wMaxPacketSize\n");
@@ -2600,7 +2601,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 			    struct usb_request *request)
 {
 	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
-	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_device *priv_dev;
 	struct usb_request *req, *req_temp;
 	struct cdns3_request *priv_req;
 	struct cdns3_trb *link_trb;
@@ -2610,6 +2611,8 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	if (!ep || !request || !ep->desc)
 		return -EINVAL;
+
+	priv_dev = priv_ep->cdns3_dev;

 	spin_lock_irqsave(&priv_dev->lock, flags);

-- 
2.25.1

