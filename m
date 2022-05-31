Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4DB539001
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbiEaLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343912AbiEaLpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:45:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DD8FFBB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x17so9250275wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7wMZQlqIVLxhzJ4d1t/ELkzaXc9kr5ySRrjRBJot3E=;
        b=SGhJnZz0e2Odbkv884INRKwNwnjTSyzmQ+ewY47ETUW1pGmWomFBE5igGYmCZIrnJZ
         766uTQ0g81Z8kZ9qQjDpa8eKFCQ0lgvUofA5hlqAjFdXvJzz5XLtoeIX/+W5nKerLOAx
         nIs19QVBXD2CzaVwHj0ZSrtKXNRs8FiaTA2zcbQaZduEbYl8X1pN43TSOAk+Boj0zd6W
         jKeqOqAEkxL3Kp4J3Dh97veJm/82yN3t87/CTAPqLY+GNpYxfAAMgrRNBnhhjCnjMlZd
         Es+Zp9ARBC2GHoywC4RkW/1ByOZTupcZndlU9elkwJun8uAmiOGZo9natKlk7kn1uyYn
         sexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7wMZQlqIVLxhzJ4d1t/ELkzaXc9kr5ySRrjRBJot3E=;
        b=xOMEIo7F37RpMyGzCqR6iwZx9NVE+metkaKElh0zFB5USX1uLSWhBBA5L7ptUsX9YL
         Vgn6LiQeFRVRNMcT/cMt65p9aCMc89l5opae3sw4Cl+2f59583dVx8UJK/5YNr8uKzwQ
         bUdSZ0sV+AJxvANGzqNPTEe04DpYFzc8zrnIoY8AMCkUY//YjKnkP4xk+qhYyo9JxMbI
         d1HG27vAcLfbE5bmqCu0ycpUhe+s9H4479sDkKAFRLYFhXmowJxCRXR41br5mCp5yBx9
         ozZ5tYZRPN0u2wtg3MuNUZnCklcNs5GKFO/tTaFKWB4+NrRFrPrG7Lp0z1OmQN1m5bXn
         6T6w==
X-Gm-Message-State: AOAM5334HdWIUPPixru86yEQejtCWJlytRvMLKOsysCMR2F6h09gESu4
        6RAXJTKliwUP7dtsCC04JV3NhQ==
X-Google-Smtp-Source: ABdhPJzaigv2LfXPVBVdkqcThmw+HR5X3hxrRPPBc8aVHnRmWua+xDAK+a8kKwJwCgT+2Qc7sfGc8g==
X-Received: by 2002:a05:6000:2cd:b0:20f:d035:84f8 with SMTP id o13-20020a05600002cd00b0020fd03584f8mr38402854wry.263.1653997535368;
        Tue, 31 May 2022 04:45:35 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id e15-20020a056000178f00b002102f2fac37sm7695660wrg.51.2022.05.31.04.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:45:34 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] dt-bindings: usb: mediatek,mtu3: add binding for MT8195 SoC
Date:   Tue, 31 May 2022 13:45:25 +0200
Message-Id: <20220531114526.144275-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
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

Add binding to support the mtu3 driver on the MT8195 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index df766f8de872..37b02a841dc4 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -25,6 +25,7 @@ properties:
           - mediatek,mt8173-mtu3
           - mediatek,mt8183-mtu3
           - mediatek,mt8192-mtu3
+          - mediatek,mt8195-mtu3
       - const: mediatek,mtu3
 
   reg:
-- 
2.36.1

