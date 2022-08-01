Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59F586F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiHARPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiHARPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:15:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5287B55;
        Mon,  1 Aug 2022 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DTuwx+WR1szHjLCY8OmCUFj7bvBZBX0WY4Rg8q6o9uc=; b=O3DJPJ1tSTcI/qnCmd76PmNLod
        KGImLH6oL7xZO4K75pOZl+wJLsL/jarStRhxeZMyMK/3x61PhN5yNK+LSc19lTPN8iLv75AfHwbmV
        kXvnHrxBKWJ/OJUeMn8g4HYC/onIF+5jYFYU0G62tp+Fsz2SgK1ZBfptbKowFIfmH+BiNkpc7LVKA
        WM0IgXNdERQFKAuCh5/tjXMrfFWWvLWQnXh2UWUnAV3vLeT29QCqR8ksUf071Yf8KQ26ZVmUjHYuD
        toxMauXSSUhASTRskAa6myjgSqZmjQwLWyl0RlNRuh/9xPq2zLsJJdpKnEP6TEldi1VJNVuE7o9os
        HLXCSPXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIZ0T-008A2f-0N; Mon, 01 Aug 2022 17:15:05 +0000
Date:   Mon, 1 Aug 2022 10:15:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH 1/5] md/raid5: Refactor raid5_get_active_stripe()
Message-ID: <YugKGLvbnvSeJfRg@infradead.org>
References: <20220727210600.120221-1-logang@deltatee.com>
 <20220727210600.120221-2-logang@deltatee.com>
 <YuKZmloAcZWY5of8@infradead.org>
 <CAPhsuW4jtiuNPzC2aK-Jo80X15AWdYi7HQ2n7YWqVP6Uux3hYg@mail.gmail.com>
 <215E9FEF-69F9-44AB-A5B0-FD3C8335E985@deltatee.com>
 <CAPhsuW4r2nz3Q62Q9CpouHmy2JNwgJZsn=ZHT3q82DE6ddhXtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4r2nz3Q62Q9CpouHmy2JNwgJZsn=ZHT3q82DE6ddhXtA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 09:49:38AM -0700, Song Liu wrote:
> We are in the merge window right now. So the timing is a little tricky. I will
> try to send pull requests with this set as-is. Then we can do follow-ups.

I can send the patch.  I don't think it's anywhere near critical enought to
rush it into the current merge window, though.
