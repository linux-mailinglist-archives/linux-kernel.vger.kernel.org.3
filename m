Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D087D5652BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiGDKs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiGDKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:48:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B68DEE4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R065WUthmqEzgKWBrKAm5cYHdmg6DG4yvVjf9aretus=; b=vIRAshX83ml6lhx5YzTLRFSdLx
        +/XlOOmPWFLIb8vohBG+auYtcUzx49+jp/UVKIKc1b+q+4TRRpi9MFRJpCp8ebYN0Et8QZHy7LUoH
        v1hXcq2aLAEcKEHtFD9x9Ef5CHAVH2Q/xVa6xKiTnDjCgzkZzLwcDj/HHblGh7e9Zzd3w9H59yu7V
        1g0If6WEv5JgyNbKNzfX/x5SJQ9Rw4eIwxjLa2zd7f3ryUfy/bm79K7eJfrnNg8MT58BGR8t7eQO1
        3YUW94KTxi/q/QYCE8C29s4V4ewUg75zmGTi7n0WCD3iTO3AnDRRcsG1rEyPkClQqvEvCvbxMvR77
        ty9vwmUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Jd9-00HBz8-Pt; Mon, 04 Jul 2022 10:48:39 +0000
Date:   Mon, 4 Jul 2022 11:48:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsLFh4naDbzGpDWB@casper.infradead.org>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
 <YsIQKdYiswzq5kTG@casper.infradead.org>
 <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 05:32:33AM +0100, Russell King (Oracle) wrote:
> On Sun, Jul 03, 2022 at 10:54:49PM +0100, Matthew Wilcox wrote:
> > On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> > > On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > This is the number of bits used by a PMD entry, not the order of a PMD.
> > > 
> > > No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> > > This is even more confusing.
> > 
> > Well, what is it then?  The order of something is PAGE_SIZE << n, and
> > that doesn't seem to be what this is.
> 
> Where is it defined that "order" means "PAGE_SIZE << n" ?

include/asm-generic/getorder.h: * get_order - Determine the allocation order of a memory size

> "order" here is "order of magnitude" and in this case, it is 2^n, just
> like order of magnitude in base 10 is 10^n. So strictly, the usage
> here is completely correct, but if you describe "order" as "PAGE_SIZE <<
> n" that is no longer an order of magnitude, because it doesn't increase
> in an order of magnitude (iow, n = 2 isn't PAGE_SIZE * PAGE_SIZE).
> 
> Now, if you're trying to tell me that Linux has decided to define
> "order" to be something non-standard, I'll accept that, but then we
> shouldn't be renaming stuff that is using it in a standard way.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
