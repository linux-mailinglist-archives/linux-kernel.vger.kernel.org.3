Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5154ECB37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349638AbiC3SDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349592AbiC3SDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:03:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C772195
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8sQ6SQCM7+eekKWwRavWR33/gb8wY09eRtrYpsnuNfQ=; b=yUXTtYD7LDJ8eYXzNSyyQftYQp
        S3O3C63uKLospuC5Mh4AL7JUStHkfwaRMljYo1yNjIR4OiIFD0WCK6jyi4GeT6zDxpQJ1+vdcHAMr
        Q9GQ8fNuoqDTs+qyoLgpt5fZSxYSIBkGtonuYlUG6ikqvFlpI2GChXbsKYHjI4IF/xYbqm+ndyIMd
        ZT3PM5Bm0h4mo51aGi0q6qMUxCjahNmfVAewOXBnIkSgPBXAUY3oAv4hW8yl+qZwlGs/YmUtbLjqG
        wX+ok7SDr/YclbDU4s+KHcUp+FpF2CmEH5tEZs9x1mHwaVvFaNUhDxmbduA7BR2uyfpRiyCw7IYfk
        eQNcXaFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZcdJ-00H3zL-To; Wed, 30 Mar 2022 18:01:25 +0000
Date:   Wed, 30 Mar 2022 11:01:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Christoph Hellwig <hch@infradead.org>, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
Message-ID: <YkSa9d3JOExAiBXU@infradead.org>
References: <1648659326.eabkokyuym.none.ref@localhost>
 <1648659326.eabkokyuym.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648659326.eabkokyuym.none@localhost>
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

Can you try this patch, which is a bit of a hack?

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66c..61997c2ee0a17 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -28,7 +28,8 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) &&
+	    !get_dma_ops(dev)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
