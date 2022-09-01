Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE755AA314
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiIAWag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiIAW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:29:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD649B64
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:28:28 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oTsfW-0007wk-Sn; Fri, 02 Sep 2022 00:28:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     conor.dooley@microchip.com, guoren@kernel.org,
        apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4/4] riscv: check for kernel config option in t-head memory types errata
Date:   Fri,  2 Sep 2022 00:27:44 +0200
Message-Id: <20220901222744.2210215-4-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901222744.2210215-1-heiko@sntech.de>
References: <20220901222744.2210215-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The t-head variant of page-based memory types should also check first
for the enabled kernel config option.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/errata/thead/errata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index a6f4bd8ccf3f..902e12452821 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -17,6 +17,9 @@
 static bool errata_probe_pbmt(unsigned int stage,
 			      unsigned long arch_id, unsigned long impid)
 {
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
+		return false;
+
 	if (arch_id != 0 || impid != 0)
 		return false;
 
-- 
2.35.1

