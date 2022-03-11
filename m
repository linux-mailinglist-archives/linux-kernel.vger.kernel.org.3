Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4852F4D5C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiCKH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiCKH3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:29:36 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950B1B6E1F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:28:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V6t3gLV_1646983708;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V6t3gLV_1646983708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 15:28:30 +0800
Date:   Fri, 11 Mar 2022 15:28:28 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com,
        huyue2@coolpad.com
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Message-ID: <Yir6HNsdYFdLVwEN@B-P7TQMD6M-0146.local>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
 <20220311151232.00003619.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311151232.00003619.zbestahu@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 03:12:32PM +0800, Yue Hu wrote:
> On Fri, 11 Mar 2022 02:27:42 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Avoid the unnecessary tail recursion since it can be converted into
> > a loop directly in order to prevent potential stack overflow.
> > 
> > It's a pretty straightforward conversion.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 33 insertions(+), 34 deletions(-)
> > 
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index b4059b9c3bac..572f0b8151ba 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
> >  				   unsigned int lookback_distance)
> >  {
> >  	struct erofs_inode *const vi = EROFS_I(m->inode);
> > -	struct erofs_map_blocks *const map = m->map;
> >  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> > -	unsigned long lcn = m->lcn;
> > -	int err;
> >  
> > -	if (lcn < lookback_distance) {
> > -		erofs_err(m->inode->i_sb,
> > -			  "bogus lookback distance @ nid %llu", vi->nid);
> > -		DBG_BUGON(1);
> > -		return -EFSCORRUPTED;
> > -	}
> > +	while (m->lcn >= lookback_distance) {
> > +		unsigned long lcn = m->lcn - lookback_distance;
> > +		int err;
> 
> may better to declare variable 'lclusterbits' in loop just like 'err' usage?

I'm fine with either way. Ok, will post the next version later.

Thanks,
Gao Xiang
