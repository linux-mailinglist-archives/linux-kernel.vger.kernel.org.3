Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A215544EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbiFIO0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbiFIO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:26:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158582DC23B;
        Thu,  9 Jun 2022 07:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A605D61DDF;
        Thu,  9 Jun 2022 14:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F86C341C4;
        Thu,  9 Jun 2022 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654784787;
        bh=/TNMqXAFkzzbD2nFZOZ+zBMA3FkHrzThtNSNS4wQTRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmsx1unYC9DAg/0BWCk/6+3msjIV8TD9HmDDtDV1AzOsXfwZKke2B3Y6uf2IYcwLY
         rmzFWSt7IElyFoLrASe8r1x77YXD/0Oy/eryBsUwvtzxwkww7go+JYMUThMmDJOvNh
         iFSO0YyBDdTIlgAu7LmvEicYpezNzr+quBULi0CBqyYRf/3v7lTIB1rqqYeRgps2S5
         v/b2mugsw9KL9jJcuQ/O843s/GKHbpX7jV/1yNkJrpt8Hcqy1VYHf1CUj/5td1DxdK
         QL6snTaSE6W1qUzocZBX96T5/+EgH8Ww5WbUfwONknxYtAV9IvAAHpcjxATuJJPQLI
         Jmn9S1u8Bjghw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzJ79-00069N-Cj; Thu, 09 Jun 2022 16:26:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] media: flexcop-usb: clean up URB initialisation
Date:   Thu,  9 Jun 2022 16:26:04 +0200
Message-Id: <20220609142605.23620-3-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609142605.23620-1-johan@kernel.org>
References: <20220609142605.23620-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

