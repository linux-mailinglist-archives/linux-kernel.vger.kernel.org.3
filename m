Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0A530F77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiEWKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbiEWKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:50:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0394D267
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:50:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so33316wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTipBQpMUHbzIB78SpRWE0aZpYF7CdaIwWlizpfEkA0=;
        b=ePI8JS1mctfDL3dO9htUkRnfmok+YrhIapLwhHYJPfR8R6GHhgxiX+EigQq0lWaOpa
         lUd2frUxdmDwV7VrhqQr91fhoNYg/dCnRsaUbXVQH/n0MSOxc2u6ym2Eo/FzjARm3FZZ
         gT+TczI/6Ypbtptd2PpNgkl04Scq72HVRoijaHEUnKF373aE9elxK0gAB/R0Up6QO3Xh
         jHMDPMiEaZfbkMsRtMjLLS+doUDFrhZavCPihsU9CxC8ITzIaWeNfpcDzlCiSHix1Kfb
         B1GW23MiJ0rJWCpI3iknt5r8G47/AngXfA0crnTiZtsLb3jjXWVeWCOZXcAjy/UlQFcP
         vVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTipBQpMUHbzIB78SpRWE0aZpYF7CdaIwWlizpfEkA0=;
        b=p+3xgpukVC5Aw3p9q1uTleiXfDFRlYOffwaNIS/7sNUYilmBDZ3WOHJlk9TdkvYOmu
         KIVgHa27xzzHoUI7ANsIgRciY5yW7cS5XzZBE8PExHBbUE/ZeaLnziu1hpgUUP9ClQ8M
         pIY6VOsnx3sYl7L8MKUBWD7CV0IA8MENQMIbQvo1w2vxRN2ee+8EiM0CrEOJUOzGSyPy
         isLWkbRItZ6lP1ujzM2UtkuC9c+BIgyw5UVK8EaYHI0PWjJLT1xj0U8+UJ5bOoNmdw+t
         HHspVrsJ7slP17/AFPDQij8Y/mwxSBz4xJkXS91ObjjR3GWGYhDBJSyu/MWgsbl89/F0
         OFPA==
X-Gm-Message-State: AOAM5309S7zNqgAf8slyEesGcWl80+bWKQSFtAY+IgiVvSuKh0XuJaPP
        PJpC0TEwaMCHLpwh+/n67wz3NA==
X-Google-Smtp-Source: ABdhPJygVo7Uq8Hm69+Q7YlNBB/Vn/rNG0nxqMPhhVn6Gufk9PmyiPIHQHKU66sNdjrJCeJcttYnEw==
X-Received: by 2002:a05:600c:348c:b0:397:4f69:775f with SMTP id a12-20020a05600c348c00b003974f69775fmr2120929wmq.24.1653303024598;
        Mon, 23 May 2022 03:50:24 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:50:24 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Helge Deller <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 03/21] drm/edid: Convert cea_sad helper struct to kernelDoc
Date:   Mon, 23 May 2022 12:47:36 +0200
Message-Id: <20220523104758.29531-4-granquet@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523104758.29531-1-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 include/drm/drm_edid.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 144c495b99c4..37c420423625 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -359,12 +359,18 @@ struct edid {
 
 #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
 
-/* Short Audio Descriptor */
+/**
+ * struct cea_sad - Short Audio Descriptor.
+ * @format: See HDMI_AUDIO_CODING_TYPE_*.
+ * @channels: max number of channels - 1.
+ * @freq: See CEA_SAD_FREQ_*.
+ * @byte2: meaning depends on format.
+ */
 struct cea_sad {
 	u8 format;
-	u8 channels; /* max number of channels - 1 */
+	u8 channels;
 	u8 freq;
-	u8 byte2; /* meaning depends on format */
+	u8 byte2;
 };
 
 struct drm_encoder;
-- 
2.35.1

