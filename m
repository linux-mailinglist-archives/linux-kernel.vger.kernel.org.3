Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3F5343A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbiEYTHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbiEYTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:06:45 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22A11171;
        Wed, 25 May 2022 12:06:40 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4D581C000E;
        Wed, 25 May 2022 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIhItMaoCnkWqyhSFVbn20u15vvXwqMOPRlHHrZFzpg=;
        b=XsX/QCgIDhf08pk19d9ePgx3zHC/H0iVkrvSXuA9UGqCgJgIdRlog5d8L3atrKsbyFZe0q
        435c2KkTNB7KAKng5i1Xd6qFl2RT6hQm4BGPe2apDPIrDdOEcQpsjGe9bKSFFUn/BGOqPv
        LSmE1e0CTi/34JixY+dGqayyxz62zobp7F8vrZ8jjsT5m1Ya9K5/FCblUxx2tDeTbmlbQp
        gHCZc/nasRF/k2RPpI6ntEynXvwg21aLLROSUIlyxzYOYuFA2aAzdz8jZPX6uExbqPeWrR
        Hi+P9X54siuoKn6xUongss87Qhhp4s/tBBGzn8jcNow5nftg1dc6gEmCZaJ/Nw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 11/44] media: sun6i-csi: Register the media device after creation
Date:   Wed, 25 May 2022 21:05:44 +0200
Message-Id: <20220525190617.696344-12-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no particular need to register the media device in the
subdev notify complete callback.

Register it in the v4l2 code instead where it's more in-context.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index a55347b7a6d6..e3d60b647cb2 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -638,7 +638,7 @@ static int sun6i_subdev_notify_complete(struct v4l2_async_notifier *notifier)
 	if (ret < 0)
 		return ret;
 
-	return media_device_register(&v4l2->media_dev);
+	return 0;
 }
 
 static const struct v4l2_async_notifier_operations sun6i_csi_async_ops = {
@@ -685,6 +685,12 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 
 	media_device_init(media_dev);
 
+	ret = media_device_register(media_dev);
+	if (ret) {
+		dev_err(dev, "failed to register media device: %d\n", ret);
+		goto error_media;
+	}
+
 	/* V4L2 Control Handler */
 
 	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
@@ -744,6 +750,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
 
 error_media:
+	media_device_unregister(media_dev);
 	media_device_cleanup(media_dev);
 
 	return ret;
-- 
2.36.1

