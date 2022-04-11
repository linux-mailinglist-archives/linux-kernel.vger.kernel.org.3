Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707734FB8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbiDKJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbiDKJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:57:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B41263F;
        Mon, 11 Apr 2022 02:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F2638CE1714;
        Mon, 11 Apr 2022 09:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386BBC385AA;
        Mon, 11 Apr 2022 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670925;
        bh=HHV9Ri58ctEofpGBkf5IU36ecNuwh1ugqE59mUikbtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goujv62t7LQumqKPFRHX18SvYzGEFUh2LjbedAoxrR1fMrNZyyAcqwEOPETLOcNYA
         3gHw8H/FOMoD4uTOI+lBVdK7UQQVBCqwF4MJquH4FifaKyFhAr088icWFJO2UYKoo9
         lJ2fic6SWq2tO9s8OwwWCUMYJo5bGAJcckcEuW5Wf4DZRJo0qxZ4xspxwR7ekOWPGS
         +Wjmw0KZfNkOJSZl3gXFp3m5LVXC6aVcRa7ZCXwKd0OSOyJ6iCmc6OtVeuqsducrbJ
         OuZFNHFZSoNeFY2qrKOUfsjcEvWcYKhJi5lm5BqUzyTNKVArhmMEN4mQE7sejlJVd0
         9VVcm9XV78QoA==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 1/2] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
Date:   Mon, 11 Apr 2022 12:55:15 +0300
Message-Id: <20220411095516.24754-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411095516.24754-1-rogerq@kernel.org>
References: <20220411095516.24754-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far for armv7 TI platforms, GPMC was being selected by
arch/arm/mach-* architecture Kconfig files.

For K3 platforms, GPMC is no longer required for basic boot
and cannot be always enabled by default by mach- Kconfig.

We need a way for user (or board defconfig) to enable
it if required so ake OMAP_GPMC Kconfig option always visible.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 30bff6cb1b8d..da2af9c38fe3 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -103,8 +103,8 @@ config TI_EMIF
 	  temperature changes
 
 config OMAP_GPMC
-	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
-	depends on OF_ADDRESS
+	bool "Texas Instruments OMAP SoC GPMC driver"
+	depends on OF_ADDRESS || COMPILE_TEST
 	select GPIOLIB
 	help
 	  This driver is for the General Purpose Memory Controller (GPMC)
-- 
2.17.1

