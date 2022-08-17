Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7D597076
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiHQOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbiHQOGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:06:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625A1027
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:06:00 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 591B63FB9E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660745158;
        bh=kSCXGcq5H05zQq19jPsNfhJBW132uDa7sGBTwXgYgjg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KBbSNTjXgKB+hfMjyZXcHlrE4zw1iZCQ4ydhUPhr7NzVd+HkWp2zAQERmXZr2Bk9U
         a+GxDlEDHEvvkA66dHHxRr1XeQtwNkGYdnU/elZFwEYL+NN88VkJDmYw8Po7FAWmNP
         dgDWk1pzTvEj2xvBfknUamhZe/Hca+aZmPtFlfz534eSVP81tdjmw+793CKchrjmph
         vOW4kE7xSHVCjF7oYM0Mp/JIqKyjg+AvutW9mHwCu/A6+BBo1QRmg7w0l9viD6WXgL
         RvdR2Bu61L28FfWdJpOnzc0IcnyM4TxRaHIBpT5vg/V0c76lr3xd5HWTeg0Nd9alzG
         pz3fy4K4FBMXg==
Received: by mail-ed1-f72.google.com with SMTP id w5-20020a05640234c500b0043dda025648so8810928edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kSCXGcq5H05zQq19jPsNfhJBW132uDa7sGBTwXgYgjg=;
        b=5aBdPd8cuJiBy8smIa+4Mn3U0qF8kEgZQ4LbsDhtHvu1wNLkiHnjdGa3bGfLgRmZ29
         kxHDmvzg7VipksMjvaeJwNNPHeKHrY1AzJ9mwzeV813u1TDG2qPY3rt5amc2ET+svNw/
         TZTCoX0z2IiHDkwos3jnhHS+2jT31qgKGEogyrpTgJ4qAKIe/AiVU5w4rSDGiZllvNTN
         MqODAapEp48dZC8351Z10i0a9ZtRFm0JNmWVD0vp4c7Gf/px+cj6cVlHVnvZX+5bd4bh
         wvbhfs2Kvx8mL43F5o7KO/P521kO2vHLI3xznDNELC32mSFibKVnv5+7xwZozscHeSSW
         VvDw==
X-Gm-Message-State: ACgBeo3Mr8xTZoGodtdsWi1RsaYNa74Z6h0CPVzoDzYs/+Xx4CFPsyAY
        42UYntz4oqGe77Ve4ck3yoEYsNXHBOuTsYnqieTpjEolMJcZQvUVdr+VrkeQ5eWg0PYixMLHRXT
        o74+dCz/fiFE3BU0ma1iNVXGUINhMjhQxxTtOITTCHQ==
X-Received: by 2002:a17:907:2814:b0:738:545f:54be with SMTP id eb20-20020a170907281400b00738545f54bemr9113430ejc.534.1660745158120;
        Wed, 17 Aug 2022 07:05:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7vF5bJb6zsBPhAQ1W8GKZlyq4EQV66kfHwkKI4Mx/QZf+aSWQo229JOM7T+wVina/z5et9Hw==
X-Received: by 2002:a17:907:2814:b0:738:545f:54be with SMTP id eb20-20020a170907281400b00738545f54bemr9113413ejc.534.1660745157911;
        Wed, 17 Aug 2022 07:05:57 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906309700b0072b342ad997sm6737603ejv.199.2022.08.17.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:05:57 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] media: meson: vdec: Add MODULE_FIRMWARE macro
Date:   Wed, 17 Aug 2022 16:05:39 +0200
Message-Id: <20220817140539.150013-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson-vdec module loads firmware so add MODULE_FIRMWARE macros to
provide that information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 .../staging/media/meson/vdec/vdec_platform.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/staging/media/meson/vdec/vdec_platform.c
index 88c9d72e1c83..c7750d4be848 100644
--- a/drivers/staging/media/meson/vdec/vdec_platform.c
+++ b/drivers/staging/media/meson/vdec/vdec_platform.c
@@ -280,3 +280,23 @@ const struct vdec_platform vdec_platform_sm1 = {
 	.num_formats = ARRAY_SIZE(vdec_formats_sm1),
 	.revision = VDEC_REVISION_SM1,
 };
+
+MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
+MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
+MODULE_FIRMWARE("meson/vdec/g12a_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxbb_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxm_h264.bin");
+MODULE_FIRMWARE("meson/vdec/sm1_vp9_mmu.bin");
-- 
2.34.1

