Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B72567383
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiGEPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGEPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:52:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9869E1EEFD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:50:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so21271185lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcjULYMpr+QHdI3JsNhjzwImTiYpQuBvwJ8lHs69eYs=;
        b=IpCNknScKIJXSEUwWGsF+SrFTJNmtDNa372+AiVdo/2fZ5eA1uMADg419eOcaIk4SE
         C37tZ2Oz9Gesq1pYOAzUQjBu3a3mUFNE9BlufU/QaiUcOlZCCw8WPBpUW44PDJaSqcx6
         cL3XI/vWE8FeIWUneTrmuZ0YBs9w8P87e7hcx30SInjkkCCGZBpyZE6ho0Q0YX44M+rc
         EvUH6kIlydrPhHlj15TIAUKgekCxn2GV+BTl+tanDK8fXAzSN+B4p8bY8OukaXZNnITn
         OKeTK9f8En+YmG5P4Xoa14yL0fskYwg2cvuYTlrBSBLFlGDt5QVI073k5EkRlii3TzK5
         V38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcjULYMpr+QHdI3JsNhjzwImTiYpQuBvwJ8lHs69eYs=;
        b=2fR0YvSOdYptSLy0QhF/zjLauLXBkitzSe2R7jjxwbcw/MFCGr6YTssg+0O7QipJEl
         sjpfbROgwbijwxAg8n25lv6z5sdmiJD8E0g4mlBEfJiDGJNXMxTUIYzl70LBMJQal+wc
         Sz/IZtGWrf/jojxNzjO/bmcOPd59k2WoS7iteeQDUySDAWRHp49BaN5/RPCqoDrxnAAc
         +VWKwX0bMh8EVqqWF8c7xxn8aK+eMKWLnTaVzhmYAHlVd0sgawaNo/TQT6Vsicb69HNN
         Po0WgRopojbA9+SEx6397shpufj7Vik6Yum6xgsZZISjm0kMcod6R6jUFGFwuYJp2VWl
         9TKw==
X-Gm-Message-State: AJIora+EYzhiKDmk1fG6MSZHLsBQAP34Mz8ApEQRfcC91xuWXMggkglL
        IVHqGqma8jYFcpmw/qprSVokuQ==
X-Google-Smtp-Source: AGRyM1veCggYbDR4uBoTxkp4gmYxE1f/2yXS96puPSrWecpOdrcqmdtbS/t46m6wVikXX5MKd1DN8w==
X-Received: by 2002:a05:6512:2a91:b0:47f:6e1d:d22c with SMTP id dt17-20020a0565122a9100b0047f6e1dd22cmr24346725lfb.550.1657036252021;
        Tue, 05 Jul 2022 08:50:52 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512070600b0047f6b4f82d1sm2347341lfs.250.2022.07.05.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:50:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: hwinfo: renesas,prr: move from soc directory
Date:   Tue,  5 Jul 2022 17:50:38 +0200
Message-Id: <20220705155038.454251-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group devices like Chip ID or SoC information under "hwinfo" directory.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This should go via Renesas tree because of changes around soc/renesas/renesas,prr.yaml.

Changes since v1:
1. Split from https://lore.kernel.org/all/20220705154613.453096-1-krzysztof.kozlowski@linaro.org/
---
 .../bindings/{soc/renesas => hwinfo}/renesas,prr.yaml           | 2 +-
 MAINTAINERS                                                     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{soc/renesas => hwinfo}/renesas,prr.yaml (92%)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,prr.yaml b/Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/soc/renesas/renesas,prr.yaml
rename to Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
index 654c96638e75..792f371cec03 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,prr.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/soc/renesas/renesas,prr.yaml#
+$id: http://devicetree.org/schemas/hwinfo/renesas,prr.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Product Register
diff --git a/MAINTAINERS b/MAINTAINERS
index 392e59e9a03e..d32d724d33da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2630,6 +2630,7 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
 F:	Documentation/devicetree/bindings/arm/renesas.yaml
+F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
 F:	Documentation/devicetree/bindings/soc/renesas/
 F:	arch/arm64/boot/dts/renesas/
 F:	drivers/soc/renesas/
-- 
2.34.1

