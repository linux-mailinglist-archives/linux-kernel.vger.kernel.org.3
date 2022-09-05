Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD05AD155
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbiIELLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbiIELKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:10:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506475A3D5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:10:45 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oV9zx-0005hc-Lt; Mon, 05 Sep 2022 13:10:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 3/5] riscv: use BIT() macros in t-head errata init
Date:   Mon,  5 Sep 2022 13:10:25 +0200
Message-Id: <20220905111027.2463297-4-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905111027.2463297-1-heiko@sntech.de>
References: <20220905111027.2463297-1-heiko@sntech.de>
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

Using the appropriate BIT macro makes the code better readable.

Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/errata/thead/errata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index bffa711aaf64..a6f4bd8ccf3f 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -49,10 +49,10 @@ static u32 thead_errata_probe(unsigned int stage,
 	u32 cpu_req_errata = 0;
 
 	if (errata_probe_pbmt(stage, archid, impid))
-		cpu_req_errata |= (1U << ERRATA_THEAD_PBMT);
+		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
 
 	if (errata_probe_cmo(stage, archid, impid))
-		cpu_req_errata |= (1U << ERRATA_THEAD_CMO);
+		cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
 
 	return cpu_req_errata;
 }
-- 
2.35.1

