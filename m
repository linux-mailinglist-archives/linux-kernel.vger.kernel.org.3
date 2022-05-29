Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED6F5370AF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiE2LKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiE2LK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:10:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE437A468
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:10:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id rq11so16118568ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bs5DBrDYP0sNBpBiG9sxUl5vLBFzr14O34yIMD/h0nA=;
        b=qaOhJnDyEs6kctcS3mIPnzusmrpIIwicdocaEDl31DjnAwK97kNHZNUzdvP1LUYR3e
         NBkwEO4oM9OJypv+WKnT2k3VxCRzjHhCU4D6iERnxvX4ziadVonmv1NTYGXbVk6gRvCX
         pzepUVp/dyKcAR/9dEZeqJRb8VQLXZtJ2z4D5dWzCBq0Xgl/sP6gLteEBKMN0qa/veT2
         aFoc3OPkSXiEZUP/pWO+YvzZef7NNh8GagxM53ils7KTOm5i6XrGcGV4+OwlJ0AJ/6n3
         GIuF4NLiPLv9qD1O2HdzgtQjai/tfpVg17iq8FA4TbtV20webywr+GDLRfD4BdLfNXgN
         y83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bs5DBrDYP0sNBpBiG9sxUl5vLBFzr14O34yIMD/h0nA=;
        b=h+39KyFBYW0VlorXPEbtAzSbAvrDj2ToUC5EwlYpWNXMAekmq9Qt5G1Rg1i6QC/BWu
         x2IiQHAR94ykBeA9F70+yvxeQEbeBKKTQFh1aNGyMc4a538h3ABsu1Gi56uExwM3n+2P
         LlTJ4wiYUm44p9VHS4HOgoSjWheBa1tUzXebYUM67whNnyUEOsJi0+bpIkAMOmJt983+
         O2VgLssL1FcTXRXVR65xxpTclkRewkQeTIW0UomxOPUrRI89LJl2hY3DwdZs6jtspgJR
         krzs0y67Zb/VNUQFW5knVVAgeAaWSWxb21KVWeJi1VM5DF+vfegdWlbo8FsrRqf2rYJG
         h1Tw==
X-Gm-Message-State: AOAM531kO1ROhVGQ7zeHfyZPLvai19mLALCxjfn0qG5j3rCGDiVSpNJ2
        z1ggK5jL3ZwxSzvihyHp7uUoFQ==
X-Google-Smtp-Source: ABdhPJx+u4MF8iq6avvPhns6VVqIcAsvksAUbgN+Qkn99OG8kj9/FnVxPTJNPlV7SjkKxfcImdWG5Q==
X-Received: by 2002:a17:907:9626:b0:6fe:bae9:70bc with SMTP id gb38-20020a170907962600b006febae970bcmr35066248ejc.150.1653822625432;
        Sun, 29 May 2022 04:10:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709063ec300b006fee2bdf6c6sm3073996ejj.169.2022.05.29.04.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 04:10:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: aspeed: yosemitev2: use proper "mellanox" DT vendor prefix
Date:   Sun, 29 May 2022 13:10:17 +0200
Message-Id: <20220529111017.181766-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529111017.181766-1-krzysztof.kozlowski@linaro.org>
References: <20220529111017.181766-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mlx" Devicetree vendor prefix is not documented and instead "mellanox"
should be used:

  aspeed-bmc-facebook-yosemitev2.dtb: ethernet@1e660000: 'mlx,multi-host' does not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The change depends on net/ncsi change.
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..26217bc652e7 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -95,7 +95,7 @@ &mac0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &adc {
-- 
2.34.1

