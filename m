Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97D5073BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355034AbiDSQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDSQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EFA15A32;
        Tue, 19 Apr 2022 09:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66031B81BF2;
        Tue, 19 Apr 2022 16:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34BBC385A5;
        Tue, 19 Apr 2022 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386354;
        bh=iNfaqPXbxvJ8CzkrujTl+KTX1dXRxdfsCaFm+BFdUkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfRkXwjMc9oek9+kpE3h7BCEd05AgRXzISzSv39xtx/qe6Q/2hxmd3obXTk9UB36X
         +q4K5dVdjE3QggFgrTvjYnWJW1DdumolThYG/Etv/6l46iOKZpsTRoAEErpmmuzy/U
         lUmHdvOnaZOz3V1CaFwc0LstSClQkNGYSguKhmK3DQNsD7u/0DwgzqR9wbmaqBeb3U
         gj8yt11H4YBBVesxMPSkz9sQGyQQ2mEHodmsWtzBM5xh6K1SJLtjD+piWx4+Ajg4Jr
         LtTB6YXt4UPB2SD8A7KAOdJAvbYsNgQ2Zzg1xKK1Z0QY63UFZvEjMGPJhE0gvn5f2x
         4UMXt0euV9HXA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 03/48] ARM: pxa: make mach/regs-uart.h private
Date:   Tue, 19 Apr 2022 18:37:25 +0200
Message-Id: <20220419163810.2118169-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is not used by any drivers, so make it private to the
platform.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/{include/mach => }/regs-uart.h | 0
 arch/arm/mach-pxa/viper.c                        | 2 +-
 arch/arm/mach-pxa/zeus.c                         | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/regs-uart.h (100%)

diff --git a/arch/arm/mach-pxa/include/mach/regs-uart.h b/arch/arm/mach-pxa/regs-uart.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/regs-uart.h
rename to arch/arm/mach-pxa/regs-uart.h
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 3aa34e9a15d3..4b81c0117971 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -48,7 +48,7 @@
 #include "pxa25x.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/regs-uart.h>
+#include "regs-uart.h"
 #include <linux/platform_data/pcmcia-pxa2xx_viper.h>
 #include "viper.h"
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 97700429633e..5d02f10b5b5a 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -39,7 +39,7 @@
 
 #include "pxa27x.h"
 #include "devices.h"
-#include <mach/regs-uart.h>
+#include "regs-uart.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include "pxa27x-udc.h"
-- 
2.29.2

