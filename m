Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F91483ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiADJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:05:59 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41396 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbiADJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:05:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0u6ZRm_1641287154;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0u6ZRm_1641287154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 17:05:55 +0800
Date:   Tue, 4 Jan 2022 17:05:53 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
Subject: Re: [PATCH v2 1/5] erofs: introduce meta buffer operations
Message-ID: <YdQN8Q4UsLgZVR+c@B-P7TQMD6M-0146.local>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-2-hsiangkao@linux.alibaba.com>
 <6fbbd94a-7c68-6798-4248-d9c0807bd89d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fbbd94a-7c68-6798-4248-d9c0807bd89d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Tue, Jan 04, 2022 at 03:54:08PM +0800, Chao Yu wrote:
> On 2022/1/2 12:00, Gao Xiang wrote:
> > In order to support subpage and folio for all uncompressed files,
> > introduce meta buffer descriptors, which can be effectively stored
> > on stack, in place of meta page operations.
> > 
> > This converts the uncompressed data path to meta buffers.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   fs/erofs/data.c     | 97 +++++++++++++++++++++++++++++++++++----------
> >   fs/erofs/internal.h | 13 ++++++
> >   2 files changed, 89 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > index 4f98c76ec043..6495e16a50a9 100644
> > --- a/fs/erofs/data.c
> > +++ b/fs/erofs/data.c
> > @@ -22,6 +22,56 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
> >   	return page;
> >   }
> > +void erofs_unmap_metabuf(struct erofs_buf *buf)
> > +{
> > +	if (buf->kmap_type == EROFS_KMAP)
> > +		kunmap(buf->page);
> > +	else if (buf->kmap_type == EROFS_KMAP_ATOMIC)
> > +		kunmap_atomic(buf->base);
> 
> Once user calls this function, .base should be invalidated.
> 
> buf->base = NULL;

Thanks for your suggestion!

Since buf->kmap_type will be switched to EROFS_NO_KMAP, so buf->base
is completely ignored (IOWs, it's unnecessary to reset buf->base..),
however I'm fine to set buf->base = NULL here either.

Thanks,
Gao Xiang 

> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
