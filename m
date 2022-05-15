Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E359527A03
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiEOUpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiEOUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:45:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62F101CF;
        Sun, 15 May 2022 13:45:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j28so1942400eda.13;
        Sun, 15 May 2022 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tU6uMaYficFOXva4xeM/4aLqe2TPDWlHeWmOttB+92A=;
        b=P7TMK03vc1TChbgogl3ipw55D51VjwvKdAuihPqDCO8UPPVh9Hc0+K5hf9Qd33/Mpt
         //OL49uwGwZj8lWj1IMXNYKWboerFDDcdcewQ9+JoiJYwQanBfr5NEgUKSxZOdWKf6Wr
         eKobsDqGALNdzY2YV6d1nx3uqui1Snzyab+zeDVy2F94uUeHxkhKJWgnT5fFRvnqTYDm
         UdCSzE53aVfkag8SZGOaDxyzQyi53579I1wwdyN4NFNQXwKcu9yXSfUOdPozgjThn22+
         3DfnrqeqV9+i05AQq9wWJMkrvhhlHugZCypqqBsA59IAFmacAgcIJdsdAiNHnx+L4K8D
         FDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tU6uMaYficFOXva4xeM/4aLqe2TPDWlHeWmOttB+92A=;
        b=ZcpvOvx6XsAv+zwHmK6IwDE5dAR7NccupoC7p705AHHuuq6W05IYXrSqkxGox3SCR7
         RdiJg+6ugyTelWmIGLh6g1A0ag3WGe/coJRcktHD4eXhR0d66qyDTiIO3d+Q0VxSZS7p
         +T5l7zlLKEipT1DYF4qO3VTQrQdnLlBKTovQGU2QESkYfet8ubs+x1c26cUzrKMv3VLU
         XL0rCxZ8+X+/tQC98g1OAtB3CPHJY5Y1zBKZU1MsJp9u23YGHXSGtKZKgMOqLAtZAd3H
         rT7oGBmBgmMiRP78K0n7DF1RYWwDHwg7FKtNfkGT1hn/TwSkomYG3QMiVEZxK5A8VkVV
         bgBQ==
X-Gm-Message-State: AOAM532d2dXqCmXyEaXbcHT1LHYdTUK1wK8gAFKZwKiDKwej2cuctssg
        vUN7ACaZMgr6xCdudk/mJMG0z/Bqn2Gp9w==
X-Google-Smtp-Source: ABdhPJwYZFDmvGmQVM5BvZuDSpnC/dP7nbjdio7lY6LzlTi8nCBgbLC9fjqP2uJkwsFacO3oCVqxzg==
X-Received: by 2002:a05:6402:b3a:b0:42a:a6de:e533 with SMTP id bo26-20020a0564020b3a00b0042aa6dee533mr5513937edb.100.1652647542371;
        Sun, 15 May 2022 13:45:42 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id i10-20020a50870a000000b0042617ba63cdsm4174156edb.87.2022.05.15.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:45:41 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 1/6] clk: qcom: clk-alpha-pll: add support for APSS PLL
Date:   Sun, 15 May 2022 22:45:35 +0200
Message-Id: <20220515204540.477711-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

APSS PLL type will be used by the IPQ8074 APSS driver for providing the
CPU core clocks and enabling CPU Frequency scaling.

This is ported from the downstream 5.4 kernel.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 12 ++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4406cf609aae..8270363ff98e 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -154,6 +154,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL_U] = 0x30,
 		[PLL_OFF_TEST_CTL_U1] = 0x34,
 	},
+	[CLK_ALPHA_PLL_TYPE_APSS] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0xff,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0xff,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+		[PLL_OFF_STATUS] = 0x28,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 6e9907deaf30..626fdf80336d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -18,6 +18,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_AGERA,
 	CLK_ALPHA_PLL_TYPE_ZONDA,
 	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
+	CLK_ALPHA_PLL_TYPE_APSS,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
-- 
2.36.1

