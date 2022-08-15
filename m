Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6A592F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbiHONFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiHONF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:05:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2381146D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0O1sf920eUihvgTY7T5XThUehKdDUHn2aHkaf8kBbAc=; b=U5+YgxZRQJLUsZVFGa8jpjISiZ
        KXqYNcUc1MqF7NtePqt0KqehSGtnJdqqCaFozy4CIyCEG6PLW/qQes26YDnOMVQ7G9mxk7meBbkX+
        Ad4seMTumPH4iTpcmCefpeyUQ+qVxQhzFYz/j/t9etjlPQjX5JQ03IYKDb2gYC5TPlN48pYtMGiAi
        soblL2ptmaA4v/24nrXFZArqKunBh0PexOXZh4iM240WD+YmP+Ce97qrjFhtFx11cqXGzPFW2txRB
        AS7yxj+/PzcEzLVuX8SetJ1HDhR6MhalKy1VrMxU6zfk33PbOSVI24Vt/vat1p2DbSX83vhstHv3Y
        W6LzNG8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNZmT-005jhz-Cz; Mon, 15 Aug 2022 13:05:21 +0000
Date:   Mon, 15 Aug 2022 14:05:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds
 limit (1024) in 'ntfs_read_folio'
Message-ID: <YvpEkYMatTeNvNZa@casper.infradead.org>
References: <202208140835.W6F1j6Da-lkp@intel.com>
 <Yvo8KUKJBlMtoNgI@casper.infradead.org>
 <CAK8P3a3Gx39P90k9ZUMdzHiNpjNn1tdvkTktQyzUqqfG+an4BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Gx39P90k9ZUMdzHiNpjNn1tdvkTktQyzUqqfG+an4BA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:56:11PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 15, 2022 at 2:29 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Aug 14, 2022 at 08:21:36AM +0800, kernel test robot wrote:
> > > Hi Matthew,
> > >
> > > FYI, the error/warning still remains.
> >
> > FYI, this is still not interesting.
> > This is a hexagon 256kB PAGE_SIZE config, and so the amount of stack
> > space is correspondingly larger.  The frame size warning should be
> > increased to allow for this.
> >
> > > >> fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]
> 
> I don't think we should change the frame size warning for this, there is not
> generally any correlation between page size and stack usage, so that would
> just hide bugs elsewhere.

In this specific case, there is.  It's a stack allocation of an array
that depends on the number of 512-byte blocks per page.  With 4k pages,
that's only 8.  With 256k pages, that's 512.  With an 8-byte pointer,
that's a 4kB allocation, and even with a 4-byte pointer, that's a 2kB
stack allocation, which is still going to blow the prescribed stack
limit.

This is not unique to NTFS!  An NTFS-specific "fix" is inappropriate.
It's just that nobody's paying attention to the warnings coming from
fs/buffer.c:

include/linux/buffer_head.h:#define MAX_BUF_PER_PAGE (PAGE_SIZE / 512)

int block_read_full_folio(struct folio *folio, get_block_t *get_block)
{
...
        struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];

I don't know why I'm not getting a nastygram about that one, but it's
all bufferhead based filesystems.

> NTFS has had problems with stack usage on 64K+ pages before, the last
> time we addressed this using 4eec7faf6775 ("fs: ntfs: Limit NTFS_RW to
> page sizes smaller than 64k"), but it looks like this time it affects both
> write and read support.

The reasoning there is faulty.  If you have a 64k (or 256k) page size,
your stack is correspondingly huge and can handle these kinds of
allocations.
