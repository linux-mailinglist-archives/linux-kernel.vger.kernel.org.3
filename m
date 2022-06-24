Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A675596B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiFXJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiFXJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:31:45 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5BE3BF8C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:31:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hongnan.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VHGmWSp_1656063100;
Received: from 30.225.24.47(mailfrom:hongnan.li@linux.alibaba.com fp:SMTPD_---0VHGmWSp_1656063100)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 17:31:40 +0800
Message-ID: <2e708294-a2df-e775-4ea8-5b1fd0aa4544@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 17:31:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, linux-kernel@vger.kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
 <20220609034006.76649-1-hongnan.li@linux.alibaba.com>
 <0c139517-e976-5017-8e7a-d34c38f0f6bb@kernel.org>
 <70fe93a3-7af5-b563-dcb7-3f7be81348ed@linux.alibaba.com>
 <YrBl4CMZUiO6YqNM@B-P7TQMD6M-0146.local>
From:   hongnanLi <hongnan.li@linux.alibaba.com>
In-Reply-To: <YrBl4CMZUiO6YqNM@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gao Xiang,

on 2022/6/20 下午8:19, Gao Xiang wrote:
> Hi Hongnan,
> 
> On Mon, Jun 20, 2022 at 05:37:07PM +0800, hongnanLi wrote:
>> on 2022/6/19 8:19, Chao Yu wrote:
>>> On 2022/6/9 11:40, Hongnan Li wrote:
>>>> erofs_readdir update ctx->pos after filling a batch of dentries
>>>> and it may cause dir/files duplication for NFS readdirplus which
>>>> depends on ctx->pos to fill dir correctly. So update ctx->pos for
>>>> every emitted dirent in erofs_fill_dentries to fix it.
>>>>
>>>> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
>>>> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
>>>> ---
>>>>    fs/erofs/dir.c | 20 ++++++++++----------
>>>>    1 file changed, 10 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>>> index 18e59821c597..94ef5287237a 100644
>>>> --- a/fs/erofs/dir.c
>>>> +++ b/fs/erofs/dir.c
>>>> @@ -22,10 +22,9 @@ static void debug_one_dentry(unsigned char
>>>> d_type, const char *de_name,
>>>>    }
>>>>    static int erofs_fill_dentries(struct inode *dir, struct
>>>> dir_context *ctx,
>>>> -                   void *dentry_blk, unsigned int *ofs,
>>>> +                   void *dentry_blk, struct erofs_dirent *de,
>>>>                       unsigned int nameoff, unsigned int maxsize)
>>>>    {
>>>> -    struct erofs_dirent *de = dentry_blk + *ofs;
>>>>        const struct erofs_dirent *end = dentry_blk + nameoff;
>>>>        while (de < end) {
>>>> @@ -59,9 +58,8 @@ static int erofs_fill_dentries(struct inode *dir,
>>>> struct dir_context *ctx,
>>>>                /* stopped by some reason */
>>>>                return 1;
>>>>            ++de;
>>>> -        *ofs += sizeof(struct erofs_dirent);
>>>> +        ctx->pos += sizeof(struct erofs_dirent);
>>>>        }
>>>> -    *ofs = maxsize;
>>>>        return 0;
>>>>    }
>>>> @@ -95,7 +93,7 @@ static int erofs_readdir(struct file *f, struct
>>>> dir_context *ctx)
>>>>                      "invalid de[0].nameoff %u @ nid %llu",
>>>>                      nameoff, EROFS_I(dir)->nid);
>>>>                err = -EFSCORRUPTED;
>>>> -            goto skip_this;
>>>> +            break;
>>>>            }
>>>>            maxsize = min_t(unsigned int,
>>>> @@ -106,17 +104,19 @@ static int erofs_readdir(struct file *f,
>>>> struct dir_context *ctx)
>>>>                initial = false;
>>>>                ofs = roundup(ofs, sizeof(struct erofs_dirent));
>>>> -            if (ofs >= nameoff)
>>>> +            if (ofs >= nameoff) {
>>>> +                ctx->pos = blknr_to_addr(i) + ofs;
>>>>                    goto skip_this;
>>>> +            }
>>>>            }
>>>> -        err = erofs_fill_dentries(dir, ctx, de, &ofs,
>>>> -                      nameoff, maxsize);
>>>> -skip_this:
>>>>            ctx->pos = blknr_to_addr(i) + ofs;
>>>
>>> Why updating ctx->pos before erofs_fill_dentries()?
>>>
>>> Thanks,
>>
>> It’s to ensure the ctx->pos is correct and up to date in
>> erofs_fill_dentries() so that we can update ctx->pos instead of ofs for
>> every emitted dirent.
>>
> 
> How about this, since blknr_to_addr(i) + maxsize should be the start of
> the next dir block.
> 
> 	if (initial) {
> 		ofs = roundup(ofs, sizeof(struct erofs_dirent));
> 		ctx->pos = blknr_to_addr(i) + ofs;
> 		if (ofs >= nameoff)
> 			goto skip_this;
> 	}
> 	err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
> 				  nameoff, maxsize);
> 	if (err)
> 		break;
> 	ctx->pos = blknr_to_addr(i) + maxsize;
> 

Thanks for your suggestion. It looks good and works well in my test. I 
will send PATCH v3 later if everything else is okay.

Thanks,
Hongnan Li
