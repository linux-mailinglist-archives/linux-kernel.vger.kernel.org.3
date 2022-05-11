Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1006D522C93
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiEKGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbiEKGsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:48:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C605AEDB;
        Tue, 10 May 2022 23:48:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91C3D68BFE; Wed, 11 May 2022 08:48:32 +0200 (CEST)
Date:   Wed, 11 May 2022 08:48:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Conor.Dooley@microchip.com
Cc:     hch@lst.de, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: linux-next: Tree for May 3
Message-ID: <20220511064832.GA761@lst.de>
References: <20220503172926.08215c77@canb.auug.org.au> <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com> <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com> <20220509141122.GA14555@lst.de> <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com> <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com> <20220511062232.GA32524@lst.de> <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 06:44:22AM +0000, Conor.Dooley@microchip.com wrote:
> On 11/05/2022 07:22, Christoph Hellwig wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Can you try this patch?
> 
> Hey Christoph, gave it a try but nfortunately, no joy!

Yes, while it is a real fix, the problem it fixes can only happen
with Xen, which is not relevant to riscv.  The only other thing I
can think off is that the allocations were always failing on your
board, and the patch makes that failure fatal.  For that try the
patch below.  I'd also be really curious by now about the kernel
logs from a successful boot.

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e2ef0864eb1e5..3e992a308c8a1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -254,8 +254,10 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		tlb = memblock_alloc(bytes, PAGE_SIZE);
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
-	if (!tlb)
-		panic("%s: failed to allocate tlb structure\n", __func__);
+	if (!tlb) {
+		pr_warn("%s: failed to allocate tlb structure\n", __func__);
+		return;
+	}
 
 	if (remap && remap(tlb, nslabs) < 0) {
 		memblock_free(tlb, PAGE_ALIGN(bytes));
