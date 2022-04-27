Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6F5121D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiD0S4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiD0Syq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:54:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC493D1CF8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:41:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso3002842wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOzQqgz02aXb8qIj3DdqRtK5QB4xG5+T1rYPUXMs6Ec=;
        b=sMQ00jB4PYRaPkQFfSUvqdUjsB0t3kmViFDoJ9Nk7BFqGwnnMheHWVshL7y0+Tmmkv
         BQijD9LFsYNhnZS3CofuWAG8kKQrWLrfmJK7I5qqOZjnFJ1bz8Z+BvKmiNC59kU7sMEm
         SwBR2YOgkKYGKs0WHP4GkGslf7XKbXzESEGZkHJaM7rV6YPOl/WIaZDyFdr2C6pocRkS
         ohBgMwbx3sadc37rGKAjCLwxZ6xBqUWXzG+VsCh5p1eiukH3ufwMwaulSu4FDmfFPo5+
         MEZnSnn1atHDMaiVgsSzRrdBj0WMKTZFKadPj+KC5PsfngMTIFDejnVM5f6h65J/Xhst
         Tcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOzQqgz02aXb8qIj3DdqRtK5QB4xG5+T1rYPUXMs6Ec=;
        b=NGj39+onFV6VLxVXEhTo8/Nn6dhHrYwWg63P/Q3o2J2MaEnRltCCd+VLfe9G33BJX/
         zs9uBGEPYVUtSh2btEd3vtCsbpP0C/jElFHRCYpBuu3t6ThR9wKF7D3plxcDadvg6e9I
         MgLRBt5lnMdZQCrvtYy5/6unhdZeZS0ZJpY72YnD9e55lfeL7d5O/JX3iq4Wd/4mkI3D
         rh3sBAR6GrLTcREaxe8UqwqY/nZ5/57G78qySu0rrlYSD/pgWzvGLNCL36fwXQH2L71a
         NeVuh2L9xOmHOWqhcC8SzW3vdPipAejsObLvpPSeyUoNWGMZG+lV239hDXcGKkYTAM7Y
         Gg3g==
X-Gm-Message-State: AOAM531qbOim60Ym5cKK/EgCitYXxiL7ge2Upvxgp//uW+whg4iTXITV
        yYKgil06L1q9+Aa7qkKJH/jUpw==
X-Google-Smtp-Source: ABdhPJwdERY7gYet7KuRWi7VwbXro7/zG2+D1IXT5t5ZUhGspXNqQd3r9PXr52s1VjbV51PZ00PFPg==
X-Received: by 2002:a7b:c30d:0:b0:381:4bb9:eede with SMTP id k13-20020a7bc30d000000b003814bb9eedemr36195672wmj.74.1651084880025;
        Wed, 27 Apr 2022 11:41:20 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d64c3000000b0020aef267950sm1992798wri.49.2022.04.27.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:41:19 -0700 (PDT)
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
Subject: [PATCH 3/6] arm64: dts: sdm845-oneplus: enable pmi8998 charger
Date:   Wed, 27 Apr 2022 19:40:28 +0100
Message-Id: <20220427184031.2569442-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427184031.2569442-1-caleb.connolly@linaro.org>
References: <20220427184031.2569442-1-caleb.connolly@linaro.org>
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

