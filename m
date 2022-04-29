Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF3514971
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359289AbiD2MgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350304AbiD2MgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:36:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F54C90DA;
        Fri, 29 Apr 2022 05:32:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so8884931edx.9;
        Fri, 29 Apr 2022 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiMnA4TFSr6pbrf2v1jYlsNpIwtbaZqdPagqNdNxTZA=;
        b=U3RJHzAANKbk8TbiWJ/7n7kqBW/pM7WkVdq7taLcVE7X/Mdb1LSEv88GMlVNxFT0Je
         szxcPB53G5uv1MJpEiWNLDILZKyRsl6b9nxG9OJqubrsu0fzSsPCDnuV30cxklrTg8Hl
         Sm91yafEhkbxmiXTFDI7bpSsN3GFKIZ6BowlsxL/Oa3zhgpva1bahAi/hSzswYHyvOZq
         UDpTCHM8M9YF4pHsQHy6z//pdABZy1bHUQBnF0Vsb+5jjwIAD5EHfenSeCB/rKou6Cuz
         gKJ8s5e8LyBpIAfOMJhye+/vXBVr13d1BRbiR7ftSOdN2SlHBhwILtB8jAriMqvpSotx
         z64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiMnA4TFSr6pbrf2v1jYlsNpIwtbaZqdPagqNdNxTZA=;
        b=lzdpzvU7s8i5PhV1G7o4eKqTJLuCHFTBK57OLWxevVGBWBnAXD1UWhYN6NSgPJsdKs
         4NEaQ6BtuLSYPOjLLDE9jOE8yE3aZEOQl9LeNkVSeXv/HAsYHa44C/A1t7ZSOxWYtMDJ
         RdoP5FEY5xOG5RjKfNh7hEPfvyWRQXyVdcpoCH5lM/tlP3sFnIr9tel0q6LG3CgvwuLj
         cXBI2VzoaXph3IRloJBsQfLomkFt4D+OLOlW8WCgwBmrw7iOlQLdEMcWmu2Xxg2gk4Mi
         kjrxLz+DtKy27/t3QAH1q79lRJcNfTo8mEX4yoQOtg00DLXWrYGKDdp0qd/QWC5PaBOC
         RXAQ==
X-Gm-Message-State: AOAM530wvSt4ehPcdtnimBzL8K2lWRbvJYBaBN6Rq+MaOsblOAWVQ2UV
        jla9n4twFhDFRC3vhs55WMQ=
X-Google-Smtp-Source: ABdhPJySRsdH9GJm7JRed1pmA9Q7WECQr2VBBuEavY80eSwbkyxC/V5Dwg8FUtRO7BUTp4cwY2GE3w==
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id i20-20020a05640242d400b00412c26b0789mr41514148edc.232.1651235564337;
        Fri, 29 Apr 2022 05:32:44 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e33sm601176ejc.153.2022.04.29.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:32:43 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/2] ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Fri, 29 Apr 2022 14:29:50 +0200
Message-Id: <20220429122951.13828-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429122951.13828-1-ansuelsmth@gmail.com>
References: <20220429122951.13828-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add syscon compatible required for tsens driver to correctly probe driver
and access the reg. Also add cxo and pxo tag and declare them as gcc clock
now requires them for the ipq8064 gcc driver that has now been modernized.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..9817448cfa95 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -298,13 +298,13 @@ smem: smem@41000000 {
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
@@ -736,7 +736,9 @@ tsens_calib_backup: calib_backup@410 {
 		};
 
 		gcc: clock-controller@900000 {
-			compatible = "qcom,gcc-ipq8064";
+			compatible = "qcom,gcc-ipq8064", "syscon";
+			clocks = <&pxo_board>, <&cxo_board>;
+			clock-names = "pxo", "cxo";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.34.1

