Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECB955DCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbiF1JBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245600AbiF1JBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:01:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828962EA0A;
        Tue, 28 Jun 2022 02:01:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so6532667pji.4;
        Tue, 28 Jun 2022 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WC8mCwxcFPmaNTe2dlW1gLIl9Or1Z5lRzz4HZt059cU=;
        b=cHOv2tnOzN5DjBKRhNofHljKi7umJ5Xm/g76iK9eSCTRrXh7h9QUV4ZpaSQIy4iHMK
         gFauxi1NO/RZ/dqrZc0/7BXp2I4fI0FaxBcI4y0ixI74MDF8ooboITcKkadRq9sdUJaN
         SYJBcK4flKPKxECgN0jMIcz3BRODURWZVmF+eZBzHQSF3vMAn4jxIxVDtV5MPs3lhBlo
         /a0ZrY57Bl0+7gnWoQOK00/dlcNvCisyHckyR6/13P5V+VrXn/GEE2K0CyINlA86oImM
         jElfY+wwNCz+fuK9kCWtHz8IFiYuDmYJq1IguwhS0ItGdqaww3ZnvoF6zOlhFrBa8BFk
         Ttgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WC8mCwxcFPmaNTe2dlW1gLIl9Or1Z5lRzz4HZt059cU=;
        b=N857xCcpZ2yfuunQHQKz0EpSgkHFuc4vZAh9CN4MKiTZaK8kvf9rAc4JmpHH5BYBmq
         +fsT2yK7e81N9NxvL3vB6XJv7COktEKVL3Fp6SH0wQsI/mIP/cvuWG1kjhJkuxDSPZec
         09/La5PDStFZbfmu7wMjTQJpAJtzNQ70V2Ch823ef5cgkVajOEUh7chNSIj9frD8WiEc
         Xi8Y7zn2sJ9HuzNw1gXJVHTqBPnJiqu/UsG/549cste0MQTZ4JUCYP7AwNJIQEbMdzk1
         WdM0av7hwl/jkNG6Tn4DjmUREVjCUyJv1WyUGPYc4wbSMwLiTqhooeFiE87JgEth/XVe
         +EKA==
X-Gm-Message-State: AJIora9lUaAX+2XQXW3CWcYpvhO9VYCzQCP6UZ2KncOaZU3w1YBmDOcc
        dkY6Bb1hEc0oaT3PSaFst8M=
X-Google-Smtp-Source: AGRyM1uu7K7ZqUZpUVxaDaTHYPHo2j0dvxZYfU0UvSOI3CXJaRDKIP0kRZiYgo66dZ/5mvWwJIsEXA==
X-Received: by 2002:a17:902:ea04:b0:16a:1f33:cb0d with SMTP id s4-20020a170902ea0400b0016a1f33cb0dmr3985871plg.103.1656406902005;
        Tue, 28 Jun 2022 02:01:42 -0700 (PDT)
Received: from chrome.huaqin.com ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090aaf8600b001eee7950428sm3163530pjq.44.2022.06.28.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:01:41 -0700 (PDT)
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
Subject: [PATCH v2 2/2] dt-bindings: display: simple: Add InnoLux n140hca-eac panel
Date:   Tue, 28 Jun 2022 17:01:17 +0800
Message-Id: <20220628090117.2148016-1-rexnie3@gmail.com>
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

