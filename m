Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3010659B470
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiHUO1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHUO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712461ADA5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BF8760EA0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3276EC433D7;
        Sun, 21 Aug 2022 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661092052;
        bh=w/PkrSzM/YSb7wa9LQoXCP3wB1H/7EbaPvzXWLdFQ+4=;
        h=From:To:Cc:Subject:Date:From;
        b=P4l2sSNSRd6fKLtyuxgZwmpLCFeiqXTLY9U4TL0OmoXNDrsHG8VL38AT2ZluD2vJB
         NNSWMuaqhAH37SPiydGhEUaxFg3JVs8RekJDNEx/h9ZIUNfhFB5etI0WQJJYQkCoZK
         bM/9xz6vyNEntdsT+ver8E+Xaudsb7vliVcdpIB6gqOUg2XFUDNb7B7lqJ3lmD7JB5
         Dg7Itif42nhm+IhpXPwJbrGoQ2NScayiwYBp15qlKVa5FyroK2ETTQaQ1oX3Eh3vsf
         AX7Ei1U9ofCYz1VImXqyZuZI1Mq10eJe/lCuG3KVdHF+gxTs7m9F89Aa7gz73VXzUE
         ywmHsn++m3hpA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: compat: s/failed/unsupported if compat mode isn't supported
Date:   Sun, 21 Aug 2022 22:18:19 +0800
Message-Id: <20220821141819.3804-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compat mode isn't supported(I believe this is the most case now),
kernel will emit somthing as:
[    0.050407] riscv: ELF compat mode failed

This msg may make users think there's something wrong with the kernel
itself, replace "failed" with "unsupported" to make it clear. In fact
this is the real compat_mode_supported meaning. After the patch, the
msg would be:
[    0.050407] riscv: ELF compat mode unsupported

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index ceb9ebab6558..b0c63e8e867e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -105,7 +105,7 @@ static int __init compat_mode_detect(void)
 	csr_write(CSR_STATUS, tmp);
 
 	pr_info("riscv: ELF compat mode %s",
-			compat_mode_supported ? "supported" : "failed");
+			compat_mode_supported ? "supported" : "unsupported");
 
 	return 0;
 }
-- 
2.34.1

