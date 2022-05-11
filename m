Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C77522C30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiEKGWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEKGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:22:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A098C5DA1;
        Tue, 10 May 2022 23:22:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F317F68BEB; Wed, 11 May 2022 08:22:32 +0200 (CEST)
Date:   Wed, 11 May 2022 08:22:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Conor.Dooley@microchip.com
Cc:     hch@lst.de, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: linux-next: Tree for May 3
Message-ID: <20220511062232.GA32524@lst.de>
References: <20220503172926.08215c77@canb.auug.org.au> <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com> <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com> <20220509141122.GA14555@lst.de> <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com> <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try this patch?

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e2ef0864eb1e5..856179f27f608 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -234,7 +234,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs = default_nslabs;
-	size_t alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
+	size_t alloc_size;
 	size_t bytes;
 	void *tlb;
 
@@ -267,12 +267,13 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		goto retry;
 	}
 
+	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
 	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
 	if (!mem->slots)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	swiotlb_init_io_tlb_mem(mem, __pa(tlb), default_nslabs, false);
+	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
 	mem->force_bounce = flags & SWIOTLB_FORCE;
 
 	if (flags & SWIOTLB_VERBOSE)
