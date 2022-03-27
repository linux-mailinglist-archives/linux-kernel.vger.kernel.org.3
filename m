Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA14E89E9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiC0UFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiC0UFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:05:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E21262C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:03:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b19so17527435wrh.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1d28fyRINWBEv9rFNENNgciYP3HOQGFrcYEryHqhBZQ=;
        b=ETiMFcHrqDcGBEgPEp4gfZ1ft8E9q6y6ATkGzSVs9s/aB1O+Kvl9zW7Wp2Z1HI3v3R
         5RjXenHnXi7ULhG35yU/RVt2Zy4ux6NoihY0JjBJnAM+UBINSKubsl1Jr26/v+I7GOjK
         cTCbd9sBP2U/mvbB+rcJUXPDXItFBclpPdkVuEhFbHxB4rVNX8+vSCkGFhmUjHf1g21N
         a7aoNTd3PA/TWCRNGxqoKU7hlKgp+gvW/fQ7pXdMLwt0cxc5l/OLqWb4kkX+KW1f+N8t
         EAxZGziLUfq3WyE13+L45h5OamBGDBcttq6VjvRPxR4h7EbMMuN/9XzlBTrD0egq2HpI
         aZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1d28fyRINWBEv9rFNENNgciYP3HOQGFrcYEryHqhBZQ=;
        b=uYhTsyY21/Rpoy4oXmoYTnUGo8h9a/Phdu2GRp9knW+E3nbogpQyZqHBIT/40nqYsb
         N53RqPsKilhVIy50XnkTC+0wr3ysJs340DsqsqifWqeLuEI+GmK7NZm/sB7p1eusKBrS
         WrXKOwQsBCR+XmxLHJpo7a1IqGMF5FC5JXf+vAEf9pasLSJ0R9kTf90fevjjbIIyOsNW
         7QkkVoHe97Q18jZauPW74gMENNKWDytgEwvnkg32zt2dq6nFvGvKMgrhbgAd9wFUaxMd
         I+N1Gq/zBm0bpRrPOZxOSnd83h5yBwsUXlc7HAScdFNluGVbSf+j+e6gMNaTU0qJ1zky
         ZYKA==
X-Gm-Message-State: AOAM530a4TSraQgzLVrd/KqxGQdnlDwwEqH78K7WdgOqGOebPimRzPo+
        g+rUgxAkn5YTINTD3SODY9PHTF/66vph8A==
X-Google-Smtp-Source: ABdhPJzePJDajCPuH03dlfT6LG4aetEiDC1h/QSd89XIhYxAFlPsxZjCF0AKG5u4+34RD+EcMX0Avg==
X-Received: by 2002:adf:a482:0:b0:1e3:3e5f:496c with SMTP id g2-20020adfa482000000b001e33e5f496cmr18356033wrb.606.1648411435594;
        Sun, 27 Mar 2022 13:03:55 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0038d06cc21b2sm1354555wmg.35.2022.03.27.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 13:03:55 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/4] dt-bindings: arm64: dts: mediatek: Add mt8195-demo board
Date:   Sun, 27 Mar 2022 22:03:09 +0200
Message-Id: <20220327200312.3090515-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327200312.3090515-1-fparent@baylibre.com>
References: <20220327200312.3090515-1-fparent@baylibre.com>
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

Add bindings for the MediaTek mt8195-demo board.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
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
2.35.1

