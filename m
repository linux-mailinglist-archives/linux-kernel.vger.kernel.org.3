Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4849DD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiA0I4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbiA0I4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:56:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E228C061747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D6AF61B1F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0387EC340EF;
        Thu, 27 Jan 2022 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643273789;
        bh=CdUM/xw3G6lznVQt3NFsLntFbhnkWNalr2oPO1cWbtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdeB0IOjH7cl+p7r/DVrnXMzWGpLTAqd7OeqfmR5lN0cQswaE9TQ6aDaVI3nQVMWG
         XoHl9bO+SG272yKyOFDqISU2IJw45i5Pq/n+j/ppeWnbAzxPVYRLz/NWmQpY4kSMvB
         xUEOdmh4J1oeda569iz0hqKGdwsogExt4lJCnta6F7gS2WpvPBTmm98TirE4gY4pV9
         ilrA1lVskayUfHi3CDPLv25yxIFGYn1H+WjpHtr3OmSeg6BB+NXpIg1xgEUBvsMt7R
         SbZATL97Cpcc10wh9AMIHkhf0kCazy/3u2l4zKjEo6pIl0BjvXau/bg5zp51XEUcwg
         bRq46RA7wqkFQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 3/3] EXPERIMENTAL: x86/module: use __GFP_UNMAPPED in module_alloc
Date:   Thu, 27 Jan 2022 10:56:08 +0200
Message-Id: <20220127085608.306306-4-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127085608.306306-1-rppt@kernel.org>
References: <20220127085608.306306-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The permissions of pages allocated by module_alloc() are frequently updated
using set_memory and set_direct_map APIs. Such permission changes cause
fragmentation of the direct map.

Since module_alloc() essentially wraps vmalloc(), the memory allocated by it
is mapped in the vmalloc area and it can be completely removed from the
direct map.

Use __GFP_UNMAPPED to utilize caching of unmapped pages done by the page
allocator.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 95fa745e310a..70aa6ec0cc16 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -75,7 +75,7 @@ void *module_alloc(unsigned long size)
 
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
 				    MODULES_VADDR + get_module_load_offset(),
-				    MODULES_END, gfp_mask,
+				    MODULES_END, gfp_mask | __GFP_UNMAPPED,
 				    PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 	if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
-- 
2.34.1

