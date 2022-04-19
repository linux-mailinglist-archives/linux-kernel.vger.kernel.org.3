Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31F6507518
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355327AbiDSQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354759AbiDSQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:47:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C69D;
        Tue, 19 Apr 2022 09:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02B1BB81BB6;
        Tue, 19 Apr 2022 16:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6062FC385A5;
        Tue, 19 Apr 2022 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386683;
        bh=XdueS6o3x8Genbrjo7SphR5bJ8o+YLBkmS/22/Y/tzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXQtUJB7B4bM52daStJxTBrA8/zErvRHpHn2okco8xXiPRjGGTcMxZ34F9ihe2zZF
         1BoMvocNKdvX/A7Mn4lmcao9QbvEfofhr0515a2QLJ4e/1ti5g/eDZCmDNi5sdZR/I
         9XNG+Otrayi6yRijGpRrnLzixoTgFiEZlFFL/2ise5K7ONOzh9kv641LscK+chNQJ7
         Q9EFuzcxnFtDUtDisGrueMKhbPDgR4AstoPr4QwJ7WiTnp9E3XeIFc84uL5FnW7uoT
         5DjaGzrz2kHiXzQHJSz/k+R25fFOoMSH+WeElYMHF7zCHXx8w3wvu8Yx03jMnZvboF
         gxYGbk6+OLuAg==
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
Subject: [PATCH 45/48] ARM: PXA: fix multi-cpu build of xsc3
Date:   Tue, 19 Apr 2022 18:38:07 +0200
Message-Id: <20220419163810.2118169-46-arnd@kernel.org>
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

On a kernel that includes both ARMv4 and XScale support,
the copypage function fails to build with invalid
instructions.

Since these are only called on an actual XScale processor,
annotate the assembly with the correct .arch directive.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/copypage-xsc3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
index 6f0909dda2f9..c86e79677ff9 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -29,6 +29,7 @@ static void xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+.arch xscale					\n\
 	pld	[%1, #0]			\n\
 	pld	[%1, #32]			\n\
 1:	pld	[%1, #64]			\n\
@@ -80,6 +81,7 @@ void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
 {
 	void *ptr, *kaddr = kmap_atomic(page);
 	asm volatile ("\
+.arch xscale					\n\
 	mov	r1, %2				\n\
 	mov	r2, #0				\n\
 	mov	r3, #0				\n\
-- 
2.29.2

