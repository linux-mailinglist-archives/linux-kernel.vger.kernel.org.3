Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6699C55E4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbiF1Ndu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbiF1NdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:33:16 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C813E20;
        Tue, 28 Jun 2022 06:33:15 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 27199200014;
        Tue, 28 Jun 2022 13:33:07 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     krzysztof.kozlowski+dt@linaro.org, paulus@samba.org,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org,
        joel@jms.id.au
Subject: [PATCH v3 11/12] powerpc: wiiu: don't enforce flat memory
Date:   Tue, 28 Jun 2022 23:31:43 +1000
Message-Id: <20220628133144.142185-12-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628133144.142185-1-ash@heyquark.com>
References: <20220622131037.57604-1-ash@heyquark.com>
 <20220628133144.142185-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgtable_32.c:mapin_ram loops over each valid memory range, which means
non-contiguous memory just works.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/mm/init_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 693a3a7a9463..6cdb561c05c5 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -124,10 +124,10 @@ void __init MMU_init(void)
 	 * lowmem_end_addr is initialized below.
 	 */
 	if (memblock.memory.cnt > 1) {
-#ifndef CONFIG_WII
+#if !defined(CONFIG_WII) && !defined(CONFIG_WIIU)
 		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
 		pr_warn("Only using first contiguous memory region\n");
-#else
+#elif defined(CONFIG_WII)
 		wii_memory_fixups();
 #endif
 	}
-- 
2.36.1

