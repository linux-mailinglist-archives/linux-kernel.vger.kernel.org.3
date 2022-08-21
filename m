Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32D59B25C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiHUGy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUGyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:54:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228F1D30F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nQM4oPZzphwSDtvEtGpl2bA0fG0oLY3le8thgzAQhNg=; b=JkBhF3nreFwoDyib/sG7ENabdx
        k1OH4BrKOFhNgvArnk8jflKPqMmepsbcKLRKbrMOzyefREECHQ+Z9RpxfesTxBwS3scFav+XbbCYa
        ziJLi8YLh1xEG6QcZ4PLKiBgzVAOxFEF/+nanDmU0sXUaKtUXEl1NnGhjeeGJuhYmTjrkjQzbgn+Z
        CbTu5OsA+o3IgGYU86+2J+G1apP3lg7jZzOEbk0929IeKT8vS07hIZLVQes2frPFBQ+NOx++uyQNO
        Q0APSZhun1pSiXyU+dgbDyg51DWXm6UAwduXkwpKVHNhJNkHkErgRCGCyWDsFBqWnO6mRLelWjckL
        k6zX/QtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPerG-006zaX-KB; Sun, 21 Aug 2022 06:54:54 +0000
Date:   Sat, 20 Aug 2022 23:54:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Message-ID: <YwHWvjoZF1V4FSlW@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-3-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot);
> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);

It seems a bit odd to do this in two steps vs just doing the entire
change in the first patch.  Any good reason for that?
