Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB850E813
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbiDYS0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244320AbiDYS0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:26:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A45B8930A;
        Mon, 25 Apr 2022 11:22:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u15so31204202ejf.11;
        Mon, 25 Apr 2022 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzcS/ticocMB6pY40bBOU+jgqAFHJfeM6b9Rf1dfoWQ=;
        b=bEWbEo3Wln9xY4+Za34RvJ9WPedwk3r4AP/ks43UsvAY9ZdBU37Q9k4QbsYOX+JUo8
         SKwBXZY8ONZbG8XAHMotKCJMMja/LUdOaVR7tMOkhPdKQQC1RZKMD5KSC0Y3S+GPHuKX
         bonxF24UziHb6ateQwmuS2dfveV4eBe8+YGxEvIocRmlKxC95YVuBGjsNZSDlczD8X5U
         hkQppSTsR8l5eD/cGVVA7YNsxl/nq8Hhel7JAU2588e7FfUxf6cbNm3Aed23XGrzQXAK
         QRh2M37pGW3BaFy7Uq06u/t3A/TBQoLkEDWTmoiVwFT3r9/7FE10yWkTzEJeVEJdydkX
         g4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzcS/ticocMB6pY40bBOU+jgqAFHJfeM6b9Rf1dfoWQ=;
        b=CkJyzFK6V4Dr5rVSEio0JOjWEOW4SLNfprfuJ95/pIbrWLCEQqIWQXoft8JJjx12Fs
         EnF1wTG4eWiyr0rKUujVbR+tJy02CVdiGX0jVdjDugkpXt6l3l2bO/FqkbwHKwgojP8a
         tyU9r8fz7oFnQLu+2AjVeypsfC8f0ofSi0Ak67nWTzTMkAJtS+VOb2hk4RBuOF2wAxS0
         J1B7gQCJlYRo0Qbn5sR0/2lgya8y+OpQMv2XtHMI301fO92JmSGhoi2qL5MOloLu4eBv
         H5pfl0qMCFwyTmq34ZxHXhiwRnPtDDwTQBDN1khVPE92tuyOgfHcbx5DNNkzdywMToLp
         RTMQ==
X-Gm-Message-State: AOAM531eA2oihajuowLgDL4vG+EqqsTs2Kkkm3UhMksXbEQ3IX7W1z3b
        KaRe9SeoksSr/pIQSNy0E98=
X-Google-Smtp-Source: ABdhPJwXjKGZ10uS32h9MBla/5CxN3QS63VWvBPegOM1xH6Vx8RXzZt1t0a2kLribNr2mj9s86BynQ==
X-Received: by 2002:a17:907:3f9c:b0:6f0:28d1:3ad6 with SMTP id hr28-20020a1709073f9c00b006f028d13ad6mr17702887ejc.365.1650910975072;
        Mon, 25 Apr 2022 11:22:55 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-91.zg.cable.xnet.hr. [94.253.165.91])
        by smtp.googlemail.com with ESMTPSA id h13-20020a170906590d00b006f39021e683sm1677210ejq.12.2022.04.25.11.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:22:54 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/7] clk: qcom: ipq8074: disable USB GDSC-s SW_COLLAPSE
Date:   Mon, 25 Apr 2022 20:22:44 +0200
Message-Id: <20220425182249.2753690-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425182249.2753690-1-robimarko@gmail.com>
References: <20220425182249.2753690-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in IPQ6018 Qualcomm intentionally disables the SW_COLLAPSE on the USB
GDSC-s in the downstream 5.4 kernel.

This could potentially be better handled by utilizing the GDSC driver, but
I am not familiar with it nor do I have datasheets.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 2ebd1462db78..65249a03a672 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4806,6 +4806,11 @@ static int gcc_ipq8074_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	/* Disable SW_COLLAPSE for USB0 GDSCR */
+	regmap_update_bits(regmap, 0x3e078, BIT(0), 0x0);
+	/* Disable SW_COLLAPSE for USB1 GDSCR */
+	regmap_update_bits(regmap, 0x3f078, BIT(0), 0x0);
+
 	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
 	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
 				&nss_crypto_pll_config);
-- 
2.35.1

