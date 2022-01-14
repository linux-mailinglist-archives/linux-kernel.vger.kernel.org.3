Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2241648E1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiANAns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbiANAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:43:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A4C061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:43:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so12621556pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LT+Vm4rzQkk47lugUpAeU8Aw0wC+LkjKsmIBgeDejg=;
        b=M52J4hq6RxIIbN21Vg65/n9UCDqSBjaQ4fbrXsn+GQPgCvQX5VTMUNl7+jfFgUnm/X
         y4458WxGx4CXxklfB7lepyCwO85RmpbtNNQZ9LCjF/IHoKKqTk5DH0JdE4U/9J2jnx3I
         +AzTvjl4VxEKiyGG2L4FMLUp1RD4AUabeML2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LT+Vm4rzQkk47lugUpAeU8Aw0wC+LkjKsmIBgeDejg=;
        b=Spniu263DlPAeyMVo+AyKnvq44ZN9GLykYWC3Fv7GX63Uidx+qhJk+NiJM1xPaoJsB
         d0tr3OKtPyeWmddvp7MJquX0KdfozxXRF54cZqvb92AGmVRJCuwk04e4oAMpx1/KQdqk
         P/rNCmOy3QBW9qiPxu89RjH0xRqq9suzpKoCdDewENW5KLwQebUiKqw3LhViCokl/jVU
         sDGAmqm+RttaSUXYqQfTzF49Hm92wXdcWIyj9neMhmCx1xQ3+zlML5wynpWRPdN0HZEe
         yTBKy7bg18+3AyUIOsrEI2toQXdwdwz2UtAUTj8auNXsYtEGB+ApS3IHs46+SK86PS96
         2Msg==
X-Gm-Message-State: AOAM533Jv1saAG+dBeO5VFmoAjyHJ/0kCp4ckjMGFVw85Gwn+YS8Un8M
        eiZzeBNWSmZYeZJsrYUyz4VmOA==
X-Google-Smtp-Source: ABdhPJxgxNnaoZZRzk4weku2Sp6EHxGfy7/c7stTjDEkbQ9+wP4d2oL6pe1uoG7zyeZRZaFCNnuLPA==
X-Received: by 2002:a17:902:d3c1:b0:14a:8d01:9d30 with SMTP id w1-20020a170902d3c100b0014a8d019d30mr1979443plb.56.1642121023532;
        Thu, 13 Jan 2022 16:43:43 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:cf6e:9fa9:a398:4c9])
        by smtp.gmail.com with ESMTPSA id j4sm4061498pfj.217.2022.01.13.16.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:43:43 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     quic_rjendra@quicinc.com, sibis@codeaurora.org,
        kgodara1@codeaurora.org, mka@chromium.org, swboyd@chromium.org,
        pmaliset@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: qcom: sc7280: Fix gmu unit address
Date:   Thu, 13 Jan 2022 16:43:00 -0800
Message-Id: <20220113164233.1.I19f60014e9be4b9dda4d66b5d56ef3d9600b6e10@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220114004303.905808-1-dianders@chromium.org>
References: <20220114004303.905808-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When processing sc7280 device trees, I can see:

  Warning (simple_bus_reg): /soc@0/gmu@3d69000:
    simple-bus unit address format error, expected "3d6a000"

There's a clear typo in the node name. Fix it.

Fixes: 96c471970b7b ("arm64: dts: qcom: sc7280: Add gpu support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0e93eb..eab7a8505053 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1790,7 +1790,7 @@ opp-550000000 {
 			};
 		};
 
-		gmu: gmu@3d69000 {
+		gmu: gmu@3d6a000 {
 			compatible="qcom,adreno-gmu-635.0", "qcom,adreno-gmu";
 			reg = <0 0x03d6a000 0 0x34000>,
 				<0 0x3de0000 0 0x10000>,
-- 
2.34.1.703.g22d0c6ccf7-goog

