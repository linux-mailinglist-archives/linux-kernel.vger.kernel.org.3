Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B94E5361
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbiCWNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244393AbiCWNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:42:05 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B2E7D02A;
        Wed, 23 Mar 2022 06:40:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9so989203ilu.9;
        Wed, 23 Mar 2022 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0yGfWVmwvBNXjV8YPBIOWgjw8QQzbCwNdOAxvwVYTE=;
        b=U6wM5GzjHJQC3hlOYG2GxK4bQbvQp3hRDn+95gNbAfEFuk64fLKwY/tFSnVyK+NOj4
         vZdXztglI5nT5OqVgR0LmqQ5/zLQNrcB9NcwH/1R8NuihQSH1k1uVW77r0Ph/WLqE/1u
         3WZfIcLcgFQHFNonYfaUPVRIeWPEnR0wrr4wXtBarfp/4sMKCVkpxJ0FrnXP72vEPY8/
         SxMiB6fvPl/UooyAOhFgBjcUFQlLjrd3xbGBHnpHjGtWD9TE9pBgLTBMVUTVlfYxQBeQ
         kVDerAky8jen0gUdFCVIf0t4Fvck8cdKvgKzNb7XeZr6gopmbUli8TaQx6o01i2hM48M
         XUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0yGfWVmwvBNXjV8YPBIOWgjw8QQzbCwNdOAxvwVYTE=;
        b=ZSaJSQ0Yy4z4glXjGB7k+G5hJb/4fCU3U5uQPC41UAgGhbDuoEsUeLsQRGrYv5xPA4
         gXNU0T0+RUkwDU8v5914ZFpJ2th7IOpZ6HhEuTrVUbiZTyjmOcKSUb7U0HuezmurSp4z
         oS8Ag3QobU6nU9lFkVBR2z3B1VkCCg0teoxYouwVXspXwMQ5snJx1k8NGxPQiJ+hRBxc
         Dw/qaWNxFETdy6+C/67fZ28yy4MwwRYbRLePIi7DdUjlFtkfp5TT+M8/MuMUpLM7KpxZ
         TJRax6ms8vaAobTZIt56bG0a2UTmulJ7W8fRLYbO1o8DYIP4yDyW1Qo/rNh5oWi/5qRG
         NZxQ==
X-Gm-Message-State: AOAM532TO0dzbMyU5M7q7Crf3oj+GCjUhrgT8wGyHvDsfxQum5Cyl1yk
        DxxBszLtb/o44osdr1I1dso=
X-Google-Smtp-Source: ABdhPJzb6EZp+G+otRr+uRIAi5dKKi+NDQ5nUb8OUQKG4oZdIcQqV2tuKvBx5s3aRxvoMx2tKK+wvg==
X-Received: by 2002:a05:6e02:1ba8:b0:2c8:218a:24bd with SMTP id n8-20020a056e021ba800b002c8218a24bdmr41690ili.198.1648042834178;
        Wed, 23 Mar 2022 06:40:34 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:3c99:2d92:f93d:dc94])
        by smtp.gmail.com with ESMTPSA id y6-20020a056e02174600b002c7f247b3a7sm35253ill.54.2022.03.23.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:40:33 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: mmc: imx-esdhc: Change imx8mn and imx8mp compatible fallback
Date:   Wed, 23 Mar 2022 08:40:17 -0500
Message-Id: <20220323134019.3796178-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The SDHC controller in the imx8mn and imx8mp have the same controller
as the imx8mm which is slightly different than that of the imx7d.
Using the fallback of the imx8mm enables the controllers to support
HS400-ES which is not available on the imx7d.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 7dbbcae9485c..d6ea73d76bdd 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -39,14 +39,14 @@ properties:
       - items:
           - enum:
               - fsl,imx8mm-usdhc
-              - fsl,imx8mn-usdhc
-              - fsl,imx8mp-usdhc
               - fsl,imx8mq-usdhc
               - fsl,imx8qm-usdhc
               - fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
       - items:
           - enum:
+              - fsl,imx8mn-usdhc
+              - fsl,imx8mp-usdhc
               - fsl,imx93-usdhc
               - fsl,imx8ulp-usdhc
           - const: fsl,imx8mm-usdhc
-- 
2.34.1

