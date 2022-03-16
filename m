Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0904DB201
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353614AbiCPN76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiCPN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:59:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F96541D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:58:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d7so3097598wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s6m9aC6ErC5jFLU7fXW7B9m4H4WVAslUM1/WFG9oE0=;
        b=VH23sZTxL2r3MDruxIZTnefpHWNhrjNaJ53us5jukGDBXfjJWXUyXgPJJc7jk3XfnP
         ZPjx6gZ1RXhY9vy/Z7ZEL8EMcIR5dDVOUkf0f6fHAAlqa8BQWZXpkx+yWoHan9V6zOp5
         njXNxh9IBuWxtCjkb7ITxZ3FJpFbOO3bmZXieEDrlQROKPR6w016WA+SLLdy+HJlb1dF
         Ars3LA33WTc/JA3YA1lwdZeYtzVSPTuW0Yf5hcjuNssDA4UiO5ZMNvrzr3PqL95xodce
         uZRPv17JpcBC3vlI6wzW2vYtVCGYdi33D4ruZj9Ir4oORVPRhdY4vOTloPnOKcUhiefc
         2A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s6m9aC6ErC5jFLU7fXW7B9m4H4WVAslUM1/WFG9oE0=;
        b=pEP1HhC0jjmAVLARo/T6tCaui/JQaqNL8RPHrvDsEGbID3wwyorTAqAfX8xWhAifne
         nFAZsGpolp1nBtat5/J7rvCmo+iMiv3905K5KUaTN0RZSM3ZjA1pWvcMwllw9EFeBxjC
         4x6W63B7aFFEitnY9idd+5C89nsH5fsxKcD/UEm6g05MIEzDDU5kRiICMNOt1LiyISIa
         UpfFc+xdHshEzLhetomSAxL2nRyCvCUjcnbw/ZhhC9z+ryUBBEunGT+9GnJGod1+Bn+u
         0kgfOHUe1WSeYCUoSaMu3uZOlnuDluV9jb4IhkbT+lypmBOkVKxYE042Oo66a7SNBVfS
         PIog==
X-Gm-Message-State: AOAM531qNVbo6UmTOclQNRLngCE+rYPjYgQJBwXwgVVC/WsSAcbFsCao
        5GPE2x+QDypvgTqOWU1Mh3gfDA==
X-Google-Smtp-Source: ABdhPJzym5XQB1hTKfyzEYFHEVJAMLUtUJ/4esfiP3VnDDCHuPt8YpDKbwA10sxLnZQlLyrNiSqHvA==
X-Received: by 2002:a5d:43c2:0:b0:1f1:d99c:fafd with SMTP id v2-20020a5d43c2000000b001f1d99cfafdmr121188wrr.282.1647439116044;
        Wed, 16 Mar 2022 06:58:36 -0700 (PDT)
Received: from localhost.localdomain ([37.173.241.155])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm1790563wmb.37.2022.03.16.06.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:58:35 -0700 (PDT)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     narmstrong@baylibre.com, andrzej.hajda@intel.com,
        robert.foss@linaro.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH 2/3] drm: bridge: it66121: Fix the register page length
Date:   Wed, 16 Mar 2022 14:57:32 +0100
Message-Id: <20220316135733.173950-3-nbelin@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316135733.173950-1-nbelin@baylibre.com>
References: <20220316135733.173950-1-nbelin@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the register page length or window length to
0x100 according to the documentation.

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 06b59b422c69..64912b770086 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -227,7 +227,7 @@ static const struct regmap_range_cfg it66121_regmap_banks[] = {
 		.selector_mask = 0x1,
 		.selector_shift = 0,
 		.window_start = 0x00,
-		.window_len = 0x130,
+		.window_len = 0x100,
 	},
 };
 
-- 
2.25.1

