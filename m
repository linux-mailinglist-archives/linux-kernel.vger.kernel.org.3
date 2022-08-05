Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54E58AAAE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiHEMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiHEMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:19:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81B78212
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:19:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so4755458ejp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=GdlW2vrkR8Va0X99n1iERUM39qc5sgEPSCjAR8k9yixoELLFcDdtyx0CpxG3GJ/HmJ
         ZahKVF7vjOa8jNj8pFFIBkkgsZeMpGsiqgY01rXRrPOk3y4Qobwdgo/9aFYVl7ZsBkBU
         EXWm6C+okDN1w0VIjgK1RumilBXQ2pXnNn7cEGmoLaKgnhsYElerxmLHjVQcV46raskC
         4zr4XKYJxFrs1Crin8TlBdOoECDvh6BggXxn9UBDHp7vNC07tl5bqXttcZi4afbFu4CB
         mAN67OOXeVo9bNsr68oIJuJpvy8sjguUX52+Hrtz1vHEswlPu7iuwCX0me8LzZXQ+Xs5
         rvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=HZsnJTBr2WrOm84cVUgLf2sXScFIdNJpLlmIh+y+iPPxAJTRJKfwp8rCWV1l1tmqeO
         MUtc/kegxBLohaLEB7XGB4ihPl5/K/ZMOwCn2CPJpHuO12n3HMlf/C9K51casE621MQV
         Gug76nme1sfYCWd0ORGf+759nyINKIN3w3kK6TBt/J1LJPW3XUXBRD6fv17enHmBZQxt
         bj1rAOOfN3K0EoH7dZN6hviL+7GS9kkV5lwIOmkhqBkN6VlwNHeulFr+6N3qaz/obiC7
         NAxZLcDwFJuhv5jGVOx22WsWqbvO2qAs9rUiloSmjWI4+9qPV5GgFYLUBIb3TmMUrNgX
         LK8Q==
X-Gm-Message-State: ACgBeo0MPYDF4BGNu3DxKlTYyTh3QbNGo+D56lz0zerJKlSqnZv5Gig5
        YzssHWi1HSMAE8yY5zX65j9gLQ==
X-Google-Smtp-Source: AA6agR7U9bW7l6YeondNI0IKqukUvOZaPzQy8h7T/tdMPVGZDBOXIp3O3HkM71h2OzKTbTAKiNwOYQ==
X-Received: by 2002:a17:906:93f7:b0:730:da74:3454 with SMTP id yl23-20020a17090693f700b00730da743454mr4197777ejb.331.1659701951491;
        Fri, 05 Aug 2022 05:19:11 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-5241-be09-b892-f882-607f-7a79.rev.sfr.net. [2a02:8440:5241:be09:b892:f882:607f:7a79])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0072b3464c043sm1506111ejc.116.2022.08.05.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:19:11 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: [PATCH v3 03/10] DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
Date:   Fri,  5 Aug 2022 14:18:45 +0200
Message-Id: <20220805121852.21254-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220805121852.21254-1-jneanne@baylibre.com>
References: <20220805121852.21254-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board uses the pin as a power-button, enable it.

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1f7ce60ecb57..238798ea6a79 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -362,6 +362,7 @@
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&gic500>;
 		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		ti,power-button;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.17.1

