Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18383515834
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381417AbiD2WOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381380AbiD2WOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:14:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FD8DCAAB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e24so12399050wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPvH0MBskyIk7K4Q5MwlcYyiI7TN5qNty2K68EGClBE=;
        b=bMoFXpcmhxWEeAvHhcC4DwJmx7xVH9OJLuvuzIfnSPoUO8vgTXh64l5n5vzzZAVGXI
         ilsu1vPrs2+TyJvWIvDSQRznlEj8BQUyvX1REXOSY1ZRmTZqEZMONgwKFH7ZghTD5esx
         SArfV/fM/ROl25I70P+YNl4p1hBs/ZYmT6MB4KsvfisxLUW5XPIparyCV9m1IpFBiCOx
         6N1XQmKQuF6DXSuLB8HIxB/m3TANLenOfZTDEOzoC79AvjzdGJE1UifUC54Kg73HOLq1
         MG2af2SjTKJhHC1Tbj9beb/Eqz6aXAKJgwGIf4okxINSP+pGGbdtEMQjS1Wc6lae3LGn
         svOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPvH0MBskyIk7K4Q5MwlcYyiI7TN5qNty2K68EGClBE=;
        b=Q9P6AC5W29MOxHJJ3XT26VLhQs41tnR55vIWiRTdt2cwkxpybzz1a85f8bj8nK13Ui
         KU79isu5ks5WuYibg9tr+6/yAkbziUOMOWvPhOXuITVTWeBHIvPFYa3Y9FVO/Hy7LOvn
         a915uo5fnj8aD7NyuB6lWo6tm2l1AhvlH9QnB31R6eLYgeRKJmaN7aRbn7m6Mxp5SwGC
         m6qS0V+gbGSM9NIlbpCpTPHjzADhQT6GynhczCXKaJNtbdbOruCAd0rli6ZP4zdkSJDW
         A7YTV26OCbao362eHxbunWysdaKuraygRRuQntTu0VGvXSnwWLhOldpAgBzh23zq08G1
         RFDg==
X-Gm-Message-State: AOAM531LusebPiePd8elo83XodrCKsuMVZHKOk2dYOI0yq0044PiuvAf
        YiiApnDTz2R6e542W+0CN74BZA==
X-Google-Smtp-Source: ABdhPJx+sVITDFclPpg3If6Dc3/v0KU17TwTzYjxLtBPl8SoAXPO/UianCNUtWudHDf0OS51HfEhqA==
X-Received: by 2002:a5d:64eb:0:b0:20a:ecf8:ac9f with SMTP id g11-20020a5d64eb000000b0020aecf8ac9fmr839799wri.342.1651270261813;
        Fri, 29 Apr 2022 15:11:01 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:11:01 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v14 06/10] arm64: dts: qcom: pmi8998: add rradc node
Date:   Fri, 29 Apr 2022 23:09:01 +0100
Message-Id: <20220429220904.137297-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for the Round Robin ADC found in the PMI8998 PMIC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 0fef5f113f05..da10668c361d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -18,6 +18,14 @@ pmi8998_gpio: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8998_rradc: rradc@4500 {
+			compatible = "qcom,pmi8998-rradc";
+			reg = <0x4500>;
+			#io-channel-cells = <1>;
+
+			status = "disabled";
+		};
 	};
 
 	pmi8998_lsid1: pmic@3 {
-- 
2.36.0

