Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DBC4B40DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiBNEdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:33:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiBNEdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:33:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77254F9DE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 20:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YWfsS/Ud5X+wEl1SN02/jV0RlU7lg5m7I8cMWVWhSiE=; b=eop54UwcxRz3PgsOYt+YcaCLBM
        NT/bbNNnh/rI05IyyMZA3rVtTb+XZmTTmwGc8Lu4y9vLBl709B/Mw9ZDVBkG890IZELyQfkF5WoAl
        FfFeTA/3qlMRMk64vj00rEZwoOF6fEfXjGScjE9n/VkiCTD/Jo8j3SyCmq+i2GYiye6OqPrARkJyL
        5bdOQO+9fp2xOjbHIWAmeJKKCmYpDHn6CuW8jXQZgk7D6YU3l8L+Esoi4cCPy6tQSs0pnc7/u5I7y
        XglOhALxCKML2dBOQAjcFjU432D/dwHZrBYy+1wxvMes16dshvd7G6bQ7qoNjGDURyqSik0dINyPF
        s4LVLlxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJT3P-00CYbm-Kh; Mon, 14 Feb 2022 04:33:35 +0000
Date:   Mon, 14 Feb 2022 04:33:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/75] MM folio patches for 5.18
Message-ID: <YgnbnzrWfHr7AC9s@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:57:37PM +0000, Matthew Wilcox (Oracle) wrote:
> Whole series availabke through git, and shortly in linux-next:
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
> or git://git.infradead.org/users/willy/pagecache.git for-next

I've just pushed out a new version to infradead.  I'll probably forget
a few things, but major differences:

 - Incorporate various fixes from others including:
   - Implement pmd_pfn() for various arches from Mike Rapoport
   - lru_to_folio() now a function from Christoph Hellwig
   - Change a unpin_user_page() call to gup_put_folio() from Mark Hemment
 - Use DEFINE_PAGE_VMA_WALK() and DEFINE_FOLIO_VMA_WALK() instead of the
   pvmw_set_page()/folio() calls that were in this patch set.
 - A new set of ten patches around invalidate_inode_page().  I'll send
   them out as a fresh patchset tomorrow.
 - Add various Reviewed-by trailers.
 - Updated to -rc4.

