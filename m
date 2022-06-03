Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5E53CC50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245525AbiFCPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiFCPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:30:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A012608
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qkeHRBdl081MDBZtrAPApzGYGIh1KENS5YX5qLHLvrk=; b=nAsmKW3CDG6cFmCfkkE5LVu6HE
        FNJ9U5jlkN+wIaijymvGC3pX0hnBhsHJ1wfPHVw32iDumMlRuXvlAi5W+lHx3yVsd+hNqXFoWwoXm
        +jBL5bfqte7c7RmIRemY+lzkQj7DkB+tZGyhY0D4g2Se1aHVWhTzReUE1UrpqHLr29TZCffXmvSRI
        qXl7L/F0zAz0AkutWD/MlZ/W8YnGfLIhxxNrmr8XgrERhPXkWp4hENrBIHuDsI6wF7weQRKBB0Nw4
        c2tQOvsN1skTlRhOO1SMvh2OA7XP7yLPIzjj7mSuznEXbJTqaSZwgHWr/Ln5sFsNRhLAFXczR1Ifg
        CRPekc0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx9F3-007yWV-2u; Fri, 03 Jun 2022 15:29:37 +0000
Date:   Fri, 3 Jun 2022 16:29:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
Message-ID: <Ypoo4WrVx5/YvaXx@casper.infradead.org>
References: <20220601103922.1338320-1-hsinyi@chromium.org>
 <20220601103922.1338320-4-hsinyi@chromium.org>
 <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
 <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com>
 <YpoFnROxAwdSScuV@casper.infradead.org>
 <90b228ea-1b0e-d2e8-62be-9ad5802dcce7@samsung.com>
 <CAJMQK-jDwchHokDZw7k24rGdy7OeUmiVWUCfxBiu1E1dZwuy2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-jDwchHokDZw7k24rGdy7OeUmiVWUCfxBiu1E1dZwuy2Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 10:55:01PM +0800, Hsin-Yi Wang wrote:
> On Fri, Jun 3, 2022 at 10:10 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi Matthew,
> >
> > On 03.06.2022 14:59, Matthew Wilcox wrote:
> > > On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
> > >> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
> > >>> Implement readahead callback for squashfs. It will read datablocks
> > >>> which cover pages in readahead request. For a few cases it will
> > >>> not mark page as uptodate, including:
> > >>> - file end is 0.
> > >>> - zero filled blocks.
> > >>> - current batch of pages isn't in the same datablock or not enough in a
> > >>>     datablock.
> > >>> - decompressor error.
> > >>> Otherwise pages will be marked as uptodate. The unhandled pages will be
> > >>> updated by readpage later.
> > >>>
> > >>> Suggested-by: Matthew Wilcox <willy@infradead.org>
> > >>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > >>> Reported-by: Matthew Wilcox <willy@infradead.org>
> > >>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> > >>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> > >>> ---
> > >> This patch landed recently in linux-next as commit 95f7a26191de
> > >> ("squashfs: implement readahead"). I've noticed that it causes serious
> > >> issues on my test systems (various ARM 32bit and 64bit based boards).
> > >> The easiest way to observe is udev timeout 'waiting for /dev to be fully
> > >> populated' and prolonged booting time. I'm using squashfs for deploying
> > >> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
> > >> top of the next-20220603 fixes the issue.
> > > How large are these files?  Just a few kilobytes?
> >
> > Yes, they are small, most of them are smaller than 16KB, some about
> > 128KB and a few about 256KB. I've sent a detailed list in private mail.
> >
> 
> Hi Marek,
> 
> Are there any obvious squashfs errors in dmesg? Did you enable
> CONFIG_SQUASHFS_FILE_DIRECT or CONFIG_SQUASHFS_FILE_CACHE?

I don't think it's an error problem.  I think it's a short file problem.

As I understand the current code (and apologies for not keeping up
to date with how the patch is progressing), if the file is less than
msblk->block_size bytes, we'll leave all the pages as !uptodate, leaving
them to be brough uptodate by squashfs_read_folio().  So Marek is hitting
the worst case scenario where we re-read the entire block for each page
in it.  I think we have to handle this tail case in ->readahead().
