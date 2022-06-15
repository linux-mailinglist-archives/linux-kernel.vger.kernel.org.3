Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFCB54C26E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352684AbiFOHJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbiFOHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:08:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ED92937A;
        Wed, 15 Jun 2022 00:08:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q15so5797397wmj.2;
        Wed, 15 Jun 2022 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhHHfhBS4JEZS5T4Cqsky8UODYiFkR3zFwNbdfWOgRM=;
        b=B3CYB6Nl2KGF+oCOFeUR6gZzBF3a3b32bAom3UR9EAoLMEnX+yxruYjwcNyBnMBYkl
         Dk9BQ01Wzx7JQFlgvVgUTMRUSac8nLBg3mCEVa9T7qiJijaj7dlNeik5AC5x9NSD2ggd
         KWYDvbjRazPZ3QxQnCG0Ep6zIUM7F8LSdT5qo3J/B8bdJvx07PY3wZlwtePuDNpIXHry
         AVqwQKpUvEv7KscMM8dojQH/4hQoa0FJx4gF9vfm/LMOS+v1EpZwLwPRkZ6u2WyQFRvG
         /lDDxNO88QNANusB4C1VCw6pGFEV0gCvpHwAzbxygUE7zrSsmKWlbfSoYR2Ipo0/Wydf
         czww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhHHfhBS4JEZS5T4Cqsky8UODYiFkR3zFwNbdfWOgRM=;
        b=7CGjM8W+htJGrOKACeV2f0ytq05EoI5kR81ZM4hvVz+bvBx7qTSDv0vNPNSPQ7AdLW
         cfYH/DpCGE70DDRsM2VqpChBi5sNEf/x+0ETh96Q87bVf2Zaoh7cmYxhNCDRogZY1XyJ
         axR1Y/EC667eEvW6grTB7RErw+tux7EOJm0kBBPexoY+Ac6Oe2rB4ma0Ufr1Xc1KSlOA
         ukOdYVQnlwvZUHvCi8sawU5DHjwKMpzKaWcPKfvyxied2ji3KHOGPhCBYoQh3TNOWfsT
         NVPn+ke9sUKorbHzxj1GXz1rziPA8raFpfNKX2A30IOCe6ihOCz3cL3nsd3zdp4sfi6c
         44gQ==
X-Gm-Message-State: AOAM532VJlZhoPzGRtMaC621lfMrwxeD/0LahkqfQvqugROstzD30hPK
        fENpHnjGd2sTcktL3hRFnDJAxXo+liY=
X-Google-Smtp-Source: ABdhPJx4NWtb3vWFFFfgrtFkg5c3A3KxJh3ThnO9v7JUj7JFhsIT9FFGr1tDDi/+cINTfg5V5a/R7Q==
X-Received: by 2002:a7b:ce87:0:b0:39c:5509:660c with SMTP id q7-20020a7bce87000000b0039c5509660cmr8103989wmj.163.1655276915130;
        Wed, 15 Jun 2022 00:08:35 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id n10-20020a056000170a00b00219fb3a275csm12058044wrc.16.2022.06.15.00.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:08:34 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: mstar: Add pwm device node to infinity2m
Date:   Wed, 15 Jun 2022 09:08:13 +0200
Message-Id: <20220615070813.7720-6-romain.perier@gmail.com>
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

This adds definition of the pwm device node, infinity2m has its own
hardware variant, so use the one for ssd20xd.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 1b485efd7156..70561e512483 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -32,6 +32,14 @@ cpu1: cpu@1 {
 };
 
 &riu {
+	pwm: pwm@3400 {
+		compatible = "mstar,ssd20xd-pwm";
+		reg = <0x3400 0x400>;
+		#pwm-cells = <2>;
+		clocks = <&xtal_div2>;
+		status = "disabled";
+	};
+
 	smpctrl: smpctrl@204000 {
 		reg = <0x204000 0x200>;
 		status = "disabled";
-- 
2.35.1

