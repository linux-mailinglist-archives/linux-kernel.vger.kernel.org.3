Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D55265E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381876AbiEMPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381903AbiEMPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:20:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3F067D2F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:20:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t6so11896432wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ec2V5shBteoRtCqtxfW2R62kxRNZBNcV3MF01Vbbug=;
        b=Dz/TgheE2kSeXBPeznCYl+5Ffu99oqRAdGfjpKNzMd2xb5x3Eyfp257Vb01Av0iTJD
         SA8xNL4ghJZod04teSU8QYNC12/sQ0h08m6/HG9I6sJr8soW/ngrRjiaIgW7ApLvPtWu
         dDbH92Y16pL02ChfwxiY1iEZkcTXjYhvvphtwX+TtagLcctGLCU3v+Tlu8R3gTnxEeWQ
         LK950UHURpgod8cncO1kRtDZSq0Vv2TBE8SLI0njm3MVK16/uplc2Wfe8NwZ7Ibw4iZC
         7VRDtL642U3ybvcJ1hNXkuQy2L24VpipJj+DsC7cZ5uLlUu6uJDFGdsNiGd90ZYzp2qA
         5zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ec2V5shBteoRtCqtxfW2R62kxRNZBNcV3MF01Vbbug=;
        b=tBE4EDN6d6cuVbLeGpPxTBfGSEM6VemWjUnbMnMaEwjVQ9f0E9GE2p5vk8Hh7ngN+A
         VjfECfyaE5dXKHyLb+qb6g0FF6utb++AGP/5KmRQSt/llqhYdRgf1ZOiePm7Z/G3CzNv
         tWiELZRUiC5IKMA19TMNG5mWeFkER10icXA704Syzqt8XZ4qwZPcZ+m1uBdmIqeeYhpN
         XBVLdPFltNJPNUjID4A1niSHO+iHp7+B1FvD6WzImi8HUIDaZUlrQkK37xshh21zifNY
         vSkMEGa07TiO/CYNvtWvkDpBRc8U6eT91dAmVzycc2gEgQ12dejFDAq6VNJv2D+39xRW
         2/pQ==
X-Gm-Message-State: AOAM532gHbKHkDjSSuHwEQ9syA5fwpKEJih+1Pa0HDc/mzcaeFI7vqSO
        1OWCF95G+fYBgaQQntPgixx2dg==
X-Google-Smtp-Source: ABdhPJxSz+4rACuf5SGMLZwOR56WI1iH59s/y3Xd/FVT14T2LZZfcFpcOvY4/3XaobZvZCLYVZfoxA==
X-Received: by 2002:a05:6000:15ce:b0:20c:57e0:60a0 with SMTP id y14-20020a05600015ce00b0020c57e060a0mr4701358wry.656.1652455229899;
        Fri, 13 May 2022 08:20:29 -0700 (PDT)
Received: from groot.home ([2a01:cb19:85e6:1900:9353:61cb:4e25:b9cd])
        by smtp.gmail.com with ESMTPSA id l9-20020adfc789000000b0020cd8f1d25csm2590612wrg.8.2022.05.13.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:20:29 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [RESEND PATCH] MAINTAINERS: input: add mattijs for mt6779-keypad
Date:   Fri, 13 May 2022 17:20:25 +0200
Message-Id: <20220513152025.2803478-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.34.1
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

As stated in [1]:
Fengping has no longer interest and time to maintain this driver so he
agreed to transfer maintainership over to me.

Add a dedicated maintainer entry as well for the driver to make sure
that I can help with patch reviews.

[1] https://lore.kernel.org/r/20220421140255.2781505-1-mkorpershoek@baylibre.com
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5936f2d9d8ed..d092414ae7be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12139,6 +12139,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
 F:	drivers/media/platform/mtk-jpeg/
 
+MEDIATEK KEYPAD DRIVER
+M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+F:	drivers/input/keyboard/mt6779-keypad.c
+
 MEDIATEK MDP DRIVER
 M:	Minghsiu Tsai <minghsiu.tsai@mediatek.com>
 M:	Houlong Wei <houlong.wei@mediatek.com>
-- 
2.32.0

