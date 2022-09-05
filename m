Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D285AD146
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiIELLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiIELKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:10:47 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7FC5A3E3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:10:45 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oV9zy-0005hc-23; Mon, 05 Sep 2022 13:10:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 4/5] riscv: use BIT() marco for cpufeature probing
Date:   Mon,  5 Sep 2022 13:10:26 +0200
Message-Id: <20220905111027.2463297-5-heiko@sntech.de>
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
---
 arch/riscv/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 729f7a218093..08f7445985dc 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -289,10 +289,10 @@ static u32 __init_or_module cpufeature_probe(unsigned int stage)
 	u32 cpu_req_feature = 0;
 
 	if (cpufeature_probe_svpbmt(stage))
-		cpu_req_feature |= (1U << CPUFEATURE_SVPBMT);
+		cpu_req_feature |= BIT(CPUFEATURE_SVPBMT);
 
 	if (cpufeature_probe_zicbom(stage))
-		cpu_req_feature |= (1U << CPUFEATURE_ZICBOM);
+		cpu_req_feature |= BIT(CPUFEATURE_ZICBOM);
 
 	return cpu_req_feature;
 }
-- 
2.35.1

