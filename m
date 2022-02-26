Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213544C57AD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiBZSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiBZSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:33 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8146827EC37;
        Sat, 26 Feb 2022 10:41:58 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id v5so7291275qkj.4;
        Sat, 26 Feb 2022 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOsPhZEWEQuuT2NShwv+/GSU4LHuvEm9yYvo2QoT/EQ=;
        b=R/KSu7/gavFinTUC20uEgLVG35ZIykqp3uptjNeINv1ka6InCTj1HVRehTJ8MWuNHY
         cBqTZOU3zOnyrjzc+rsL50Q0aCvVS5LG0+B1bjwzXpXL08iSpSvxBbDer6F0WTniHtSo
         MiXoxQawrpOodNXq9i85BHHG/FMTh7D0bHEXF/THfg6/LyAhnNG3PXzLm0dYDn8ldFKw
         +GvBK2hTSIric62sja6XothC9bBtmBWERqVaTTO45wSpSthE1OBUk5PAD5zGnxsyCxyz
         vUgtwKZSxqmxZC2cf8V1GRpxEmQ0NqOJ+3abZhxGiuFUO2SqzWQiLuWHaliaQAAeiGi3
         PzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOsPhZEWEQuuT2NShwv+/GSU4LHuvEm9yYvo2QoT/EQ=;
        b=pF4Io6PQNo+F/FbGmpZDDHKCt/dlrshcLRWwp7yVVbev0GhBHpUnEv0k6HtMIc3wlJ
         cOtlD3A208dxtrFwZ3AoV/nNquekeH5c/bGNdSYxbUEjVcSl3jlGoCNSUrz0T5eOvN2V
         FcwBKbqNIwQMlZ+3yRzIj5darWBvgtQNuq/EMSx0nVeVUUAsjxFY+6ftGuYYKi2QkSxH
         yq/wnYo1cvdfNFjBjEcprvfy+sZ61bGHTIBkQ6+1rtgR7Itk2/NNRbevuefkhawkME3I
         pcWQWACUKPGvSzAPI0Om7TS9YZhjZSLvpVOG3kIRMAvM2MkCdUdGzxugI9zRpNPvLi8V
         05Bg==
X-Gm-Message-State: AOAM533dZ7ZGpTRqb6J7J6w9P7ZSxoqB2SfMLgqtLbu/6qGvbo3BsF/v
        n6bdesqgqVyO89G3Uk27zTw=
X-Google-Smtp-Source: ABdhPJxCMJ/DgDWAppj+Kl9sdGzkRlm8iCGGKIndo6Lf3q5EL5QDB1gCMVii5QhrxfaQdKYl/m2dww==
X-Received: by 2002:a05:620a:1219:b0:60d:da3e:86d6 with SMTP id u25-20020a05620a121900b0060dda3e86d6mr7557051qkj.473.1645900917626;
        Sat, 26 Feb 2022 10:41:57 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:41:57 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Peter Geis <pgwipeout@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] dt-bindings: usb: dwc3: add description for rk3568
Date:   Sat, 26 Feb 2022 13:41:39 -0500
Message-Id: <20220226184147.769964-4-pgwipeout@gmail.com>
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

The rk3568 dwc3 controllers are backwards compatible with the rk3399.
Add the device tree description for it.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 04077f2d7faf..b3798d94d2fd 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -30,6 +30,7 @@ select:
         enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
+          - rockchip,rk3568-dwc3
   required:
     - compatible
 
@@ -39,6 +40,7 @@ properties:
       - enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
+          - rockchip,rk3568-dwc3
       - const: snps,dwc3
 
   reg:
-- 
2.25.1

