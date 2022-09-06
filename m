Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED265AE802
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiIFMZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiIFMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:23:27 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2BC819C18
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ABlJF
        eYOIQ1yMO4RgFSt8TOjiYFH1v4bYER/CMetTR8=; b=Lu6vgE9UhNP6WbYwomcKj
        K18e/JS0PdkV1sXt5seLfKV7ChMGqeig1pMxxOSPr6+3LeessyB9HibdL9s0mVkB
        ajf6Ax8BMAxz8EaKj79cBqOrXkpimagkeQglsNF0ApHsEjhGn0r1BZU9D4XGLLfO
        Q6SPsegjECfKTkx7wyflOQ=
Received: from whoami-VirtualBox.. (unknown [223.72.91.155])
        by smtp13 (Coremail) with SMTP id EcCowABn1lLLOhdjrfx8aQ--.20577S2;
        Tue, 06 Sep 2022 20:19:24 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        anup@brainfault.org, alexandre.ghiti@canonical.com,
        guoren@kernel.org, akpm@linux-foundation.org, heiko@sntech.de,
        tongtiangen@huawei.com, sunnanyong@huawei.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, tjytimi@163.com
Subject: [PATCH v1] riscv : support update_mmu_tlb() for riscv
Date:   Tue,  6 Sep 2022 20:19:21 +0800
Message-Id: <20220906121921.8355-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABn1lLLOhdjrfx8aQ--.20577S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF45JFW8XFyftFyfXrWrXwb_yoWfGrc_W3
        WxCw4vgryvqF4xua1DXF1fWr45K34rAF1DXrs2qa13tF98JanrJ3ykta15Jr4UuanIvF4I
        kr95GryFgFy2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREuWlUUUUUU==
X-Originating-IP: [223.72.91.155]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiTgx0eFUDRgjDigAAsf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro definition to support updata_mmu_tlb() for riscv,
this function is from commit:7df676974359 ("mm/memory.c:Update 
local TLB if PTE entry exists").

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ec936910a96..84a791d54f95 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -418,6 +418,9 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	local_flush_tlb_page(address);
 }
 
+#define	__HAVE_ARCH_UPDATE_MMU_TLB
+#define update_mmu_tlb	update_mmu_cache
+
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp)
 {
-- 
2.30.2

