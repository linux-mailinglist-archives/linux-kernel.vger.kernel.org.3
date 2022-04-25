Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACAE50E6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbiDYRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243736AbiDYRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:20:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC8B289B5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:17:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i24so15390740pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LB+mmEmtSM6N/iMNtUelrgbgK3X940eJfV3qLOHCqJ4=;
        b=cZTNmb7GwCW+IZWsIPO1vgRVD3FnUtDriF1O9qu9/UbUYS26dkKEtaLGcELgRCS/hH
         H08NYddXndDAKi5uEjRfS43PQ8rW2hCBndV4UbwTnYO8r1beyLeaJxnn2mZREIfeOkVH
         bThY/Q1PtUPFRH2ZCl2adO8d24xCmd7iLCEzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LB+mmEmtSM6N/iMNtUelrgbgK3X940eJfV3qLOHCqJ4=;
        b=xL0lvd/6pIz5bkI9pujm2IO3I4hX6n+3QWS1z1s36GG8Vi07Gtsg7WW3M5TO8eXSGr
         PSYPH46FCHUso7Azvvv5Ide0ydPK+iA94wOIFLpBOtf0xaHF+wdhPT91K/EyjWN2G14F
         JpHVZrYqx+h5yWW2ociATyFHu3s6aeHpcYBljFW0AUXULx73PesyNlUHZ56RCu95nms4
         tiHnvor6u1NY+3+m2sh6wOHZXpcNOwCLsTOjmMsVmRujENLT/zHJpHXKnxEhsAhR7FV0
         fI/ssil0ZpODuw+DruszTBhE2AKdRx8yNdBChDQL+YkxEiC4Fkdo6N6te0XKnQgvnFQX
         u95g==
X-Gm-Message-State: AOAM530Pzdj2ybSx8g0R8nhPji/QS8KTXtpe9kBz1vl3NuON0YajIobW
        zElBNTfPZzaoXMU3hEAUnzzsHg==
X-Google-Smtp-Source: ABdhPJznoB/9Z0WWQLZbk3TSWrZBwAo/tkD3Ukr5vZ9klzHak9BNDS/s+EzAwjs3AK8oT+ejZ9QrNw==
X-Received: by 2002:a62:b50d:0:b0:50d:43b8:f2cb with SMTP id y13-20020a62b50d000000b0050d43b8f2cbmr4708758pfe.13.1650907071876;
        Mon, 25 Apr 2022 10:17:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3897:4488:e7c2:f2a1])
        by smtp.gmail.com with UTF8SMTPSA id c11-20020a62f84b000000b0050d33b253a0sm5774878pfm.112.2022.04.25.10.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:17:51 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/2] soc: rockchip: Fix compile-testing SoC drivers
Date:   Mon, 25 Apr 2022 10:17:37 -0700
Message-Id: <20220425101646.v2.2.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220425171737.321813-1-briannorris@chromium.org>
References: <20220425171737.321813-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 7f94b69ece51 ("ARM: ixp4xx: fix compile-testing soc
drivers").

drivers/soc/rockchip/Kconfig makes plenty of provision for configuring
drivers either for ARCH_ROCKCHIP or for COMPILE_TEST. But
drivers/soc/Makefile pulls the rug out from under us, by refusing to
build anything if we specified COMPILE_TEST but not ARCH_ROCKCHIP.

Currently, I'm not aware of anything that breaks without this patch, but
it certainly makes for confusing builds (CONFIG_ROCKCHIP_PM_DOMAINS=y,
but we didn't actually compile the driver?) and leaves room for future
error (I have pending patches that break confusingly with COMPILE_TEST=y
even though their Kconfig dependencies seem correct [1]).

Defer to drivers/soc/rockchip/{Makefile,Kconfig} to do the right thing.

We also need to force ARM/ARM64 dependencies for ROCKCHIP_PM_DOMAINS,
because it uses ARM-specific macros (dsb()).

[1] e.g.,
https://lore.kernel.org/linux-rockchip/20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid/
[RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Depend on ARM||ARM64

 drivers/soc/Makefile         | 2 +-
 drivers/soc/rockchip/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index fd7717d597fc..4c91705a8bb3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -23,7 +23,7 @@ obj-y				+= pxa/
 obj-y				+= amlogic/
 obj-y				+= qcom/
 obj-y				+= renesas/
-obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
+obj-y				+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
 obj-y				+= sunxi/
diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index aff2f7e95237..785e1798d286 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -25,6 +25,7 @@ config ROCKCHIP_IODOMAIN
 config ROCKCHIP_PM_DOMAINS
 	bool "Rockchip generic power domain"
 	depends on PM
+	depends on ARM || ARM64
 	select PM_GENERIC_DOMAINS
 	help
 	  Say y here to enable power domain support.
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

