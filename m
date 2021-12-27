Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7427647F9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 03:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhL0CVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 21:21:51 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45942 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhL0CVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 21:21:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V.p-vQR_1640571707;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V.p-vQR_1640571707)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 10:21:48 +0800
Date:   Mon, 27 Dec 2021 10:21:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>
Subject: Re: [PATCH v3 1/5] erofs: tidy up z_erofs_lz4_decompress
Message-ID: <YckjO1lSbaB6Ixze@B-P7TQMD6M-0146.local>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-2-hsiangkao@linux.alibaba.com>
 <c3fd4833-2483-f77e-fb79-42871e2d4219@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3fd4833-2483-f77e-fb79-42871e2d4219@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Dec 27, 2021 at 10:08:54AM +0800, Chao Yu wrote:
> On 2021/12/25 15:06, Gao Xiang wrote:
> > To prepare for the upcoming ztailpacking feature and further
> > cleanups, introduce a unique z_erofs_lz4_decompress_ctx to keep
> > the context, including inpages, outpages and oend, which are
> > frequently used by the lz4 decompressor.
> > 
> > No logic changes.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   fs/erofs/decompressor.c | 80 +++++++++++++++++++++--------------------
> >   1 file changed, 41 insertions(+), 39 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index c373a199c407..d1282a8b709e 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -16,6 +16,11 @@
> >   #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
> >   #endif
> > +struct z_erofs_lz4_decompress_ctx {
> > +	struct z_erofs_decompress_req *rq;
> > +	unsigned int inpages, outpages, oend;
> > +};
> > +
> 
> Could you please comment a bit about fields of structure
> z_erofs_lz4_decompress_ctx?
> 

Many thanks for the comment! I will revise it in the next version.

Thanks,
Gao Xiang

> Otherwise, the patch looks good to me.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
