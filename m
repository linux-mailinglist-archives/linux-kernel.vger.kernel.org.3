Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479E556D779
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiGKINK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGKINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:13:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE01D306
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A142B80D55
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71BBC34115;
        Mon, 11 Jul 2022 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657527181;
        bh=R6O2miSV0bOrDOZQkXiINnHBRHuYVWwD77xWgO0zff8=;
        h=From:To:Cc:Subject:Date:From;
        b=F4q2KeUfhOlQzLvF3uDI4wijo8E1SWhOjrUT5gCEZeD/eoRkALTDGiof0r7O88Xbm
         VERcHfP+10r176GwKfqsMKSa3nlfygCiLQyE937IqBZViNOX43oHpy1he55Jz+E4kC
         q63ry67oZWLVt7BQPnwct9IdnvgAeWzZvqTHIFGj4YuGw91vAmyuHbKy7d1MkucaJr
         hZN5wBOXc+xQvH7DD0iuQ0SueoeMEvUetfUHWzFrCPvcfaCE7JfXFM+8Ahqn2hDAlj
         ZHKPfWZFcUC0M8X4rqGyB5dqt9JcYXt9ed5cykCjzkKD4/z3wbRWI+B+5cPC1+kc1r
         eTiooHb4X9sig==
Received: from [213.208.244.172] (helo=localhost.localdomain)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oAoXL-006aXF-KK;
        Mon, 11 Jul 2022 09:12:59 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] gpio: thunderx: Don't directly include asm-generic/msi.h
Date:   Mon, 11 Jul 2022 09:12:57 +0100
Message-Id: <20220711081257.132901-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 213.208.244.172
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, kernel-team@android.com, sfr@canb.auug.org.au, brgl@bgdev.pl, linus.walleij@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures that require it, asm-generic/msi.h is already
dragged in by the higher level include files, and is commonly
refered to as 'asm/msi.h'.

It is also architecture specific, and breaks compilation in
a pretty bad way now that linux/gpio/driver.h includes asm/msi.h
(which drags a conflicting but nonetheless correct version
of msi_alloc_info_t on x86).

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220711154252.4b88a601@canb.auug.org.au
Fixes: 91a29af413de ("gpio: Remove dynamic allocation from populate_parent_alloc_arg()")
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-thunderx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index e1dedbca0c85..cc62c6e64103 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -15,8 +15,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
-#include <asm-generic/msi.h>
-
 
 #define GPIO_RX_DAT	0x0
 #define GPIO_TX_SET	0x8
-- 
2.34.1

