Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28F857FB35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiGYIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGYIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:25:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF36171
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:25:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r186so9755782pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kGQIfBSg21d8MaClj25+YrNibPoLqEzZ9tPdy7y2WU8=;
        b=Z/44oLBpU67FazLoPRhw9EoDB7p9O0DopA+QnAhE/fO+Qa/QflytOcQ2fvgzPbSw5L
         WQVHStfPgywQj4rIX3JM/mPCAdddMBviY8QD+kdCGDjBpNpLFMDse95KCMVWKn4LUS4D
         OH2W9TecbxWviO8rlbZxq8KlL09VWh6Y3OOQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kGQIfBSg21d8MaClj25+YrNibPoLqEzZ9tPdy7y2WU8=;
        b=ucSm5cbKCxa0vDBufceZ5a/2VxzLwuqTDc7yqE8F/zHzPMIcdow+7Q5uTjXFmCUrgb
         hEhviRycBVuScWKAdY618sA7keMbEQtua6H9HNwJUKJLiTMpqVb3cDCMeFDEbPMZvSqB
         UIr2I1UuFbIfVGCY2sbGCWl7YHImTSoLjvQzeliNESIu1CG+cOxw2xb78ncxp65EeDcm
         U0aTMqBkZW2Al6EM3WNQzY5+4x9XJXHSblN9/xs2wY9WQFkV7bzEKSpY36bt9K8XjlpY
         BYMxmyNVdGbOzDLEyAcXGoPI9iZAABDssBoEsDCfpwLbIbAQw0+3RXAD6LlNtK9IcHHj
         8w4w==
X-Gm-Message-State: AJIora8u1qy61SSpx5hpA3GxZ60yFzKdKUBWgrKNKT91bM1L4hxMFs+x
        HFAx5wqYCvktwaafIj8EyfGkHQ==
X-Google-Smtp-Source: AGRyM1toZNSKvxgwGTAar8bhczeRFzgE/1q6uyg+lK8LTNMCbEYdUJJ8lpGmzEk3tpAOQilyUtm83A==
X-Received: by 2002:a63:9142:0:b0:412:b171:b6ac with SMTP id l63-20020a639142000000b00412b171b6acmr9876579pge.206.1658737501260;
        Mon, 25 Jul 2022 01:25:01 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:7c:3b29:8e9c:93e3])
        by smtp.gmail.com with ESMTPSA id f21-20020a63f755000000b0041ab5647a0dsm4010394pgk.41.2022.07.25.01.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:25:00 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: mt8173-oak: Switch to SMC watchdog
Date:   Mon, 25 Jul 2022 16:24:47 +0800
Message-Id: <20220725082447.2613231-1-treapking@chromium.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to SMC watchdog because we need direct control of HW watchdog
registers from kernel. The corresponding firmware was uploaded in
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index a2aef5aa67c1..2d1c776740a5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -528,10 +528,8 @@ power-domain@MT8173_POWER_DOMAIN_MFG {
 			};
 		};
 
-		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt8173-wdt",
-				     "mediatek,mt6589-wdt";
-			reg = <0 0x10007000 0 0x100>;
+		watchdog {
+			compatible = "arm,smc-wdt";
 		};
 
 		timer: timer@10008000 {
-- 
2.37.1.359.gd136c6c3e2-goog

