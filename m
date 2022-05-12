Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62ED524D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353960AbiELMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353976AbiELMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC49E24E000
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g23so6037184edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko9Su/75NK6EGUguCwaBtbcpvuAyD9W5527i5Vs8bj8=;
        b=DPtfHdCxQyPjMWiV48UAakFbrVlTVijW71FcHtaln2ZL8t17ZxoszZivDMJ6hnlh9K
         gpUJC4Eq7pk4YQ244e8UVwwmJxhauhxSooZu84WsiPGPYM040zTYwuACi4rJDoCYKRK8
         mrvbXTmCqfu9MA794MdXLFZfmMRbdZ4y22nRqnPtdrsZ+7jLiSf5/hOJFTSZghblZ7N+
         MghE37FekuBDKBWuCd3L0vf2NiGHwH/6YZoj5T1NqihWuMZn0VchJ8xuVZJ3WVNRj98Z
         gkhTxC9feCyi0b3ZslJELMh7SUmDkVsr1x4IGtN6ze080zOhtG0w0XBAT1p9A9PxvL1g
         h0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko9Su/75NK6EGUguCwaBtbcpvuAyD9W5527i5Vs8bj8=;
        b=0PNMBV2rrJ9bi4bAPVZKdWXNwoSk4FNBN9FyWicyBVcesPVgB5FFBGe/BD5UnyBc6Q
         JO5ReFYm9pRNO9ATks9j3ucSn47BzwI2qjvcpU5h8YF7fGZM+4a2Zhn2kNxqpDspY45g
         kRsnWWpR6n03Lsr78q8g64kOuXFX/oYEs66gq9SEhIU5+HI4m36nSyX11Ie1aegtLPZX
         +eCMw8v4EWfv1c3Um8VQ9/Yf+y/Y0ZivM2KLe+a28A8Chiy6QCFx+hztysN32bctN4Tq
         Qna1XldXeWXOHxq71x23isd5jxzsiUKudtOCeF0WR1UW1w5CRjcWK2Idnuu4+9Saacv1
         XhuQ==
X-Gm-Message-State: AOAM530mEvEd10Qt95huWAR/4Z+mxuiwy6ig+dzVpJBkyFZcM7iHyRjv
        eCAlWAxlWsP58OB2YMa5SjOtCA==
X-Google-Smtp-Source: ABdhPJxvLFLd/qQ+0VVcM620/Hgm80BrqP2iC39LQgdeotHa7tWzpbNQ2Cwd0iajqVENtmpmdAgFqQ==
X-Received: by 2002:a50:ab57:0:b0:428:9f9b:d8e3 with SMTP id t23-20020a50ab57000000b004289f9bd8e3mr21884275edc.305.1652359760305;
        Thu, 12 May 2022 05:49:20 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:19 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 06/11] arm64: dts: marvell: uDPU: align LED-s with bindings
Date:   Thu, 12 May 2022 14:49:00 +0200
Message-Id: <20220512124905.49979-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to bindings they LED-s should be prefixed with "led" in this
use case, so fix accordingly.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 4ae1688e6627..f216777acacc 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -31,32 +31,32 @@ leds {
 		pinctrl-names = "default";
 		compatible = "gpio-leds";
 
-		power1 {
+		led-power1 {
 			label = "udpu:green:power";
 			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
 		};
 
-		power2 {
+		led-power2 {
 			label = "udpu:red:power";
 			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
 		};
 
-		network1 {
+		led-network1 {
 			label = "udpu:green:network";
 			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
 		};
 
-		network2 {
+		led-network2 {
 			label = "udpu:red:network";
 			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
 		};
 
-		alarm1 {
+		led-alarm1 {
 			label = "udpu:green:alarm";
 			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
 		};
 
-		alarm2 {
+		led-alarm2 {
 			label = "udpu:red:alarm";
 			gpios = <&gpionb 16 GPIO_ACTIVE_LOW>;
 		};
-- 
2.36.1

