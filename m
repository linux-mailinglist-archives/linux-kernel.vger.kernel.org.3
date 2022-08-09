Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA7E58D82E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbiHILdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbiHILdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:33:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FB240A0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:33:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a89so14720780edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=889hlD1ho6n/GA784dTSvUCYoqPA1nuSRX9iN5LTl7I=;
        b=s+VQYwlTtMncZwIaDlzTeyk4S2iK9jzrnMXdaNYlJye1sbKxeMHhcfHZC/bz8vpm9l
         IcCbKoyFgltNeGROjglwvzaX3CapMq7mSWeaQf5aLKh+tE093UuKRrwKMq11zPF7thcX
         r/1zAPLj4OyTwAdohRWY6Jmh4bOkTZIPG1o3qJmSRIQZXgtk5SBQzLrignB1WWivFd/e
         PkD+Rfke3huZbSoZkkcAyTmHuW2DYnY6n1wuYhkMfM0zSqqltEVxZb1WsfCslRIWfLG5
         Y1v2kDK1JBKhlbWVfyMvmQt+XeVhhwElmVQpo/mjVP4wOzQ21i3JNwTRbrgnqs9D3xis
         5DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=889hlD1ho6n/GA784dTSvUCYoqPA1nuSRX9iN5LTl7I=;
        b=Pya2AJIgKDAIYVi89cnewSF9CwBi+3PwTiAQ307/BJec5Rn/dzr6VFor5Db7mm0GzI
         cLQ6uV5SqtPMw1jR5OrMEbJ0J3Uc0z+xIP27TeX95rtj0q6Q3Y896/25gm3+fKTobmml
         jgFq9UbUwagEQRm0FQtJRTmwnBYqHJPGObjWZvGaC8TfNNHCMDWaFmuH2GYUR5/Vm9X9
         FgeNmsbOeOOdcUGatJ34HrJi0vI3kr3xR2ZWeIRh8Wll4Hbf/byN9ZhhXv8Xr+F4IuE+
         Q179Lvw27/TpBYX88RQaldAB4jsQR0j8RWopK93NjvXTP79j94P79/ZHwpVXDVvttrUu
         ifjw==
X-Gm-Message-State: ACgBeo1e1msbr/LUM73vLIJ1jYNcuFgE/aIgw19fFqbI3wqSW3uqOr5f
        av1ME2LZq7pOp19a1E0QKPujqw==
X-Google-Smtp-Source: AA6agR64lvncagWgUfaaLzpJdMGks7RtcI5cEH5eDUzB7/BxgSwGU/2FDYKyxLysPXYt4yc0tmYluw==
X-Received: by 2002:a05:6402:26c5:b0:43e:2f1b:31c2 with SMTP id x5-20020a05640226c500b0043e2f1b31c2mr21261884edd.424.1660044809162;
        Tue, 09 Aug 2022 04:33:29 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007304d084c5esm1006993ejm.166.2022.08.09.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:33:28 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 4/9] clk: samsung: exynos850: Style fixes
Date:   Tue,  9 Aug 2022 14:33:18 +0300
Message-Id: <20220809113323.29965-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809113323.29965-1-semen.protsenko@linaro.org>
References: <20220809113323.29965-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some typos in comments and do small coding style improvements.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 drivers/clk/samsung/clk-exynos850.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index cd9725f1dbf7..ef32546d3090 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -173,7 +173,6 @@ PNAME(mout_peri_uart_p)		= { "oscclk", "dout_shared0_div4",
 				    "dout_shared1_div4", "oscclk" };
 PNAME(mout_peri_ip_p)		= { "oscclk", "dout_shared0_div4",
 				    "dout_shared1_div4", "oscclk" };
-
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_DPU */
 PNAME(mout_dpu_p)		= { "dout_shared0_div3", "dout_shared1_div3",
 				    "dout_shared0_div4", "dout_shared1_div4" };
@@ -599,7 +598,7 @@ static const unsigned long hsi_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY,
 };
 
-/* List of parent clocks for Muxes in CMU_PERI */
+/* List of parent clocks for Muxes in CMU_HSI */
 PNAME(mout_hsi_bus_user_p)	= { "oscclk", "dout_hsi_bus" };
 PNAME(mout_hsi_mmc_card_user_p)	= { "oscclk", "dout_hsi_mmc_card" };
 PNAME(mout_hsi_usb20drd_user_p)	= { "oscclk", "dout_hsi_usb20drd" };
@@ -963,7 +962,7 @@ static const unsigned long dpu_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_DPU_SYSREG_PCLK,
 };
 
-/* List of parent clocks for Muxes in CMU_CORE */
+/* List of parent clocks for Muxes in CMU_DPU */
 PNAME(mout_dpu_user_p)		= { "oscclk", "dout_dpu" };
 
 static const struct samsung_mux_clock dpu_mux_clks[] __initconst = {
-- 
2.30.2

