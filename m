Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9073254C26D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346399AbiFOHJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbiFOHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:08:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0047529362;
        Wed, 15 Jun 2022 00:08:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so6540756wrg.7;
        Wed, 15 Jun 2022 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwR7/AOTal+NwY86Mp0FPWEx+VIIdg+npTDhkz4uRZA=;
        b=gL8bFY2m4va0wZeJRgUWqT7kUBrgClgBRzeWX6YYme41Px5+XLUsZs9BZHzhA+j5uJ
         QpBDiZsW+/xE0hj0VZ2mae9c9SV/iffmUp+YaRKTjsQ5uxNFtRv8KVw07hkNc5hb2YHR
         Tt5zploYnrKt3aBmE4ykfGtpuKVbQj/z2Y3dmPwPKCl6BCsNBJE2maanXiYn9AIVrrFl
         vBKDO78TRIcjTOYXLwIcPD7t27vpH8gPK88BJ++c5uX0ES11ecP8lurhG+W7JxuinaLY
         R9rVz7bGM5P3rQb8mEoOkIBv4CTekqz9YbPYHu3acTS35H86hDApTQS2WCuz6Ineo8So
         35jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwR7/AOTal+NwY86Mp0FPWEx+VIIdg+npTDhkz4uRZA=;
        b=SwkxC3iO7/kq6+7S+DLG0/yhdMrUSdbeYcGn83W0NHDKDuesmZI2pSZ82gDH/+xXtU
         9T5kqgtbgCottHjT6Sb3CmavPdFQmfG/DVdhwXgjhX0WiVBSx9Y8ulUNq6RVQYtc3ufq
         aKuZev5nfFBNgxTPPXjWjuQgt6mbH6IEHCCPtDc5e+zFGqqNyHYJePRScijDKqs9P/GS
         sapq0V/w/uOSptG25q550CbtdBbGuxxp5tiaI0QVTCelW/zI8COa2kZs+NK9QtpArLWf
         LXTIJrfkmbhKuGURrzP+V5JqVS12+4k4Myj6F8r6BweVziMzWNsRXdM01jJT+mnCnRpO
         bGsw==
X-Gm-Message-State: AJIora+rK9zKUNQ7WjVdP5ZCYXpKc0t+D7R+nNNa2IxqyNF3SyRoSpqk
        pM+3D9PfTfGuhCHaGlZL5Bctbu//PRc=
X-Google-Smtp-Source: AGRyM1ssv4YeT78/571fz1QIuy4yDwJUyp3ElYxO5BCNbb/YE3woCIMzzu8jcbMtQbq4IB8m1ejJpA==
X-Received: by 2002:a5d:6d8a:0:b0:219:b7fc:f29d with SMTP id l10-20020a5d6d8a000000b00219b7fcf29dmr7969502wrs.665.1655276913323;
        Wed, 15 Jun 2022 00:08:33 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id d9-20020adffd89000000b002102d4ed579sm13472386wrr.39.2022.06.15.00.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:08:32 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: mstar: Add pwm device node to infinity
Date:   Wed, 15 Jun 2022 09:08:11 +0200
Message-Id: <20220615070813.7720-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615070813.7720-1-romain.perier@gmail.com>
References: <20220615070813.7720-1-romain.perier@gmail.com>
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

This adds the definition of the pwm device node. The PWM being able to
work with the oscillator at 12Mhz for now, it shares the same xtal than
other devices (rtc or watchdog for instance).

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/mstar-infinity.dtsi
index 441a917b88ba..752f4c26b31c 100644
--- a/arch/arm/boot/dts/mstar-infinity.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity.dtsi
@@ -38,6 +38,16 @@ opp-800000000 {
 	};
 };
 
+&soc {
+	pm_pwm: pwm@1f001da0 {
+		compatible = "mstar,msc313-pwm";
+		reg = <0x1f001da0 0xc>;
+		#pwm-cells = <2>;
+		clocks = <&xtal_div2>;
+		status = "disabled";
+	};
+};
+
 &cpu0 {
 	operating-points-v2 = <&cpu0_opp_table>;
 };
-- 
2.35.1

