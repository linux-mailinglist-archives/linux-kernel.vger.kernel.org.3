Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650114C9CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiCBEqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiCBEqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:46:03 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7D4B12E1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:45:17 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 379B3100006;
        Wed,  2 Mar 2022 04:45:09 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net
Subject: [PATCH 11/12] powerpc: wiiu: don't enforce flat memory
Date:   Wed,  2 Mar 2022 15:44:05 +1100
Message-Id: <20220302044406.63401-12-ash@heyquark.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302044406.63401-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
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
index 3d690be48e84..59a84629d9a0 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -125,10 +125,10 @@ void __init MMU_init(void)
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
2.35.1

