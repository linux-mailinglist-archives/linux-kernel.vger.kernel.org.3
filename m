Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29848544ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbiFILmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244196AbiFILls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:41:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29FF1EBEC0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id me5so46371366ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itsEy92F8LgvkoK7MoKZ9B/GZxw2SAC9YAvwl0r5wg8=;
        b=Oxug/ke+Q18uNPTc76KAnvm3XW5VZD/Adi0mZ4N0a4drEay7osACxDmHxCypfpQXLG
         IKnc6ERqhRJtqXdpKMiSII5QXp9tdpfWwqV7O4mW/zFa4q9rkEQoqDJK2gVYeY+eW+rS
         p8Cxlf7JU0L4JdsCGo/ChW47iFOaqSq/cuEO+hdt2R3lmjNvq4bj03OewAUXc36vuJHM
         xVNybWt5HujPTL+Jpeq5/E4xauYDAeGYBViTSQB5IYELtBkemayWbvegI9AOv+ggoro4
         kBO1Mi31M/qWuS5DA0BIeZ3szMdR7o1xWUGnrkGOmmN7j588uXzMdHG+rrKAmChsB9sd
         peuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itsEy92F8LgvkoK7MoKZ9B/GZxw2SAC9YAvwl0r5wg8=;
        b=SvnYvcb02YwxmLVJw6KozdUU7zkTK89nYrVBsOgx3CFWzquHJPPIGvHJWcloSBBXKT
         3f0TxUuQ1kX/Z+Cq+qow8oxiDByngA02/mhPzt2KuifMFOBPiyRGJ+fV53KvxoAcyn0m
         hoEsNwe4R8QArF70rpLefKL7yoQ5PB/e387L+PcMKeTe1phPbsdhQ90zITw1dQUt0oys
         Rbdcsib6XDYNOLjMnSO2X/fSreEitjjZh0jThC2oAdOXOMeMzsDA6UtM+2Ag34R9TR1H
         A834Tht3PrwZYTcJfG+8WciIZn1op0Rr9BecrfhXqrLUYwL8JmtuuQeQi4kuPns5I1Lj
         SEnQ==
X-Gm-Message-State: AOAM531jEl0nclFHqayxHSsypNhxvUkDH/cGYupOxIUEJzJtBs76P3xn
        eErrNszwTY0VjEJlC7MWdPmd3g==
X-Google-Smtp-Source: ABdhPJxxXjuRWeNSOrRAq8RdCQDP19RGRNSmJXWhHhYzlIXknuViFdrCOhvi7uJs9lFBKTH6jPLqNw==
X-Received: by 2002:a17:906:147:b0:711:fd7e:7d6 with SMTP id 7-20020a170906014700b00711fd7e07d6mr5537332ejh.389.1654774842528;
        Thu, 09 Jun 2022 04:40:42 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906058a00b007101f6f0720sm7760844ejn.120.2022.06.09.04.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 37/48] ARM: dts: xilinx: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:40:24 +0200
Message-Id: <20220609114026.380682-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/zynq-zc702.dts         | 4 ++--
 arch/arm/boot/dts/zynq-zturn-common.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index cf70aff26c66..d23201ba8cd7 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -30,14 +30,14 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw14 {
+		switch-14 {
 			label = "sw14";
 			gpios = <&gpio0 12 0>;
 			linux,code = <108>; /* down */
 			wakeup-source;
 			autorepeat;
 		};
-		sw13 {
+		switch-13 {
 			label = "sw13";
 			gpios = <&gpio0 14 0>;
 			linux,code = <103>; /* up */
diff --git a/arch/arm/boot/dts/zynq-zturn-common.dtsi b/arch/arm/boot/dts/zynq-zturn-common.dtsi
index bf5d1c4568b0..dfb1fbafe3aa 100644
--- a/arch/arm/boot/dts/zynq-zturn-common.dtsi
+++ b/arch/arm/boot/dts/zynq-zturn-common.dtsi
@@ -49,7 +49,7 @@ usr-led2 {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		K1 {
+		key {
 			label = "K1";
 			gpios = <&gpio0 0x32 0x1>;
 			linux,code = <0x66>;
-- 
2.34.1

