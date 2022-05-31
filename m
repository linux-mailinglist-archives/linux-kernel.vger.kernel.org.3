Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5629F5392A0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245166AbiEaNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345064AbiEaNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:51:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E9994E5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:51:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r129so2784470wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0mir9eT63DKpCuSFhXy2EQ9q6hMHk3Lk25p5hkr1WY=;
        b=dgPXuSTwBJUbGqXppjZhZZZOomCBtiDDRzWdJYbbljs4aTyDRm+Rc7yvBXo99ZlOUR
         U7mwFug0gjhRtdGOHx+b6JtR/f+n8/zxm2PDGTHjIPz/KhJYudpdaSA1BwC3X7i3s4Hr
         HDaavWH9RbL8wPJaZbnSIeRt0gsaiINZnc/ykOQ2BIYBBEtJ2fIb/S9kytfEqSzP2NbH
         qCSnSlzdfu5UlZu6g48e8t4J/3G6v16GoWLx/irJQpEzoh5NlHyGsJfxl0Gw80km5oQv
         3ZY1xvrun6xC9e4jGwbOr1PrJsdJ5tEYLvd9Q7LpqBKpPeYigH/lFh3JFg3igrkvpwyS
         XUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0mir9eT63DKpCuSFhXy2EQ9q6hMHk3Lk25p5hkr1WY=;
        b=GozZqa7mQIj09oQnlde/TAo7mzSyfAyDNXtjEDJRrd4QZKYIexaGUFqOsRsmGVp5op
         eAk0glLqYhdOOVSN8RQS/J1qYHgTFrCiYc29KAbqfMlTS/nQc37EUnw5rCsDbq6ZeSsY
         76waPWAwX3BMFhXV2oQQr7LS56LNmaqinzMeMGIVX5eSiboUV7/e3d7QLHIMfRvog5Zs
         s1qh/VlwbwZXfVhkg+KBhuURnoauhtbilZ85pC9dWKLcsiQIoFfZRT5SY2NPYjeIefm+
         3aK4+Bf7q9ABq6QcZVbwEff9ynxpQUq1h7Kag3Gg4fEzejHGV1TN1MhxLnBCgvy+k+CQ
         VlFQ==
X-Gm-Message-State: AOAM533byvPmvQdv6hQ1d75BiUEYMpLqCMxu3CDTaYSf29z6UFdoa0Qk
        hl1K2BjKHlBBB6iaAKSD9lXRaA==
X-Google-Smtp-Source: ABdhPJzCiszx6tFF9AeRKTF7WMnbdQGjSgr3MjgxoHordumIGouDeHTHRrvMyk2Xvt9rX9h430+GnQ==
X-Received: by 2002:a1c:f213:0:b0:39b:ad32:5e51 with SMTP id s19-20020a1cf213000000b0039bad325e51mr10808986wmc.72.1654005060973;
        Tue, 31 May 2022 06:51:00 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:51:00 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 12/17] dt-bindings: phy: mediatek,tphy: add MT8365 SoC bindings
Date:   Tue, 31 May 2022 15:50:21 +0200
Message-Id: <20220531135026.238475-13-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
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

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 7b2e1bc119be..4b638c1d4221 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -82,6 +82,7 @@ properties:
               - mediatek,mt8183-tphy
               - mediatek,mt8186-tphy
               - mediatek,mt8192-tphy
+              - mediatek,mt8365-tphy
           - const: mediatek,generic-tphy-v2
       - items:
           - enum:
-- 
2.36.1

