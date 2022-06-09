Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34923544AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbiFILmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbiFILke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768021E0AFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u12so46916882eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNSMqPOWSXzw+Ck8M30e8l38LaeW0dc38daK1PaMf9A=;
        b=mNZv/vOTlgWw33oah/CqDorwmXalyTLA9BKQ25HQG6NfYltICakt5zZVVDjeF9AdIB
         lg9XtD34rEryysprD956jx1BJEB2y+b7QCbjgr/8W7zZ2bhq0YoFP5IKAOQRSyH/xW8q
         LBk8PH1/qkRnLxCU1Wm9sX4MoV2kxQFNYRgzjhaXSSHoI3q7JdZC+sXukltg5WmyM8Hc
         ydHE4Ro7TDaiavP+mZCZRdyS/TtWj1t3hs/5vssvk9Ii9ibpl0GYgI3YkMWAQeM0rlmf
         510h5UMxnN/ap47vWnT78ToH/45kN5npPdfVkwgxJIEWqGJGIEC1NQa9aL08XwH56BYt
         tJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNSMqPOWSXzw+Ck8M30e8l38LaeW0dc38daK1PaMf9A=;
        b=UFQjV9lxjxOAe+wezzRA8zkqJQBiyYUSGZjvYMkYYCz4bVWPn1DBKChiqXPmubrEV0
         9nC6diVFbrFL3+pQdKvQhZRLhycbnmz+f7AK7zwxQdPXFLx8Pe4KfnsV3dscO+pMUMFQ
         xKVY/H2yjB15YRxeBWJrWh4x2aETDH/ebfFy3N1uU/SEqo4GnmlVimI9m9Fi6ykot2tV
         hD+t4sPoUyk4G4udNRymNqyVxatJzQSzEJIBrrLIj6Ht4boby48abHJXst5jvKJ2h66d
         EjGYYfDISHYagCKDjE5ics66ybzSyALB0hAnGYhAIUwUczcLc9vSilAkxEkPHFs4dcQX
         p1yg==
X-Gm-Message-State: AOAM5309Z0bgwiRhwBSzEJA+bg+E8BUrgbkzm+vqYES6hkRZ7Z4O9b8U
        T0U6Z4XDiCCT0BNmum7ZdRrv4A==
X-Google-Smtp-Source: ABdhPJxmAk2Y+XroE7iF0LDQjobmFkH/yU0gGNvbSEj5slHvWwdNDLIfiKGfqCCpS+4l9xnWfXsPTA==
X-Received: by 2002:a17:907:5010:b0:711:f093:3a93 with SMTP id fw16-20020a170907501000b00711f0933a93mr9061053ejc.620.1654774812751;
        Thu, 09 Jun 2022 04:40:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b006ff59151e34sm10638441ejb.39.2022.06.09.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 23/48] arm64: dts: mediatek: mt7622-rfb1: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:39:56 +0200
Message-Id: <20220609114002.380563-4-krzysztof.kozlowski@linaro.org>
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

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index c28da9323a9c..1a86857c9027 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -40,7 +40,6 @@ cpu@1 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		poll-interval = <100>;
 
 		key-factory {
 			label = "factory";
-- 
2.34.1

