Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C7535542
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349133AbiEZU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbiEZU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:57:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E46A066
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:56:59 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nuKXL-0006ZH-2e; Thu, 26 May 2022 22:56:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH v2 4/5] riscv: fix dependency for t-head errata
Date:   Thu, 26 May 2022 22:56:45 +0200
Message-Id: <20220526205646.258337-5-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526205646.258337-1-heiko@sntech.de>
References: <20220526205646.258337-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alternatives only work correctly on non-xip-kernels and while the
selected alternative-symbol has the correct dependency the symbol
selecting it also needs that dependency.

So add the missing dependency to the T-Head errata Kconfig symbol.

Reported-by: kernel test robot <yujie.liu@intel.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/Kconfig.erratas | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index ebfcd5cc6eaf..457ac72c9b36 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -35,6 +35,7 @@ config ERRATA_SIFIVE_CIP_1200
 
 config ERRATA_THEAD
 	bool "T-HEAD errata"
+	depends on !XIP_KERNEL
 	select RISCV_ALTERNATIVE
 	help
 	  All T-HEAD errata Kconfig depend on this Kconfig. Disabling
-- 
2.35.1

