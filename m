Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9250AB1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442287AbiDUWCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442280AbiDUWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:02:48 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9AEC39
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:59:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e1so3934018ile.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/i7C88k688+MpmDweUYU8miJaLmYfGKcYBjcJu+CDo=;
        b=ULUOAKD5l9KGzgpIQGscugkj8DfAkAk5L3CYAzM3EUPB1DeRg5l0kv6OLuaYKAUVqP
         fR42DOqJxwEXyDrysQjkBAv8vVNSLggl2PNVczfw65ERZjheqaWK85S7agGbICEEwBZt
         1E2Jwe5Z8nN8CjNnio/hQ1FbQtJ7X3CV0C2XVtJvbnZbKNnj932aCVeG57lSigsPteAR
         4VrtO/9f9kJYCNntoWIDXTIczPRJxGUKD/pkOrsaGU1b0h8xt8OxgWJvu1duVhyvxdJb
         pEZf+T5tHa7AslVcsstpmpJXvyXrKIjsjm3TRf1Qm2VC94jllATwHetjqXtYHdylCs3m
         emaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/i7C88k688+MpmDweUYU8miJaLmYfGKcYBjcJu+CDo=;
        b=ZsxTzx4bogXNle18AcKeWAkYpY1h/MdoVlAwr+VYhjeGuKUWDh4uoOL8q4Kp/1JSmm
         k6n/vZhq1hFhx98PupQ99sAWZfn5S+4f518x7kdrzcG1SkI/mC9aQbnLQF9Sz3vNE8Me
         0JXEaqt9ycaH8YPNEb4P4gVxwSGALv177Qe/djvAMGkTQY+rzjy4xRNoPC2u2p2lNwKg
         TeN+bVVWT3OuYQwzGy3BpwNrZd7lY8rWomKkehqRhBgDhOi2+fbrPpF6IzGjz7tYNXSp
         0nWV3XocJApyTh5yeHwsmPETZYJ1N+UlxnDwtmeCsDO8colmQORedU5MzRd9SZ4mTknd
         LXvw==
X-Gm-Message-State: AOAM5326oHDSY/8gSMd1P7ZbCqrC5qzGi0yeBm9yrJ7dXpqBYKX6KsLZ
        YYFojuH3s3cQuKAURdbUtebBIQ==
X-Google-Smtp-Source: ABdhPJwfkz2B9faaKd/IufhZz4WfvvGClgR/udStomS5H0LnkfxfEjjlnjeYZgcpR2CzaGFarHpMQQ==
X-Received: by 2002:a92:1303:0:b0:2c5:f030:3074 with SMTP id 3-20020a921303000000b002c5f0303074mr774453ilt.134.1650578396474;
        Thu, 21 Apr 2022 14:59:56 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o19-20020a056e0214d300b002cbec3af6casm143004ilk.30.2022.04.21.14.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:59:55 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     stable@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        davem@davemloft.net, elder@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: add IPA qcom,qmp property
Date:   Thu, 21 Apr 2022 16:59:53 -0500
Message-Id: <20220421215953.1750848-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
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

commit 73419e4d2fd1b838fcb1df6a978d67b3ae1c5c01 upstream.

At least three platforms require the "qcom,qmp" property to be
specified, so the IPA driver can request register retention across
power collapse.  Update DTS files accordingly.

Cc: <stable@vger.kernel.org>	# 5.17.x
Fixes: 1aac309d3207 ("net: ipa: use autosuspend")
Signed-off-by: Alex Elder <elder@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220201140723.467431-1-elder@linaro.org
---
The code for this feature was included in the v5.17 cycle, but the
DTS file updates were not accepted until v5.18-rc1.

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
index eab7a85050531..d66865131ef90 100644
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
index 765d018e6306c..0bde6bbb3bc74 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1443,6 +1443,8 @@ ipa: ipa@1e40000 {
 			interconnect-names = "memory",
 					     "config";
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&ipa_smp2p_out 0>,
 					   <&ipa_smp2p_out 1>;
 			qcom,smem-state-names = "ipa-clock-enabled-valid",
-- 
2.32.0

