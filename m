Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918F6526355
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiEMN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiEMN5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:57:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6DA712E9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:57:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso7907782pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c38pckiAKbL4R5gHxVgybPN8tZ+xHGcvHTSt+rrxRXI=;
        b=Aj0zmrOaKti+xYakhuf30LNS9d4gixVrjVffHak/1ybBgigezMf2WbGLhH4zREtA7i
         UOCRkjtXh4tXDHwTNxDVAbZhvyrT1JU1yZ66a2XAAxW7TQIpnCm6LY8SRCeknr88LLPo
         SUXgWuDxFtra4m7lNPXmTUuqyfV6H31zK0lHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c38pckiAKbL4R5gHxVgybPN8tZ+xHGcvHTSt+rrxRXI=;
        b=PQTW9L7U2K760N3RW4SOjIQCSma9C5k5KdBv0u8GKLpCO58cd0zeC7WPDlV/3kjqIN
         LKy+pF6Uu2/Fs8avfdAtg3oIQZEaNj8ptpq7gK4xFOsDXOhXqZ2nSAjahgyI8utM2Qkf
         pJfOFTHgKvAAy6fbS+KE0yGgdhc1zN1HjEjIRQ5OMJAZI5AyfvnwGlN6MGLUS2N1r2mU
         xieQ/kiD5kJnsAhepd5AgrECVhF6oYPdUuFSxncypvN1x0ojVuipImZIW3lwCedPse5s
         lnHY59JX8JZSXYQ0kziBECqdA7l7i1GMwLVkylDCSE4mZlKsO6suABzpKIOmvNVmnhD5
         jX4g==
X-Gm-Message-State: AOAM531IgwZwVeoD7qc1v7pyRYhhtWRxOKFS06JOgKM/Q3aAQgDuhrmI
        eQ0Z9tT9cR3NJmLiv2ego1dIow==
X-Google-Smtp-Source: ABdhPJypfdJ6x5Kten/v6OEf0RQgmVULwcLl0muJOPJ+GbmUvv32LL9LYZnsjMVnVyL/VoEiVqjEVQ==
X-Received: by 2002:a17:90a:a82:b0:1da:3763:5cf5 with SMTP id 2-20020a17090a0a8200b001da37635cf5mr5138007pjw.55.1652450253811;
        Fri, 13 May 2022 06:57:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:1ee3:ea22:908:c2b5])
        by smtp.gmail.com with ESMTPSA id p123-20020a625b81000000b0050dc76281d7sm1843921pfb.177.2022.05.13.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:57:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     quic_aravindh@quicinc.com, quic_khsieh@quicinc.com,
        quic_sbillaka@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, quic_abhinavk@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: qcom: sc7280-herobrine: Enable DP
Date:   Fri, 13 May 2022 06:57:14 -0700
Message-Id: <20220513065704.1.I9b9b9d4d1a3e0350a89221892261881a1771ad15@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables DisplayPort for herobrine boards.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9cb1bc8ed6b5..709b7aa02101 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -429,6 +429,15 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp_hot_plug_det>;
+	data-lanes = <0 1>;
+	vdda-1p2-supply = <&vdd_a_usbssdp_0_1p2>;
+	vdda-0p9-supply = <&vdd_a_usbssdp_0_core>;
+};
+
 &mdss_mdp {
 	status = "okay";
 };
-- 
2.36.0.550.gb090851708-goog

