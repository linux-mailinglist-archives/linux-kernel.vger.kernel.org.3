Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB804C5C8C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiB0PbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiB0Pa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:30:57 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5943F337;
        Sun, 27 Feb 2022 07:30:20 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id bt3so6934290qtb.0;
        Sun, 27 Feb 2022 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RL6lgc9JQzCOWChXKBrpjhVjZkUp1FLcriOwSbYz2iE=;
        b=hvgOgznrh30xXh+nkSrsBMPkCB4ujzOxoGmBK/u9VRcgkqwymxg6Mxu8hYKJG8vCnc
         YfmFcT74a7dYNXyvozTgKNHdwRcPRmd8KP0iZX2dIbRbL/9rT6caMH7Tfke0C811BgeN
         QvWQvpWPeh5n8G4wUOZ2BV4IdUF1Djv68inIz+GeeIQHbV8+zqmWxMU4hhdPwPWP23Ky
         2bbbvy+DX0naoadktFKmGu2zqbYwZpZLaTi4NKwoTQh3ZXFaYFQJvc05p3g5tlBR28p/
         MAteWdW/xil/F+uzEsEwvIUJQ2KHObSBEDbTJNTfVwstTk11sOiwQR2S4fo1AsHWoIXN
         G+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RL6lgc9JQzCOWChXKBrpjhVjZkUp1FLcriOwSbYz2iE=;
        b=kFSMuOpUG3+AID/TD+Hru9G4uBti+0kHO/8xQXmzHRYPnR5eQaTfMQ0lY1dm2/ZHlu
         BZo1PzI4zuz792bGtW+zHvkQfOG2O3s3djN7pzvILaGFOVfSFGWGWcdCUOgFRPXDjmBx
         vEUehgmY3rzgn7cf3JK2b6XbjQEhSl3f/xUpUXzlrI5WgQGF9MuBD1+2qzWoo3nyVFZ/
         DVyussw2WzhWJhSKhrh9MGRmv92HE2fhxFj4/3x35f0rOsZ5m8clqZ+6lWnUzP+dkUz5
         vc9q5NGFIkzq/sr8rAPeK3+nAinoo2dAd8z2ttMR30+/3thc6DqQ5Uqx77ZjdvtAOkt8
         VkiQ==
X-Gm-Message-State: AOAM532gv4X1UA2cQ+uZjE5RlXUJB1ez6oh4cKkU7pVbEd/O4vzvs9bQ
        P6uD8W1vvd1gL7CnQ0VqB+Q=
X-Google-Smtp-Source: ABdhPJwsjJ4rXnuZsZt6SzbdunncOBf1dPZk6WG4fCqgA687+tb1CfuSAGeppBjNxh0cIZG0GwXynA==
X-Received: by 2002:ac8:5993:0:b0:2dd:c4df:35aa with SMTP id e19-20020ac85993000000b002ddc4df35aamr13528206qte.369.1645975819897;
        Sun, 27 Feb 2022 07:30:19 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:19 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Vinod Koul <vkoul@kernel.org>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: soc: grf: fix rk3568 usb definitions
Date:   Sun, 27 Feb 2022 10:30:10 -0500
Message-Id: <20220227153016.950473-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227153016.950473-1-pgwipeout@gmail.com>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
MIME-Version: 1.0
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

The rockchip,rk3568-pipe-grf and rockchip,rk3568-pipe-phy-grf
compatibles were incorrectly assigned to the syscon, simple-mfd
enumeration, vice only the syscon enumeration.
This leads a dtbs_check failure.

Move these to the syscon enumeration.

Fixes: b3df807e1fb0 ("dt-bindings: soc: grf: add naneng combo phy register compatible")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 072318fcd57b..5079e9d24af6 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,8 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3568-pipe-grf
+              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
@@ -39,8 +41,6 @@ properties:
               - rockchip,rk3399-grf
               - rockchip,rk3399-pmugrf
               - rockchip,rk3568-grf
-              - rockchip,rk3568-pipe-grf
-              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-pmugrf
               - rockchip,rv1108-grf
               - rockchip,rv1108-pmugrf
-- 
2.25.1

