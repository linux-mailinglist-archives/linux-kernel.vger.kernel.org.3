Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA246A076
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381923AbhLFQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387952AbhLFPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:54:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF1BC07E5E3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:40:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so10725559wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQXx7GnUnnrSCouIsJOJJqdsqKC/T8UFD1PrZ+Nst5U=;
        b=IuaMZSyQ+XFWmM3aQkBaM/vyuejE/mCo0s0ldZhwVJQfdZrFwnV/LW9wnvrMm1NWVM
         +gz5GFxnJUbj7kaKnnzdt9lARyJlkmSi7vpqH1lR5dGD8Z7FwIGJW4drbwMTN6XhoqFC
         74LTT6ajb8LK3pLQygvtY/J8YqDewfGhzCYQKHxq+8OFeU7JtpkFp+lSd8TnVVUXdxBo
         xP2dD/c35+5cKD4JtLh2/DD42FGrVN+6eAIkUExDTsO9JW5IE2A/k30op8e7tr5gD0Rv
         STfkdgDX7X3c64D7UMEYn9E3DfZTJ/ty2pj+EREM/AuQIgpkQwb1Tc3lZwQhM3/c5e9q
         D2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQXx7GnUnnrSCouIsJOJJqdsqKC/T8UFD1PrZ+Nst5U=;
        b=RJwO/0QMpjgT0XLxLYghD318sIjZeSj877A3xhKEYrlMXjmjJdVwshCdP410BJUsnB
         BKGavkbzq6D3ChVtVijqnkMgtFhfWzQLJeVmQBEvGqftJZMVhqoCk6teEeUj1OCMdpx+
         3LVh7OtmWvAiuHnVIBVQcAp027W4p6E8UO1tAwTY8lhBwMcWbv4WzAuBN3L4ElIPBjGo
         RVJMemraJNeDwY1D62tvS1zXypYoGmLxZqAKOl/JwVtrBMzmK47xxGSJpPRKgdvPUZiW
         lbqL2YTRo0WTTpabEnmNCDyNptHyAvXVekMkqEys/hztV6z9T81H53wtInYHonur+qs0
         +XnQ==
X-Gm-Message-State: AOAM533IJMmVyiIVu0s6Q+mHholDad27UYl5RBhP9yudNVjz505RMXdm
        wUrPirN6ctwxxX4dCTNykTmtLA==
X-Google-Smtp-Source: ABdhPJxOHQO9mqqr0dXVOzuceTkm+GBE8UVOd04B0PnegF7w28h7QvZL6qZBwGY/2Tfr8iffu6aqiA==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr39723541wml.21.1638805206906;
        Mon, 06 Dec 2021 07:40:06 -0800 (PST)
Received: from xps7590.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id g13sm15818962wrd.57.2021.12.06.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:40:06 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mauro Carvalho <mchehab@kernel.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4 1/2] arm64: dts: qcom: apq8016-sbc: Remove clock-lanes property from &camss node
Date:   Mon,  6 Dec 2021 16:40:02 +0100
Message-Id: <20211206154003.39892-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206154003.39892-1-robert.foss@linaro.org>
References: <20211206154003.39892-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-lanes property is no longer used as it is not programmable by
the CSIPHY hardware block of Qcom ISPs and should be removed.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index a5320d6d30e7..b7a578aafcbb 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -253,7 +253,6 @@ ports {
 		port@0 {
 			reg = <0>;
 			csiphy0_ep: endpoint {
-				clock-lanes = <1>;
 				data-lanes = <0 2>;
 				remote-endpoint = <&ov5640_ep>;
 				status = "okay";
@@ -289,7 +288,6 @@ camera_rear@3b {
 
 		port {
 			ov5640_ep: endpoint {
-				clock-lanes = <1>;
 				data-lanes = <0 2>;
 				remote-endpoint = <&csiphy0_ep>;
 			};
-- 
2.32.0

