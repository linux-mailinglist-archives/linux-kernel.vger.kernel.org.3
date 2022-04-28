Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E7512A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbiD1DiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiD1DiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF97DAA7;
        Wed, 27 Apr 2022 20:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B7DA618FB;
        Thu, 28 Apr 2022 03:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC8C385AD;
        Thu, 28 Apr 2022 03:34:54 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, dalias@libc.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 1/4] m68knommu: use asm-generic/mmu.h for nommu setups
Date:   Thu, 28 Apr 2022 13:33:16 +1000
Message-Id: <20220428033319.239341-2-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428033319.239341-1-gerg@linux-m68k.org>
References: <20220428033319.239341-1-gerg@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nommu case defines its own local mm_context_t structure. There is
nothing special or different about the m68knommu version of this and it
can easily use the common asm-generic version.

Remove the local mmu_context struct and include the asm-generic version
instead. This will also make it easier to support ELF format executables
in the future (since the asm-generic version has support for this
already).

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/mmu.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/mmu.h b/arch/m68k/include/asm/mmu.h
index 5c15aacb1370..e00672425b00 100644
--- a/arch/m68k/include/asm/mmu.h
+++ b/arch/m68k/include/asm/mmu.h
@@ -6,9 +6,7 @@
 /* Default "unsigned long" context */
 typedef unsigned long mm_context_t;
 #else
-typedef struct {
-	unsigned long		end_brk;
-} mm_context_t;
+#include <asm-generic/mmu.h>
 #endif
 
 #endif
-- 
2.25.1

