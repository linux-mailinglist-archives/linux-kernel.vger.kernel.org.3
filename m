Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03D14A5DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiBAOH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiBAOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:07:28 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF35C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 06:07:28 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c188so21298753iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jE7i/45ZN4yQfoK8ALMqe4UBbhhVgSudWp2g9UDwE9c=;
        b=spDwLyL2L5jJZInLzDJOx9fN23OKbt/8qSnko2v/3YXEzKCUJs4f8VNwfAqXa5GIKt
         upn7j7A8OpyFRvyGiKSfwDj28Z6es5tIdaQQu/W8JohsWpgPtONLj9ObnClXIMRhJCBf
         55ZKzrZ107eU0+PukEOzjwPVg9l0wb0X9sHIOs5PCgR9lBOKH5RUdKVvwXC73SomUFa0
         oFrwXyFkQNofhj3X0OqAwmi15SPHQrWIi+T08/Nh7dtQJvPLJ/j6AJz8GKagVC5aDplD
         M4iMhyGVUkYRul1K1QZdqBZuwXNMgiX7chPmKaJAOAm4w6Qaf3iRKviX7RkrAwIwIHbq
         LrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jE7i/45ZN4yQfoK8ALMqe4UBbhhVgSudWp2g9UDwE9c=;
        b=SPW1hjzLZvbiIPkrGIN0UkQ9Y/9gb3knvwMWo/fsOkd2fCB6axp4njAoidwPIXvrAK
         VQxvAVsk2Ecgs6WJBlsk6jWjceLzH59awi911NjSV5CzH6Je3uZAJRkQF5lsr5mKsKOC
         p33GR24dB60WqKmB1K5LrSxQr+9r6y0x3mKKc+LzWNK/PF7yRR2ijph6rAvHxIf7CoDG
         zTwIRlpSimkgMtvaJ//I6r7Xjq/0q+mxaWQxufkKD+vYBV9WHfrY6jnn/nycG8EEnBpZ
         j0nXHClVmfpKqGCplab1mvkr/rITIdM+uVHmVDl0GYFc4IWHuF6V/mYi10IT6RU0wggk
         Yskg==
X-Gm-Message-State: AOAM531CuJWN3vOUTFIQSL8ahGq+HHs4xlhBJCoO0Jv5AORCgj6Sds2j
        yNOpBx5ehm59EXzb9vnT0skwag==
X-Google-Smtp-Source: ABdhPJy5ZVgUEgsNb+EEn6bsYx+QID1EFyGStYPvKLXl7Kwy3rMkx1FnTIjPI3ojR4qk6eC+AUQFfQ==
X-Received: by 2002:a05:6602:1652:: with SMTP id y18mr13414248iow.101.1643724447619;
        Tue, 01 Feb 2022 06:07:27 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m4sm19228887iln.48.2022.02.01.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:07:26 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, mka@chromium.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: add IPA qcom,qmp property
Date:   Tue,  1 Feb 2022 08:07:23 -0600
Message-Id: <20220201140723.467431-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least three platforms require the "qcom,qmp" property to be
specified, so the IPA driver can request register retention across
power collapse.  Update DTS files accordingly.

Signed-off-by: Alex Elder <elder@linaro.org>
---

Dave, Jakub, please let Bjorn take this through the Qualcomm tree.

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 2151cd8c8c7ab..e1c46b80f14a0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1459,6 +1459,8 @@ ipa: ipa@1e40000 {
 					     "imem",
 					     "config";
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&ipa_smp2p_out 0>,
 					   <&ipa_smp2p_out 1>;
 			qcom,smem-state-names = "ipa-clock-enabled-valid",
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0e93eb9..fe5792e7e8d7a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1714,6 +1714,8 @@ ipa: ipa@1e40000 {
 			interconnect-names = "memory",
 					     "config";
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&ipa_smp2p_out 0>,
 					   <&ipa_smp2p_out 1>;
 			qcom,smem-state-names = "ipa-clock-enabled-valid",
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 53b39e718fb66..5c2866355e352 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1425,6 +1425,8 @@ ipa: ipa@1e40000 {
 			interconnect-names = "memory",
 					     "config";
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&ipa_smp2p_out 0>,
 					   <&ipa_smp2p_out 1>;
 			qcom,smem-state-names = "ipa-clock-enabled-valid",
-- 
2.32.0

