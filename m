Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3962053AA6C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355744AbiFAPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354695AbiFAPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:47:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6BC3123A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:47:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i10so3499564lfj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+1GcNao+MpcpUVYncd1ScTVUmB5P8PxXyVNWxX2GeI=;
        b=tnQNJHh2vEdrcbhYQuO5shlFnBSNoFpkKp6+nLw5kDyn26ZA6V+dT25LgW2GFD30j0
         Btg5efvrHQE4di3DRW/bks8zTFoIoUxFiE8YTMmzm60Y9NlxPV9hfwFGEjQ+433TAnSi
         INoWF4m/Qd7hbB6dhSz6LNtL6MDwjWAqSxxTgdJndcZsZEbPsDhwaItlMI2h5LnmwSfE
         1NsY1GivAH1Kv/FRH1jxVbgQG83QKJi50lx2ToazfWCukd6oG7Tdm5bX/K6gk/9vafbp
         qVFDJLmC6l1WOBYfcpK+1eXNLbmqm7CZ7213FdANP6gyTpj4znf7ox66XKMSBKf+2SCI
         EcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+1GcNao+MpcpUVYncd1ScTVUmB5P8PxXyVNWxX2GeI=;
        b=Ber+AE0V5Q7nA6MdEcDnw/tPWfwt4IbJxueUUPtght6simIX/X/98SY7tg6S84Nipb
         gwTPzn4l04JKUkszWVeGfukAAf/FSphts1PjRqRD4oTSk9DhRe6kuOvJsel6pkTnRE/S
         CwHPMuHis+/iID48N7/V1Cbg6T/fHgSvdPbPm2T7Bis+P9JAS5A6RLjfxFkHyqm5obuj
         hzobbjePiKyNBBCGuLKmek5EdnibwMXnIn7ogpFObr3kr8llcPxxSy4fDD+Mq31f5MNZ
         7nUrBqOMYv8zdfi7xV+mqVAiVvKuDxZQO3WTZ9M19d2efcdW8JkUdPQ1DJw/ska4GKlG
         veTQ==
X-Gm-Message-State: AOAM530vfpn4iDihwFqxauYmGKQc+nqczC9xHr9AX5spDLXKC6mZDasQ
        VWkpEgGkJoyEpKgd++s9lk8PeQ==
X-Google-Smtp-Source: ABdhPJxrvmdZIE50mE4LyGk8Q7U6bi5QRa+ZXwfv1N+HWB/5Nwi30SD46rFfuu/DH57WAEhFWv7iBQ==
X-Received: by 2002:a05:6512:3c96:b0:477:e016:82a3 with SMTP id h22-20020a0565123c9600b00477e01682a3mr47737lfv.268.1654098462742;
        Wed, 01 Jun 2022 08:47:42 -0700 (PDT)
Received: from panikiel.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id f10-20020a19380a000000b00478ad871b25sm431219lfa.145.2022.06.01.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:47:42 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        amstan@chromium.org, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 2/5] ARM: dts: socfpga: Move sdmmc-ecc node to Arria 10 dts
Date:   Wed,  1 Jun 2022 17:46:44 +0200
Message-Id: <20220601154647.80071-3-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601154647.80071-1-pan@semihalf.com>
References: <20220601154647.80071-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ecc manager is a part of the Arria 10 SoC, move it to the correct
dts.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 10 ++++++++++
 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi | 12 ------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 26bda2557fe8..4370e3cbbb4b 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -736,6 +736,16 @@ emac0-tx-ecc@ff8c0c00 {
 					     <37 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			sdmmca-ecc@ff8c2c00 {
+				compatible = "altr,socfpga-sdmmc-ecc";
+				reg = <0xff8c2c00 0x400>;
+				altr,ecc-parent = <&mmc>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					     <47 IRQ_TYPE_LEVEL_HIGH>,
+					     <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <48 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			dma-ecc@ff8c8000 {
 				compatible = "altr,socfpga-dma-ecc";
 				reg = <0xff8c8000 0x400>;
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
index 4b21351f2694..b0d20101cd00 100644
--- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
@@ -23,18 +23,6 @@ chosen {
 	};
 };
 
-&eccmgr {
-	sdmmca-ecc@ff8c2c00 {
-		compatible = "altr,socfpga-sdmmc-ecc";
-		reg = <0xff8c2c00 0x400>;
-		altr,ecc-parent = <&mmc>;
-		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
-			     <47 IRQ_TYPE_LEVEL_HIGH>,
-			     <16 IRQ_TYPE_LEVEL_HIGH>,
-			     <48 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
-
 &gmac0 {
 	phy-mode = "rgmii";
 	phy-addr = <0xffffffff>; /* probe for phy addr */
-- 
2.36.1.255.ge46751e96f-goog

