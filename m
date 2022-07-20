Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7FE57AE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiGTCvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiGTCvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:51:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925645F41
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:51:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so859626pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=x9qN/Ine23pB3bYTzTIPjB/Cp7a2zC9ts1mpyMbbBVQ=;
        b=XreIWuLQsh3dkB5AZ1XDPQUy51j91mo+S13qcictPzt6p3+CN7wXelaEXYXgX2B/nV
         hCC7fp13tbxI54JNf1o75dIt5m+hohlj9JA8Vlkm44bJAI5rru2VYSQPH3OrAG2e2Uar
         tMKTcjI/CE9k89qgAMFHbjWVhaw9zp48aJEzu8ZjBsJM1P8wtIzjVjGxFzBwuSPNBsya
         wiccnIM2SznbNm+5EF+tjLG2GCUoWjupYXCXleiPc6WBUKhpPLpZkt6A2W+XuiP73FIz
         0ywpTO//80+eVPJEfVhxEEAr8u/CwKq6PwpYINOE5i8sbqDz992BshZ+6cyxPKe8z5fz
         bvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x9qN/Ine23pB3bYTzTIPjB/Cp7a2zC9ts1mpyMbbBVQ=;
        b=XmRD/0hrtgw1Xr9NVazdhW1VmdzK+77lGPLloduxYFukphkHF9laQzcZsLdYFPFAa0
         84M3Zt+FmLMpH0tOzDXRS1WasZ3yMQiGNDiKwYseum6x9IR4gK82LmzV8JHIlDkKyBds
         i0e8oCdi4+M+ycf6Z/GYaow0FU5QBvKtJ5Mr1px/gvDypeaKDGHHEbPeJL/ZsCtn423C
         gIA9o+zMBlzNdR0sVNYLvMwftRGUwHYPOtTBFsBEyGMam+/PhkyYxQRpExfE4DLvVsF2
         ppsWDvvS1b05UnC0YcVWIov7uy5ssNfjq16npISPXjaSqa38/QDJ1KGdC6E3ZkLAsEIn
         jPYQ==
X-Gm-Message-State: AJIora/u9NZFcfMahEKuC4IeFFEoYHCgVVPgXtxHxTBTSw+poZZRSFnN
        6q/CiCcOsfYEfGyDh2RY1J2fI2dX6C0SMg==
X-Google-Smtp-Source: AGRyM1vhyN65VoSkDpow0z5gPeZQ176YIsONAzGBLws8/XcMIQcSYoC9DrywXM8KPDIYvti6ZTlyag==
X-Received: by 2002:a17:90a:7aca:b0:1f1:ff59:fe7e with SMTP id b10-20020a17090a7aca00b001f1ff59fe7emr2887319pjl.11.1658285504964;
        Tue, 19 Jul 2022 19:51:44 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b0016c50179b1esm12614704plg.152.2022.07.19.19.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 19:51:44 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
Date:   Wed, 20 Jul 2022 02:51:27 +0000
Message-Id: <20220720025058.1.I5bfba8857ea0d43c747ecdc3a950875abd56927f@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SKU6 is LTE(w/o eSIM)+WIFI+Parade

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
index 764c451c1a857..4649eaec6318d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Pazquel (Parade,LTE)";
-	compatible = "google,pazquel-sku4", "qcom,sc7180";
+	compatible = "google,pazquel-sku4", "google,pazquel-sku6", "qcom,sc7180";
 };
 
 &ap_sar_sensor_i2c {
-- 
2.17.1

