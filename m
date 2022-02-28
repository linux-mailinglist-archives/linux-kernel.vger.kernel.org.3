Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598CD4C6EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiB1N5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiB1N5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:49 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0F67D015;
        Mon, 28 Feb 2022 05:57:10 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 8so12569625qvf.2;
        Mon, 28 Feb 2022 05:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=DhunHPDFR2V3Hox2LdEShrwB0I3eShU0H4fvqIdK+bMIwAsCFDMmDxrEpkJkykMeV0
         f/P3nuUDuCob8St13oVJktiQ2Ww69QXeBxbSKxX3PPJjfSNxKYx9fljBCgNv89PIeS7b
         ILdszhgU8EBRvQGJln1QI8D6D698gEXGA3y9SvUdzFUqGQPuntRmm4YPoDyB6qyep1K5
         H8nb6oaxe0tWG6CE2PPG8FtfYVVOBXH9iAVatcmO1D7rGTKRa3zJ7RYZZ+u/wiDx99c8
         t4kiYnRutathdQFMfvCpkXzi29kKntBXXYiT5TDCR4aaUiUdcKy0zsewS0Py0t98X0Mo
         f9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=ZewqfxkCkkNFvWMRQQA2zi2rsmGXIHAl9hbkLwqY6dYfsVMcWFrWzHULuvmkQOYR20
         qFfB6fQSfg+1lGUH4gl9QL+l3qpmVwLjbMDbKZsrCkvpOY7LVkddBcDGRBvlkRMc+UQ5
         /u24Vu0l4VTSsGAPj++yBfvEtJ744g/IuPFmefds5l1oW/RbjOlPCWA7ZzgGvxk43lKP
         Yse9L4FGZAkqN3+j7oi2vqk+oL3JdK6CEjHrwSp4yZm3qftb7ifY6JrOfEYyRjTvsY/F
         RnUL4bbnM7Q9dBDSfnPItXogM/2fJ6Od5iXo9Y6jFYIhEFG/AEDfM5NREgOfG98Ng4aY
         l9Ww==
X-Gm-Message-State: AOAM530MzWSvD7lUUWMYhrR0NKN0ICc974RwBMCiMnPC7ipzLjXiziQv
        7DU8RYYI8/dmeDYKkZbrZFE=
X-Google-Smtp-Source: ABdhPJxkrLbQyS3Zcpt3zgmIhbkWINWdUv5D/WJEcUEfNDhC6TXSahGBuov5CQ56hIdXTZYp9U8VaA==
X-Received: by 2002:ad4:5aaf:0:b0:432:ec0a:f90c with SMTP id u15-20020ad45aaf000000b00432ec0af90cmr6051866qvg.27.1646056629455;
        Mon, 28 Feb 2022 05:57:09 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:09 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] dt-bindings: soc: grf: add rk3566-pipe-grf compatible
Date:   Mon, 28 Feb 2022 08:56:53 -0500
Message-Id: <20220228135700.1089526-3-pgwipeout@gmail.com>
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

