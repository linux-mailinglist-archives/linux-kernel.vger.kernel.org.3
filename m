Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240344E3F90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiCVNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiCVNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:30:37 -0400
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3104227CDA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:29:05 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 22MDT0Km001060
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:29:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1647955736; x=1650547736;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c2YIwja29O1WBS129ebO6CkccAwpqLVJQ1HQcp3TXN0=;
        b=EFoyRNR4AObZg/WhT450pv9k9/cyaQZXT0c/TCKa7WxdhcYAL0g87FiwAMhDRlKi
        gibP9NTTskZ/DXQN87gDte0mZ39qgtYPWjAxasfQWHBF5izs30Jh77tomqTNEE67
        uMsOy0Qu0GwyqXtCoDPORtpdaZ855ANoJ11+ovJ0AuTKsOFGYYZ1BeUBvyZxNqDy
        f4lY/kv45l8UuLlJgUjuiRK8kcjUbzGtIF4kEQbY31FeTo+//3N0dU4HD46tucS5
        ku2SV0SpMVBiJKoL6nSvTTOaFKV/ytGo6vZFosN+hgtxABArWKOlYsbhCxUN9zuL
        xhx6ff+32Ko8q3TVWZQbJw==;
X-AuditID: 8b5b014d-f0a8d700000035db-42-6239cf1827f6
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 68.A4.13787.81FC9326; Tue, 22 Mar 2022 15:28:56 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Date:   Tue, 22 Mar 2022 15:28:39 +0200
Message-Id: <20220322132839.3653682-1-mick@ics.forth.gr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42Lpjp6urCtx3jLJoPGvmMXW37PYLS7vmsNm
        se1zC5tF87tz7BYvL/cwW7TN4ndg83jz8iWLx+GOL+weDzddYvLYvKTe41LzdXaPz5vkAtii
        uGxSUnMyy1KL9O0SuDJmrDUsOChQMfX5D5YGxuu8XYycHBICJhJ9u9rZuhi5OIQEjjJKNF/a
        zQ6RcJO4fX8nK4jNJqApMf/SQRYQW0TAXWL15D9MIDazQL7Eti/nmEFsYQFPie27f4D1sgio
        SsxauYQRxOYVsJDYu/o/I8RMeYn9B88yQ8QFJU7OfMICMUdeonnrbOYJjDyzkKRmIUktYGRa
        xSiQWGasl5lcrJeWX1SSoZdetIkRHFyMvjsYb29+q3eIkYmD8RCjBAezkgjvv9/GSUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5Wa7JJAkJpCeWpGanphakFsFkmTg4pRqYuIPyDi+Y9UCNo/Hu
        uZPGlhda3acaf5UM3CZwpTfsfZnFvg+hFx1sVx7+N+Pay6CEuV3Sct/fN61a8L4ydQWbgHn9
        AcGz6hzC0bM5mYPe6Tzam3ni4j15OR82/gNGRy1Eup9Iz42O4clcEbp9hbFhuOG93kO6XafK
        d9kLydl+uugtdNy1P/hZmHxt2ISNmg9FmV1mev2NdZA68eWoZHjPu01/Nzl8XFckpPKrxiNC
        dSdf8Pob6+pl4kU2XpslPv+Pw7S0ebXr+e20zliyLvzwpjPxU/zX48/XtETyRy17FBG84Z+U
        iNKMCtuCWfP0Dttr9axcz3+6a42Y2dLF/7ftlE58fsroTk7ifa+Aw0G+SizFGYmGWsxFxYkA
        rj6lgJ0CAAA=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the DTB provided by the bootloader/BootROM is before the kernel
image or outside /memory, we won't be able to access it through the
linear mapping, and get a segfault on setup_arch(). Currently OpenSBI
relocates DTB but that's not always the case (e.g. if FW_JUMP_FDT_ADDR
is not specified), and it's also not the most portable approach since
the default FW_JUMP_FDT_ADDR of the generic platform relocates the DTB
at a specific offset that may not be available. To avoid this situation
copy DTB so that it's visible through the linear mapping.

Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/mm/init.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0d588032d..697a9aed4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -206,8 +206,25 @@ static void __init setup_bootmem(void)
 	 * early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
 	 */
-	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
-		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
+	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
+		/*
+		 * In case the DTB is not located in a memory region we won't
+		 * be able to locate it later on via the linear mapping and
+		 * get a segfault when accessing it via __va(dtb_early_pa).
+		 * To avoid this situation copy DTB to a memory region.
+		 * Note that memblock_phys_alloc will also reserve DTB region.
+		 */
+		if (!memblock_is_memory(dtb_early_pa)) {
+			size_t fdt_size = fdt_totalsize(dtb_early_va);
+			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
+			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
+
+			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
+			early_memunmap(new_dtb_early_va, fdt_size);
+			_dtb_early_pa = new_dtb_early_pa;
+		} else
+			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
+	}
 
 	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(dma32_phys_limit);
-- 
2.34.1

