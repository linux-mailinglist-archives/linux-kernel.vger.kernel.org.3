Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562384C2EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiBXPEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiBXPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:03:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0548213FAFB;
        Thu, 24 Feb 2022 07:03:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n14so65956wrq.7;
        Thu, 24 Feb 2022 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ay7hHiiyWs/Vspu7K7W0oyce1GoH5RAvVwUQfqJxKdw=;
        b=QE7qSiCRSkNpeioUFowv1w/tMqa+CqBSzJ8cdc7hagydOTeoSgSBg5mTtY2ShLJmyX
         UFVN3AfQCxZMsCrk8jjKemUEPPKJCmHt9tsAIBJMz2iQlRiKr0yYVQ5wkPYiDE3WGvqF
         Z+WQ4rFRURUE5JY7P1NkgTBOo7KBC92JQHNGkgYzIkmZNhH3BP5fOltzvXyTFoGx9f6h
         6gMi3kUxcEeF2IaMoGETmeVNJjY2kcJjX55PSYIoo8d1NhXXVpjI6gkhOAFPhM8LmJfD
         MyEJhsU6aprqVV/HfZxPtIBLAytYOCwl5EfWf/FhLmSfHo3wGNSo85mj96ywZGeOwj4n
         IkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ay7hHiiyWs/Vspu7K7W0oyce1GoH5RAvVwUQfqJxKdw=;
        b=D4WNien1cFFpY+D8HGwBn/Nc4xGBoojZGhxtMVedKNMKSJQY2nHzOJjyokuxeXMmRt
         ME+jJIOV9hJVHe1L4Kome5wm11PBpw1FeGZywKF12/ZkF7c0ns4HMgjFqLSGAJDnbRhN
         7QXoK27EDF1EbIDPXVATp9ExYRlVMTLbh4SsRSIa0jTr5riAab58e3nbJajhKiRG8yF2
         2DbjOC8p45j2o5MlOHXpTPQfaVvhaj5q4xVjzgIO9lkuebRonfiYl6dXTCNdA9vu75ZE
         2P/ik4loSfn4h+w/nghJIsEDDNaXlqjLr6FWASzFMlt+SiQXU/CbnfGBf4VPBVJsWfgG
         9AoA==
X-Gm-Message-State: AOAM532NC2/BUCkXj9S3aNBYdgYl8yNv/t6Xz+H15X1osEQFbGpAvXV/
        0UledogHvzimSft+gkXGJi4=
X-Google-Smtp-Source: ABdhPJx2y+M/VKJ1us6B+6NIX3jANMf2jjeXPdnF2XYwqMhSm+MhoRZohCbTFsnugTJ4/g/NbYnhVA==
X-Received: by 2002:a5d:6d0e:0:b0:1e2:fa3d:7f22 with SMTP id e14-20020a5d6d0e000000b001e2fa3d7f22mr2593465wrq.142.1645715003444;
        Thu, 24 Feb 2022 07:03:23 -0800 (PST)
Received: from localhost (92.40.203.111.threembb.co.uk. [92.40.203.111])
        by smtp.gmail.com with ESMTPSA id w13sm3088645wrv.21.2022.02.24.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:03:22 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] mips: dts: ingenic: x1000: Add TCU clock to tcu device node
Date:   Thu, 24 Feb 2022 15:03:25 +0000
Message-Id: <20220224150326.525707-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This should've been present all along, but was omitted due to a
mistake in the driver.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v1 -> v2: https://lore.kernel.org/linux-mips/20220209230145.18943-1-aidanmacdonald.0x0@gmail.com/
 * Split DTS changes to separate patch.
v2 -> v3: https://lore.kernel.org/linux-mips/20220212150927.39513-1-aidanmacdonald.0x0@gmail.com/
 * Add fallback code if TCU clock is missing
 * Update X1830 devicetree

 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..c69df8eb158e 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -111,8 +111,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1000_CLK_RTCLK>,
 			 <&cgu X1000_CLK_EXCLK>,
-			 <&cgu X1000_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1000_CLK_PCLK>,
+			 <&cgu X1000_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.34.1

