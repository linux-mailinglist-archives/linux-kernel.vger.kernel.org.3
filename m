Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB759C299
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiHVPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiHVPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:21:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C196419BA;
        Mon, 22 Aug 2022 08:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 916F7B81252;
        Mon, 22 Aug 2022 15:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D724C433D6;
        Mon, 22 Aug 2022 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661181312;
        bh=mJKU6IxtGb73K0o7zmE3+f0ogV7uh8EFo83lJ4xT0io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4aVr/l97IpgBUzDaCdRJ/n1iABrcNKxKymZyyaCC6Ho4J/LEbj+V0crRKqgO1g6y
         ssjRTLRXrAXO/bNLw0h1rn2HI62SomwIX5acIJyIXBAWsrw9IO9FDbwfZ8YGzQstbL
         B4xEqA4rWJSoh8OQNSWbqEh7cO7w37NuItsnntAblflS6UnvnO/nBZPVZpDE+O9hHu
         TA3ED/gxpO5Xu5xrvc9w45bZY+5M6RZOkmTAQzci9sJhujCA8PQ9zFGAlgZg6wvpAk
         rHI4p6p42M+/falRCWuRFg867pD1i7gFmXlF89OPc76+ylDO+kmeoUcnT1T6Latix9
         jbhd1qBPJai7w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ98w-00074h-BM; Mon, 22 Aug 2022 17:15:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH RESEND 1/3] media: flexcop-usb: clean up endpoint sanity checks
Date:   Mon, 22 Aug 2022 17:14:54 +0200
Message-Id: <20220822151456.27178-2-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220822151456.27178-1-johan@kernel.org>
References: <20220822151456.27178-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a temporary variable to make the endpoint sanity checks a bit more
readable.

While at it, fix a typo in the usb_set_interface() comment.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/media/usb/b2c2/flexcop-usb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index e012b21c4fd7..31dd37d8236c 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -501,17 +501,21 @@ static int flexcop_usb_transfer_init(struct flexcop_usb *fc_usb)
 
 static int flexcop_usb_init(struct flexcop_usb *fc_usb)
 {
-	/* use the alternate setting with the larges buffer */
-	int ret = usb_set_interface(fc_usb->udev, 0, 1);
+	struct usb_host_interface *alt;
+	int ret;
 
+	/* use the alternate setting with the largest buffer */
+	ret = usb_set_interface(fc_usb->udev, 0, 1);
 	if (ret) {
 		err("set interface failed.");
 		return ret;
 	}
 
-	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
+	alt = fc_usb->uintf->cur_altsetting;
+
+	if (alt->desc.bNumEndpoints < 1)
 		return -ENODEV;
-	if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[0].desc))
+	if (!usb_endpoint_is_isoc_in(&alt->endpoint[0].desc))
 		return -ENODEV;
 
 	switch (fc_usb->udev->speed) {
-- 
2.35.1

