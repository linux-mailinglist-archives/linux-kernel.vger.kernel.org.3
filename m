Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699215AEFF0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiIFQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiIFQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:07:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035286436;
        Tue,  6 Sep 2022 08:30:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so3120950wrb.4;
        Tue, 06 Sep 2022 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=18ALGCD6WSmdQYtbgKgYJ3c/Y319JyrAAYBhTvLvvok=;
        b=D+lIKJTJ5gmuLshP9pZR7/p9Uq3yXYg4c6fW1hSumSgSCwDmr/fcsKGBJJYtzoWVcF
         TN92NA+w2VWWby8boBIRrC14bsNy6GYJyUPzlPtxWzS4vdR7pAtld7jVe9UKiyn/T3n0
         mnFsqq4rRCunuO52qB/6Rs/YrSV+UibGc8pmWPOntrv5gMbhCfkfgWHX4dCR8zLDaqL9
         kCfQSPl/94cmjytUnDrr4Dls+czbEXkNWUC73gjbfe1dWCc98c4xtUZIa7MxCZu8jtdz
         teAm6/fXX6x/DcjovAjmyj/7jszu1EpgLa2cmsO0eHBSZ2RJFDtT1FFVcEwih0SifB3g
         3E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=18ALGCD6WSmdQYtbgKgYJ3c/Y319JyrAAYBhTvLvvok=;
        b=Wpre2dZZiI1lMAhVnFWULUm7dxTsm3KESna25e+eryg3PzslGYEQTq6o/6lD9gZTU5
         q7FwkcEj9HupF4N+aDn9G/axxsaw5tt2WkThoKtbtlHXhheltKNXbGBsewqiLqJvW31s
         kIJmZ8HvnlpIiOz6AhF8wZFp6BaO3ohh+0aByAN304VNj7yfnD68viAIF1RRhvadUUQT
         9HOARKamsiuVctS9GQ/hNTs3y58G02xUN6pJigJWPCnZ8McYLkfJ2CyiF5QDEyVAzdll
         DQRNCqsEbwP8tk1mFOX/opS2LOn6O1IWQEygRcnekcSNgxffUrwK710bVoGzmxKsQydC
         lrHw==
X-Gm-Message-State: ACgBeo2qFu3Dy7oktOgF8eevRLODNbSd6+ybMqShz6NUHKcZSE11Spg7
        yJVUgJpy6FUmoFFNzNse/5k+GNO06nHk0A==
X-Google-Smtp-Source: AA6agR6P/RoJFPCp99aXsrvNKO/CW4Xn7PpfrGRr103Jx3gdD14r4PVNgrMIKUUt26sNFdyw2C87+w==
X-Received: by 2002:a5d:608d:0:b0:228:d095:4a15 with SMTP id w13-20020a5d608d000000b00228d0954a15mr3792578wrt.499.1662478244524;
        Tue, 06 Sep 2022 08:30:44 -0700 (PDT)
Received: from Clement-Blade14.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a6125562e1sm14922731wmg.46.2022.09.06.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:30:43 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 5/5] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
Date:   Tue,  6 Sep 2022 17:30:34 +0200
Message-Id: <20220906153034.153321-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906153034.153321-1-peron.clem@gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com>
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

Enable GPU OPP table for Beelink GS1.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 6249e9e02928..9ec49ac2f6fd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -5,6 +5,7 @@
 
 #include "sun50i-h6.dtsi"
 #include "sun50i-h6-cpu-opp.dtsi"
+#include "sun50i-h6-gpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
-- 
2.34.1

