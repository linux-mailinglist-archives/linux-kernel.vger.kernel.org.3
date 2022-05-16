Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F947527E80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiEPHW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbiEPHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:22:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979B18341;
        Mon, 16 May 2022 00:22:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z2so26850700ejj.3;
        Mon, 16 May 2022 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=J4zEfCzFiz2vNhPIgLN9iLY5RMLWZ9r2xPcP4Z+eml4=;
        b=jTx6tyW8v5C7uUHu9n5jOilXZA2LzPMgXOixCTPK5+D/Jos2D30jcno1+1YGy5S0kg
         81mQ+TktykWhoIXLgeCVvfJe/ANynH7qefCbFs27lSOfOaPzHMeH+VWuCHDYkACFJ6VH
         D6qjGciPRBkfjl7hP06guRP67uRVU5VSvGh2CAcMV1x/dzQYt7D3JVVees9uXQHTWPDf
         6bHSv4NlhPaW/fCHo0mc5Uq2Z+k1zvrUx5XR8Q5XqXw4dED/GDYBYcznmSmSc1XEIfFu
         k90oMvk+RG9ojmHrAc748Z9RXf0muP0LDy+GFweC18teV/rCfGOneP9OdFzMlaF7i4Yr
         Jv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J4zEfCzFiz2vNhPIgLN9iLY5RMLWZ9r2xPcP4Z+eml4=;
        b=5XMElwM1ppTLWQu5K6AaG64camRvkNNlw3LuyxHd5ZpRXaEabA/nzUBVU3s3nmuoLR
         lPqVxUteqdcO1GrNtxuLNF7qbm00PCTgEciN29xqhPlnNtPwq9cK9Ru8KwrVpuKCA6fQ
         c6EfR0spzDlNLLJMWof6jm2wcUkxz+mHQwkAIKIYp13M6UV75+r+b8dUCt14MBk0oW7t
         9Z3+X+R30lBfCpFjBHporuhJ65HtqPeObrtu6XV+Vkys4x8aqhnSoN3xFyePHfs8olhR
         wlwlYSGTpFTkHi/XRa+4uu5rLfaOw2UGcwHxDUsJsNksoasfL0UPVkTHUydX7BlZPZRV
         oG2Q==
X-Gm-Message-State: AOAM533nPycPuBvOIWplBuKbjytbLor56VyBOERllolRIYUMs48oaDX4
        GApWrKSCyVY6TdGUQnbfRfY=
X-Google-Smtp-Source: ABdhPJwQJSawA7JRHf14WPm4hYYYxXwwXeH60jg1o4+rfg9vJsnrU3YGEdPPKSETS4TZktUGXcd/vA==
X-Received: by 2002:a17:907:969f:b0:6f3:dede:f2d2 with SMTP id hd31-20020a170907969f00b006f3dedef2d2mr13684088ejc.511.1652685769688;
        Mon, 16 May 2022 00:22:49 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id el10-20020a170907284a00b006f3ef214e2csm3434769ejc.146.2022.05.16.00.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:22:49 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>,
        Furkan Kardame <f.kardame@manjaro.org>
Subject: [PATCH] drm/meson: add YUV422 output support
Date:   Mon, 16 May 2022 07:22:45 +0000
Message-Id: <20220516072245.10745-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongjin Kim <tobetter@gmail.com>

Support YUV422 output from the Amlogic Meson SoC VPU to the HDMI
controller. Without this YUV422 format out of the HDMI encoder
leads to using the dw-hdmi YUV444 to YUV422 color conversion which
gives wrong colors and a green line on the left edge of the screen.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Furkan Kardame <f.kardame@manjaro.org>
---
I've had this patch in my sources for some time now; originally picked
from Dongjin's mainline branches for Hardkernel boards and tweaked for
some minor renaming after DRM bridge changes were merged. Furkhan has
reminded me this is still needed a couple of days ago and now the same
issue is reported on the mailing list [0] so best to submit it. If a
fixes tag is required? please advise the commit and i'll resend.

 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 5e306de6f485..08529efb4405 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -218,7 +218,8 @@ static void meson_encoder_hdmi_atomic_enable(struct drm_bridge *bridge,
 	if (encoder_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24) {
 		ycrcb_map = VPU_HDMI_OUTPUT_CRYCB;
 		yuv420_mode = true;
-	}
+	} else if (encoder_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYVY8_1X16)
+		ycrcb_map = VPU_HDMI_OUTPUT_CRYCB;
 
 	/* VENC + VENC-DVI Mode setup */
 	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, yuv420_mode, mode);
@@ -230,6 +231,10 @@ static void meson_encoder_hdmi_atomic_enable(struct drm_bridge *bridge,
 		/* Setup YUV420 to HDMI-TX, no 10bit diphering */
 		writel_relaxed(2 | (2 << 2),
 			       priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
+	else if (encoder_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYVY8_1X16)
+		/* Setup YUV422 to HDMI-TX, no 10bit diphering */
+		writel_relaxed(1 | (2 << 2),
+				priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
 	else
 		/* Setup YUV444 to HDMI-TX, no 10bit diphering */
 		writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
@@ -257,6 +262,7 @@ static void meson_encoder_hdmi_atomic_disable(struct drm_bridge *bridge,
 
 static const u32 meson_encoder_hdmi_out_bus_fmts[] = {
 	MEDIA_BUS_FMT_YUV8_1X24,
+	MEDIA_BUS_FMT_UYVY8_1X16,
 	MEDIA_BUS_FMT_UYYVYY8_0_5X24,
 };
 
-- 
2.17.1

