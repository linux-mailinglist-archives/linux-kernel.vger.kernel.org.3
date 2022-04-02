Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0B4F03FF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbiDBOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356618AbiDBOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628D182DA5;
        Sat,  2 Apr 2022 07:36:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so11423254ejb.4;
        Sat, 02 Apr 2022 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7nPX0FS+sUDMedLCWLeoyXqqsqm0c5Dk9c11Pv8XJw=;
        b=nWWshgpSZPDeAzvpV+ru6q4bftzMnLHLFQNa+fEOYpGRwFqEGaW+NGrw/9jJ0a3xmD
         rSkCm9gWGS+yrBDP33ky5c3RhuzOGfrrZYuBNZMHyA3szIvoJFPPhlg8s+XE4tXk95Sd
         NQ2w/HEbsxmknGWXT0Fsg1MdkmgTHJ4p8le/rrley7FBtuTuo3EDrUsXi2qZw2suj0AX
         gxpzHKLkFC51b5Su56nA9CD+SLsmKxNeKKdGomRS9snrX5mGryPiSqvzmBjSVrYhiZ0H
         r4jB6OM5st9pN5QbbM5tiMIQYpOdj4Wp62fk1H6O0Jtl2UaftvStKnJrjnixO4QSw0fJ
         IveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7nPX0FS+sUDMedLCWLeoyXqqsqm0c5Dk9c11Pv8XJw=;
        b=HWY1sRp8pM8EdptN/XQqq24kKqxrcOMYmE983yGZFL0NzUoLbRqZZ24Ov4JANrQAQl
         ZnJgB31aY0jhXVMk3zv/gg3zikTFpIscodnOCClVHu3AsL9vo0Nti1t6mAV86JnkV1iN
         /vnWYdrv43/8UvuZgyYNfyVcXTzexIMs4aRID5GVZWln6p8NfcR8r4aEQevKf80eGm0D
         kz3WG1PTa4h/mSh3559g32I9N5UEdAVRrStOEoOPqu/Ld8IXNbsXmIMf3QTX3hx43opg
         7P6Jp9vyNlD4RCK4H33DNPGts3py07Ql9IyzWD4OPZph6QxFz+7aPAesrcAD4ZZAG7VY
         XEUQ==
X-Gm-Message-State: AOAM530pAEJq+oZg2AQSLRAnkxAXdH0EgnI9Tq1pBZOkaIDsQmynrh1L
        vYexAeVgkVKbnC9NfGOnETk=
X-Google-Smtp-Source: ABdhPJxJn5VfKuILnQXKNWoz+AIUpzD+KxuWTuFhTY+txH1IG4cNyiawoGOucUv+UK708eGrEMPt9A==
X-Received: by 2002:a17:907:7b8d:b0:6df:fb75:3d41 with SMTP id ne13-20020a1709077b8d00b006dffb753d41mr3955984ejc.166.1648910214626;
        Sat, 02 Apr 2022 07:36:54 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:54 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/16] arm64: dts: rockchip: rk3399: use generic node name for pmucru
Date:   Sat,  2 Apr 2022 16:36:32 +0200
Message-Id: <20220402143636.15222-13-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
References: <20220402143636.15222-1-jbx6244@gmail.com>
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

The node names should be generic, so fix this for the rk3399 pmucru node
and rename it to "clock-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index ce1cc42ff..56af1a1d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1413,7 +1413,7 @@
 		clock-names = "apb_pclk";
 	};
 
-	pmucru: pmu-clock-controller@ff750000 {
+	pmucru: clock-controller@ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
 		clocks = <&xin24m>;
-- 
2.20.1

