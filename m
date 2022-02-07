Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAB4AB640
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbiBGHxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiBGHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:52:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9AC03E97A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=srMga+KqKmGEAG7aLx65DgSl9Dt8LohJT0QVZ5uH5Mc=; b=rtWTzQo+COGf+NByOtO1joMDYq
        GYLC09+6nU2u1CZg4enekJUJog/D9HPdidsxeUcYKGwrNJLJswzzlj6kGd7YSRWdpBJ3nZWXa5dKN
        EOS5AufpOMySf8XkfpaWNAFkKAnYQMAy7lOdkJ1W0gdGFqVOPFUX/Vq62H5MUXuI7oa/PDC7qF3YJ
        GcpqcukIvmtoeHStgEve9V7jg6xtSzxt1nloQmGpun9k9XyQWoFTOQ75+K7eeGmJgJwPcLmpo75m9
        ys0yqZS89axL+vX8a2QaDwQrZDioKDFLJ3ea9cHGs6ofmfHKBbNCBBr6mL1+g80co9niz1LEvJXTM
        RlIEhP1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyoU-009G0G-90; Mon, 07 Feb 2022 07:51:54 +0000
Date:   Sun, 6 Feb 2022 23:51:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/75] mm/vmscan: Turn page_check_dirty_writeback() into
 folio_check_dirty_writeback()
Message-ID: <YgDPmt0M1BZCCrFn@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-35-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-35-willy@infradead.org>
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

> -	mapping = page_mapping(page);
> +	mapping = folio_mapping(folio);
>  	if (mapping && mapping->a_ops->is_dirty_writeback)
> -		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
> +		mapping->a_ops->is_dirty_writeback(&folio->page, dirty, writeback);

This adds an overly long line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

