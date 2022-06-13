Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92D54A1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbiFMVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiFMVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:51:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD018B0B;
        Mon, 13 Jun 2022 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=1jnWbukvzBTl9kVUgY+6pa9UbKF7LTneuzMyv/jkkds=; b=Ssps8AdMySuil6oFIYoRGHv1Ij
        AdttMd34hfrO73iCNixRCsBonzsTFlFL3x5E7w9cgJs45EAYFsqvTTWDp5pnontodphj+JjRMBa26
        uwYfinabfBpAxe5eHOLTi2NS1cvAuc7U5oRDolD1GRBfeR48Vk5TCY3NfEct4KurEi0PobxFfSDCV
        kLTdZOVLTk6F/o4/KIlifWYPDjNURVSusR8yFV27bUgwe+BQekrFqvD2yJWCzvwqsLRPcne6lmNPa
        Gbp+DKAIAhqtdSdkjLvLxuTqzFj4EkcN+zFAwgkKV9Pi4kFbwO3IiEiFVSJ4U63ADvJmkoJ2LMrT6
        cytY+1dA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0rxd-00HDAP-Rw; Mon, 13 Jun 2022 21:51:02 +0000
Message-ID: <44efdfc2-526f-0ea7-e332-ec29c00ef762@infradead.org>
Date:   Mon, 13 Jun 2022 14:50:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/13/22 08:52, Sergei Shtepa wrote:
> Allows to attach block device filters to the block devices.
> Kernel modules can use this functionality to extend the
> capabilities of the block layer.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  block/Kconfig             |   8 +++
>  block/bdev.c              | 129 ++++++++++++++++++++++++++++++++++++++
>  block/blk-core.c          |  88 ++++++++++++++++++++++++++
>  include/linux/blk_types.h |  22 +++++++
>  include/linux/blkdev.h    |  81 ++++++++++++++++++++++++
>  5 files changed, 328 insertions(+)
> 

