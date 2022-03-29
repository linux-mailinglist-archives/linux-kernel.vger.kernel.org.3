Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AED4EB1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiC2QcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiC2QcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:32:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8B24221E;
        Tue, 29 Mar 2022 09:30:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h4so13554614edr.3;
        Tue, 29 Mar 2022 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rup4gmFVRMm1Db1xKcQ9C4DJyayglE33FgITP93feZI=;
        b=f8zqtGcfvk0wEpNaAgaCylr34j14R+MDTTY9qugHrR1MIk/oAlUmCHAAvTannf6ZUz
         sLY36RDHN0pt3a7GCMLxHiNojdB3MLuSBUkzIZVRHTWGX8DquOLPps7qp5PIyNinj13i
         58KwUPz25LTZe2Di6xx4zhdb7FBfiDAevjCdMJ2J5oNvt+Rahrnk5wf/XJAxuPp10CMI
         Z3tQ7GMhTvu/hyfb0/8je/fK7yqsHvbZv3PrmOf4GL7WrhCZiMSzH2g85ObyMspop5Kc
         vRtkCdcF0QXVz/ZXU4dI+I6PNZm2YhPBZsVRXsi9ZelyDjWZvTA4Qf+PO7RUCWIH3GJW
         0lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rup4gmFVRMm1Db1xKcQ9C4DJyayglE33FgITP93feZI=;
        b=IMOsVFrgVkzpt2smsoDhDnqswo8LzWWhtHNQzSNuftUk3ggRkNFKUJl4WpZc7zHKUD
         dPLRizjChI5xdqJF6mByXSoqysrEEOche0m7MRdzL+BrK0wbFNerCfrUkX9WUz09VyMZ
         pHPHSQMwM35DOTm6zoeBiqMq3WUDmILuVm7nB6WdYLWpwuL2LdRFPvHo4etQ1E1S0V5B
         nFdtq6Yi0erGU2KHLNPvin+8waObf6pfMMc+IPBuub90oDcN4wwl9MHGZaAv5PJ2oYdA
         ZQ5xoTjy+Tt+n2SptUGNUra08HhuDwGhUQ78cP2T0HeQoUYaJ4j1kpce3nNH/e0p1Qgj
         U1nQ==
X-Gm-Message-State: AOAM532VuZ+mXCuvqcvoQF1nif37YGD0udkDxbbqehp2WaBFLF8bcQnJ
        LxucGJwGivvkbBPUYEJHSuc=
X-Google-Smtp-Source: ABdhPJzTy7FW/+WGlMtP1pToBeoHtes0f1brjP90ukaULF4+ONZLw0bw81tdrnAqoB2Cm4GbqnRReA==
X-Received: by 2002:a50:d90f:0:b0:418:8a5a:14b2 with SMTP id t15-20020a50d90f000000b004188a5a14b2mr5538105edj.241.1648571429156;
        Tue, 29 Mar 2022 09:30:29 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b004197b0867e0sm8601179edv.42.2022.03.29.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:30:28 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: rockchip: add clocks property to cru node rk3328
Date:   Tue, 29 Mar 2022 18:30:16 +0200
Message-Id: <20220329163016.27458-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329163016.27458-1-jbx6244@gmail.com>
References: <20220329163016.27458-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks property to rk3328 cru node to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 73418fd2f..8ceac0388 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -758,6 +758,8 @@
 	cru: clock-controller@ff440000 {
 		compatible = "rockchip,rk3328-cru";
 		reg = <0x0 0xff440000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

