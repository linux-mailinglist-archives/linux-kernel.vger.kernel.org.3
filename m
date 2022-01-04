Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695B483EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiADJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:02:18 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:24739 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbiADJCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:02:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0us7pN_1641286921;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0us7pN_1641286921)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 17:02:02 +0800
Date:   Tue, 4 Jan 2022 17:02:00 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
Subject: Re: [PATCH v2 5/5] erofs: use meta buffers for zmap operations
Message-ID: <YdQNCJzQULVxC2QC@B-P7TQMD6M-0146.local>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-6-hsiangkao@linux.alibaba.com>
 <5ed798da-4f01-17d4-cba2-dda50728bd25@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ed798da-4f01-17d4-cba2-dda50728bd25@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Tue, Jan 04, 2022 at 04:15:05PM +0800, Chao Yu wrote:
> On 2022/1/2 12:00, Gao Xiang wrote:

...

> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -698,20 +698,18 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >   		goto err_out;
> >   	if (z_erofs_is_inline_pcluster(clt->pcl)) {
> > -		struct page *mpage;
> > +		void *mp;
> > -		mpage = erofs_get_meta_page(inode->i_sb,
> > -					    erofs_blknr(map->m_pa));
> > -		if (IS_ERR(mpage)) {
> > -			err = PTR_ERR(mpage);
> > +		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
> > +					erofs_blknr(map->m_pa), EROFS_NO_KMAP);
> > +		if (IS_ERR(mp)) {
> > +			err = PTR_ERR(mp);
> >   			erofs_err(inode->i_sb,
> >   				  "failed to get inline page, err %d", err);
> >   			goto err_out;
> >   		}
> > -		/* TODO: new subpage feature will get rid of it */
> > -		unlock_page(mpage);
> > -
> > -		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
> > +		get_page(fe->map.buf.page);
> 
> Comparing to previous implementation, it adds an extra reference on the page, why?

Thanks for the question. Previously, erofs_get_meta_page was called
independently without reusing zmap mpage, so the page refcount had no
relationship with zmap mpage.

However, now we reuse zmap metabuf instead(fe->map.buf), so an extra
page refcount is needed since zmap metabuf will be released at the end
of readpage or readahead...

Thanks,
Gao Xiang
