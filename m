Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3274941C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357359AbiASUcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357345AbiASUcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:32:11 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8087C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:32:10 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c66so2193718pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbN3aXRh0tW2nxOBZ+2r3Fa7kNORZifU05Up9v4Gb14=;
        b=W8+mnjkxgiFJIPna5wr33XhcJnB5V3DbA6K4E3maWzb5FOZZ261wvwlhSfpbuHYwcE
         XcSywcI0HsIrAhLLy+Vp7SY6tdshYOubSjUjW6a2lOJOP+iE7NKpcCruPTIDF3X4b94T
         DPt0+By8COMRqBZnnQM8IDAqFUyJyccU08Pf1s/EZaMHgF0Rk1Xxv1rGQKm9l6w74dgN
         m99geXbQ/5OUVwGau1lAw+LTXE0yKjhoZG97t583HHbFSZ0eYJAYmL+8YFc0RHGQ5t1m
         UY/ByJA5eE21/oBNfXI3edIGamyyJCdlKjPhO9M0t+bPL9aZuiNBZmOWxpKzExvUOvUA
         6bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbN3aXRh0tW2nxOBZ+2r3Fa7kNORZifU05Up9v4Gb14=;
        b=uyB78liZmdZOsBcn8IEc5tSQ4md49rPMYWzf7RnQ+sjOKSZtQkz2SbN1QxW8w71aaw
         qJn5bpWP0/NQOMdRuEfQVFaoTbWb491O7BORJLnHNFPzzTwViiygXefQslUoLaVGD7QP
         Bj7XahFLSFYUVQo16otKEPXFjjF0996kUGXZx9C5CtHNMjIE90O0Ykv4YSr1mK+4MZpR
         iOsSrSt/FPtj5sr/cvcqeuUnRtZecDR5osCqwPqZTjc9yLPIHLL0lGttaPfwTQI8QtjT
         tWRzJlQX79bkxl1gnz+AHb7Ya7C6poZa3WAgIT3CeqxORNRy3Rc61ehqpsnOZ7GAl4b6
         GVVw==
X-Gm-Message-State: AOAM532cXemNqqQo8QtzfgZdMVD9WqKfZX6IX/1lPnbCh+/eSkoTbR1+
        Q4ikLI9S3pM8p7DQtegD13zYUw==
X-Google-Smtp-Source: ABdhPJz8orUKdY2yDkn04tiT6KnfcjLggVN+L8/kUQ0lOLoizjGD2fDGP0KarfyeAc6wgRYRcfVhzQ==
X-Received: by 2002:aa7:91c3:0:b0:4b0:eebe:49c0 with SMTP id z3-20020aa791c3000000b004b0eebe49c0mr33012000pfa.6.1642624329793;
        Wed, 19 Jan 2022 12:32:09 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f3a:47e5:8bff:a3f8:a494:acd0])
        by smtp.gmail.com with ESMTPSA id x13sm6807552pjq.43.2022.01.19.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:32:09 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org
Subject: [PATCH 2/4] pinctrl: qcom: sm8150: Specify PDC map
Date:   Thu, 20 Jan 2022 02:01:31 +0530
Message-Id: <20220119203133.467264-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
References: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the PDC mapping for SM8150, so that gpio interrupts are
propertly mapped to the wakeup IRQs of the PDC.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8150.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
index 7359bae68c69..499dd05c3e3d 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8150.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
@@ -1500,6 +1500,25 @@ static const struct msm_pingroup sm8150_groups[] = {
 	[178] = SDC_QDSD_PINGROUP(sdc2_data, 0xB2000, 9, 0),
 };
 
+static const struct msm_gpio_wakeirq_map sm8150_pdc_map[] = {
+	{ 3, 31 }, { 5, 32 }, { 8, 33 }, { 9, 34 }, { 10, 100 },
+	{ 12, 104 }, { 24, 37 }, { 26, 38 }, { 27, 41 }, { 28, 42 },
+	{ 30, 39 }, { 36, 43 }, { 37, 44 }, { 38, 30 }, { 39, 118 },
+	{ 39, 125 }, { 41, 47 }, { 42, 48 }, { 46, 50 }, { 47, 49 },
+	{ 48, 51 }, { 49, 53 }, { 50, 52 }, { 51, 116 }, { 51, 123 },
+	{ 53, 54 }, { 54, 55 }, { 55, 56 }, { 56, 57 }, { 58, 58 },
+	{ 60, 60 }, { 61, 61 }, { 68, 62 }, { 70, 63 }, { 76, 71 },
+	{ 77, 66 }, { 81, 64 }, { 83, 65 }, { 86, 67 }, { 87, 84 },
+	{ 88, 117 }, { 88, 124 }, { 90, 69 }, { 91, 70 }, { 93, 75 },
+	{ 95, 72 }, { 96, 73 }, { 97, 74 }, { 101, 40 }, { 103, 77 },
+	{ 104, 78 }, { 108, 79 }, { 112, 80 }, { 113, 81 }, { 114, 82 },
+	{ 117, 85 }, { 118, 101 }, { 119, 87 }, { 120, 88 }, { 121, 89 },
+	{ 122, 90 }, { 123, 91 }, { 124, 92 }, { 125, 93 }, { 129, 94 },
+	{ 132, 105 }, { 133, 83 }, { 134, 36 }, { 136, 97 }, { 142, 103 },
+	{ 144, 115 }, { 144, 122 }, { 147, 102 }, { 150, 107 },
+	{ 152, 108 }, { 153, 109 }
+};
+
 static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
 	.pins = sm8150_pins,
 	.npins = ARRAY_SIZE(sm8150_pins),
@@ -1510,6 +1529,8 @@ static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
 	.ngpios = 176,
 	.tiles = sm8150_tiles,
 	.ntiles = ARRAY_SIZE(sm8150_tiles),
+	.wakeirq_map = sm8150_pdc_map,
+	.nwakeirq_map = ARRAY_SIZE(sm8150_pdc_map),
 };
 
 static int sm8150_pinctrl_probe(struct platform_device *pdev)
-- 
2.33.1

