Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67D49D110
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiAZRmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:42:42 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43202
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231546AbiAZRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:42:41 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B943D3F1A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643218955;
        bh=gEM6VSiZGn9+riCesXh6Ndj0fTM5V3VNUzWbxDz0u7k=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=aXC5olx+rVtygbdF5epzgjgWV2OiV4C9pX6s400OoH0oZNd0B2R4h8D0pu9LVqnSi
         PUMxLd2m7227/oh+uC0g39/xqVsigTGqm0HsEpOhF7xE9CW28++4SGRHpZ5wUvPmwn
         K6O3nrcFfiEgF8AFZ1r+bhx0Qa4jEy0+7Xd7sQi6M80hjRLW90CDsX8qmnMb/f8V0A
         PYeIgmqoXYjNAEHEr51w7azViY5ECFLEotmTeq7lq0RreGNXHBZoB/XbK0HtHvhIYM
         15ESELGJoDriYvr2ciM/sQL7SPMd/a6MAebZlShTPP0LFQy/rwvW4cmIbFwMy+t8c/
         6git/igr/CvOw==
Received: by mail-wm1-f69.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso205851wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEM6VSiZGn9+riCesXh6Ndj0fTM5V3VNUzWbxDz0u7k=;
        b=zk30jznLi53Y1VfwdPa2lk1qcJoezQnuIjgjpm3PUwhoMvoTBu2SHMur0dw/dOuprT
         TRYcR+Q+ozyVwGlCSIF71vD8qkzKfC+JXWzlGS45LbSS9dVa2owevWNokhC+h33mk3Ju
         2ERu9tvYgbgAdUB2eFnmir+h7anOi40AjVQXeZkCHL1cosSAiBo0gZyIYujRZ2IT1/ql
         5+rfc6M4YSFYr8xuuSUJJPWVojfxBkYfM4cE4XmbTsMmkGZdiHUZZhv/U/tndBqhtjC6
         1j9nlxSr554KiZ7LXvZtD6mMjt9esufWNcO5+3wXxdfQ5GDKB9EdrXbieDZCpWGtnWNA
         K/4w==
X-Gm-Message-State: AOAM533NAyIWyniyJ1bZHYc9eWH9gjK9lEwKiT5g+oY14L9rtp353DfQ
        5PLf6cVhX4nqVZtx4p6PD2uTJyM3QjsXmsOiMIBLeyL0CPhG2V43AlrTg3kIQIMWkWB3fa1M0fk
        QqykHN8rrBwbe8vrwormPyz/COfryvXtwEHSEuD3Ttw==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr8635253wmi.139.1643218954807;
        Wed, 26 Jan 2022 09:42:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6kdysdMCq3VW5eb4T595OgQuQT6Z+gTtfvxQP+Z6YAumo97c6qlaVhjpPpKKj/OOAmgJgwQ==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr8635243wmi.139.1643218954548;
        Wed, 26 Jan 2022 09:42:34 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f8sm21074368wry.46.2022.01.26.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:42:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND, third time][PATCH] arm64: dts: intel: socfpga_agilex_socdk: align LED node names with dtschema
Date:   Wed, 26 Jan 2022 18:41:57 +0100
Message-Id: <20220126174157.288111-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Align the LED node names with dtschema to silence dtbs_check warnings
like:

    leds: 'hps0', 'hps1', 'hps2' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

---

This patch waits for a year. Dinh, you previously acked it but can you
apply it?
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index ea37ba7ccff9..26cd3c121757 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -21,17 +21,17 @@ chosen {
 
 	leds {
 		compatible = "gpio-leds";
-		hps0 {
+		led0 {
 			label = "hps_led0";
 			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
 		};
 
-		hps1 {
+		led1 {
 			label = "hps_led1";
 			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
 		};
 
-		hps2 {
+		led2 {
 			label = "hps_led2";
 			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
 		};
-- 
2.32.0

