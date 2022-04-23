Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B495950CD3D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiDWTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbiDWTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:53:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D405EBCD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:50:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c12so18232405plr.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnaG27CUaF96qRrvNCKtI1jKKcB/F0ggNK0LpZNX450=;
        b=euvqk/3k5nOsdbMbphMEN4CwhHk+MVqAtb6+sfEQPJ448w0ggdkR+rcGKaevDGxoNk
         bOMGahgHVkcsUAPcl/LhZDuTB1MblzoVJHEkc4qKEmG2ekAolZj1IVdErGWNMM3rTQNK
         JbG2dGea4xzd2gH6xT4Y03yutNxe4uZNDxKiteEI1v+RoGFc8DO3KeQGAP3HEZxqx2cb
         XO7Pi8HdzhH86C8L3QXz2EpfpoZRd43/kQp5y4IXRlKEuhEy1TlYLd/C/x1Ll9fputQ5
         vHIhGkgm5js/ND2+KhZpuTD8q0ysc6CZ2RBvI5i2Rt9v6Eg94RtY7dnTMXUIMkpv7rBg
         g0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnaG27CUaF96qRrvNCKtI1jKKcB/F0ggNK0LpZNX450=;
        b=yPwGBIVkiJgEXLNgP7kuKD6mYFFisi9xDZkMhumN0DTeRvm0NMUCCP8RIFVuBe8cYc
         bWw9V/EFlfhNdlBdHu/sMMc4l3VnvWkZU3rVv4dRLJIybNXKx8iAWHXiLHsK08v8zziK
         fo11LzdeyUD+VqdsL43e/IFIUZ4oqvd9RxunZ0c6WBf2a9Ou70VBt1xNlTy7DmcIej6H
         NwcXEzAcH+CTukLr/btf/zgiUDJy5jxO55HTyM+Q6q/2d8EGSLJh6rh9n42TVvA78ZBt
         rUGNl1C3staJHGcQF7/lFlYR4yU/xc+AFV08ouYXUWLU9TPJuyUQ1capBc/fSEc/jezO
         tVHQ==
X-Gm-Message-State: AOAM531JVGDRjign5CMF0A7YoUAwMh/ESHFZopNpMZtuBoQTrhNlbjU9
        ttbZIaCOmnYZsymLRekC91z6oQ==
X-Google-Smtp-Source: ABdhPJz+MlFDRUsCphdYzX6ga/IiEzYxo+rtWsKc2w02ngaXhEqKsTbIPV4kfcY7i/T+DD62oiCLaw==
X-Received: by 2002:a17:902:e748:b0:15c:e3b9:bba3 with SMTP id p8-20020a170902e74800b0015ce3b9bba3mr4883928plf.139.1650743413356;
        Sat, 23 Apr 2022 12:50:13 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id g17-20020a625211000000b005056a6313a7sm6308781pfb.87.2022.04.23.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 12:50:13 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/1] arm64: dts: qcom: sa8155p-adp: Disable multiple Tx and Rx queues for ethernet IP
Date:   Sun, 24 Apr 2022 01:20:03 +0530
Message-Id: <20220423195003.353150-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the issues seen with ethernet traffic getting stalled on SA8155p-ADP
board with default (or larger) mtu size of 1500 bytes, by disabling
multiple Tx and Rx queues for the stmmac IP block.

With the single queue setup, the ethernet traffic is stable,
wget / curl can work well on the board and no ethernet stall is
observed even when longer netperf / iperf3 test are run. Also
a performance of ~940 Mbits/sec is observed on the 1G link, so
there is no observable degradation in performance as well.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 40 ++----------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 8034d0d31bd0..ba547ca9fc6b 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -49,7 +49,7 @@ vreg_s4a_1p8: smps4 {
 	};
 
 	mtl_rx_setup: rx-queues-config {
-		snps,rx-queues-to-use = <4>;
+		snps,rx-queues-to-use = <1>;
 		snps,rx-sched-sp;
 
 		queue0 {
@@ -58,28 +58,10 @@ queue0 {
 			snps,route-up;
 			snps,priority = <0x1>;
 		};
-
-		queue1 {
-			snps,dcb-algorithm;
-			snps,map-to-dma-channel = <0x1>;
-			snps,route-ptp;
-		};
-
-		queue2 {
-			snps,avb-algorithm;
-			snps,map-to-dma-channel = <0x2>;
-			snps,route-avcp;
-		};
-
-		queue3 {
-			snps,avb-algorithm;
-			snps,map-to-dma-channel = <0x3>;
-			snps,priority = <0xC>;
-		};
 	};
 
 	mtl_tx_setup: tx-queues-config {
-		snps,tx-queues-to-use = <4>;
+		snps,tx-queues-to-use = <1>;
 		snps,tx-sched-wrr;
 
 		queue0 {
@@ -87,24 +69,6 @@ queue0 {
 			snps,dcb-algorithm;
 			snps,priority = <0x0>;
 		};
-
-		queue1 {
-			snps,weight = <0x11>;
-			snps,dcb-algorithm;
-			snps,priority = <0x1>;
-		};
-
-		queue2 {
-			snps,weight = <0x12>;
-			snps,dcb-algorithm;
-			snps,priority = <0x2>;
-		};
-
-		queue3 {
-			snps,weight = <0x13>;
-			snps,dcb-algorithm;
-			snps,priority = <0x3>;
-		};
 	};
 };
 
-- 
2.35.1

