Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA4575BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiGOGgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGOGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:36:16 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9942AC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:36:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJO5cNB_1657866966;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJO5cNB_1657866966)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 14:36:07 +0800
Date:   Fri, 15 Jul 2022 14:36:05 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 04/16] erofs: introduce bufvec to store decompressed
 buffers
Message-ID: <YtEK1UcH8wcUjpAc@B-P7TQMD6M-0146.local>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
 <20220714132051.46012-5-hsiangkao@linux.alibaba.com>
 <20220715142930.00001cdd.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220715142930.00001cdd.zbestahu@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Fri, Jul 15, 2022 at 02:29:30PM +0800, Yue Hu wrote:
> On Thu, 14 Jul 2022 21:20:39 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > For each pcluster, the total compressed buffers are determined in
> > advance, yet the number of decompressed buffers actually vary.  Too
> > many decompressed pages can be recorded if one pcluster is highly
> > compressed or its pcluster size is large.  That takes extra memory
> > footprints compared to uncompressed filesystems, especially a lot of
> > I/O in flight on low-ended devices.
> > 
> > Therefore, similar to inplace I/O, pagevec was introduced to reuse
> > page cache to store these pointers in the time-sharing way since
> > these pages are actually unused before decompressing.
> > 
> > In order to make it more flexable, a cleaner bufvec is used to
> > replace the old pagevec stuffs so that
> > 
> >  - Decompressed offsets can be stored inline, thus it can be used
> >    for the upcoming feature like compressed data deduplication;
> > 
> >  - Towards supporting large folios for compressed inodes since
> >    our final goal is to completely avoid page->private but use
> >    folio->private only for all page cache pages.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/zdata.c | 177 +++++++++++++++++++++++++++++++++++------------
> >  fs/erofs/zdata.h |  26 +++++--
> >  2 files changed, 153 insertions(+), 50 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index c183cd0bc42b..f52c54058f31 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -2,6 +2,7 @@
> >  /*
> >   * Copyright (C) 2018 HUAWEI, Inc.
> >   *             https://www.huawei.com/
> > + * Copyright (C) 2022 Alibaba Cloud
> >   */
> >  #include "zdata.h"
> >  #include "compress.h"
> > @@ -26,6 +27,82 @@ static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
> >  	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
> >  };
> >  
> > +struct z_erofs_bvec_iter {
> > +	struct page *bvpage;
> > +	struct z_erofs_bvset *bvset;
> > +	unsigned int nr, cur;
> > +};
> > +
> > +static struct page *z_erofs_bvec_iter_end(struct z_erofs_bvec_iter *iter)
> > +{
> > +	if (iter->bvpage)
> > +		kunmap_local(iter->bvset);
> > +	return iter->bvpage;
> > +}
> > +
> > +static struct page *z_erofs_bvset_flip(struct z_erofs_bvec_iter *iter)
> > +{
> > +	unsigned long base = (unsigned long)((struct z_erofs_bvset *)0)->bvec;
> > +	/* have to access nextpage in advance, otherwise it will be unmapped */
> > +	struct page *nextpage = iter->bvset->nextpage;
> > +	struct page *oldpage;
> > +
> > +	DBG_BUGON(!nextpage);
> > +	oldpage = z_erofs_bvec_iter_end(iter);
> > +	iter->bvpage = nextpage;
> > +	iter->bvset = kmap_local_page(nextpage);
> > +	iter->nr = (PAGE_SIZE - base) / sizeof(struct z_erofs_bvec);
> > +	iter->cur = 0;
> > +	return oldpage;
> > +}
> > +
> > +static void z_erofs_bvec_iter_begin(struct z_erofs_bvec_iter *iter,
> > +				    struct z_erofs_bvset_inline *bvset,
> > +				    unsigned int bootstrap_nr,
> > +				    unsigned int cur)
> > +{
> > +	*iter = (struct z_erofs_bvec_iter) {
> > +		.nr = bootstrap_nr,
> > +		.bvset = (struct z_erofs_bvset *)bvset,
> > +	};
> > +
> > +	while (cur > iter->nr) {
> > +		cur -= iter->nr;
> > +		z_erofs_bvset_flip(iter);
> > +	}
> > +	iter->cur = cur;
> > +}
> > +
> > +static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
> > +				struct z_erofs_bvec *bvec,
> > +				struct page **candidate_bvpage)
> > +{
> > +	if (iter->cur == iter->nr) {
> > +		if (!*candidate_bvpage)
> > +			return -EAGAIN;
> > +
> > +		DBG_BUGON(iter->bvset->nextpage);
> > +		iter->bvset->nextpage = *candidate_bvpage;
> > +		z_erofs_bvset_flip(iter);
> > +
> > +		iter->bvset->nextpage = NULL;
> > +		*candidate_bvpage = NULL;
> > +	}
> > +	iter->bvset->bvec[iter->cur++] = *bvec;
> > +	return 0;
> > +}
> > +
> > +static void z_erofs_bvec_dequeue(struct z_erofs_bvec_iter *iter,
> > +				 struct z_erofs_bvec *bvec,
> > +				 struct page **old_bvpage)
> > +{
> > +	if (iter->cur == iter->nr)
> > +		*old_bvpage = z_erofs_bvset_flip(iter);
> > +	else
> > +		*old_bvpage = NULL;
> > +	*bvec = iter->bvset->bvec[iter->cur++];
> > +}
> > +
> 
> Touch a new file to include bufvec related code? call it zbvec.c/h?

Thanks for the suggestion. The new implementation is simple enough,
so I tend to directly leave it in zdata.c instead of making more
churn to add more new files and zpvec.h will be completely removed
in the following patch.

Thanks,
Gao Xiang

