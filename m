Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022A451E9F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446996AbiEGUdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387182AbiEGUdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D64BBC95;
        Sat,  7 May 2022 13:29:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so12138635edw.11;
        Sat, 07 May 2022 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dghnijSd8lgtthMZ/SJImobMXWMBJhXwTeRnVajL27E=;
        b=Sd0f9pL+Ygu7NqDD845vGjqUQO9V0ROI1aXT4DBkeJw63xzBc1tDUQtggUFGJv2cGy
         zQDIAL+SqwW2Kr+nEzlVRr0I9Q7ip6xe1aSIvYZE9dGHJzB5Al8VVaW1fA+YgFQ5qfw6
         BpvX2E1i/Q2hVKlz+FPOhUcn+6B5h+Ki+QaEPeW0f/Cd9vaDS2d+r9T9QQtYdzlmw/E2
         M9m0XjizgR+xAlSd1kz1wBdujaobOpV0zurDiQNiYOIQ9N4q2W/ZeeOWlI5GWHuGd4fe
         nHXURlWtVCKXsqfEGBgp8jKP6QoGHIirIqlEQRNW20gfQtne6NESJB3gttPkOqVQqw6L
         g5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dghnijSd8lgtthMZ/SJImobMXWMBJhXwTeRnVajL27E=;
        b=zDilwQ7SE10s/2zbDgKHz7pINrLdMZWswV4wXWnEEcxVKLmd+V3E9zZIwGGt6rkHcz
         HzytHCwzeP0mvE2LYDpa01BInndmTQ7hFAQZ1JkobGVeiWUCmDue4omG69XlDiLipyti
         BefJb4O7J7TntDMIIs+x+GQJTz6ie3++wHGDEavH/dPF2rA3yENX3YYPl0vDsB6Tm69i
         tuyAT5hIfMhHDX0ULuUbWduLX/qQkEXYh6nMPClg7X6DzL3188tr8aHEAS/Buw6XgTQh
         iNrMB/K+QxpSg/psaRL9Hk6j7e2OZi5H1vHzb+Yuoeyf6nMsqfqbKaP8bTVHkixEIHhC
         VhVg==
X-Gm-Message-State: AOAM530GIGOxKOdoW2CMrCi1BGvwNwLVEU92u2G2vT3PxSxZdXUhHZ9X
        DIvfuyVBYge7xwRVO9ukwMA=
X-Google-Smtp-Source: ABdhPJwrD4sV3bY7dBOyEXb5y0JCQNB5YHsOYY8Ua3+A99XBNx5tHhDGEO+FNhdz69Nza5+gypGCgw==
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id eb5-20020a0564020d0500b00425b7ab776emr9975258edb.142.1651955392857;
        Sat, 07 May 2022 13:29:52 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:29:52 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 02/11] clk: qcom: ipq8074: SW workaround for UBI32 PLL lock
Date:   Sat,  7 May 2022 22:29:39 +0200
Message-Id: <20220507202948.397271-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507202948.397271-1-robimarko@gmail.com>
References: <20220507202948.397271-1-robimarko@gmail.com>
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
2.35.1

