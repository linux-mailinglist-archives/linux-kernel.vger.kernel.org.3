Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2496489F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbiAJSqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiAJSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:46:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDDC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=H3KF2prjYBSwrnfLvzejhzHVkMgjeD7cUDDGRAfx4vA=; b=IjTRj51FE8xpAGBh+cH4TWcHvJ
        MG2wJzSHRW7gAwyqyfkfXu/m/zYZ36/rsok84KGSDXK4tGnSckzORdQ1zgYiq/HVtAw5nYzZw8DUy
        IRCXKirqM7NrzeqsyuhAa06TJJ2jci8Dpi8KFiYL264JB4bqvtCDKhF+0zn4jDOmw786KKHjUS4TT
        lF4mgOAiHXJLtxCu9Z8/CyJZJgEj/Jscz5tM8SG6VLdqIKswqVG4UVAUeZLezohknH6ceuHht7+aU
        7ZENsFD1jIkWeFLbo2NQcrFAM34IBeBJD/xoGZSPnoSjAs3bK+BmnZkQm+W8iQk/zp+h5VlWiLttq
        8CQC5sBw==;
Received: from [2001:4bb8:18c:6af6:7014:844b:d20b:2d30] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6zgC-00CqCn-Cb; Mon, 10 Jan 2022 18:46:04 +0000
Date:   Mon, 10 Jan 2022 19:46:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for Linux 5.17
Message-ID: <Ydx+6rmjq2giOC/b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17

for you to fetch changes up to f857acfc457ea63fa5b862d77f055665d863acfe:

  lib/scatterlist: cleanup macros into static inline functions (2021-12-22 09:21:43 +0100)

----------------------------------------------------------------
dma-mapping updates for Linux 5.17

 - refactor the dma-direct coherent allocator
 - turn an macro into an inline in scatterlist.h (Logan Gunthorpe)

----------------------------------------------------------------
Christoph Hellwig (11):
      dma-direct: factor out dma_set_{de,en}crypted helpers
      dma-direct: don't call dma_set_decrypted for remapped allocations
      dma-direct: always leak memory that can't be re-encrypted
      dma-direct: clean up the remapping checks in dma_direct_alloc
      dma-direct: factor out a helper for DMA_ATTR_NO_KERNEL_MAPPING allocations
      dma-direct: refactor the !coherent checks in dma_direct_alloc
      dma-direct: fail allocations that can't be made coherent
      dma-direct: warn if there is no pool for force unencrypted allocations
      dma-direct: drop two CONFIG_DMA_RESTRICTED_POOL conditionals
      dma-direct: factor the swiotlb code out of __dma_direct_alloc_pages
      dma-direct: add a dma_direct_use_pool helper

Logan Gunthorpe (1):
      lib/scatterlist: cleanup macros into static inline functions

 include/linux/scatterlist.h |  29 ++++--
 kernel/dma/direct.c         | 240 ++++++++++++++++++++++++++------------------
 2 files changed, 163 insertions(+), 106 deletions(-)
