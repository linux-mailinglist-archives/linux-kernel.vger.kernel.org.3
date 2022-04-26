Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945F4510496
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiDZQyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353490AbiDZQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:52:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225719B642
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q23so13415949wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4ciD6HIPd+5KM3dYGEOIb5g49z+4yJDjMPc1UvrfkU=;
        b=IJZs0rJxdFFgeK0qhrf9rXUqCycI5k/9aihNZmVD0Pm7hmJYgN98EhRFb8/56KGxsW
         CmQ5FLvhRT4+RAs64ooR2h5jeA/sWjQd/rmBfezKcTvUEIrNPcxYGtb8HYbbwPrK3LYD
         Yr7ZgIq2JOarZPyr9GVegHztUbpfnLqoABb3C/ZOaC376RFckBFWhGra/jOo8/25KYwX
         ipklu/+JHJHG15T+ehqtCqTvzkbDJQvlrFRjEJokElNDaeLVCTfowAlwUaaeEa4xNdzO
         kUNbuBJ5j5knBsDJwIROJHpa5v/PYiYNACjfXHM/1lUsbWYOHqnUz0kffnT2idz5N2LI
         YsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4ciD6HIPd+5KM3dYGEOIb5g49z+4yJDjMPc1UvrfkU=;
        b=B5R4MT8/zDDBfns5CWHI1S8SoZruP+ULwqGl0pYNz/X51nP4PdCY0oZNCD+8yjaCq7
         aJsrWXvV5SKLHpCOLuILkbHVNPOsTSlbPU0WD/2EDUijbJ2eFKyO8uV8Xfn0tnQCz4+v
         9Rkd/iNVCrkamNulDaUpJcyELBAl/veHkJiqU30/KkZMgemVacCYxGWCem7s29a2jKX/
         OS03K3NjsP50n/xNaZ7ADnQ5HJepPuzI5nO5XcG49Cv+NmqdFzGVm/ISmyyrs6de1kKW
         Wn6D0lSJ9xD3LsN8lij4fkoq+wtGK0a/Eq7+QuATniUD1IaytpZgAYtnlm3dwS8zmhs8
         5cjQ==
X-Gm-Message-State: AOAM532uBIu1CpjrptolXBo6uwoc1oT/XWky1Ie7cjrWj8teAxw2DdJD
        /7or6ILjX6nrI2An+ymLSF+WYg==
X-Google-Smtp-Source: ABdhPJxxUshafCrpaa0LIgdqChjnIZ0fYu0cr2UYUDQ5TDdi5wXwhZ8aLoRJtA4XGbiS68e8+yiZFQ==
X-Received: by 2002:a5d:6752:0:b0:20a:ce1f:2ceb with SMTP id l18-20020a5d6752000000b0020ace1f2cebmr16099080wrw.715.1650991691348;
        Tue, 26 Apr 2022 09:48:11 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm14012661wmc.7.2022.04.26.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:48:10 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8183-pumpkin: fix bad thermistor node name
Date:   Tue, 26 Apr 2022 18:47:55 +0200
Message-Id: <20220426164755.435372-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following dtbs_check error by using the correct node name:
/home/fabo/build/linux/mt8183-pumpkin/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb: ntc: $nodename:0: 'ntc' does not match '^thermistor(.*)?$'
	From schema: /home/fabo/devel/baylibre/linux-mainline/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 10b2c0500219..3d6da7efe31b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -55,7 +55,7 @@ led-green {
 		};
 	};
 
-	ntc {
+	thermistor {
 		compatible = "murata,ncp03wf104";
 		pullup-uv = <1800000>;
 		pullup-ohm = <390000>;
-- 
2.36.0

