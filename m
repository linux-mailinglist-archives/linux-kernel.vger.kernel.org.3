Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF734E8AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiC0Wnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiC0Wmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A49B33367
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so7387986wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqdfmywTZ6fQ/7jJTAQIW5tJoHGg7kZG5yl6dza7Kzg=;
        b=KCIWiS+0zeAyMkBL0wxf40noDXnqtZrHjzyoklsSwYQXIZoSJjMZD5B0tlff61mKEa
         uUbpknkL0mh0Pe72eUpIJ8pE/35wd3aNUjvtj0ZBGrGFedALY7vVPRoA3znHAAadwzNq
         vGXrPkZgHnCK6wmY0ZZuAvSFHFl/KN6RglaSUMvpuKqTUw8Wb7lmssosBrjyDGDEXuad
         CJnlZ7FUsflKFD4nFCHkPumFs4DvX7Qg7fkJSKwmwO0VM7EtBnWXTBvxl4/5NWUDwBvG
         O78uxOpvi6ZG35LDGemTz4JIgKt6vkwrw0ekCZdsubL4S8VzdsBRrqRi7Z8nM0l8cP4g
         cPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqdfmywTZ6fQ/7jJTAQIW5tJoHGg7kZG5yl6dza7Kzg=;
        b=KgZyKWw1UB+ELvN6s7HAt2IsG+mvOYZ30AVzXH6ZykAlulf0WvbFoX0++/z5ymACEr
         s8OoschJ4y6wMAwCXyHKYxi98+s2iYjWtg+wc/BVaxoMeS2JihgIF0dn2B35UGHWpV+f
         +CfCU8DBDxZVuxFK4DmRgKrdfjo1MvdvFkzedwLkw5BL4uqtZHv4ZS45gbxDrOoNtqq1
         SuYPy/PTyZW6LtJoSRtjp7OQZYQEYy8eBnYEPHzzFgOfGCqfeOn1zmsduV6DskkGn7VE
         OOo46cl4xqrWNr69E9vAIuo4tGRHgkUCMQBobAD/ohwzPdPhJQIGYhZlnPW/10bjK31o
         Q+MA==
X-Gm-Message-State: AOAM530dX5RUdJz52CCL8cdGVgWWhjrJH642qjU9xByBbDDNH4EAo2Wc
        vdEfYOi35xySXs5JAPaX0o5Jnw==
X-Google-Smtp-Source: ABdhPJy0020PNRnBryews9tUG9uCMRDQysFLPzguWnTnvfaXr6qBSJOtbKhCXT5aSzXNCHr2ZIhXZg==
X-Received: by 2002:a05:600c:12c9:b0:38c:b319:6da2 with SMTP id v9-20020a05600c12c900b0038cb3196da2mr31709200wmd.125.1648420864103;
        Sun, 27 Mar 2022 15:41:04 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:03 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Subject: [PATCH v9 04/22] drm/edid: Convert cea_sad helper struct to kernelDoc
Date:   Mon, 28 Mar 2022 00:39:09 +0200
Message-Id: <20220327223927.20848-5-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
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
 include/drm/drm_edid.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 144c495b99c4..5d4d840b9904 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -359,12 +359,17 @@ struct edid {
 
 #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
 
-/* Short Audio Descriptor */
+/* struct cea_sad - Short Audio Descriptor.
+	@format: See HDMI_AUDIO_CODING_TYPE_*.
+	@channels: max number of channels - 1.
+	@freq: See CEA_SAD_FREQ_*.
+	@byte2: meaning depends on format.
+*/
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
2.34.1

