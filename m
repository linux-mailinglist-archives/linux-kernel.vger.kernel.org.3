Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420C65A9DFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiIARaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIAR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:29:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB3E099
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:29:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c66so7841800pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=aEdHMfIGdtLpgQABmHB5FAb5y4ZWlHDUTnfIlMSvXfY=;
        b=BYFUvve325d13qmtzzWxYDe2qdOVUiCzyah59NhIi3R4+yxdWwUUsCx/IgGmZVBFGL
         E97lIyPk0InE4KS8d1W8wmOHAGdghOCobSx2/Ghy/c8mZ959oaMWMEJ6u7ic7wA9H6lG
         jq2ivBKrZAfnI7+LpLTlpUy62ULMyrpMG6Fe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=aEdHMfIGdtLpgQABmHB5FAb5y4ZWlHDUTnfIlMSvXfY=;
        b=zcyn9aYRDy2hMmzl6w3zvXrram990aa/nFttGsc+Ggtk8PPmMfvEU/IP3fpA/KSDVA
         zlXqOTNdPQg3M1v3PYD5mKT82aCn7EhESQH2XY/evQ82KsXXkqhyruVf7W8zD7YFxw3i
         Z0tgX386/dADewfjIpGil9Zl5LLZc7Z9xd7nn32j7eDRtiBHFa7QG1rwdCkIPrkgFuZH
         mNr/tPGqjFrbW23bzIPK9yuHupCCRbLWk8GV/LAn1wqUYW6nbBn4aVXfIYIqjkNyiJ1k
         j4W2ZFutAzz2RvGZ606g/dVr7iTYF2Lv3FQ62LSCgaYCAFjuICgAvuGbiyjkxqWyBl5o
         +jHw==
X-Gm-Message-State: ACgBeo3+lGtW4WEPgy9tKfIhU4VV1/tsFScttO2orwEcyOe5N/xPNodB
        tb6lXk34fgpGOlQ4w38TY8h2/g==
X-Google-Smtp-Source: AA6agR41hr8BNob0m3jPe5drjS5xktzGPZfgiELVke4qhZdqfmbWfo9tbzS0Vle0ZWaUXbrGOVCA2w==
X-Received: by 2002:a65:5889:0:b0:428:90f3:6257 with SMTP id d9-20020a655889000000b0042890f36257mr27637380pgu.590.1662053394413;
        Thu, 01 Sep 2022 10:29:54 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:34cd:3659:c11f:5d05])
        by smtp.gmail.com with UTF8SMTPSA id f5-20020a170902684500b00172f6726d8esm14193442pln.277.2022.09.01.10.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 10:29:54 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: sc7180: Configure USB as wakeup source
Date:   Thu,  1 Sep 2022 10:29:50 -0700
Message-Id: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 USB controller of the sc7180 supports USB remote
wakeup, configure it as a wakeup source.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- use qcom/arm64-for-6.1 as base, v1 was unintendedly based on a
  downstream branch that was used for testing

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e8debb0da411..af5bab27eaf3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2782,6 +2782,8 @@ usb_1: usb@a6f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			wakeup-source;
+
 			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xe000>;
-- 
2.37.2.789.g6183377224-goog

