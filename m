Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1E53F581
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiFGF2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiFGF17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:27:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47EB4BB9E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 22:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v5EnYcovArD4OSt7S5RJFQjxE1fmtrYeexg0Oh7zsXA=; b=kMjbbyOtHNOK46H1tp7iathRaX
        7BebtK0+f2fli7C4RkLW81saetKvQz/q2G+U7nT6NcV6GhBAJDa/N1teXU1oXlFNRh+RlrzwOZcYG
        vot4cNE1mSL+6UpbjU8PCoae+O4u1V96s8/Vqjl5WheoAcXtoKVcSZ5jj28OCiw2o7N7bZIMqkmUc
        hyR66NtxdcKqEaMB2jAqBAThxBPgVO3KUZuoT5Vc13NhHHDCG4fdqJxaHulIEnVr8euxDhB3fcOXW
        7lNRoJ8AAQ2EJKvVLuzdOoHrrbXA8HSNSQkdjmiq7ClUd3bhbtODzeD9USbdXaXzSWyNhRgthaB9d
        Wc0HI3Yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyRkm-004paF-G9; Tue, 07 Jun 2022 05:27:44 +0000
Date:   Mon, 6 Jun 2022 22:27:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, urezki@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: ioremap: rename ioremap_page_range() to
 ioremap_range()
Message-ID: <Yp7h0Jv6vpgt6xdZ@infradead.org>
References: <20220606083909.363350-1-bhe@redhat.com>
 <20220606083909.363350-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606083909.363350-6-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:39:09PM +0800, Baoquan He wrote:
> Because the current ioremap_page_range() only maps IO address to kernel
> virtual address, no struct page pointer passed in or page handling related.
> So rename it here.
> 
> The renaming is done with below command:
> sed -i "s/ioremap_page_range/ioremap_range/g" `git grep -l ioremap_page_range`

This creates a lot of churn without much of a benefit.  If you want
to get rid of the name please convert most architectures to the
generioc ioremap code first so that all these callers go away..

