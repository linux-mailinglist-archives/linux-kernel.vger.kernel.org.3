Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DB513186
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbiD1KqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbiD1KqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:46:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2657585966
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:42:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a21so5037321edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOzQqgz02aXb8qIj3DdqRtK5QB4xG5+T1rYPUXMs6Ec=;
        b=fWvIQQJeFXrda8Ur2+SsRaqvcZ8BmjCQsWq1dyasRRaviFhPmCRJ6ptJnBcRO6njS2
         pZ2e+bzzD1FMTX1NvhX/XmFRVNGisEujIMextBEuw16ABp+3xirZrEpKe6NpTwynu60B
         vV24ClYqyW1h/+M0pqnzd7tAVGddio3/vcx2EU8igg+Yb9lwG+w7LKF++691lsr6DF/8
         I+8vFSMymGGegdCh6ViEpwo09My3+VZB5eyAnkPJDGWsiiWSlHu5jF3+C5GLKVZZFWA6
         cFyflY605GJ3Asqna87zfdu3VTnbWSoE9iB4/NT8INSB59ggclcjpWwo4P2QMZEbiouc
         O7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOzQqgz02aXb8qIj3DdqRtK5QB4xG5+T1rYPUXMs6Ec=;
        b=TeJdCv9T4EyZYdcfKSYyTgmE7Xqkm8YJ8RsTn/V1DusIo06H7p3Ow/o+zBuh9Se7wq
         AM6lHpnR+YPJ5wFoHeRnElG2Jof3ikJ2xKu2ypCv8Ece+wwId7nWoF1pBB97RjR0FRTN
         SafnzPVIE9I8jnBDG86ygeXn43vo46oqgslcT+wI6opR7R226TtNuq1+jZs4VwAdkxfv
         hGVoKg9FCiP83giJoGq98h1ZUcxFfaYlRYDL0e4TMYT4+p7RqeRR0I/kJWF9aRktAAQM
         Q0QCdLHLdyNb8NEROGiXAhyu6zmrjKedSsWjpsh8UNg656lKEPEk2jOiTBAprNuVxzR8
         l6iw==
X-Gm-Message-State: AOAM532ekqAV9soFwWBYl6vxv0h5KsF9mtkC9YCooXKC/qOQddBJu/bu
        cQOb51LTsNyy6VQG9VfsC9t+8Q==
X-Google-Smtp-Source: ABdhPJz/r0wtITcJ5NGANqGMCjDdZiQ7xMZvN8VMFgcxl1tXMBZ9RXKAtsh5GST7FPVW1drRSrXLGQ==
X-Received: by 2002:a50:ed0e:0:b0:425:e476:f4ed with SMTP id j14-20020a50ed0e000000b00425e476f4edmr22316159eds.32.1651142569586;
        Thu, 28 Apr 2022 03:42:49 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id mf1-20020a1709071a4100b006f39f556011sm4982583ejc.125.2022.04.28.03.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:42:48 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v2 3/6] arm64: dts: sdm845-oneplus: enable pmi8998 charger
Date:   Thu, 28 Apr 2022 11:42:30 +0100
Message-Id: <20220428104233.2980806-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220428104233.2980806-1-caleb.connolly@linaro.org>
References: <20220428104233.2980806-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the smb2 charger to expose usb attach/detach events, charging
stats etc.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 4 ++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 9c91ddc766af..b1fa00a8047b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -461,6 +461,10 @@ pinconf {
 	};
 };
 
+&pmi8998_charger {
+	status = "okay";
+};
+
 &pmi8998_rradc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index bf2cf92e8976..4e119a78c568 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -32,3 +32,7 @@ &display_panel {
 &bq27441_fg {
 	monitored-battery = <&battery>;
 };
+
+&pmi8998_charger {
+	monitored-battery = <&battery>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
index 1b6b5bf368df..0b610e3a8d9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
@@ -33,6 +33,10 @@ &bq27441_fg {
 	monitored-battery = <&battery>;
 };
 
+&pmi8998_charger {
+	monitored-battery = <&battery>;
+};
+
 &rmi4_f12 {
 	touchscreen-y-mm = <148>;
 };
-- 
2.36.0

