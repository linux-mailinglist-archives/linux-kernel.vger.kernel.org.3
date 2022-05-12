Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6C52451A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350025AbiELFlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349998AbiELFlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:41:09 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3835548F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:41:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VCzPcW9_1652334062;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VCzPcW9_1652334062)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 13:41:04 +0800
Date:   Thu, 12 May 2022 13:41:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: scan devices from device table
Message-ID: <Ynyd7iTbE+NhnTmh@B-P7TQMD6M-0146.local>
References: <20220510093511.77473-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220510093511.77473-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 05:35:11PM +0800, Jeffle Xu wrote:
> When "-o device" mount option is not specified, scan the device table
> and instantiate the devices if there's any in the device table. In this
> case, the tag field of each device slot uniquely specifies a device.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h |   9 ++--
>  fs/erofs/super.c    | 102 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 72 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 1238ca104f09..1adde3a813b4 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -37,12 +37,9 @@
>  #define EROFS_SB_EXTSLOT_SIZE	16
>  
>  struct erofs_deviceslot {
> -	union {
> -		u8 uuid[16];		/* used for device manager later */
> -		u8 userdata[64];	/* digest(sha256), etc. */
> -	} u;
> -	__le32 blocks;			/* total fs blocks of this device */
> -	__le32 mapped_blkaddr;		/* map starting at mapped_blkaddr */
> +	u8 tag[64];		/* digest(sha256), etc. */
> +	__le32 blocks;		/* total fs blocks of this device */
> +	__le32 mapped_blkaddr;	/* map starting at mapped_blkaddr */
>  	u8 reserved[56];
>  };
>  #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4a623630e1c4..3f19c2031e69 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -219,7 +219,52 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
>  }
>  #endif
>  
> -static int erofs_init_devices(struct super_block *sb,
> +static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
> +			     struct erofs_device_info *dif, erofs_off_t *pos)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_deviceslot *dis;
> +	struct block_device *bdev;
> +	void *ptr;
> +	int ret;
> +
> +	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
> +	if (IS_ERR(ptr))
> +		return PTR_ERR(ptr);
> +	dis = ptr + erofs_blkoff(*pos);
> +
> +	if (!dif->path) {
> +		if (!dis->tag[0]) {
> +			erofs_err(sb, "Empty digest data (pos %llu)", *pos);

			erofs_err(sb, "empty tag @ pos %llu", *pos);
?

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
