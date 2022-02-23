Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0D4C1D07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiBWUUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbiBWUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:20:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53704D250;
        Wed, 23 Feb 2022 12:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q1W+354r1yFrfGm0Wpiyr0IKReRKDAIj1JkhtV8ApN4=; b=YGgXRvCbpk5F8XSat9aLJERqRt
        uvxU9fNLZ3tVFbO6wVVfcvs50nr3cf5H7gX2BPAxBcDUUy1FZ5x2mET5uqAl6wI899vPUdWM3dla0
        OlOJtzKg0dYs+GGKKJje/t6+2AiOMJj6k1clVh+rxEjldvYDMeuGL4JPCqX25k+7VtmqxwICsqfXE
        4HspiUas5cpLisu8rBSNd49ThEma/VF98fiC0cqT04g6/xxBcqbqBqUQKotrra0s5w7bocnrglF+b
        +G1YTZ8ssHi4kcsvoL9V8AQJXp2DegufRmkW0cAqrAJAvwHWSyxqDOZynmtng5x0cFRtW7O+HFEm7
        tJoV73Kg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMy6g-0046Ei-VH; Wed, 23 Feb 2022 20:19:26 +0000
Date:   Wed, 23 Feb 2022 20:19:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [mm/readahead]  a0b99df1aa: xfstests.xfs.421.fail
Message-ID: <YhaWzsnreHHbJcmp@casper.infradead.org>
References: <20220221080217.GB835@xsang-OptiPlex-9020>
 <YhOaJ4cZU/1MiNI2@casper.infradead.org>
 <20220221205529.GH59715@dread.disaster.area>
 <YhP/vPUcm4lUHzrg@casper.infradead.org>
 <20220221214355.GI59715@dread.disaster.area>
 <YhaSK5C9rGVD+7OQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhaSK5C9rGVD+7OQ@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:59:39PM +0000, Matthew Wilcox wrote:
> > > /mnt/scratch/test-420/file2:
> > >  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
> > >    0: [0..255]:        128..383          0 (128..383)         256 100000
> > >    1: [256..1023]:     hole                                   768
> > 
> > So this is the extent list for file2 after the reflink. Note the
> > hole at 128-512kB. The flags tell us the 128kB data extent is
> > shared. There are no unwritten extents at all.
> 
> My debugging indicates otherwise:
> 
> +++ b/fs/iomap/seek.c
> @@ -15,6 +15,7 @@ static loff_t iomap_seek_hole_iter(const struct iomap_iter *it
> er,
>  {
>         loff_t length = iomap_length(iter);
> 
> +printk("%s %ld %d:%lld,%lld\n", __func__, iter->inode->i_ino, iter->iomap.type, iter->iomap.length);
>         switch (iter->iomap.type) {
>         case IOMAP_UNWRITTEN:
>                 *hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
> @@ -61,6 +62,7 @@ static loff_t iomap_seek_data_iter(const struct iomap_iter *iter,
>  {
>         loff_t length = iomap_length(iter);
> 
> +printk("%s %ld %d:%lld,%lld\n", __func__, iter->inode->i_ino, iter->iomap.type, iter->iomap.length);
>         switch (iter->iomap.type) {
>         case IOMAP_HOLE:
>                 return length;
> 
> gives me output:
> 
> 00016 iomap_seek_hole_iter 68 2:131072,-131387284454392
> 00016 iomap_seek_hole_iter 68 0:393216,-131387284454392
> 00016 iomap_seek_data_iter 68 2:131072,-131387284454392
> 00016 iomap_seek_hole_iter 68 2:131072,-131387284454392
> 00016 iomap_seek_hole_iter 68 0:393216,-131387284454392
> 00016 iomap_seek_data_iter 68 0:393216,-131387284454392
> 00016 iomap_seek_hole_iter 69 2:131072,-131387284455352
> 00016 iomap_seek_hole_iter 69 3:393216,4503599627239424
> 00016 iomap_seek_data_iter 69 2:131072,-131387284455352
> 00016 iomap_seek_hole_iter 69 2:131072,-131387284455352
> 00016 iomap_seek_hole_iter 69 3:393216,4503599627239424

I forgot to print 'offset' first, so that's showing (type:len,garbage)
With that fixed, and a call to dump_page() in folio_seek_hole_data(),
I see:

00016 iomap_seek_hole_iter 69 3:131072,65536
00016 page:00000000f7f02915 refcount:18 mapcount:0 mapping:000000008692207c index:0x20 pfn:0x108750
00016 head:00000000f7f02915 order:4 compound_mapcount:0 compound_pincount:0
00016 aops:0xffffffff81c32a00 ino:45 dentry name:"file2"
00016 flags: 0x8000000000012014(uptodate|lru|private|head|zone=2)
00016 raw: 8000000000012014 ffffea000421e008 ffffea000421d008 ffff888103947520
00016 raw: 0000000000000020 ffff8881051cd2a0 00000012ffffffff 0000000000000000
00016 page dumped because: folio_seek_hole_data

(inode 69 decimal is 45 hex)

So I think this explains the output?  an order-4 page is 64kB, so it'll
report the entirety of 128kB-192kB as data.

