Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392624C6EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiB1N5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiB1N5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:49 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0FC7D020;
        Mon, 28 Feb 2022 05:57:11 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j5so12468775qvs.13;
        Mon, 28 Feb 2022 05:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQUDxIOQmLA9ZKQOZ3DN3t0eYopkqsvrJZ7NjA42XWM=;
        b=D6wZocUmb6FhBDKphSVz7f0+50OiiHnoN4aW4spyaT3McyYINKNrdPC3rrxPTZI/5I
         p7By6hXY+sQQqS2imvNWYN+Vw/mzJmBVtt/bnGGpdtkFnwtrNCypFPXSW+/pv18qekX6
         o+GVc8Eas7xOnZCfKgTJfufQQ3Rz+EA6ePOZXOSZK0oQ6nZRIIUo0nDgsjACfpnn0Th4
         x7+NGOhFfcGw0Vt9VAGqHC7dUrW+HHlI8uXrr+VXjHoBpOEk/PiB32oFHTvwpZsUBIWC
         BvqlzD7ItoFyqBCmRTzwjiBxY1z3g27a8wxpVJz2w3SJ2UO01ZGfuUBe2WN9OABJ7a5x
         ZwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQUDxIOQmLA9ZKQOZ3DN3t0eYopkqsvrJZ7NjA42XWM=;
        b=MN04tPcAPpd6N+4eJs7qRjf8AmWGSlhWpaXcxpAWICjK/1qah/J3pKgT6fGbIM2qkI
         CWn5vPSYNzr68Gaez8KYaUoMlgQIaPTs3zpbCfhMG+p1IpKLNrrEDtTIRBCOtprT9F0Z
         7HuJewMSGAzlSCVSgElpuw6nDOBwa8/lqVoVcGgu+81gs5ng5o9B+kprWLAjRvCv/RJF
         Uq0lkRMchZWZoJFL7gnl1lqBA4n+MX7+0hX/OdTD0QmydAaKVP+4Zc/itya5Eta3z+8P
         gFAF+Ti0JzDeLcXH2S2L7AmyURZMnsxchfx8RHb8ts9X+phFXCXYGU9ZJzMnkO/r7dFR
         aWyA==
X-Gm-Message-State: AOAM531o1Ud01ylarpV/UAHxDzdgcK1ian2qxLXaHGQxYYSgKHvWk2Ya
        t1aCecIfYklavJQLMGDOglc=
X-Google-Smtp-Source: ABdhPJzK8dI/AuVUIiY2N79dEgcXtr0u3v9g6tyJfKve6jayoJ2SoZtpH7AuPI9zJCIbLK8W9zAigQ==
X-Received: by 2002:ad4:5fcb:0:b0:432:d049:c6d with SMTP id jq11-20020ad45fcb000000b00432d0490c6dmr9850850qvb.39.1646056630371;
        Mon, 28 Feb 2022 05:57:10 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:10 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] dt-bindings: usb: add rk3568 compatible to rockchip, dwc3
Date:   Mon, 28 Feb 2022 08:56:54 -0500
Message-Id: <20220228135700.1089526-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
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

From: Michael Riesch <michael.riesch@wolfvision.net>

Add the compatible for the Rockchip RK3568 variant.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
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

