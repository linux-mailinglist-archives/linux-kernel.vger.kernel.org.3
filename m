Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCEB4AB226
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiBFUq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 15:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiBFUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:46:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1578C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 12:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RNHB7IBpnhy7O1ocgj3YZzudmkDv9q8iWD+k6XTlaWc=; b=hNh9HJ5dK+tD2uA2GF/WMf94un
        fKwL9VA975Odmrk+HKicay0hWm3ntUy05vz/jSgsZjI5qj4Ri1lHVGdwWx7OlQ6Bg16K5ELGJqEy+
        UZieiwwTGcRDZsUMKp6mef7620Q2xlUfq1TsGiuc3Qo3jIACPqDtwuiTdlffhe4JcUyaT0os9HgUR
        3YwrvrXHSTgJNzt/Q5bzsPOnkAQGTuZfO7Utvclm7p9DZc2Gq4NMQOM7EJ81iOTervlPk4Nv3CqV1
        mEZJd6SkEc53Iwi0CQ+Jcy4UNeeWkMsj+xxDr8vHmO1n+xXnW3ixPtNVDrxaivbLkBXOrAqdwKdiK
        tEigfOog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGoQn-00Faff-UK; Sun, 06 Feb 2022 20:46:45 +0000
Date:   Sun, 6 Feb 2022 20:46:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/75] hexagon: Add pmd_pfn()
Message-ID: <YgAztSuYrKXZBgJx@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-42-willy@infradead.org>
 <YgAPtxN7WW222SFI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgAPtxN7WW222SFI@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 08:13:11PM +0200, Mike Rapoport wrote:
> On Fri, Feb 04, 2022 at 07:58:18PM +0000, Matthew Wilcox (Oracle) wrote:
> > I need to use this function in common code, so define it for hexagon.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  arch/hexagon/include/asm/pgtable.h | 3 ++-
> 
> Why hexagon out of all architectures?
> What about m68k, nios2, nds32 etc?

Presumably they don't support CONFIG_TRANSPARENT_HUGEPAGE.
This code isn't compiled when THP are disabled; at least I haven't
had a buildbot complaint for any other architectures.

> > +#define pmd_pfn(pmd)	(pmd_val(pmd) >> PAGE_SHIFT)
> 
> I'd put it in include/linux/pgtable.h inside #ifndef pmd_pfn

That's completely upside down.  pmd_pfn() should be defined by each
architecture (because generic code can't know anything about the format
of PMDs); if anything pmd_page() should be defined in linux/pgtable.h
in terms of pmd_pfn.

I'm not signing up to do that work as part of this series.  That seems
like a distraction.
