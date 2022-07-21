Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6AF57D733
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiGUXFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiGUXFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:05:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3328C5BA;
        Thu, 21 Jul 2022 16:05:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bf9so5018043lfb.13;
        Thu, 21 Jul 2022 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqVpR7xxMTAaFTS3I79ex2ZZ87sBYfejjyEKh4Yfib8=;
        b=byADmjpFMjHxSR8c2u5vLmQPuHEg0iQBrQRss5YnVVw5UVsoackaMZVulER39E7/P8
         w/2Nqo1LbPg0+C4wamNg/I8Q13hP1mpS9iIDRppfUhMpoL5hPCdrPt5pgHAwrblI2lq9
         beMAmhI3fNzI6xNr/yZhhlRS0Rpo/3BgBg8F93pbzCLeHIIO08sbtcFhinpPqsoRn/m8
         AuRNY+frKFjtsCS7Ib7JsNaD2mDVT3q+/dmJW8dQzMjZUAuGQGoSZ9I0FfWBcHpoGabv
         cQtUy5wU069PVg+eSGEK8x6JbYMcangrcirmt2GTxcKgX247rNto4GvzzhP6zWSdWwrF
         d3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqVpR7xxMTAaFTS3I79ex2ZZ87sBYfejjyEKh4Yfib8=;
        b=Fbylndw8eIfIy0jlh+bsvNRHcT4MY8om4KtHCPlk+eCv3JHIhhWPKFwtStBZ180L/e
         7tJaYXCVzDYXxFYvCbQzC61Gb03mLA+zKDij+W9Dey9zAK5oou2kymESwaonMVFb/Fno
         eQuZtZUBmjtqdSrYnGqbmajg2Y33DOksddd/4HCO4Se677w80+l/hQiqonAe2FIgmBjB
         o3TcUqMiAF5DmgCVTE3gqITLd2SP5Bos3FlF+OhC+Z7/dqyadNduinB2is/KEcVlZLzS
         Ks6J4EY5UMuamJFVKCTFtA6Gz7xtlZtZFKalv6OugSMpTa56Kq1jG7VseyJQBfolaATy
         9ebA==
X-Gm-Message-State: AJIora9a/yAq+sDyUCJXhm09zbZQ7k88o2YK6apeiqaqePxhd+4pkQ30
        NRUGJrwRvWXJndIKK7Cumy5qYkd57H/RSmEfMaI=
X-Google-Smtp-Source: AGRyM1vrlHtI5KYFFYgGHqpOVbjdN4khbSpLRr5eJqzqsMYVRGwhXcua0l2+f6yqE4fDq/GRK/fE8g==
X-Received: by 2002:ac2:420b:0:b0:489:eac1:5d7f with SMTP id y11-20020ac2420b000000b00489eac15d7fmr244104lfh.355.1658444737719;
        Thu, 21 Jul 2022 16:05:37 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id g31-20020a0565123b9f00b0047fb0d5e049sm701360lfv.273.2022.07.21.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 16:05:37 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Date:   Fri, 22 Jul 2022 02:02:28 +0300
Message-Id: <20220721230231.98886-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220721230231.98886-1-matti.lehtimaki@gmail.com>
References: <20220721230231.98886-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The PM8226 provides 8 GPIOs. Add a node to support them.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
Changes in v2:
  - Rename pm8226 gpio node
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 9b7d9d04ded6..0c10fa16a0f3 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -90,6 +90,16 @@ pm8226_mpps: mpps@a000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pm8226_gpios: gpio@c000 {
+			compatible = "qcom,pm8226-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8226_gpios 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pm8226_1: pm8226@1 {
-- 
2.34.1

