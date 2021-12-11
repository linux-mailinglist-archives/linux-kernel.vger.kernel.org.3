Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331184710E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 03:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbhLKC02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 21:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbhLKC0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 21:26:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3060C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o20so35725330eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8ojrHbxmE5FLDRKKp3KpbiDMf6SbWlM17imhKOU9dU=;
        b=GGhHo7Jaw+QBGgFqFkRY24G6A4g++chkvJbb/x0riVF6m5htIK8gG/aXczb8WCMCJz
         GnaSaaodRoqcbIXyjnLXNwiZJS1i3ZhdPvKh1S0rMPy9bX7DWUI/+Fh9aKFRQJlWzEhx
         A+JJA1BMWfsAWuOiPdpyauhfITDjyLL4dV1yw0pbsWZGstp89/j6GBOiW9RHIJctAoue
         staSiN2hPj0KuM2YuX6HFmsyjIo/9K0XxHA0hljIzl80czEBBEal3RrdaJLC4KgEM4m7
         8S2idMYZcxrDvJBn1p7o5nozCklCN/JK2JIrlWcJis3jpjhTreRD6Kj1rxmn3d5s9Qsa
         s2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8ojrHbxmE5FLDRKKp3KpbiDMf6SbWlM17imhKOU9dU=;
        b=fL+MYH3awv94aheTQLEGRCcFqXdByoOIL1pLHpudFund62e4io16DQL0y0Sjpg9LDe
         r6QmfrlVHt2Q4F7JSdZLCEXLv3KNhQnGzJSNQ5ViU/MTCe1Zg2ycz4t6bKe/y+KOV3Sj
         JfdtFibr+0RRrp2aQYdyS1SVWOlb9ptteHLlZBQQ1SBOAoLmzgxQHeiqDA+uA6Uj7DCO
         1VJvb+aipMiknVXC44zQAcZXqtSgLj5GECitbuF2K0Gy7Bl7+BspsJoKGuMvcjzAOJme
         ZpKFOqIUakFUW8fe/Neb9bZ5O56oGpSRQn207rg8eriqUtL3vPnXP5f39S1wSEH42EbY
         eXSQ==
X-Gm-Message-State: AOAM530ejDcBaHMajwd722Ok4AIRur992Dd7IrCFxSu8/cQbH4P2WFnD
        uknCU5FbNjzwZxIpp8i9AFEGug==
X-Google-Smtp-Source: ABdhPJxdU3ie2HHClJoOFIOZRKZ05PscJB9zK+SiPPLZWZNmDvZKIzzv2ksLTK7o6fKIX0jB+xHlMQ==
X-Received: by 2002:a50:c34d:: with SMTP id q13mr43984159edb.65.1639189358272;
        Fri, 10 Dec 2021 18:22:38 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:37 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: qcom: pmi8998: add rradc node
Date:   Sat, 11 Dec 2021 02:22:21 +0000
Message-Id: <20211211022224.3488860-5-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211211022224.3488860-1-caleb@connolly.tech>
References: <20211211022224.3488860-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

Add a DT node for the Round Robin ADC found in the PMI8998 PMIC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 0fef5f113f05..da10668c361d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -18,6 +18,14 @@ pmi8998_gpio: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8998_rradc: rradc@4500 {
+			compatible = "qcom,pmi8998-rradc";
+			reg = <0x4500>;
+			#io-channel-cells = <1>;
+
+			status = "disabled";
+		};
 	};
 
 	pmi8998_lsid1: pmic@3 {
-- 
2.34.1

