Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123DF527A26
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiEOVBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiEOVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:00:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376EE6438;
        Sun, 15 May 2022 14:00:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j28so1969999eda.13;
        Sun, 15 May 2022 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Ns1RqO2cFYUrMqcJQr7rdBO780Yqa0pL6pb5yGq7SQ=;
        b=GOe+p2cbTc+TOwseoHreFOyY+q4zCnPdK/bUwvCcSz84wRZdHv8LyfzzLXaWUYtwhm
         s0oQMmDwNupVM+ckYOf9Mx7tWoFgH3IUdHeZ4po//fQ95tapmlS6sc86divBgeO83KxW
         ZvIkshvXrfgXpIRhQuBPN2mnWUpfOvsiI119UESBblSMrrF6ZtruBlzFCoJ2GVkiMFme
         CN3TiPUnGC0+bYI8vHAU8knEVWQXgsvamN6TVrb35ZhohUxNtIjxISMV2sxEDIUDA17a
         s8EYFU0lZhbieD0TOgXOX3QXMEuFA0/rczToYE+KBfR5GuvbnxQYRr3rbLfMjzbWopwg
         z8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Ns1RqO2cFYUrMqcJQr7rdBO780Yqa0pL6pb5yGq7SQ=;
        b=YeRYHY4Bx/Uu71DzNTK5QKrf5FmyDsA2t8iohoh/usxYjR/om9stM507Yw2aOeZQtE
         /ApJexSf3xSPk0vnRlb/P2TOg6haWYF1fkwr7LJAGRD8UR2m5vmo0a9JP6QBAahQBcZO
         ZW95/2+mhcUjJYPxpnkUl7iBhVuZKL4Z+BNN3Vka1EhaF82UZcr1CNQ8WVuDplltIUDs
         yIvv15ZRj5lm9mUWMjYcj73fXzwwu7aQ3QZO9l2BeAUPoeotZv8kwIqE6siw4XoCE3hK
         UhVGQXrvIAL8wfLNVtPLvp3mYNxigfHFNbhsniAjHz4AncXB3I+DzCEFaYs39heBjJGb
         rMNg==
X-Gm-Message-State: AOAM533+UCaweX7xDRXPDU3v/7ARBJj4EqjgpdvMETc3U2LDKIGqBOid
        SSlaTCYqy3Zz6eV/LTrA784=
X-Google-Smtp-Source: ABdhPJwNFNGE4ksp89T+QwmXEYmbhSSMCKNwYylnQuJXr+lZ0Stz/XyILm2BVKLgPg2AApcMkaChYg==
X-Received: by 2002:a05:6402:3586:b0:427:b16e:a191 with SMTP id y6-20020a056402358600b00427b16ea191mr9745523edc.137.1652648452800;
        Sun, 15 May 2022 14:00:52 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:00:52 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 02/11] clk: qcom: ipq8074: SW workaround for UBI32 PLL lock
Date:   Sun, 15 May 2022 23:00:39 +0200
Message-Id: <20220515210048.483898-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515210048.483898-1-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBI32 Huayra PLL fails to lock in 5 us in some SoC silicon and thus it
will cause the wait_for_pll() to timeout and thus return the error
indicating that the PLL failed to lock.

This is bug in Huayra PLL HW for which SW workaround
is to set bit 26 of TEST_CTL register.

This is ported from the QCA 5.4 based downstream kernel.

Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL’s")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 1a5141da7e23..b4291ba53c78 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4805,6 +4805,9 @@ static int gcc_ipq8074_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	/* SW Workaround for UBI32 Huayra PLL */
+	regmap_update_bits(regmap, 0x2501c, BIT(26), BIT(26));
+
 	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
 	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
 				&nss_crypto_pll_config);
-- 
2.36.1

