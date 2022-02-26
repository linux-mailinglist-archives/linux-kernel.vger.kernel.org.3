Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547B84C57B7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiBZSmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiBZSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:33 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5DF27EC2C;
        Sat, 26 Feb 2022 10:41:57 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 8so9353260qvf.2;
        Sat, 26 Feb 2022 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=WOcKHnbvL/6tTiONrnrCInXreCNOmGUPPUCeG8xCoJngLTZSx8KaDLkpFstbgxp50g
         vERfAg+nbs2oBLM/SWE29rZj+26fK+xXUp2yo9543VtG7nXF/DAxqqWLqmhVvu72TP9P
         AbnYqadsloMHD4aXmAGfj2sHYFNm6BahjCUlAelOYQqG+4peZJ8955iu6ksLyByRVhaZ
         kHM35JgQVfRzm1QM6mfU/nk0UOmElSDK72NNjKY3sfhoHZQZ6GE1ACPT8kjDyDooMkOm
         4ls6mh9hayYhG91IQWAaPVgStnDUwlHOoLEe6Q772DmsQVaalf8DdYKPaGl4pV8gtaU8
         ae9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=a0WaFjXd5onBsF56t1+5sJF4STF86PeCDIMMS0PgeKhPqw8tDNuz+nDUresYuNUf34
         qXx09ZI/lL0HfWmQTMcnElMCWbtwT3gkAzE7xkfmN6EG5IIEq3JjnES57aiO9Mvc4yMH
         Z0MJqD+NhA1a43sB7Drpn9fDWuggvLpP5GkrlNfLFXXz8GuLF0fJAyJ5E/HXR2d0QcBd
         sUCv8RJAU+AmAXDddEO/hbywb7bnbCalZhgkAag5Dy+rVhCVA+2nbuSVRIz3XO85oRGU
         +cQwyA3osbnolbfs84tp8t2CpL/ZKGB6jZetYykrqPIzLABjo3NuRd1aYVQr0kQAveEj
         n+IQ==
X-Gm-Message-State: AOAM531HSohcWZte7aINm/UWYnQaUaCt6eNylUSV0yiCFGc4m4HZcyQY
        q1Z9e+WEaHtYU7aD8U0Gtio=
X-Google-Smtp-Source: ABdhPJwoouE/r333Mn111gg36xlXBSMHIg5VNS79zI8Z5qqJ9+iTNUUcocIFiU9lWVufrDHnNWvFHw==
X-Received: by 2002:a05:6214:5284:b0:42c:8d98:53ee with SMTP id kj4-20020a056214528400b0042c8d9853eemr9621526qvb.114.1645900916577;
        Sat, 26 Feb 2022 10:41:56 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:41:56 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] dt-bindings: soc: grf: add rk3566-pipe-grf compatible
Date:   Sat, 26 Feb 2022 13:41:38 -0500
Message-Id: <20220226184147.769964-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

The rk3566 requires special handling for the dwc3-otg clock in order for
the port to function correctly.
Add a binding for the rk3566-pipe-grf so we can handle setup with the
grf driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 5079e9d24af6..75a2b8bb25fb 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pipe-grf
               - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
-- 
2.25.1

