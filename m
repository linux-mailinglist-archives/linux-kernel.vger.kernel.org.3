Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138B54F0952
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357674AbiDCMYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDCMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:24:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC034B83
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4wMs/Nqcp6JMJCOeAiciegLddg5+RH3CPGP7YX3Zovw=; b=t6VkHZfztk9JHbAjpDWnjswvr+
        DQlqofEaMbXC8+ef1pzLpiR2Kr9HLG34IUMXMqL4bet3X/B2Tp/SaT5m0masgDsl7+gOAEa6jvFlz
        vqp2lPMVvCl8akXqtYRUGbtpzQ4ewqKmQpPmRzekBODslOZPZye0SudGYy/rBLdBKM35YEb1VLSAS
        tEvmBK/8lbDrFum4vF6lNnrxcq5KKCkzcp1HjGW9S66Pe77ZTqOgnLRtJQcBOC6cKtSD4B5byyQu9
        BOQiN1b6wwt/JBU+1rGzed0KZbu+1nTNcpsnImor+RflbwQAgg8QXSNiiyTTwYpWJwzUEOFI09Kj+
        YuvjAM7g==;
Received: from [2001:4bb8:184:7553:31f9:976f:c3b1:7920] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nazFq-00BLsM-1L; Sun, 03 Apr 2022 12:22:50 +0000
Date:   Sun, 3 Apr 2022 14:22:47 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] second round of dma-mapping updates for Linux 5.18
Message-ID: <YkmRl8McdwST4cII@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5efabdadcf4a5b9a37847ecc85ba71cf2eff0fcf:

  Merge tag 'devicetree-fixes-for-5.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2022-03-29 08:55:16 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-1

for you to fetch changes up to 4fe87e818ea492ade079cc01a31d088e445f8539:

  dma-mapping: move pgprot_decrypted out of dma_pgprot (2022-04-01 06:46:51 +0200)

----------------------------------------------------------------
second round of dma-mapping updates for 5.18

 - fix a regression in dma remap handling vs AMD memory encryption (me)
 - finally kill off the legacy PCI DMA API (Christophe JAILLET)

----------------------------------------------------------------
Christoph Hellwig (2):
      PCI/doc: cleanup references to the legacy PCI DMA API
      dma-mapping: move pgprot_decrypted out of dma_pgprot

Christophe JAILLET (1):
      PCI: Remove the deprecated "pci-dma-compat.h" API

 Documentation/PCI/pci.rst      |  14 ++---
 include/linux/pci-dma-compat.h | 129 -----------------------------------------
 include/linux/pci.h            |   3 +-
 kernel/dma/direct.c            |  10 +++-
 kernel/dma/mapping.c           |   2 -
 5 files changed, 16 insertions(+), 142 deletions(-)
 delete mode 100644 include/linux/pci-dma-compat.h
