Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C997E5706AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiGKPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:10:43 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B95FAD7;
        Mon, 11 Jul 2022 08:10:41 -0700 (PDT)
Received: from andrey-lpc.intra.ispras.ru (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 4A85140737A7;
        Mon, 11 Jul 2022 15:10:37 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: cdns3: removed useless condition in cdns3_gadget_ep_dequeue()
Date:   Mon, 11 Jul 2022 18:10:32 +0300
Message-Id: <20220711151032.16825-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparison of 'ep' with NULL is useless since
'ep' is a result of container_of and cannot be NULL
in any reasonable scenario.


Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 64b558f597d1 ("usb: cdns3: Change file names for cdns3 driver.")
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 5c15c48952a6..f31b389ae0b2 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2608,7 +2608,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long flags;
 	int ret = 0;
 
-	if (!ep || !request || !ep->desc)
+	if (!request || !ep->desc)
 		return -EINVAL;
 
 	spin_lock_irqsave(&priv_dev->lock, flags);
-- 
2.25.1

