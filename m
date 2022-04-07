Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC74F893B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiDGUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiDGUgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:36:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42BC33A6E2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:21:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b21so11593543lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJSbUDifbnKiCK7OxjEYTIFgKb9+e/PTX5OKVRIiP8Q=;
        b=hd2cjk9p73fGKxH7od8GPCflsA3w0/7xSp6Em8srH/JA7WqbKWz8ozYtWwgffmatqc
         ZjK/TwTCTeRsMZQUD57l64pyQQjAQDmxwfGS/tL9dE+hNgo6GdYQboropLVCAKova7wu
         kHlE9rzK+pCMzVdJ7tbShhVGEF9tU4sJZ4owYDqwsTWLZdJDad5fOBEyNS58zA0ECYGo
         qAvev3LSHwJFlnQ+R8SHN7cJYIkxu+4/cchEG6C8zqrjRFlVnsEeKbe97Opo0ZQ5Udrg
         Paj3abv4rxah4hJKQs+tSxPqxexYFJnPUP87ikqT27udwl+BuHd3BgAqnIaOd3z0SZhw
         MDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJSbUDifbnKiCK7OxjEYTIFgKb9+e/PTX5OKVRIiP8Q=;
        b=OcAfuJ19lmy+usgEnTDwVpwPtzvtXofcQ3FbfgLeOcHqILP1fqHrLTP1hILTA04tqP
         Lka5aUqfyyYdLxZoVgutXe+H/ofzGCJqsW5yLw/05/C7H20V5hgSubajmHsMy8oFf0fu
         30AzDqhnC+HEI8cTIxDhhmQPo4vvKCHZ0yPhlIxp6Yo2nJrazMj7I+YYWBmW1d4BooK5
         ebqcaU6aU+HGnrAl724Jm53jq1Q05hTGt+fbVFtvZDRxhfoKdrKCRQ3ZKCVF1Zbu3lJQ
         dxNjN7aRN4ZL7SXvC5tTp130FTcfjAmMjH9Gbxpn5LDUiMgOmKZbkiRGpSN7VA3I8nG6
         6h6A==
X-Gm-Message-State: AOAM5320OPtzgjPEc5FJBWdXaJLcdRpeIiT0PG6VEXlodwWVmJv/Tzmh
        QfXOINjM5bbrKpJIHBhh5oCD9dFWICe2ulSL
X-Google-Smtp-Source: ABdhPJwNLPy67bEWqYLzGAxwSpQ8ki3vGFaI7YdSZF0inJLa3UZuK4crjNLHxrGjUrAEcPnCUKDHNw==
X-Received: by 2002:a17:906:c0c8:b0:6d0:562c:2894 with SMTP id bn8-20020a170906c0c800b006d0562c2894mr15225490ejb.625.1649360340546;
        Thu, 07 Apr 2022 12:39:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm7923846ejz.213.2022.04.07.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:39:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RESEND PATCH] riscv: dts: sifive: fu540-c000: align dma node name with dtschema
Date:   Thu,  7 Apr 2022 21:38:56 +0200
Message-Id: <20220407193856.18223-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Fixes dtbs_check warnings like:

  dma@3000000: $nodename:0: 'dma@3000000' does not match '^dma-controller(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index aad45d7f498f..5c638fd5b35c 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -167,7 +167,7 @@ uart0: serial@10010000 {
 			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			status = "disabled";
 		};
-		dma: dma@3000000 {
+		dma: dma-controller@3000000 {
 			compatible = "sifive,fu540-c000-pdma";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
-- 
2.32.0

