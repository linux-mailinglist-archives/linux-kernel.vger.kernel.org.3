Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60E55C4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344038AbiF1Iy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344019AbiF1Iy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:54:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8382DA90;
        Tue, 28 Jun 2022 01:54:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t21so11432092pfq.1;
        Tue, 28 Jun 2022 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WC8mCwxcFPmaNTe2dlW1gLIl9Or1Z5lRzz4HZt059cU=;
        b=KQaVeMvIK6tuqnHSMdPgFQMzEqe69xzapzWGFSkXXSzGpslkQZiKvpkndmQmbvsQcF
         3eXYDi6vX572wjK1KHg1/m0lgsL0BzcS+4uH0x/bLsxCuBZ0gndhW9kk5MVotcXKys3i
         2883cqdlYnIiUEZAG9lnMss+hKV11KcDexX/q8Ck+9JV6hztDT62MxRvojYqjflEzzhm
         eHcphQSn19g19YEIhpvYD3KwbPVQ6+oOqM+oTYDLgrXk7uYO4/1y81riptgqSYbbFpHX
         0bnzAlRt0K6NiVw/GrbUWMXmhakslOMse/ynaMzUje6+r4G45B6SoUDy7JC+HjB3lEbn
         xIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WC8mCwxcFPmaNTe2dlW1gLIl9Or1Z5lRzz4HZt059cU=;
        b=zZ5+VjCVAwkOxpe2NuTMsYwalWQW/w6ykY2R2y0/A1Kw8p3eSX6a5FTkDDmVspofYn
         fouDG4dhtIOiUKX7vaGwc1N2Poqw0rSP0IML0Y6DUVJrwl38fiaCZ87yV4COcdYFww2F
         ItiSebpF5/Zg+C5YFSNAj9a0qTk1FWWQ5/LIRyiX9ZTOTC0uk4611BMSzAUUxpAcpyjU
         JURh9uSAhSEk6pVhmH+21e20CTDsZSkD4SMDAf9+7C6sN41SzpzVjbd8QeBWEq/mH4At
         +mFT1lJQmGK2iUJdqMo00y0W/pP8U124x0rIktFEyPXQsip7Z9hgHkhZ2539Tozm5kvV
         EWXQ==
X-Gm-Message-State: AJIora+uFeR1Oh4vU4OriBk75uCcMCJEBwG0BkC6LuhbDVd/XpBYNPVV
        QvZdmgY8qvSnYzfj2bhF5Ko=
X-Google-Smtp-Source: AGRyM1uiulusMvDPUmm/nYRbHm8DSfvspJVNvlbmGIdRAexX4Kc34/cplPHlah8MfxNGVhbXo74LZQ==
X-Received: by 2002:a63:f413:0:b0:40d:ba87:53f8 with SMTP id g19-20020a63f413000000b0040dba8753f8mr14812732pgi.193.1656406496018;
        Tue, 28 Jun 2022 01:54:56 -0700 (PDT)
Received: from chrome.huaqin.com ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090a0ac900b001e095a5477bsm11120939pje.33.2022.06.28.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:54:55 -0700 (PDT)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, spanda@codeaurora.org, dianders@chromium.org,
        devicetree@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Rex Nie <rexnie3@gmail.com>
Subject: [PATCH 2/2] dt-bindings: display: simple: Add InnoLux n140hca-eac panel
Date:   Tue, 28 Jun 2022 16:54:48 +0800
Message-Id: <20220628085448.2147440-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for InnoLux n140hca-eac display panel. It is a 14" eDP panel
with 1920x1080 display resolution.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index a5568d1dc272..51e573615aab 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -186,6 +186,8 @@ properties:
       - innolux,n116bge
         # InnoLux 13.3" FHD (1920x1080) eDP TFT LCD panel
       - innolux,n125hce-gn1
+        # InnoLux 14" FHD (1920x1080) eDP TFT LCD panel
+      - innolux,n140hca-eac
         # InnoLux 15.6" WXGA TFT LCD panel
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
-- 
2.25.1

