Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4254355B5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiF0DLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiF0DLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:11:47 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49601388F;
        Sun, 26 Jun 2022 20:11:46 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 23D241E80D5E;
        Mon, 27 Jun 2022 11:10:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r7PXBy4w9chS; Mon, 27 Jun 2022 11:10:51 +0800 (CST)
Received: from nfschina.com.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhounan@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7302F1E80D11;
        Mon, 27 Jun 2022 11:10:51 +0800 (CST)
From:   zhoun <zhounan@nfschina.com>
To:     gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, jakobkoschel@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lutovinova@ispras.ru, zhounan@nfschina.com
Subject: [PATCH v2] usb: remove unnecessary mv_u3d* conversion
Date:   Sun, 26 Jun 2022 23:11:08 -0400
Message-Id: <20220627031108.12246-1-zhounan@nfschina.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YrV2aQc8lB6wDEbE@kroah.com>
References: <YrV2aQc8lB6wDEbE@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou nan <zhounan@nfschina.com>

remove unnecessary mv_u3d* type casting.
After analysis, the two u3d objects have the same type.

Signed-off-by: Zhou nan <zhounan@nfschina.com>
---
 drivers/usb/gadget/udc/mv_u3d_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index 598654a3cb41..102278a71307 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -175,7 +175,7 @@ void mv_u3d_done(struct mv_u3d_ep *ep, struct mv_u3d_req *req, int status)
 	__releases(&ep->udc->lock)
 	__acquires(&ep->udc->lock)
 {
-	struct mv_u3d *u3d = (struct mv_u3d *)ep->u3d;
+	struct mv_u3d *u3d = ep->u3d;
 
 	dev_dbg(u3d->dev, "mv_u3d_done: remove req->queue\n");
 	/* Removed the req from ep queue */
-- 
2.27.0

