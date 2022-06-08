Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B32542FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiFHMJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiFHMJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:09:16 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C241F4B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:09:12 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nyuUh-0006dy-Vz; Wed, 08 Jun 2022 14:09:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de,
        Heiko Stuebner <heiko@sntech.de>, Ron Economos <re@w6rz.net>
Subject: [PATCH] riscv: don't warn for sifive erratas in modules
Date:   Wed,  8 Jun 2022 14:08:49 +0200
Message-Id: <20220608120849.1695191-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
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

The SiFive errata code contains code checking applicable erratas
vs. actually applied erratas to suggest missing erratas to the
user when their Kconfig options are not enabled.

In the main kernel image one can be quite sure that all available
erratas appear at least once, so that check will succeed.
On the other hand modules can very well not use any errata-relevant
code, so the newly added module-alternative support may also patch
the module code, but not touch SiFive-specific erratas at all.

So to restore the original behaviour don't warn when patching
modules. This will keep the warning if necessary for the main kernel
image but prevent spurious warnings for modules.

Of course having such a vendor-specific warning may not be needed at
all, as CONFIG_ERRATA_SIFIVE is selected by CONFIG_SOC_SIFIVE and the
individual erratas are default-y so disabling them requires
deliberate action anyway. But for now just restore the old behaviour.

Fixes: a8e910168bba ("riscv: implement module alternatives")
Reported-by: Ron Economos <re@w6rz.net>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/errata/sifive/errata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 672f02b21ce0..1031038423e7 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -111,6 +111,7 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
 			cpu_apply_errata |= tmp;
 		}
 	}
-	if (cpu_apply_errata != cpu_req_errata)
+	if (stage != RISCV_ALTERNATIVES_MODULE &&
+	    cpu_apply_errata != cpu_req_errata)
 		warn_miss_errata(cpu_req_errata - cpu_apply_errata);
 }
-- 
2.35.1

