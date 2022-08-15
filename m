Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9F593035
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiHONtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiHONtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:49:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFB422B2C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19466B80EBF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D0EC433D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660571340;
        bh=RXoSi/7YbiC+CPYE1PW8WmeBQ/QNMuQCpJzyi8cEeYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aiDVGgQwkR6FJOd4Lewb0NwL0nyT2R+rJA8z3RZm7rtgXkZTTLjT0vpyMi/ocQJ3W
         3hETtLv6HcmMrI8SjvI5GtTrZdUmpz2O/UXlKwDbp3bKDkwsNeh2rikwJywZ38/xHB
         7CKsJe3JHYdBeVpAMdKRyi99rctxhNt/DNjWcnsBph0el6rww+S/IKSVHluPuxPqh3
         CjgJy5Zm4KTz274/Mam2R0YKxe2oeqd2Qna61W+PliAiqnJz6/L72ml7ZGBTj+9Wsv
         qFgr5dGMdILfD2pxiZZTn4Capw0ENVHsB2eCJh45JbHf1qXpInfhH5P9T1Zx7qcDYd
         aGOQbnBfO7tkA==
Received: by mail-ed1-f51.google.com with SMTP id t5so9626959edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:49:00 -0700 (PDT)
X-Gm-Message-State: ACgBeo3WlxOZ/90jZ3n8SDx9q/VxMnM8ZuUUAeJuVumCEbrEERWYNQLr
        svsO080rHFiSPDR3pcG+xgONSSTv6mLr+bDj07I=
X-Google-Smtp-Source: AA6agR4dsQl443RF5VdPLcs7MwGq1b8CumhzXbapAVOlOuTPKUmEhmJHhP3Jui6aOXI8XLwMvXNqQskSysZjSiFJKv8=
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id
 v21-20020a056402349500b0043dd76ee9ffmr15010151edc.227.1660571339043; Mon, 15
 Aug 2022 06:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <202208140835.W6F1j6Da-lkp@intel.com> <Yvo8KUKJBlMtoNgI@casper.infradead.org>
 <CAK8P3a3Gx39P90k9ZUMdzHiNpjNn1tdvkTktQyzUqqfG+an4BA@mail.gmail.com> <YvpEkYMatTeNvNZa@casper.infradead.org>
In-Reply-To: <YvpEkYMatTeNvNZa@casper.infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Aug 2022 15:48:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3=XC4ez-zeGptQb_9NtX5rVfr8Qq80eGaEckzUzjAxzg@mail.gmail.com>
Message-ID: <CAK8P3a3=XC4ez-zeGptQb_9NtX5rVfr8Qq80eGaEckzUzjAxzg@mail.gmail.com>
Subject: Re: fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds
 limit (1024) in 'ntfs_read_folio'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 3:05 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Aug 15, 2022 at 02:56:11PM +0200, Arnd Bergmann wrote:
