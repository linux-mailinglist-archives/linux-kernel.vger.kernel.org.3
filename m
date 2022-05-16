Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0F528E16
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbiEPTkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345600AbiEPTi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:38:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71423F88C;
        Mon, 16 May 2022 12:38:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i40so4692715eda.7;
        Mon, 16 May 2022 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LebDF3RuPxmX1Cw/8NAKFfKs/e37d3Ws73/ZUWsOSYY=;
        b=bseiz9mTWBFks9ltjnA8R2a+/W7/FVLzfkmSDHkJfeKfQX1rYGRuIyUViZL8yKA9mF
         MLEAdCbqCH+RPshFcSqj8Y/AkfxtyUTdOtL2F5UnpHv0UXW0mf1LKw3QS/uRg9BEqWq7
         QMATuJ+nvY4vq7d4KZnFOq4VS8QyGepI2Sam7Qz6f6IallvZ+rxo7sHaARhKMtw359gl
         9H/CUYF9h8DrFCKvAY6T1zMs8VFaRAwHSyzzb1/zafJQy5vhl5bQ42vFNfVAh7T7ClI8
         oRRmlyG0j5tAoD3DEzyuDLbHY6upzDkmAnY6zHLJ8BGTThl1mtVURC7BBqr7hvTVZUbw
         kcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LebDF3RuPxmX1Cw/8NAKFfKs/e37d3Ws73/ZUWsOSYY=;
        b=bQAU7dH3n3ni1KT0j80EoabV5Q3NzXee7YMiF/RDOkdDdI0mfh4nwvKeA60967TDMB
         hQds208CVNIYz+Y84XbzXe5m/H2sRwnXQPScqcAaFnbDTPaBr1KpygD4tBpk4hlDRJjs
         R1tQNWwlOtZJi3IWSW7N2/IkkbmKWB8hkN8wDV1SXOquv1TtAa3g3o5K4bASsFUEz/4G
         +2DFL21cAa1MPMisgszKLqyHfRWBPjzfzAtT2EhKEN7PHY5TQWbCR28qiPUO1OBt4Zi5
         7WQG4oFlIk5R1znnYzzwhbgmFpZMtLFZLu/KR9Y0a6e7t1wEd/WEzCt6TGjhJEFCeizC
         +kkA==
X-Gm-Message-State: AOAM533Q6CzTq50rh+UzXdJrxu437jdpEQhqll4+4ePpZkitStn73OPm
        Hf/lxjgW7CvqJv3HXkA2ik0=
X-Google-Smtp-Source: ABdhPJyTP9Rwj4orjplkbScv8cYbfHA3DBy1Z17s4DcQWsXitJXORWnR2TTE2sCfqqK/ke8zXrzj6Q==
X-Received: by 2002:a05:6402:f13:b0:428:a849:d0c1 with SMTP id i19-20020a0564020f1300b00428a849d0c1mr15059561eda.346.1652729923428;
        Mon, 16 May 2022 12:38:43 -0700 (PDT)
Received: from adroid (102-167-184-091.ip-addr.vsenet.de. [91.184.167.102])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906220700b006f3ef214e45sm94042ejs.171.2022.05.16.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:38:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To:     linux-samsung-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: [PATCH 1/3] dt-bindings: display: simple: add support for Samsung LTL101AL01
Date:   Mon, 16 May 2022 21:37:07 +0200
Message-Id: <20220516193709.10037-1-martin.juecker@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the Samsung LTL101AL01 WXGA LCD panel to the list.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 1eb9dd4f8f58..9501b5a3c011 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -270,6 +270,8 @@ properties:
       - samsung,atna33xc20
         # Samsung 12.2" (2560x1600 pixels) TFT LCD panel
       - samsung,lsn122dl01-c01
+        # Samsung Electronics 10.1" WXGA (1280x800) TFT LCD panel
+      - samsung,ltl101al01
         # Samsung Electronics 10.1" WSVGA TFT LCD panel
       - samsung,ltn101nt05
         # Samsung Electronics 14" WXGA (1366x768) TFT LCD panel
-- 
2.25.1

