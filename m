Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64D259C28B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiHVPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiHVPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7B3DBE3;
        Mon, 22 Aug 2022 08:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D855D610A3;
        Mon, 22 Aug 2022 15:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411D6C433C1;
        Mon, 22 Aug 2022 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661181312;
        bh=/TNMqXAFkzzbD2nFZOZ+zBMA3FkHrzThtNSNS4wQTRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anMmDAU/uld9xgko3X5FETrFRedS3WY/nROOoODI38BxFOZfWl40rHDS3kkQT8wAD
         fTihu/DAVOjYjHmNpiae4Xif4oMdiUybw7RzYodfu7HoE9Ge036smsOl0Et9Tfsimq
         hTUaaZgwaOGWp06MuVG/r5l1VBZTymVP6xVfo2qFYdGh92Yw+C4ajtIslQ5jYzXvYs
         cvoTg5KUiegWlYqmYdwVQRijF+lInrKN6DFOLubDBKVLgSvO/Bj4DQ9n8ItQWEZPXY
         +6TW3s0Mskezycy8t2biLpisyzAyja+sBMb6s0Fv23nI0UfWt/BjgBeYiYrUMkAlT5
         ypCVM6g3ECDuQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ98w-00074j-EV; Mon, 22 Aug 2022 17:15:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH RESEND 2/3] media: flexcop-usb: clean up URB initialisation
Date:   Mon, 22 Aug 2022 17:14:55 +0200
Message-Id: <20220822151456.27178-3-johan@kernel.org>
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

Clean up URB initialisation somewhat by introducing a temporary variable
and separating declaration and non-trivial initialisation.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/media/usb/b2c2/flexcop-usb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 31dd37d8236c..7102b346db05 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -425,12 +425,14 @@ static void flexcop_usb_transfer_exit(struct flexcop_usb *fc_usb)
 
 static int flexcop_usb_transfer_init(struct flexcop_usb *fc_usb)
 {
-	u16 frame_size = le16_to_cpu(
-		fc_usb->uintf->cur_altsetting->endpoint[0].desc.wMaxPacketSize);
-	int bufsize = B2C2_USB_NUM_ISO_URB * B2C2_USB_FRAMES_PER_ISO *
-		frame_size, i, j, ret;
+	struct usb_host_interface *alt = fc_usb->uintf->cur_altsetting;
+	u16 frame_size;
+	int bufsize, i, j, ret;
 	int buffer_offset = 0;
 
+	frame_size = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
+	bufsize = B2C2_USB_NUM_ISO_URB * B2C2_USB_FRAMES_PER_ISO * frame_size;
+
 	deb_ts("creating %d iso-urbs with %d frames each of %d bytes size = %d.\n",
 	       B2C2_USB_NUM_ISO_URB,
 			B2C2_USB_FRAMES_PER_ISO, frame_size, bufsize);
-- 
2.35.1

