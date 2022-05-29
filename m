Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A74537215
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiE2SGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiE2SGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:06:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488A64BD6;
        Sun, 29 May 2022 11:06:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so5320285wms.3;
        Sun, 29 May 2022 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EO26AUWJ/HH6ekAIEmzU6J8VaDRoPc2hBu7v7f55oYw=;
        b=Ut/3o/vjop+XvvOsl44WCqPBHIteAXJjKksKyEGNHkRYViEh/0H+iWhEPDIvMjoBue
         ypKg/NsWPyKUstGLXb4S4J8oeVoFoPGH/LCi0jjXmEyVnTEwBQ+g/UnUDgS8/aRjSoNX
         8rq5KJVU4QFnAjdkf9l9xRFpXS1Uz2SWpwA1p4jW442nZT8dU2ZTfOBZL2L8Txp00BOl
         t8UxcfmEt+MgEWVTZfAOKamX7eABZ6ZqeWtytVrMfnKbd7EQsWTEbvkcoxInvYIPY00w
         eABRyy1twDuA+Eopf7svMdNh+zWooXxqjwd78M8L7/lA3ZIpTAL1RAihitqIqmsjQBiz
         71aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EO26AUWJ/HH6ekAIEmzU6J8VaDRoPc2hBu7v7f55oYw=;
        b=7upqovA541p9Uy/23xhLjsn0Wqz/9yQ89RDBzG3O683PoyviwOI0Lf2wqnWiy5m/2m
         nIYGkbMbv4wx9BAGT10l7HX2gKx1E6oUquURGdFLvbYEID8vC90klQGGgpq8EsnATwfH
         tDBEAAm84kCEmF4O6sadedy7OagfsdhPPYMzQMqd3oB2diTcApNwtOmvBav5DCrAIDqp
         NyNvx/liLKWgC+vSmHmMp52phw+mw0daD8GeQ2Nyfk0JHkKvpTqPZwBxhnkXXqeyPG+l
         MppqvmBw2jJncExIsuTnbmowhE8aFBiQmi8TEYoXqPI4R4briCBuSGs64KOswZSJBHy9
         XOJQ==
X-Gm-Message-State: AOAM533MV7A8QlYBMbuPS75SQoUU9G8Jjxx4CX3PQxoJuOEbZFoArsVu
        Wn3EEXBOUfzNHxDpO6CJt70=
X-Google-Smtp-Source: ABdhPJxlYG8SM67NDb5Fbhbvwq3vk+QYOPmUHuzle9cj8mRUUh4U2pI0i/8Bz6YPyXdLUwaVR2YQ3Q==
X-Received: by 2002:a7b:ce07:0:b0:394:890e:9193 with SMTP id m7-20020a7bce07000000b00394890e9193mr16240825wmc.117.1653847571313;
        Sun, 29 May 2022 11:06:11 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id q7-20020a056000136700b002100f2e6a7dsm7008516wrz.93.2022.05.29.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:06:11 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ruhel <clamor95@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: display: simple: Add HannStar HSD101PWW2
Date:   Sun, 29 May 2022 21:05:47 +0300
Message-Id: <20220529180548.9942-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529180548.9942-1-clamor95@gmail.com>
References: <20220529180548.9942-1-clamor95@gmail.com>
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

Add HannStar HSD101PWW2 10.1" WXGA (1280x800) TFT-LCD LVDS panel
to the list of compatibles.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 1eb9dd4f8f58..0d6f3973b12d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -156,6 +156,8 @@ properties:
       - hannstar,hsd070pww1
         # HannStar Display Corp. HSD100PXN1 10.1" XGA LVDS panel
       - hannstar,hsd100pxn1
+        # HannStar Display Corp. HSD101PWW2 10.1" WXGA (1280x800) LVDS panel
+      - hannstar,hsd101pww2
         # Hitachi Ltd. Corporation 9" WVGA (800x480) TFT LCD panel
       - hit,tx23d38vm0caa
         # InfoVision Optoelectronics M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel
-- 
2.25.1

