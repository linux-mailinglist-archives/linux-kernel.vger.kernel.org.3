Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9C575636
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiGNUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:13:29 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695640BFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:13:27 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id o1so2083004qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIFnewSJO5RPRbFfQGBESkxwcHJHTZrd3ulxj1Uol1U=;
        b=BTrFaJv7gF3FPkERKkD3gOFGUD0mBsIzV3jvWCFg0mh8gh9tDvABBVKW7C6CSWs1RX
         hNZroabT7L+x3JaDuZAtvVYqLjUABU6kPHy4s/7CCpeTGVBxPRtjmXt9mtXDj95cA82H
         2YflnjqZEY37UjTJxOidi4lAjCZ+myuhcB/2FQnBfo3cGbDNc9v1pU05f6nyjmIAS6eh
         nOrV8poFFpmp9D0loQQrzgf9pH5FR/lO9De5/tgGMJa9d3eI1dmIxV2t5eX9xupksC0A
         /UP8pOS2kRZOEgL0JY9+k6cnd8iQM4vgujmm7RGAi6LnceZXYtPUchNnreGuXDVlVqGM
         BVlA==
X-Gm-Message-State: AJIora/ovqTHqdnpPSB0q/ZkavzbygXWVLjeOuD8wU2XckBjqFcicijt
        taiqTh6n1ce+FBWcatFzQwTH
X-Google-Smtp-Source: AGRyM1szLUsAmGiDNl1c+GrlTpqZOEE+Fxs3qZG9HecTAWZ2su5al2HKJq3yE3EQOyzVrXdCf/lseQ==
X-Received: by 2002:a05:620a:2724:b0:6b5:cd4d:c6e8 with SMTP id b36-20020a05620a272400b006b5cd4dc6e8mr350262qkp.116.1657829606439;
        Thu, 14 Jul 2022 13:13:26 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a0c4c00b006a6ebde4799sm2186001qki.90.2022.07.14.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 13:13:25 -0700 (PDT)
Date:   Thu, 14 Jul 2022 16:13:24 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Brian Geffon <bgeffon@google.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dm: add message command to disallow device open
Message-ID: <YtB45Lte5UhlEE6y@redhat.com>
References: <20220704000225.345536-1-dlunev@chromium.org>
 <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03 2022 at  8:02P -0400,
Daniil Lunev <dlunev@chromium.org> wrote:

> A message can be passed to device mapper to prohibit open on a certain
> mapped device. This makes possible to disallow userspace access to
> raw swapped data if the system uses device mapper to encrypt it at rest.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>

This commit header and patch make little sense to me.

If you're concerned about a normal (non-root) user having read access
to the swap device then disallow non-root user access permissions on
the swap device.

Why is an encrypted swap device any different than any other encrypted
device?

As is, this patch seems to be the wrong way to achieve your desired
result.  If you or someone else on the chromium team can better
defend/explain the need for this change please do so.

Thanks,
Mike


> ---
> 
>  drivers/md/dm-core.h          |  1 +
>  drivers/md/dm-ioctl.c         | 10 ++++++++++
>  drivers/md/dm.c               | 12 ++++++++++++
>  drivers/md/dm.h               | 10 ++++++++++
>  include/uapi/linux/dm-ioctl.h |  5 +++++
>  5 files changed, 38 insertions(+)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index 4277853c75351..37529b605b7c4 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -140,6 +140,7 @@ struct mapped_device {
>  #define DMF_SUSPENDED_INTERNALLY 7
>  #define DMF_POST_SUSPENDING 8
>  #define DMF_EMULATE_ZONE_APPEND 9
> +#define DMF_DISALLOW_OPEN 10
>  
>  void disable_discard(struct mapped_device *md);
>  void disable_write_zeroes(struct mapped_device *md);
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 87310fceb0d86..e35d560aa2ff3 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -815,6 +815,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
>  	if (dm_test_deferred_remove_flag(md))
>  		param->flags |= DM_DEFERRED_REMOVE;
>  
> +	if (dm_test_disallow_open_flag(md))
> +		param->flags |= DM_DISALLOWED_OPEN;
> +
>  	param->dev = huge_encode_dev(disk_devt(disk));
>  
>  	/*
> @@ -1656,6 +1659,13 @@ static int message_for_md(struct mapped_device *md, unsigned argc, char **argv,
>  		}
>  		return dm_cancel_deferred_remove(md);
>  	}
> +	if (!strcasecmp(argv[0], "@disallow_open")) {
> +		if (argc != 1) {
> +			DMERR("Invalid arguments for @disallow_open");
> +			return -EINVAL;
> +		}
> +		return dm_disallow_open(md);
> +	}
>  
>  	r = dm_stats_message(md, argc, argv, result, maxlen);
>  	if (r < 2)
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 82957bd460e89..3e53d1bd40f0c 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -327,6 +327,7 @@ static int dm_blk_open(struct block_device *bdev, fmode_t mode)
>  		goto out;
>  
>  	if (test_bit(DMF_FREEING, &md->flags) ||
> +	    test_bit(DMF_DISALLOW_OPEN, &md->flags) ||
>  	    dm_deleting_md(md)) {
>  		md = NULL;
>  		goto out;
> @@ -403,6 +404,12 @@ int dm_cancel_deferred_remove(struct mapped_device *md)
>  	return r;
>  }
>  
> +int dm_disallow_open(struct mapped_device *md)
> +{
> +	set_bit(DMF_DISALLOW_OPEN, &md->flags);
> +	return 0;
> +}
> +
>  static void do_deferred_remove(struct work_struct *w)
>  {
>  	dm_deferred_remove();
> @@ -2883,6 +2890,11 @@ int dm_test_deferred_remove_flag(struct mapped_device *md)
>  	return test_bit(DMF_DEFERRED_REMOVE, &md->flags);
>  }
>  
> +int dm_test_disallow_open_flag(struct mapped_device *md)
> +{
> +	return test_bit(DMF_DISALLOW_OPEN, &md->flags);
> +}
> +
>  int dm_suspended(struct dm_target *ti)
>  {
>  	return dm_suspended_md(ti->table->md);
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index 9013dc1a7b002..da27f9dfe1413 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -163,6 +163,16 @@ int dm_test_deferred_remove_flag(struct mapped_device *md);
>   */
>  void dm_deferred_remove(void);
>  
> +/*
> + * Test if the device is openable.
> + */
> +int dm_test_disallow_open_flag(struct mapped_device *md);
> +
> +/*
> + * Prevent new open request on the device.
> + */
> +int dm_disallow_open(struct mapped_device *md);
> +
>  /*
>   * The device-mapper can be driven through one of two interfaces;
>   * ioctl or filesystem, depending which patch you have applied.
> diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
> index 2e9550fef90fa..3b4d12d09c005 100644
> --- a/include/uapi/linux/dm-ioctl.h
> +++ b/include/uapi/linux/dm-ioctl.h
> @@ -382,4 +382,9 @@ enum {
>   */
>  #define DM_IMA_MEASUREMENT_FLAG	(1 << 19) /* In */
>  
> +/*
> + * If set, the device can not be opened.
> + */
> +#define DM_DISALLOWED_OPEN	(1 << 20) /* Out */
> +
>  #endif				/* _LINUX_DM_IOCTL_H */
> -- 
> 2.31.0
> 
