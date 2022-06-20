Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0D1552335
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbiFTRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244357AbiFTRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:55:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30E19C2F;
        Mon, 20 Jun 2022 10:55:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q9so15692682wrd.8;
        Mon, 20 Jun 2022 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDUyLN4Pryhtw9N4iCwOXaC7LwBCPSfNWeiXJOlMPkg=;
        b=j/IwIO3a0ts7j8gthEBmCMeJ6vuYBo7HD3mAfvcgjHRCoMpwlDgxlGwUcshfULkvl4
         ux3FYylaS1HAhyCbCRfcmlKK1iAcVIKdHj+yrmEOFmbCiXy6V4a+wtYGsPZNyzriN7gj
         qibFoseY20ti4Hsd7U+99+ibAKfJP5EBKJdU/FlP9ttzN48lcL6Bq6/z2ymORhORcBwJ
         BXN+XPG9XT/9ERCFxVBGFR0BZ0k4DrArLCAsL4vyu6pZqBPvD491gJMHWamNmvy2eHEg
         mgeSu4G8QcNhmdcgLErLyKtI1w09RHh+nQTOnlXS8hnZ04a5zgRLlkN+ELVwpZTw1k7V
         lzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDUyLN4Pryhtw9N4iCwOXaC7LwBCPSfNWeiXJOlMPkg=;
        b=oqSF9K8yPZRDZmher/VL7emOa3TGo981XfDiVwQKUqoAqUePFlNvg25t4GXvsBx/sd
         3LS2k5Wm8PVFgQuSoAjbzcYxqLMGDNbKCa4G4y5IblKrgNIXiVcId2pBvbopaiG1KdCo
         K52YHFQdGR6SuubieQ/Bg8DxYO/s2Xg7AKHhtMkXrQG1NfbMnvr5ixD13BFkjO7L5o6v
         6iI3m/OM/JQOaNnmCaWnyFTfZL5oOBmklMhT6IcmrVsuETw55BBtoWL/LaO3a2qwi2aN
         8Ph99I3v0rfbvFwwdoShV7LvwWnczcs4Rr2rb6mhZA+juz0loj81s4pLs6Xcu8SP0Tcv
         cdgQ==
X-Gm-Message-State: AJIora98Qg9RXINEMB8DgMge9ex2dX4dhIbG523okHDAgqGOSFQ5EBEQ
        TQeojTgl61U3zkCNaE4TP08=
X-Google-Smtp-Source: AGRyM1vzYBSQFI6blw/ovMZUI5R79+0X2OmRbBajL6gKqGWCQJxqwYvaZKB0wzV66Sh9rKiSy4aM9w==
X-Received: by 2002:a5d:5c08:0:b0:219:e5de:72af with SMTP id cc8-20020a5d5c08000000b00219e5de72afmr23720384wrb.513.1655747733393;
        Mon, 20 Jun 2022 10:55:33 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 184-20020a1c02c1000000b0039db31f6372sm19620752wmc.2.2022.06.20.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:55:33 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/7] media: cedrus: Improve error messages for controls
Date:   Mon, 20 Jun 2022 19:55:13 +0200
Message-Id: <20220620175517.648767-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620175517.648767-1-jernej.skrabec@gmail.com>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
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

Currently error messages when control creation fails are very sparse.
Granted, user should never observe them. However, developer working on
codecs can. In such cases additional information like which control
creation failed and error number are very useful.

Expand error messages with additional info.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index b12219123a6b..99c87319d2b4 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -242,7 +242,8 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 	v4l2_ctrl_handler_init(hdl, CEDRUS_CONTROLS_COUNT);
 	if (hdl->error) {
 		v4l2_err(&dev->v4l2_dev,
-			 "Failed to initialize control handler\n");
+			 "Failed to initialize control handler: %d\n",
+			 hdl->error);
 		return hdl->error;
 	}
 
@@ -257,7 +258,9 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 					    NULL);
 		if (hdl->error) {
 			v4l2_err(&dev->v4l2_dev,
-				 "Failed to create new custom control\n");
+				 "Failed to create %s control: %d\n",
+				 v4l2_ctrl_get_name(cedrus_controls[i].cfg.id),
+				 hdl->error);
 
 			v4l2_ctrl_handler_free(hdl);
 			kfree(ctx->ctrls);
-- 
2.36.1