> > On Mon, Aug 15, 2022 at 2:29 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sun, Aug 14, 2022 at 08:21:36AM +0800, kernel test robot wrote:
> > > > Hi Matthew,
> > > >
> > > > FYI, the error/warning still remains.
> > >
> > > FYI, this is still not interesting.
> > > This is a hexagon 256kB PAGE_SIZE config, and so the amount of stack
> > > space is correspondingly larger.  The frame size warning should be
> > > increased to allow for this.
> > >
> > > > >> fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]
> >
> > I don't think we should change the frame size warning for this, there is not
> > generally any correlation between page size and stack usage, so that would
> > just hide bugs elsewhere.
>
> In this specific case, there is.  It's a stack allocation of an array
> that depends on the number of 512-byte blocks per page.  With 4k pages,
> that's only 8.  With 256k pages, that's 512.  With an 8-byte pointer,
> that's a 4kB allocation, and even with a 4-byte pointer, that's a 2kB
> stack allocation, which is still going to blow the prescribed stack
> limit.
>
> This is not unique to NTFS!  An NTFS-specific "fix" is inappropriate.
> It's just that nobody's paying attention to the warnings coming from
> fs/buffer.c:
>
> include/linux/buffer_head.h:#define MAX_BUF_PER_PAGE (PAGE_SIZE / 512)
>
> int block_read_full_folio(struct folio *folio, get_block_t *get_block)
> {
> ...
>         struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
>
> I don't know why I'm not getting a nastygram about that one, but it's
> all bufferhead based filesystems.

I can confirm I see this warning with 256KB pages, in block_read_full_folio()
and others:

fs/mpage.c:131:20: error: stack frame size (4200) exceeds limit (1024)
in 'do_mpage_readpage' [-Werror,-Wframe-larger-than]
fs/mpage.c:447:12: error: stack frame size (4336) exceeds limit (1024)
in '__mpage_writepage' [-Werror,-Wframe-larger-than]
fs/buffer.c:2254:5: error: stack frame size (2152) exceeds limit
(1024) in 'block_read_full_folio' [-Werror,-Wframe-larger-than]
fs/fat/dir.c:1133:5: error: stack frame size (2104) exceeds limit
(1024) in 'fat_alloc_new_dir' [-Werror,-Wframe-larger-than]
fs/fat/fatent.c:466:5: error: stack frame size (2216) exceeds limit
(1024) in 'fat_alloc_clusters' [-Werror,-Wframe-larger-than]
fs/fat/fatent.c:554:5: error: stack frame size (2168) exceeds limit
(1024) in 'fat_free_clusters' [-Werror,-Wframe-larger-than]
fs/fat/dir.c:1281:5: error: stack frame size (2232) exceeds limit
(1024) in 'fat_add_entries' [-Werror,-Wframe-larger-than]
fs/ntfs3/fsntfs.c:738:5: error: stack frame size (2112) exceeds limit
(1024) in 'ntfs_clear_mft_tail' [-Werror,-Wframe-larger-than]
fs/ext4/move_extent.c:252:1: error: stack frame size (2272) exceeds
limit (1024) in 'move_extent_per_page' [-Werror,-Wframe-larger-than]
fs/ext4/readpage.c:223:5: error: stack frame size (4280) exceeds limit
(1024) in 'ext4_mpage_readpages' [-Werror,-Wframe-larger-than]

I still think that raising the warning limit here is not appropriate, having
a 512 element array of pointers on the stack is just not appropriate anywhere
IMHO.

> > NTFS has had problems with stack usage on 64K+ pages before, the last
> > time we addressed this using 4eec7faf6775 ("fs: ntfs: Limit NTFS_RW to
> > page sizes smaller than 64k"), but it looks like this time it affects both
> > write and read support.
>
> The reasoning there is faulty.  If you have a 64k (or 256k) page size,
> your stack is correspondingly huge and can handle these kinds of
> allocations.

I think that is only the case for VMAP stacks, which require full pages,
but configurations without that use the "thread_stack" kmem_cache
for allocating stacks when THREAD_SIZE is smaller than PAGE_SIZE.

The THREAD_SIZE on Hexagon is 4KB, so do_mpage_readpage()
with 4200 bytes would immediately overflow that. Obviously 4KB stacks
are problematic already and only supported as options on sh and m68k
otherwise, but raising it to the usual 8KB would likely still cause the same
problem.

I have no problems with a patch removing support for 256KB pages if that
helps, as Hexagon is the only architecture to support this and there are close
to zero Linux users anway. This would leave only three warnings for 64KB
pages in allmodconfig:

fs/mpage.c:131:20: error: stack frame size (1128) exceeds limit (1024)
in 'do_mpage_readpage' [-Werror,-Wframe-larger-than]
fs/mpage.c:447:12: error: stack frame size (1264) exceeds limit (1024)
in '__mpage_writepage' [-Werror,-Wframe-larger-than]
fs/ext4/readpage.c:223:5: error: stack frame size (1208) exceeds limit
(1024) in 'ext4_mpage_readpages' [-Werror,-Wframe-larger-than]

        Arnd
