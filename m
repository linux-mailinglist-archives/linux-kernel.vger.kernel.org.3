Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6361B57C68A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiGUIj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiGUIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:39:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469737E811
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:39:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w7so1147103ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cThkGCtdmiVD8HST0EzhDMQ2qjKnc0qbzKVo4jE+GUs=;
        b=DgaEkOmk03HqRk9UyvJefPMfG0oQHCwjpI0UOvE+/u22fReCzHt4VX0/zsk4J8nVHv
         +qZsGVJXK36aPiXNRqdhNcKlO57eErYYFoRgaqcEme4pO09G/GDs9Iv38VakUPbPfnIs
         +qrxaX4pYv6e6Hwqd4dr9KOqCldkfZ/gGjGxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cThkGCtdmiVD8HST0EzhDMQ2qjKnc0qbzKVo4jE+GUs=;
        b=6W6wGTUuFPlZ2fmfPfd0LXVbSFm1vtFo/kodhpgV2AVQZDlZITbjXFHqv4aNQZC6fr
         zZsrVXwGRkNC0QEcd1IP4SWmzdhGRTTzSY3VHmKyXkoF3W3ihoq8UjATpLdPsDjiMHAl
         VU1Vl4sG/A7nkUoOnHN18K0fO588/VCpr//skvkA6J2RQ++Qt2ipUgo3+CDkz1+n2Qz2
         CDcQtHupum0pYHYpq7ysdBTkhpUqEHlH8Fmnfb+v/qTunhvHpFRUHG9wkP4Xj6rlAOp4
         IQeZ2+WbLeY7ybrhJ0HTtfrBigfw9PfISpVazh8DMh4R0tdGouy206zo9Pv2MRSG5Jh+
         cY+Q==
X-Gm-Message-State: AJIora/DMWV+yl+WuYOdinLJniD++6Fes/Sw1T0I/txwiYusN64kpXKk
        /vqzI4L27tVUAwFtjQy9E9FHtQ==
X-Google-Smtp-Source: AGRyM1ujZ06QWF7zySjG8/ejcm0b83yipgO5/xc8Aw3PzzwuzGno4gbtnf8O31SWcvDoNmJ+0RX/9A==
X-Received: by 2002:a17:902:d584:b0:16c:9ef3:17f8 with SMTP id k4-20020a170902d58400b0016c9ef317f8mr39360097plh.149.1658392740819;
        Thu, 21 Jul 2022 01:39:00 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b0016cd74e5f87sm1025943plh.240.2022.07.21.01.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:39:00 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v4 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
Date:   Thu, 21 Jul 2022 08:38:47 +0000
Message-Id: <20220721083849.1571744-2-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721083849.1571744-1-judyhsiao@chromium.org>
References: <20220721083849.1571744-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add drive strength property for mi2s1 on sc7280 based platforms.
2. Disable the pull-up for mi2s1 lines.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 57bacca6c5e1..67874749f1a8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -632,6 +632,21 @@ &dp_hot_plug_det {
 	bias-disable;
 };
 
+&mi2s1_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_ws {
+	drive-strength = <6>;
+	bias-disable;
+};
+
 &pcie1_clkreq_n {
 	bias-pull-up;
 	drive-strength = <2>;
-- 
2.37.0.170.g444d1eabd0-goog

