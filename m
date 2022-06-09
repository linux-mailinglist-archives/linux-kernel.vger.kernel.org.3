Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77929544EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbiFIO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbiFIO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:26:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C36FA1A;
        Thu,  9 Jun 2022 07:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8753561E14;
        Thu,  9 Jun 2022 14:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD75C34115;
        Thu,  9 Jun 2022 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654784787;
        bh=mJKU6IxtGb73K0o7zmE3+f0ogV7uh8EFo83lJ4xT0io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/GeapL4ZDGvqQVLPJ4mHudaXE56U/lDUQgXq3iPESeTAYN3rD2KCGIM8Oos1iWQb
         IcrZaVuXyCXoVkt6D7JaqZ1bu5uGpmzCyzSPSNBTBW/+L5GgpELAmqGQzeGBXn22Cf
         8e8nCo8M6waOrraC069U68L52LUp/QbVJu/lUbei4Mb0mBJsYj789geBPfVnKLq3PF
         wSFqPMpqfXg3lopLVb/BTmJSwO3LzRhtEvRfsg0Fv2EAOJwgWLQ4fFlpEmntSYAJmO
         vYsQLdExNEKiJ8ogQG2IB3LRws9Oz/14noxkGQB0HATZQbZj1PeFwDCdr/Fxd9VCgh
         3OgJvUGoSFyRw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzJ79-00069L-9r; Thu, 09 Jun 2022 16:26:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] media: flexcop-usb: clean up endpoint sanity checks
Date:   Thu,  9 Jun 2022 16:26:03 +0200
Message-Id: <20220609142605.23620-2-johan@kernel.org>
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

