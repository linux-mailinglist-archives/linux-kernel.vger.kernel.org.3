Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E841455D4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiF0GPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiF0GPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:15:38 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D522AE8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:15:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VHTNMzH_1656310531;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VHTNMzH_1656310531)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 14:15:33 +0800
Date:   Mon, 27 Jun 2022 14:15:31 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>, Yuwen Chen <chenyuwen1@meizu.com>
Cc:     xiang@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Message-ID: <YrlLA5kDpprL0klA@B-P7TQMD6M-0146.local>
References: <20220625145000.2720-1-chenyuwen1@meizu.com>
 <20220627135754.00000999.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627135754.00000999.zbestahu@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:57:54PM +0800, Yue Hu wrote:
> On Sat, 25 Jun 2022 22:50:00 +0800
> Yuwen Chen <chenyuwen1@meizu.com> wrote:
> 

...

> > 
> > Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>
> > ---
> >  fs/erofs/decompressor_lzma.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> > index 05a3063cf2bc..5e59b3f523eb 100644
> > --- a/fs/erofs/decompressor_lzma.c
> > +++ b/fs/erofs/decompressor_lzma.c
> > @@ -143,6 +143,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
> >  	DBG_BUGON(z_erofs_lzma_head);
> >  	z_erofs_lzma_head = head;
> >  	spin_unlock(&z_erofs_lzma_lock);
> > +	wake_up_all(&z_erofs_lzma_wq);
> >  
> >  	z_erofs_lzma_max_dictsize = dict_size;
> >  	mutex_unlock(&lzma_resize_mutex);
> 
> Please do not end the summary line(title) with a period.

Okay, that is a good point, also it'd be better to de-capitalize the 'W'
in "Wake" since they are common practices for kernel patches.

If it's convenient to you to send another version, please go with my
r-v-b tag.

Thanks,
Gao Xiang
