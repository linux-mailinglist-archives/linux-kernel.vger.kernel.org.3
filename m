Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA625220B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347031AbiEJQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348705AbiEJQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:08:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F2C5E74;
        Tue, 10 May 2022 09:04:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g23so20579005edy.13;
        Tue, 10 May 2022 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHtZM18t8DQNsNApHyAs0/7e3iISzkrkeTn6Pi0Mn0o=;
        b=BXwAnvdFPsC4hny0qi1pNI1khkfE+C3JlNrJR4CxOlZf3wRiqJo5+WQifmmkuPgXzI
         ZYRZ7nh9HFeiE6vCKsQvA57CmmXQ4HV893XMTNfBGxFU/HCnNm6gYcGG4jUIEqGTe/dg
         7C/wfM31sZxYbavGx8UtjaaXqsMAMVEBGNAfSfpdvPPo+/O5GenlOulyEw++6YVWr/w6
         XAeeDVj/1rgFdGGVodi9pJ18wjAuFP/6DDIqukjVtaDY+Y3RjubRAs2vp2zcwoZm6h6N
         mISoU9g0wEh4xFvVpWNqZQRrRgsheT6tqLIUy+bKn9zMbSgyy7leQRkrLHcuojp3Pv7n
         OhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHtZM18t8DQNsNApHyAs0/7e3iISzkrkeTn6Pi0Mn0o=;
        b=KyAUd3EFxXk1uZwReYkcsDKxWXSdhOugmzcM728huar3Q2wy6OX5R//WJP8E1NcVSm
         7k+ivXtjwh57cQf7tONb0x7dEO5zuAkg/RQsjTFlzUZ3nidesVbbn10vfp7y7hnCtY5B
         yprv3K5wkfelrXQsdgzrZEG3sd6ZTSuJhk9hvFl4K3NkHZeT54fUB5zErROfPSNOD3J2
         UGF4ScyfGW/71bQWc+hdvk1ZccymbtlRy4zQZbT8G+K5Oc1QfaWa2VcdPk11VMWvsM+3
         ucL0fMtPN9FKRnzmMNfH42xmH7TJ7DcLhWJBVEu0UhoyZpYBy3xQL38ohc1+DZ4OayvV
         xSQA==
X-Gm-Message-State: AOAM532cV9XciFYXCGhBuIACySQyeZyeQk4RZI4100zESfiqZRX5KsyX
        esTMMXtQRecc7TBoQsNfbPg=
X-Google-Smtp-Source: ABdhPJykNMZNjzYKtX/dEYFt3Qt4Q3WG5F+Xgk9V2ZLgrQhURA3fIgTfuUpvx5C7D1kLq+dOh6EQMA==
X-Received: by 2002:aa7:ca0d:0:b0:428:90ee:322c with SMTP id y13-20020aa7ca0d000000b0042890ee322cmr14647593eds.100.1652198684791;
        Tue, 10 May 2022 09:04:44 -0700 (PDT)
Received: from localhost.localdomain (89-38-99-188.hosted-by-worldstream.net. [89.38.99.188])
        by smtp.gmail.com with ESMTPSA id l21-20020a1709062a9500b006f506ed0b42sm5772791eje.48.2022.05.10.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:04:44 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8996: Add support for the CBF clock
Date:   Tue, 10 May 2022 20:02:12 +0400
Message-Id: <20220510160212.812696-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510155744.812471-1-y.oudjana@protonmail.com>
References: <20220510155744.812471-1-y.oudjana@protonmail.com>
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

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the CBF PLL register to the kryocc node and assign a frequency
to the clock.

This makes sure the core cluster interconnect is running at a decent
speed, so that it's no longer a pain to use the device with all cores
enabled.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Yassine Oudjana <yassine.oudjana@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 205af7b479a8..51ae3cbe75d3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2698,7 +2698,10 @@ apss_merge_funnel_out: endpoint {
 
 		kryocc: clock-controller@6400000 {
 			compatible = "qcom,msm8996-apcc";
-			reg = <0x06400000 0x90000>;
+			reg = <0x06400000 0x90000>, <0x09a11000 0x10000>;
+
+			assigned-clocks = <&kryocc 2>;
+			assigned-clock-rates = <1382400000>;
 
 			clock-names = "xo";
 			clocks = <&rpmcc RPM_SMD_BB_CLK1>;
-- 
2.36.0

