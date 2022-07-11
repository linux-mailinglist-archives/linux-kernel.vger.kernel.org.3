Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7475706CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiGKPRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:17:51 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0048066BB6;
        Mon, 11 Jul 2022 08:17:50 -0700 (PDT)
Received: from andrey-lpc.intra.ispras.ru (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 430AE40737D8;
        Mon, 11 Jul 2022 15:17:49 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Bin Liu <b-liu@ti.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] usb: musb: remove useless condition from musb_gadget_dequeue()
Date:   Mon, 11 Jul 2022 18:17:36 +0300
Message-Id: <20220711151736.17382-1-strochuk@ispras.ru>
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
Fixes: 47e9760529a9 ("USB: musb_gadget: implement set_wedge() method")
---
 drivers/usb/musb/musb_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 51274b87f46c..32447b7b1976 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1271,7 +1271,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
 	int			status = 0;
 	struct musb		*musb = musb_ep->musb;
 
-	if (!ep || !request || req->ep != musb_ep)
+	if (!request || req->ep != musb_ep)
 		return -EINVAL;
 
 	trace_musb_req_deq(req);
-- 
2.25.1

