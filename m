Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD2F575CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiGOH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:59:23 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA120BDA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:59:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJOMovn_1657871957;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJOMovn_1657871957)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 15:59:19 +0800
Date:   Fri, 15 Jul 2022 15:59:17 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/16] erofs: switch compressed_pages[] to bufvec
Message-ID: <YtEeVR4V/N9m/WXO@B-P7TQMD6M-0146.local>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
 <20220714132051.46012-8-hsiangkao@linux.alibaba.com>
 <20220715155323.00005df4.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220715155323.00005df4.zbestahu@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 03:53:23PM +0800, Yue Hu wrote:
> On Thu, 14 Jul 2022 21:20:42 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Convert compressed_pages[] to bufvec in order to avoid using
> > page->private to keep onlinepage_index (decompressed offset)
> > for inplace I/O pages.
> > 
> > In the future, we only rely on folio->private to keep a countdown
> > to unlock folios and set folio_uptodate.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/zdata.c | 113 +++++++++++++++++++++++------------------------
> >  fs/erofs/zdata.h |   4 +-
> >  2 files changed, 57 insertions(+), 60 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 757d352bc2c7..f2e3f07baad7 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -134,7 +134,7 @@ static int z_erofs_create_pcluster_pool(void)
> >  
> >  	for (pcs = pcluster_pool;
> >  	     pcs < pcluster_pool + ARRAY_SIZE(pcluster_pool); ++pcs) {
> > -		size = struct_size(a, compressed_pages, pcs->maxpages);
> > +		size = struct_size(a, compressed_bvecs, pcs->maxpages);
> >  
> >  		sprintf(pcs->name, "erofs_pcluster-%u", pcs->maxpages);
> >  		pcs->slab = kmem_cache_create(pcs->name, size, 0,
> > @@ -287,16 +287,16 @@ struct z_erofs_decompress_frontend {
> >  
> >  	struct page *candidate_bvpage;
> >  	struct z_erofs_pcluster *pcl, *tailpcl;
> > -	/* a pointer used to pick up inplace I/O pages */
> > -	struct page **icpage_ptr;
> >  	z_erofs_next_pcluster_t owned_head;
> > -
> >  	enum z_erofs_collectmode mode;
> >  
> >  	bool readahead;
> >  	/* used for applying cache strategy on the fly */
> >  	bool backmost;
> >  	erofs_off_t headoffset;
> > +
> > +	/* a pointer used to pick up inplace I/O pages */
> > +	unsigned int icur;
> 
> not a pointer?

Here `pointer' means a cursor or called sub-index.

Thanks,
Gao Xiang
