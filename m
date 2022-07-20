Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D957B8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiGTOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiGTOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6624C528B6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d8so6506212wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:to:cc;
        bh=VGUb9DmOvoGv8nh5rqV1xHbR9kL6IKYbqd/qwv1q+CA=;
        b=jRL5JcT9oKaeo7HwZrYobK/YmXLf7T2OTvQbB+5Tt4Ej73xiicgN2WuAV9zlw2rEKj
         gBD1wR+vAFAyQ36BarOC42aGFh0Z+CUVKmoz8jocS+Sr1oFSoZdpIpLnfx+p6ZO2A1ou
         AAcutHoNxH3HiLedSavddURbO+/DeoJdbuK1UKbsYvq/AEfupOK/Luj7ZiWHbwkOSZy2
         aHRgAVTfYYziWX4EbaYfxDteMDi0fDZibAkzqfnGLqb6TtdUDY9XJZimypikQHHkA/RS
         HwXgTHe4cGSkZD6UzZkh/rw9pNfYj2qyAa5Grv7CnZLvskr1FGDTqRsjvNQ4XaQ9hQ0Y
         SVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:to:cc;
        bh=VGUb9DmOvoGv8nh5rqV1xHbR9kL6IKYbqd/qwv1q+CA=;
        b=KQyoWvn1mLoLx08In326Bw5KeLU2CTu8/0FbKtdh8UmmF8q92MfwxJvwVpChfylvIF
         RO0/VoTChkpsuLYdej2Ltjtx2aAu8akfjuTmECFDhNXA7WzPPOmsiDdwnS1b/W81Nkkz
         S8Nb0MB184fqGnU6vlMlpXaRFkP/AtrK/Rs1EIv9kSwSLgYx8IywarKuOkY/tpYpRaOE
         zFXDLIxWNQYV9wbdeDP/CX7gWPqAfKfoGnvPFUQ2LwHSAfU/vkSCKs8FfAFgpTYxNDJq
         TMHV3OWdfrKno3DPXkalhIGro84ia034g9r4jxCpd0DCpV6y1k+4K6iv57XcRgUYS5+k
         KeLw==
X-Gm-Message-State: AJIora81pbmgr+nRFOmjBoPuZMfOg4JfN0C3axI7wlP3Vc1yaZ6KvMXm
        pFRDfPXON3VS2YrCEp1iBI0KznqkMjTqgA==
X-Google-Smtp-Source: AGRyM1vTy640y2iV3Q5noFGBYMKVc349uYWye3eyUbUhWj27qZA/i9aPmd4vKm57vaVf4wNmnxmupw==
X-Received: by 2002:a5d:648a:0:b0:21d:b684:9c76 with SMTP id o10-20020a5d648a000000b0021db6849c76mr30956265wri.463.1658328522794;
        Wed, 20 Jul 2022 07:48:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb19:85e6:1900:c639:22f8:bed9:44dd])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003a31673515bsm3321121wmq.7.2022.07.20.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:48:42 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Wed, 20 Jul 2022 16:48:41 +0200
Subject: [PATCH v1 5/6] arm64: dts: mediatek: mt8183: add keyboard node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v1-5-ef9fc29dbff4@baylibre.com>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0-dev-54fef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

MT8183 has an on-SoC keyboard controller commonly used for volume
up/down buttons.

List it in the SoC dts so that boards can enable/use it.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9d32871973a2..9d8fdebaabe3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -943,6 +943,15 @@ pwrap: pwrap@1000d000 {
 			clock-names = "spi", "wrap";
 		};
 
+		keyboard: keyboard@10010000 {
+			compatible = "mediatek,mt6779-keypad";
+			reg = <0 0x10010000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_EDGE_FALLING>;
+			clocks = <&clk26m>;
+			clock-names = "kpd";
+			status = "disabled";
+		};
+
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8183-scp";
 			reg = <0 0x10500000 0 0x80000>,

-- 
b4 0.10.0-dev-54fef
