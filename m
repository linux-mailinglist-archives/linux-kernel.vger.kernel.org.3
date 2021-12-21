Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673DD47C694
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhLUS2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbhLUS2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:28:37 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09211C061574;
        Tue, 21 Dec 2021 10:28:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v13so60536pfi.3;
        Tue, 21 Dec 2021 10:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtngP8d0g0fi2Zi2weqgSY60agKP0OsKMyjizujaa74=;
        b=Q3r4GoA8o/zYVcwujoPbTOpghL3YfVRSaA/MrB3KGhWFEfWhne3McSgxheE8s+9WaU
         V4odamfn+MNJnQEeVYfp71N396wLLT6MwbIQM3RYHFs5S8TJfGmYRv77AOpd6DXcEtM6
         RUdnQDdkWpua9keDDXaXNMdcQxHBXeauZY46sgdjH5+pKKJZ3D+pN+jzkSthkQKsakhc
         b8fERRuktBX4hW4X0CMsuXAEvwZOEY+ErzdE+rCpSgI8H9DCwQp0UYNhNrPIyzZ1cm8j
         f6Ar3itIz9w9LghDA7QXEMwbx2VdX2HqRHiAmdLPV2RwyWrP/tw6kBS484W69BHXtWfl
         ooHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtngP8d0g0fi2Zi2weqgSY60agKP0OsKMyjizujaa74=;
        b=NeRPhxjF+ClPfKYGsSHMcz7hl6oy5xes6SDPf1wBIco2KfEP6eQj6RxMk8w4wb3kDx
         gLYIKmuvd6grokYON3wtoIPcvev9nkUZ28LHUZqCnZijSoKWps8zTzVSb5adDiJGF/b2
         SwhxMbA2f97VKG4B6DG2ih90ZWQtDfw06JWOSRfS+/OASrYQSPRpPAxeEu1+gVE09lm0
         LW/5njufK/8i1m5JSZM9uwLqm636MHB18tUo1vYzcv6Uzf008v+fPjy7S2bY0ZHaOX9j
         XKDluGpkfPkNFexSFSdaEyZXNZ+6ovBzBwfh5fmEopw/ZXqFevWSYKKHxeRTQYf+wVvL
         PT6Q==
X-Gm-Message-State: AOAM532h41akmEs0mgq1n2dOW0gAIhr3asvzCSgaXh/3V4MzXkfkOyDN
        kZ0iitDXcjqT1fd+pfQRcr4=
X-Google-Smtp-Source: ABdhPJwxhTCNg3D2B6n/fOoZWVyeb1dwKHhW1JJA4lk5TEYiBhog0aJCNVOscXnjhKP2x3CnGjhysA==
X-Received: by 2002:a63:9143:: with SMTP id l64mr1793570pge.495.1640111316637;
        Tue, 21 Dec 2021 10:28:36 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:36:b871:81c1:f2ef:8174])
        by smtp.gmail.com with ESMTPSA id s19sm23436133pfu.137.2021.12.21.10.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:28:36 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        bjorn.andersson@linaro.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH RESEND v4 4/4] arm64: dts: qcom: surface-duo: Add surface xbl
Date:   Tue, 21 Dec 2021 10:28:26 -0800
Message-Id: <20211221182826.2141789-5-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221182826.2141789-1-jaschultzMS@gmail.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce device tree source for the surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v4:
 - N/A

---

Changes in v3:
 - N/A

---

Changes in v2:
 - Updated to reference an offset inside of imem
---
 .../boot/dts/qcom/sm8150-microsoft-surface-duo.dts     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index 5901c28e6696..abb7964daac4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -430,6 +430,16 @@ &i2c19 {
 	/* MAX34417 @ 0x1e */
 };
 
+&imem {
+	status = "okay";
+
+	xbl@a94 {
+		compatible = "microsoft,sm8150-surface-duo-xbl";
+		reg = <0xa94 0x100>;
+		status = "okay";
+	};
+};
+
 &pon {
 	pwrkey {
 		status = "okay";
-- 
2.25.1

