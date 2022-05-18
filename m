Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7E52BD03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiERNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiERNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:09:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F741FAF;
        Wed, 18 May 2022 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ju+39W+MjqK0PaJ3zrGj+hf6cLDd05VvDhYO8wadxW4=; b=lQyS21gGKOGmli7n7NsiTm9LSV
        4/6EjxnCsiP1GkaKgZ6zFQy4qB8VMuS2mMmR0/NsEZjxdUH/F3AOfCEyihO2oCGGl+B1sAXmcTMLL
        3bvcfP++pICulIArauX1aVTRcFI4kFB8ZvqlkTF02rlZhzcIu1zEOHgfCHiiL64mPk/uARPfD3FXI
        FHrfn5uQZ8DgJh76MSlY0EPHejJQZg/5dkbkk4BTqB1Slvbq9Mdu6Okejpe/yfnRvcX+2KvWMs1Hi
        t25/J1lSDPxKk8Pzs8hOciB8g6psEZlzdMqOzWqsg8Ge9g6QOhGopvf3tPHZGT96DApZN4jyrjGNX
        PHHBUxCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrJQi-002E94-A3; Wed, 18 May 2022 13:09:32 +0000
Date:   Wed, 18 May 2022 06:09:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, maz@kernel.org, axboe@kernel.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com,
        pavel@ucw.cz, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org,
        tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_svaddagi@quicinc.com,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: Re: [RFC 5/6] Hibernate: Add check for pte_valid in saveable page
Message-ID: <YoTwDOot4Ww9JhdS@infradead.org>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
 <1652860121-24092-6-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652860121-24092-6-git-send-email-quic_vivekuma@quicinc.com>
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

On Wed, May 18, 2022 at 01:18:40PM +0530, Vivek Kumar wrote:
> Add check for pte_valid in saveable page after being checked for
> the rest. This is required as PTE is removed for pages allocated
> with dma_alloc_coherent with DMA_ATTR_NO_KERNEL_MAPPING flag set.
> This patch makes sure that these pages are not considered for
> snapshot.

I don't think we ever remove kernel PTEs for DMA_ATTR_NO_KERNEL_MAPPING.
If the allocation did come from highmem they never had one to start
with.  The logic here looks a bit fishy to me.
