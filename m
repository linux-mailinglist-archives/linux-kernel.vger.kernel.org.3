Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC075A9020
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiIAH0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiIAHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4484F1264B3;
        Thu,  1 Sep 2022 00:24:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so867035wms.5;
        Thu, 01 Sep 2022 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B3Oi4ISMm7UdYV++8x2M6I2Kowk7pRqgdJUjdnaMDkU=;
        b=RzHusp8DKwe72M5ISQsq/uNk8lduXoXj5FqkKQPgTUgP7CPUcAocK4HvV5x0eBgHgh
         eMeh9RoW8tq6N+bwYVuRyCKwtBFNfmRghYfyLiXTfzP1spQSArqvIqiHF3bRtw3kJv9y
         IUamQsCDUnJvzFXmVIWjjOhDTIsQsBOVTl62ksc60XrIf1KPv5JkDJ71NBSFdV54Dq+u
         o46td1Dp8GRNEMWpOK8WdWM1ivXOcqCzQ4ttBoLoN/gZB4p8XLibS08AEWLnJBVm/TbG
         wL8oQeaxyTs8W1U0fJsdvF3I6nxgrDrGnlYfG+CrnnVpev9L76JXHeqOTveTF0S2irhn
         AHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B3Oi4ISMm7UdYV++8x2M6I2Kowk7pRqgdJUjdnaMDkU=;
        b=WAvA4p3n0ievBLFBXTneyj1ei+9GKY3vDga2NMHOOCfgczWLq46Zvi3jJtHfd4HlVN
         6j8uCncec5hYUn4VpBWzcmZ/X79AhQ/8cbzDHklISGe2WHqz+MVYrER2M7l+8eC0Uee9
         dZo7BNj+hjW10/8ctvYjyV56U9DvWpl+YiQjTTu41shL9drZK/pFhIanLWn+9cDYExoo
         GeqeeNDEmnhBAYCZlUs/fCpDnCq2/3IkBbuhic9m+/s8EM93YOHJv6AEthflbsJEXuWP
         UPqqFiSgOUwF4mGGFUP9iJc5miFOy6ojf1tOO1OMW5pSWkyxISk9wR0yIttpjGJvu7om
         DgMA==
X-Gm-Message-State: ACgBeo0kW1UATxaKgFZlXb3sg/8zZrO3D3khwEChVaOttNk0I62hExYf
        Q2KEla3MYsNDtc21kxbF5sI=
X-Google-Smtp-Source: AA6agR68I90fXiUz/6KzqcPfBZbXEkWEUyzSxKNMwtFkN9YzjcpZfV80UU2cKptwaMn7fb2/Ws52yQ==
X-Received: by 2002:a7b:cbd0:0:b0:3a6:9f6:a3e8 with SMTP id n16-20020a7bcbd0000000b003a609f6a3e8mr4140180wmi.13.1662017069756;
        Thu, 01 Sep 2022 00:24:29 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id bn6-20020a056000060600b00222ed7ea203sm12551636wrb.100.2022.09.01.00.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:29 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] arm64: dts: qcom: sm6115: Add GCC node
Date:   Thu,  1 Sep 2022 10:24:02 +0300
Message-Id: <20220901072414.1923075-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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

Add support for the main clock bundle on the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 7496b3e0ff48..5af915e80017 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -388,6 +388,17 @@ soc: soc {
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		gcc: clock-controller@1400000 {
+			compatible = "qcom,gcc-sm6115", "syscon";
+			reg = <0x1400000 0x1f0000>;
+			reg-names = "cc_base";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
+			clock-names = "bi_tcxo", "sleep_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,qfprom";
 			reg = <0x1b40000 0x7000>;
-- 
2.37.2

