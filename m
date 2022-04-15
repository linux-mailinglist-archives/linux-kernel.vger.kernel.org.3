Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48400502C36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354744AbiDOPDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbiDOPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:03:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F485BF3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:00:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so3982854wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pOFJlUG0A7QE7n1DqwtNq6lGe7UbdV1x9FZG4NLdjq0=;
        b=C3Rd6fa+TyiCPz2nh952O06n04xSU85OcT8gdCDnJl3vrQtyobdCztxYFW/ki5CrUz
         OPnO01Xm5LnfP+xIwxnZKXDCmfBQbxE1vgVvvQjqLnLgeCg+tCHgHe4ujvygpH8kN18y
         tbghWMAdRlWWMwbX45jLKzDkdQc32hIVagPbvN2H3JhElX7Ojkn1o0GwIhr6A17HTXiX
         5pIsV7KCoIKYBWWE7Tw2cPIbRcaeHoVadIScJoweOTYsprFq8AjD3AUfMzYtYcCFXhV2
         l8Rw/ti9oLq6wiAv7eUIs6042BmH8E5ToM3d3ZvJNcgAieYiaq66ziFxzqMJAHU+NYZS
         rI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pOFJlUG0A7QE7n1DqwtNq6lGe7UbdV1x9FZG4NLdjq0=;
        b=iW4VIueM9N6NIZOqE6KhjfERIdnLW92X/MdVP+IpGXEENWdmYZFa7uJ+IhDACr4Q06
         XZAFYQUglm4Y1D6AouT/fSLUl2eXTo63SNWMBkkOTA7eqS6XLj8YQyxipT7557L1Bb2p
         n0I5kM/x9VyhIF4rFBCr0z14kZ5DR8dE71snEipuGBJ6ZuNIJr6j0lXtGdPHTP8p1ATZ
         90CgcK7PD8ejb+pZZFYOPkSI5da0GvkjDwqtfoyB2XenPns3T5xZxfjYr+awYOANiTwS
         zHQuOofXXMhCVCPh2z0TMFJfzxZe6FV9H+6HDnCFhF/8vJVf6oaU4w/BZByDJTZKhUd0
         2z6Q==
X-Gm-Message-State: AOAM532XWN+aVdcsO1vt+yJlHHNKMaufPWT/FQJspcFvKYx9oDPmiiAX
        74VutiDJsbY7Pv0OOLJqYZTxIA==
X-Google-Smtp-Source: ABdhPJyKsCTiFSBRJqjvHjzUp5YXFv3nqiDeVyn0nKnk7EurInzgFuGGF0dlnJQuQwacVAgmXT0Aag==
X-Received: by 2002:a7b:ce02:0:b0:381:2007:f75c with SMTP id m2-20020a7bce02000000b003812007f75cmr3741111wmc.6.1650034833905;
        Fri, 15 Apr 2022 08:00:33 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d6b82000000b0020a7e34ef20sm1579664wrx.47.2022.04.15.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:00:33 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/4] dt-bindings: arm64: dts: mediatek: Add mt8195-demo board
Date:   Fri, 15 Apr 2022 17:00:00 +0200
Message-Id: <20220415150003.1793063-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415150003.1793063-1-fparent@baylibre.com>
References: <20220415150003.1793063-1-fparent@baylibre.com>
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

Add bindings for the MediaTek mt8195-demo board.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3: no changes
v2:
 * move compatible next to the MT8195-EVB compatible

 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index ab0593c77321..024a45300da5 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -133,6 +133,7 @@ properties:
           - const: mediatek,mt8183
       - items:
           - enum:
+              - mediatek,mt8195-demo
               - mediatek,mt8195-evb
           - const: mediatek,mt8195
       - description: Google Burnet (HP Chromebook x360 11MK G3 EE)
-- 
2.35.2