> diff --git a/block/bdev.c b/block/bdev.c
> index 5fe06c1f2def..4bcd9f4378e3 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -426,8 +426,15 @@ static void init_once(void *data)
>  	inode_init_once(&ei->vfs_inode);
>  }
>  
> +#ifdef CONFIG_BLK_FILTER
> +static void bdev_filter_cleanup(struct block_device *bdev);
> +#endif
> +
>  static void bdev_evict_inode(struct inode *inode)
>  {
> +#ifdef CONFIG_BLK_FILTER
> +	bdev_filter_cleanup(I_BDEV(inode));
> +#endif
>  	truncate_inode_pages_final(&inode->i_data);
>  	invalidate_inode_buffers(inode); /* is it needed here? */
>  	clear_inode(inode);
> @@ -503,6 +510,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  		return NULL;
>  	}
>  	bdev->bd_disk = disk;
> +
> +#ifdef CONFIG_BLK_FILTER
> +	memset(bdev->bd_filters, 0, sizeof(bdev->bd_filters));
> +	spin_lock_init(&bdev->bd_filters_lock);
> +#endif
>  	return bdev;
>  }
>  
> @@ -1071,3 +1083,120 @@ void sync_bdevs(bool wait)
>  	spin_unlock(&blockdev_superblock->s_inode_list_lock);
>  	iput(old_inode);
>  }
> +
> +#ifdef CONFIG_BLK_FILTER
> +static void bdev_filter_cleanup(struct block_device *bdev)
> +{
> +	int altitude;
> +	struct bdev_filter *flt;
> +
> +	for (altitude = 0; altitude < bdev_filter_alt_end; altitude++) {
> +		spin_lock(&bdev->bd_filters_lock);
> +		flt = bdev->bd_filters[altitude];
> +		bdev->bd_filters[altitude] = NULL;
> +		spin_unlock(&bdev->bd_filters_lock);
> +
> +		bdev_filter_put(flt);
> +	}
> +}
> +
> +/**
> + * bdev_filter_attach - Attach a filter to the original block device.
> + * @bdev:
> + *	Block device.
> + * @name:
> + *	Name of the block device filter.
> + * @altitude:
> + *	Altituda number of the block device filter.

What is "Altituda"?  Just a typo?

> + * @flt:
> + *	Pointer to the filter structure.
> + *
> + * Before adding a filter, it is necessary to initialize &struct bdev_filter.
> + *
> + * The bdev_filter_detach() function allows to detach the filter from the block
> + * device.
> + *
> + * Return:
> + * 0 - OK
> + * -EALREADY - a filter with this name already exists
> + */
> +int bdev_filter_attach(struct block_device *bdev, const char *name,
> +		       const enum bdev_filter_altitudes altitude,
> +		       struct bdev_filter *flt)
> +{
> +	int ret = 0;
> +
> +	spin_lock(&bdev->bd_filters_lock);
> +	if (bdev->bd_filters[altitude])
> +		ret = -EALREADY;
> +	else
> +		bdev->bd_filters[altitude] = flt;
> +	spin_unlock(&bdev->bd_filters_lock);
> +
> +	if (!ret)
> +		pr_info("block device filter '%s' has been attached to %d:%d",
> +			name, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bdev_filter_attach);
> +
> +/**
> + * bdev_filter_detach - Detach a filter from the block device.
> + * @bdev:
> + *	Block device.
> + * @name:
> + *	Name of the block device filter.
> + * @altitude:
> + *	Altituda number of the block device filter.

Ditto.

> + *
> + * The filter should be added using the bdev_filter_attach() function.
> + *
> + * Return:
> + * 0 - OK
> + * -ENOENT - the filter was not found in the linked list
> + */
> +int bdev_filter_detach(struct block_device *bdev, const char *name,
> +		       const enum bdev_filter_altitudes altitude)
> +{
> +	struct bdev_filter *flt = NULL;
> +
> +	spin_lock(&bdev->bd_filters_lock);
> +	flt = bdev->bd_filters[altitude];
> +	bdev->bd_filters[altitude] = NULL;
> +	spin_unlock(&bdev->bd_filters_lock);
> +
> +	if (!flt)
> +		return -ENOENT;
> +
> +	bdev_filter_put(flt);
> +	pr_info("block device filter '%s' has been detached from %d:%d",
> +		name, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bdev_filter_detach);
> +
> +/**
> + * bdev_filter_get_by_altitude - Get filter by altitude.
> + * @bdev:
> + *	Pointer to the block device structure.

kernel-doc says:
bdev.c:1190: warning: Function parameter or member 'altitude' not described in '
bdev_filter_get_by_altitude'

> + *
> + * Return:
> + * pointer - pointer to filters structure from &struct blk_filter
> + * NULL - no filter has been set
> + */
> +struct bdev_filter *bdev_filter_get_by_altitude(struct block_device *bdev,
> +				const enum bdev_filter_altitudes altitude)
> +{
> +	struct bdev_filter *flt;
> +
> +	spin_lock(&bdev->bd_filters_lock);
> +	flt = bdev->bd_filters[altitude];
> +	if (flt)
> +		bdev_filter_get(flt);
> +	spin_unlock(&bdev->bd_filters_lock);
> +
> +	return flt;
> +}
> +EXPORT_SYMBOL_GPL(bdev_filter_get_by_altitude);
> +#endif



> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 608d577734c2..24cb5293897f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1573,4 +1573,85 @@ struct io_comp_batch {
>  
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>  
> +#ifdef CONFIG_BLK_FILTER
> +/**
> + * enum bdev_filter_result - The result of bio processing by
> + *	the block device filter.
> + *
> + * @bdev_filter_skip:
> + *	Original bio does not need to be submitted.
> + * @bdev_filter_pass:
> + *	It is necessary to submit the original request.
> + * @bdev_filter_repeat:
> + *	Bio processing has not been completed, a second call is required.
> + * @bdev_filter_redirect:
> + *	Original bio was redirected to another block device. The set
> + *	of filters on it is different, so processing must be repeated.
> + */
> +enum bdev_filter_result {
> +	bdev_filter_skip = 0,
> +	bdev_filter_pass,
> +	bdev_filter_repeat,
> +	bdev_filter_redirect
> +};
> +struct bdev_filter;
> +/**
> + * bdev_filter_operations - List of callback functions for the filter.

blkdev.h:1607: warning: cannot understand function prototype: 'struct bdev_filter_operations '

Missing "struct " before the struct name above.

> + *
> + * @submit_bio_cb:
> + *	A callback function for bio processing.
> + * @detach_cb:
> + *	A callback function to disable the filter when removing a block
> + *	device from the system.
> + */
> +struct bdev_filter_operations {
> +	enum bdev_filter_result (*submit_bio_cb)(struct bio *bio,
> +						 struct bdev_filter *flt);
> +	void (*detach_cb)(struct kref *kref);
> +};
> +/**
> + * struct bdev_filter - Block device filter.
> + *
> + * @kref:
> + *	Kernel reference counter.
> + * @fops:
> + *	The pointer to &struct bdev_filter_operations with callback
> + *	functions for the filter.
> + */
> +struct bdev_filter {
> +	struct kref kref;
> +	const struct bdev_filter_operations *fops;
> +};


thanks.
-- 
~Randy
