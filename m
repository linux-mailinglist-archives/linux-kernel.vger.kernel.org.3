Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985EC4EA4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiC2CIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiC2CIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:08:18 -0400
X-Greylist: delayed 1817 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 19:06:34 PDT
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35552E9CF;
        Mon, 28 Mar 2022 19:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mY4De
        9R7rL76ko6BC33fB4XqBVBoP3XsFOBIbCmaZbE=; b=HJSpxhFilR7YNxGiBXm7Q
        IEEqbbtD58NG//LRSRA8CcSOn+l1GC/6SQqQaBcYo/qJ+EAMBq5TP/+Z6UPL0pFr
        hA9vme162OWfZb9/stWSxxlFpe3gmw9LuU/wSEK60oFA5N3NHgeCAxMuDKLPHKie
        lDOoOjZlKoHhryZRVD1m9I=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp8 (Coremail) with SMTP id NORpCgDn3h54YkJieyUrEg--.264S2;
        Tue, 29 Mar 2022 09:35:53 +0800 (CST)
From:   xiaolinkui2022@126.com
To:     tsbogend@alpha.franken.de, david@redhat.com, f.fainelli@gmail.com,
        akpm@linux-foundation.org, arnd@arndb.de, rppt@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaolinkui <xiaolinkui@kylinos.cn>
Subject: [PATCH] mips: Fix a compilation error.
Date:   Tue, 29 Mar 2022 09:35:38 +0800
Message-Id: <20220329013538.21275-1-xiaolinkui2022@126.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDn3h54YkJieyUrEg--.264S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UCw13AF1rJFW5urW5GFg_yoW5Jr1UpF
        1DJr1kKFZ8Wr45uFyfAa4v9FW3Ja1DGa90vFWUXr909Fn2qFy8Jrn2kryYvr1ktay0qa40
        krWfXw1qgr4Yvw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jQDGOUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: p0ld0z5lqn3xasqsjqqrswhudrp/1tbiaRrSb1pEFKnR7QAAsR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiaolinkui <xiaolinkui@kylinos.cn>

Commit 4d5b3bdc0ecb ("MIPS: Fix a warning for virt_to_page") will
trigger a compilation error as follows with kernel v5.17-rc8:
(CONFIG_RDMA_SIW=y)

In file included from ./arch/mips/include/asm/page.h:270,
                 from ./arch/mips/include/asm/io.h:29,
                 from ./arch/mips/include/asm/mmiowb.h:5,
                 from ./include/linux/spinlock.h:64,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/net.h:19,
                 from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
./arch/mips/include/asm/page.h:255:53: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
      |                                                     ^
./include/asm-generic/memory_model.h:18:41: note: in definition of macro ‘__pfn_to_page’
   18 | #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
      |                                         ^~~
./arch/mips/include/asm/page.h:255:31: note: in expansion of macro ‘PFN_DOWN’
  255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
      |                               ^~~~~~~~
./arch/mips/include/asm/page.h:256:41: note: in expansion of macro ‘virt_to_pfn’
  256 | #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
      |                                         ^~~~~~~~~~~
drivers/infiniband/sw/siw/siw_qp_tx.c:538:23: note: in expansion of macro ‘virt_to_page’
  538 |     page_array[seg] = virt_to_page(va & PAGE_MASK);
      |                       ^~~~~~~~~~~~

Fixes: 37d15948eb72 ("MIPS: page.h: Define virt_to_pfn()")
Fixes: 4d5b3bdc0ecb ("MIPS: Fix a warning for virt_to_page")
Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 arch/mips/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 96bc798c1ec1..0f986f4ad4f0 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -252,7 +252,7 @@ static inline int pfn_valid(unsigned long pfn)
 
 #endif
 
-#define virt_to_pfn(kaddr)   	PFN_DOWN(virt_to_phys((void *)(kaddr)))
+#define virt_to_pfn(kaddr)   	PFN_DOWN(__pa(kaddr))
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 
 extern bool __virt_addr_valid(const volatile void *kaddr);
-- 
2.17.1

