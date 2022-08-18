Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39132599029
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiHRWHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbiHRWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E06D2753;
        Thu, 18 Aug 2022 15:06:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e13so3506737edj.12;
        Thu, 18 Aug 2022 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gwYDRHCLyvIG0hzZx/1wWa1CYvcFrSAVpZX2Hp0kcmU=;
        b=H78nhzPQj2CiZRP5EzXW7psCXuxBq7jJkgaQBfsnAuLG3GYpjwqvl/urxI9rh6DTrV
         zRpBFYYSIsQjXRI1hAIB9USyI8aGRkGiIlW9aWuh/a6kZDKMzFhWfdWTXynLhCryz9Sf
         2NVanzEsFGkvMOE8tVfQwTvkf/Va0DG4Cvl+ggIaYJMNgTS5d6AzBo7OTHitieI2VgNh
         JeVjcbgAqgwavgnRkCvqW1g18um2C8oXeTqUulPWwyE/jsVuVebcS5qrwvgo0gX5XnwU
         nryJs6jkELH2CGewUK5pInSh78SsKNB/S/ilW2jRZ1LHQaiW9Az4YdL0Dp0XxJ7Y8aaU
         4ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gwYDRHCLyvIG0hzZx/1wWa1CYvcFrSAVpZX2Hp0kcmU=;
        b=02I/nJ6uvBKwtUtBimWSzj4A8avZVB3Z+8SYZvhbHidJqBZE0bBt7ZPRfOBCEKTFJv
         WJMSqxOhO7iocuyFG4gm4MG15RTa1uzjyKe9phIg3xb4ai9gviKgPOhYbGLZT6S73WVi
         fXPyflBEx61CtwXWUqSEED/Q4mg4J5vgWcZ3BEC+3m6PAHxmzpdl73J3CvDAh4v2Q27T
         /QsE5XsLxjmuGtID1zuLm0bY7KyTeoIrUbUaI1fw3HJ+hYVtpPiPLgaz3mRHZVI6BC3y
         kmXpwM9rHcWKzBOt3PAs69yWgYOmzSmQdiX41YLYZb/JuGFmKUwMjEDm4rrQqCyc9NZ7
         DAhA==
X-Gm-Message-State: ACgBeo1R98IgLFs4M2KjQiK6t2GUOebcJft5j8LledjQ7MMi+GcOR/N/
        4j76yo2zA2Dvkeef9XeihHg=
X-Google-Smtp-Source: AA6agR4ymEF8d31W/DQMQr9RGspNJvr+iK2oLJ9vpS+bdmPhTHUIYxu5iKfq0dR1ej+Y4waRyjHfgw==
X-Received: by 2002:a05:6402:332:b0:446:3427:5c62 with SMTP id q18-20020a056402033200b0044634275c62mr815100edw.141.1660860398575;
        Thu, 18 Aug 2022 15:06:38 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:38 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 8/9] arm64: dts: qcom: ipq8074: correct APCS register space size
Date:   Fri, 19 Aug 2022 00:06:27 +0200
Message-Id: <20220818220628.339366-8-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
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

APCS DTS addition that was merged, was not supposed to get merged as it
was part of patch series that was superseded by 2 more patch series
that resolved issues with this one and greatly simplified things.

Since it already got merged, start by correcting the register space
size as APCS will not be providing regmap for PLL and it will conflict
with the standalone A53 PLL node.

Fixes: 50ed9fffec3a ("arm64: dts: qcom: ipq8074: add APCS node")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 5985dfff073d..5b62d7590fc6 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -703,7 +703,7 @@ watchdog: watchdog@b017000 {
 
 		apcs_glb: mailbox@b111000 {
 			compatible = "qcom,ipq8074-apcs-apps-global";
-			reg = <0x0b111000 0x6000>;
+			reg = <0x0b111000 0x1000>;
 
 			#clock-cells = <1>;
 			#mbox-cells = <1>;
-- 
2.37.2

