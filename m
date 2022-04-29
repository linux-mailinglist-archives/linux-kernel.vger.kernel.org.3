Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE0514970
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359304AbiD2MgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359275AbiD2MgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:36:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36EFC90DF;
        Fri, 29 Apr 2022 05:32:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k27so8907782edk.4;
        Fri, 29 Apr 2022 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjZep7+Tgf5lr7Kg5bt8mtQgziDmuU0ShQxCZx6j8dQ=;
        b=MbPJgWF+lEghy4d5Wiupu3E2Thc8xUAOZneHtBhr4vYIpLGqh8lu2a6jTHd6QmxNbm
         2sg6A1g2/ICL2DtYWSPDUAxx1yyC6JsyVMiqCWdyYIRMs2rmbconqcYUf38BT4H8z1WO
         T22VeDtv6a1fA62WwZeKxV4GWUnr+uxXViRF1SN4mmAUFB/XfqGbvKaOjWcODg8cwG1j
         npAhUGarTWUb0ZQ7d/A2cOM93B4Md0da7QW2s9bmDE1OWXxim/n43tASFU5pv7GzgVJj
         4flLE2Dt0pOjM2tOXl/1bh2jpJPK4XXIPE0o2jltBkYZeBIDfnPzQcmroZXhkzKBPN3p
         hmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjZep7+Tgf5lr7Kg5bt8mtQgziDmuU0ShQxCZx6j8dQ=;
        b=y5jWPZDb6MWOVByXcdGA/J+WV6/KGfcFRC6CYRCZvHZAkEbnbsbsVw2pJegQRCsPB0
         0igspuxKgF1pd3VEUNXU/ahzTLruZR1VIFOvE8pEKzrSBw5QiX1UMygOo39vFpGjh2/i
         MmlkRsn5wJV8zKa5DBmZg7aZkhPW/SvRzWUCZG1ISxJ70KzwRHzeqlPWUJrg2jF/3feO
         DC941wdi3IZuaQwi45UVEr0i8SwBq+hk8zyS2xspNlOZ22S4ugC4FeUFdubflgQVeBid
         e0Ir7e5aH9aihjezqOKtgPzErTq2hc1Fk2qQaj8l0Mnm7tSyYeLD4jXQonvYcAF+bosg
         IGgQ==
X-Gm-Message-State: AOAM5305HIBAQlgoyot4OS9JFXFFWTo31/52L0uNhvvx8p/IUlxrxX6f
        jN7XlZYooaH8qzLz1m3Hn54=
X-Google-Smtp-Source: ABdhPJzQqM5gYC/o6KCtToz3A3zuh5BarSASylRN98Q+vC0KnezUvqiQATi8io0zsBAKQP5wWQvrMA==
X-Received: by 2002:a05:6402:2815:b0:420:c32e:ebe2 with SMTP id h21-20020a056402281500b00420c32eebe2mr40348109ede.1.1651235565228;
        Fri, 29 Apr 2022 05:32:45 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e33sm601176ejc.153.2022.04.29.05.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:32:44 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] ARM: dts: qcom: replace gcc PXO with pxo_board fixed clock
Date:   Fri, 29 Apr 2022 14:29:51 +0200
Message-Id: <20220429122951.13828-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429122951.13828-1-ansuelsmth@gmail.com>
References: <20220429122951.13828-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace gcc PXO phandle to pxo_board fixed clock declared in the dts.
gcc driver doesn't provide PXO_SRC as it's a fixed-clock. This cause a
kernel panic if any driver actually try to use it.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9817448cfa95..ad30f7c8a5a7 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -784,7 +784,7 @@ tcsr: syscon@1a400000 {
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
-			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
 			clock-output-names = "acpu_l2_aux";
 		};
-- 
2.34.1

