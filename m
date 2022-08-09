Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737A58D365
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiHIF5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiHIF5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:57:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA91D319
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:57:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id by6so3565272ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KINEf/W4t5TWaccuFrwzG0MR+MtGhaWK/ta0M81cluM=;
        b=MxCoAZKOsuXIqZOJdYt2kNL0DAGOO+nQDd7odztJ2+5gsNxZnCkX0hZ39iiWe4fmLK
         PN2XSwjFXHrcMXU+luitYQSbZ5Q7zc9xM2KEEnJy8QBJeG/t4n+4Po+gi2SVkWtV2YeL
         D5RU1JXYfdqasVZAUfkhKy42hrG5a2OLT+4tT1maT9zrL2q8/eRFbrS4qpUw6YCvBxyq
         jx1+rUoubhiq/HUcdhOdAs3aUAwcZAPntEr5nLTXQRaqphPM3VuxPoahYGAe2R8tTpi0
         /vEUkpfKYZup9qfFFj7AdeLEaVgzmEevwrMuM47DwcqxpuHfscESOcNhjr/81UHXXMKX
         iM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KINEf/W4t5TWaccuFrwzG0MR+MtGhaWK/ta0M81cluM=;
        b=nybUdbUVCnHNhYGSBBKHE0itre7sw1fe1N5noeZkamjd1LGf6XyvwsmKzCy47qHw53
         tasWhAHAkIJ1bqB/e90Bcoa4u9RNfCMm2QUd/JWrGlr+Up28ihAq3GyhfJ/IH62GqVeS
         jx8lYdJNgRty9CtlG284HWaQlnw8W3Z8Vs5UFsgEmXD6QalPcCdmXyL80osc6Ecd0so1
         gRw46rH2NwBXJdiIO0JtBYSJW8XIubzU2EO2UPyslHso0S/ducwE8pqVzgJ4oqIlD0xW
         E0MCdpjj9peZ+19EYO3CRsCHzegclt8rSbY48rFVUil5joEkzmczF9gxbgYrm0QPQaA9
         pKtw==
X-Gm-Message-State: ACgBeo3TE2R7AC7xgwr6h90x+QmwqialbXykz+MXhsdSso5p5KclgjX6
        HD5V+yExKbmY/52rPZvYcGWCCQ==
X-Google-Smtp-Source: AA6agR7Tf8hS9GdPkMqpMPlR2hA5a+tL4eVunhSXBds31WlgEuQinLuKuMUhl7PB7BYl4BonmilNGg==
X-Received: by 2002:a2e:93c8:0:b0:24d:b348:b070 with SMTP id p8-20020a2e93c8000000b0024db348b070mr7145942ljh.434.1660024652823;
        Mon, 08 Aug 2022 22:57:32 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id w27-20020a05651c119b00b0025e01ee7229sm1558012ljo.54.2022.08.08.22.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 22:57:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: ARM: marvell: include bindings
Date:   Tue,  9 Aug 2022 08:57:29 +0300
Message-Id: <20220809055729.19242-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include top-level Marvell bindings in Marvell maintainer entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee8f04918d44..b087994f8783 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2301,6 +2301,8 @@ M:	Gregory Clement <gregory.clement@bootlin.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
+F:	Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
+F:	Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 F:	Documentation/devicetree/bindings/soc/dove/
 F:	arch/arm/boot/dts/dove*
 F:	arch/arm/boot/dts/orion5x*
@@ -2317,6 +2319,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
+F:	Documentation/devicetree/bindings/arm/marvell/
 F:	arch/arm/boot/dts/armada*
 F:	arch/arm/boot/dts/kirkwood*
 F:	arch/arm/configs/mvebu_*_defconfig
-- 
2.34.1

