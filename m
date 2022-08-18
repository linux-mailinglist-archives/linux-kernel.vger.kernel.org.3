Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481DA598E43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbiHRUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242809AbiHRUjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:39:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A597FCB5D5;
        Thu, 18 Aug 2022 13:39:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso1534423wmr.3;
        Thu, 18 Aug 2022 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Xx725Ih3hQX23yTN0zWfPqhputIO84/6U9GSIQz+QYk=;
        b=hrEeTkCQQk/UH9/U16GGJjblGquX9MVzdldEUMGPhv97AYIZY0ccqUA8FcN2iYxE5f
         ZccvDq1LtrAoxevGXhsXUXdnp6JFRQAiFRScn6ncaGOLlHo/G/mxfkjUZJvdqX+kI7y0
         0rtE+l2j3V4i6nuFwwdLHq1N/1aSvP3mYZMvlAmxCxXLK3ANVkBordhTDagsxC0Kvfia
         hYmh8qTCNpY17OkUQnD4scznGx134L3J1B3IjUjWYcvXLyJLa93eNr+EMwBUHJeMp2nT
         3C+YFlyVVRySMnB7Y/e24JPLRkHssL1v+GE+Q0jk2nzqh4VJVtFkDFeE5nMu2vB8iojP
         HMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Xx725Ih3hQX23yTN0zWfPqhputIO84/6U9GSIQz+QYk=;
        b=GQqP0pOAS7UyQWEM9ipRRwqZcZGnA9sz/FpIRYNTxv4l9E5awxBFw3ygxALkxXGauK
         5nKZVgqBAxoRXMn/P5zI6n929ZHXJUY+zAcl2lh7CbY4SvsKLivUZ02niPzH8zn3xPga
         lT80+Z8EoYVlDzqPLYPsv/9Yh4ULoRCiRd9SgsWIM/2W1E+9PUMmw9SoJcEZolfjZZfN
         QpoKVaDOu0FhncDV7S++P7nHPjhizVpyXYLUImFQsl23NCM00DFHXg97OsFimR87JHtM
         VkUFaTliH2I8Rj4EZRj8XPPHJ3JmNsU8ShWH6gm4WaTbrghfJ1bg/MAJM5zf0+g41j5u
         dg2w==
X-Gm-Message-State: ACgBeo0V+aVuMfmelvepH9yZe4FaCls5AJaA9cCl/cWhB8gS2kKH0RLz
        SXvorhyILHkZHVwlJzjlZNg=
X-Google-Smtp-Source: AA6agR6hNAol/gvhMbvlpUqAQvXx/9eFxWuE62Dl+HHsGZ8P+cdHzNc+ydHfjKh23rN1R0gGz8FE+w==
X-Received: by 2002:a7b:cc85:0:b0:3a5:50b2:f9be with SMTP id p5-20020a7bcc85000000b003a550b2f9bemr2834206wma.18.1660855181167;
        Thu, 18 Aug 2022 13:39:41 -0700 (PDT)
Received: from localhost.localdomain (2a01cb000c0d3d00cc34c67bc193cac8.ipv6.abo.wanadoo.fr. [2a01:cb00:c0d:3d00:cc34:c67b:c193:cac8])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a54d610e5fsm1571648wmq.26.2022.08.18.13.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:39:40 -0700 (PDT)
From:   "=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=" <peron.clem@gmail.com>
X-Google-Original-From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <cpe@outsight.tech>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <cpe@outsight.tech>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
Date:   Thu, 18 Aug 2022 22:39:28 +0200
Message-Id: <20220818203928.131059-5-cpe@outsight.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220818203928.131059-1-cpe@outsight.tech>
References: <20220818203928.131059-1-cpe@outsight.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enable GPU OPP table for Beelink GS1

Signed-off-by: Clément Péron <cpe@outsight.tech>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 6249e9e02928..20fc0584d1c6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -5,6 +5,7 @@
 
 #include "sun50i-h6.dtsi"
 #include "sun50i-h6-cpu-opp.dtsi"
+#include "sun50i-h6-gpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -261,6 +262,7 @@ reg_dcdca: dcdca {
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-always-on;
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
-- 
2.34.1

