Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9966B57DA09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiGVGKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVGKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:10:41 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A321EC6B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:10:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK4..rj_1658470235;
Received: from 30.227.66.15(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VK4..rj_1658470235)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 14:10:36 +0800
Message-ID: <528c0378-90c2-8bcd-032c-837fc82bb321@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 14:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] erofs: get rid of the leftover PAGE_SIZE in dir.c
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20220619150940.121005-1-hsiangkao@linux.alibaba.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220619150940.121005-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/22 11:09 PM, Gao Xiang wrote:
> Convert the last hardcoded PAGE_SIZEs of uncompressed cases.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..723f5223a4fa 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -90,7 +90,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  
>  		nameoff = le16_to_cpu(de->nameoff);
>  		if (nameoff < sizeof(struct erofs_dirent) ||
> -		    nameoff >= PAGE_SIZE) {
> +		    nameoff >= EROFS_BLKSIZ) {
>  			erofs_err(dir->i_sb,
>  				  "invalid de[0].nameoff %u @ nid %llu",
>  				  nameoff, EROFS_I(dir)->nid);
> @@ -99,7 +99,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  		}
>  
>  		maxsize = min_t(unsigned int,
> -				dirsize - ctx->pos + ofs, PAGE_SIZE);
> +				dirsize - ctx->pos + ofs, EROFS_BLKSIZ);
>  
>  		/* search dirents at the arbitrary position */
>  		if (initial) {

LGTM.

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jeffle
