Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97E50EE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiDZBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiDZBtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:49:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115CF326E6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:45:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so16533654pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xEcNsOmWiSoMZTJZ9nDIHZwHU/nM01fZp19mgcJHcnc=;
        b=ONlUfnCtqgajUOOJkNwU0AWXmkQNY0M6ASjQrMi7sBEcTY6YbOGE9cr9gSq9Rnynkz
         Lqzeh4bhQp6RVjA4EVSy3nblPtdnIEnjq0dpmRKb5y/xXqc42zOPX5y5hot4QWmXxdT6
         sAS+g1sGOgn8Va5e0kzERx2NuZaFGV235DLok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEcNsOmWiSoMZTJZ9nDIHZwHU/nM01fZp19mgcJHcnc=;
        b=X4kpnCFmeLTw8COVjMEwvtabnanHl1VafIbu9+ThGGQp53/HJiuudX5utIfa8PGclE
         2YDfmV+e4co8qlxeIiRTJFEJwejgiLqKZKvruIrUN2BY0TyfdyqONQbVDKxSg9QNyY+y
         CnRK0V9YM/3FN6/L9yVQ1k/GTTM7W6HbybAGhxBmtxOzCT04eVPwr/pvHiYHPDSslhSS
         CK4LGCKBAeFK/ZOlPgQi3bwu7F5CVhhcwWs75vtVkiEJkYrwh4F87+Mc9Rhp1IdDmauO
         6bsRiilZMkxDmMDpOWh/GWHLOwOK+VPy4ZdjX2SVQptj3VZurCqDZMisRKrWWjC7KSWU
         OwSg==
X-Gm-Message-State: AOAM531vNRm4yzEAJQHfLMzO28ItaPnNnWL8iaCyUC0+X/C93A0+XWEJ
        upd5o3bkXmijH2jrsraX6LaCqQ==
X-Google-Smtp-Source: ABdhPJwxk4NagGqjyQ1Zjt4Y7KAzZSTlHKc6kbk46QcFNRRhLXNdVkKJpLaKkEUeZMQ8aJNP/sLzpg==
X-Received: by 2002:a63:a61:0:b0:39c:b654:b753 with SMTP id z33-20020a630a61000000b0039cb654b753mr17149715pgk.117.1650937558631;
        Mon, 25 Apr 2022 18:45:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:84c6:2d6d:c16:1a1b])
        by smtp.gmail.com with UTF8SMTPSA id c7-20020a62f847000000b0050bb32e3b8dsm10251134pfm.179.2022.04.25.18.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:45:58 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 3/3] soc: rockchip: Fix compile-testing SoC drivers
Date:   Mon, 25 Apr 2022 18:45:44 -0700
Message-Id: <20220425184503.v3.3.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220426014545.628100-1-briannorris@chromium.org>
References: <20220426014545.628100-1-briannorris@chromium.org>
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

[1] e.g.,
https://lore.kernel.org/linux-rockchip/20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid/
[RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 * Drop ARM||ARM64 dependency, now that bare dsb()s have been removed

Changes in v2:
 * Depend on ARM||ARM64

 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

