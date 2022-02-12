Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA84B347E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiBLLZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiBLLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:25:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3126AD6;
        Sat, 12 Feb 2022 03:25:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p15so27757398ejc.7;
        Sat, 12 Feb 2022 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7SIhUeX2yt0idUDRJKKmAw5gfuLEHOZUKxZ0CAvnkKQ=;
        b=qzXx3csd9RNDf0yA1DYYLijDmM6LWSt/oPmlFdym5v/OM3V1zPhchWwPa4FyV6QfXZ
         tFGPnBmObMu62ZBqHpaOCv+h2oia9kLoD/3sBusLQJCueZ79z/JcOCxuwitF6EMjqInY
         CEgZ2LzNfRsUy9PG2EFccy3NbMcPQ91SxZcheGi+BqXjbho2X651GeAvEaIJjFthHiMJ
         4xGhc2fg3IcpDPICRzRBUaIZvLlOT2QodI6qSpRNi2Z8qEVy+GweK0PAVYUokpBkLkHA
         N9zhB5hwVJV9b7G6vNdQgAnn2riQqiWjEjGknz/ya1x98y5XXKTylVzuOUPGBuaf1Jco
         h8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7SIhUeX2yt0idUDRJKKmAw5gfuLEHOZUKxZ0CAvnkKQ=;
        b=5GX3FYDj4yT6ET9ZeytBNMmfrq366HHu61XzKjkEkBY9qg7HgB8UqzFjUEcxU6nHNt
         8j4DD2rk8Z8xPvFyUkZenFUNtNZIsWX6L43YkJxNjEvTc05QUz0yciwQTvyTVZZBUH98
         cxlnPhwwS6YctKmnPhTOu5YrgpeflpVYBM0DiBfc2DavQCYZUV7mXpSetYSVbafJu4N4
         h85WUl02IopHahNmHzL+BY30ORTwc4KBiAJ7KlFkWKxYQFDak++cGfBYpNzar0ZEMYea
         +igIfGFR0xR5BCMoHkZ5kdhedoVMr3Xtfe9eOCIgJ2J77IFtAXtPBJYBysCxOC6ETgUN
         bexg==
X-Gm-Message-State: AOAM530lYpgCBnl/iYoW5GXOROT8uor9UiCz4DUE2AVzdiC2f/dJSEkl
        czvdTOdecmowtmJm85brL0s=
X-Google-Smtp-Source: ABdhPJzWitD0hfjXJ8eX/JHLhmT7VkMjcrS0EcKXiLjXUzIVCfyLkx6hDe7qD20rW2rzZQuz4QDvDg==
X-Received: by 2002:a17:907:970d:: with SMTP id jg13mr4424600ejc.418.1644665135450;
        Sat, 12 Feb 2022 03:25:35 -0800 (PST)
Received: from [192.168.178.40] (ipbcc1fa42.dynamic.kabel-deutschland.de. [188.193.250.66])
        by smtp.gmail.com with ESMTPSA id b15sm500132edd.60.2022.02.12.03.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 03:25:34 -0800 (PST)
Message-ID: <0428d955-e9c7-b632-cb19-102e49cef387@gmail.com>
Date:   Sat, 12 Feb 2022 12:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scsi: target: tcmu: Make cmd_ring_size changeable via
 configfs.
Content-Language: en-US
To:     Guixin Liu <kanie@linux.alibaba.com>, martin.petersen@oracle.com
Cc:     xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1644291974-73531-1-git-send-email-kanie@linux.alibaba.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
In-Reply-To: <1644291974-73531-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.22 04:46, Guixin Liu wrote:
> Make cmd_ring_size changeable similar to the way it is done for
> max_data_area_mb, the reason is that our tcmu client will create
> thousands of tcmu instances, and this will consume lots of mem with
> default 8Mb cmd ring size for every backstore.
> 
> One can change the value by typing:
>      echo "cmd_ring_size_mb=N" > control
> The "N" is a integer between 1 to 8, if set 1, the cmd ring can hold
> about 6k cmds(tcmu_cmd_entry about 176 byte) at least.
> 
> The value is printed when doing:
>      cat info
> In addition, a new readonly attribute 'cmd_ring_size_mb' returns the
> value in read.

Thank you for the patch. This was on my todo list also.

> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/target/target_core_user.c | 64 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index 7b2a89a..826c1c0 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -64,7 +64,6 @@
>   #define MB_CMDR_SIZE (8 * 1024 * 1024)

I'd like to change this to MB_CMDR_SIZE_DEF, since it no longer is
the fixed size of mailbox plus cmd ring, but the default only.

>   /* Offset of cmd ring is size of mailbox */
>   #define CMDR_OFF sizeof(struct tcmu_mailbox)
> -#define CMDR_SIZE (MB_CMDR_SIZE - CMDR_OFF)

Similarly this could become CMDR_SIZE_DEF

>   
>   /*
>    * For data area, the default block size is PAGE_SIZE and
> @@ -133,6 +132,7 @@ struct tcmu_dev {
>   	struct tcmu_mailbox *mb_addr;
>   	void *cmdr;
>   	u32 cmdr_size;
> +	u32 total_cmdr_size_byte;

Do we really need a new field in tcmu_dev? I think we should avoid it
since the field cmdr_size holds the same value, just lowered by CMDR_OFF.

>   	u32 cmdr_last_cleaned;
>   	/* Offset of data area from start of mb */
>   	/* Must add data_off and mb_addr to get the address */
> @@ -1617,6 +1617,7 @@ static struct se_device *tcmu_alloc_device(struct se_hba *hba, const char *name)
>   
>   	udev->data_pages_per_blk = DATA_PAGES_PER_BLK_DEF;
>   	udev->max_blocks = DATA_AREA_PAGES_DEF / udev->data_pages_per_blk;
> +	udev->total_cmdr_size_byte = MB_CMDR_SIZE;

We could do
         udev->cmdr_size = CMDR_SIZE_DEF;

>   	udev->data_area_mb = TCMU_PAGES_TO_MBS(DATA_AREA_PAGES_DEF);
>   
>   	mutex_init(&udev->cmdr_lock);
> @@ -2189,7 +2190,7 @@ static int tcmu_configure_device(struct se_device *dev)
>   		goto err_bitmap_alloc;
>   	}
>   
> -	mb = vzalloc(MB_CMDR_SIZE);
> +	mb = vzalloc(udev->total_cmdr_size_byte);
>   	if (!mb) {
>   		ret = -ENOMEM;
>   		goto err_vzalloc;
> @@ -2198,8 +2199,8 @@ static int tcmu_configure_device(struct se_device *dev)
>   	/* mailbox fits in first part of CMDR space */
>   	udev->mb_addr = mb;
>   	udev->cmdr = (void *)mb + CMDR_OFF;
> -	udev->cmdr_size = CMDR_SIZE;
> -	udev->data_off = MB_CMDR_SIZE;
> +	udev->cmdr_size = udev->total_cmdr_size_byte - CMDR_OFF;
> +	udev->data_off = udev->total_cmdr_size_byte;

CMDR_SIZE would be already set here, so we only would need:
         udev->data_off = udev->cmdr_size + CMDR_OFF;

>   	data_size = TCMU_MBS_TO_PAGES(udev->data_area_mb) << PAGE_SHIFT;
>   	udev->mmap_pages = (data_size + MB_CMDR_SIZE) >> PAGE_SHIFT;

I think we have to replace MB_CMDR_SIZE with udev->cmdr_size + CMDR_OFF here.
Just a few lines below your patch also does not change the line
         info->mem[0].size = data_size + MB_CMDR_SIZE;
where the same replacement is needed.

>   	udev->data_blk_size = udev->data_pages_per_blk * PAGE_SIZE;
> @@ -2401,7 +2402,7 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
>   enum {
>   	Opt_dev_config, Opt_dev_size, Opt_hw_block_size, Opt_hw_max_sectors,
>   	Opt_nl_reply_supported, Opt_max_data_area_mb, Opt_data_pages_per_blk,
> -	Opt_err,
> +	Opt_cmd_ring_size_mb, Opt_err,
>   };
>   
>   static match_table_t tokens = {
> @@ -2412,6 +2413,7 @@ enum {
>   	{Opt_nl_reply_supported, "nl_reply_supported=%d"},
>   	{Opt_max_data_area_mb, "max_data_area_mb=%d"},
>   	{Opt_data_pages_per_blk, "data_pages_per_blk=%d"},
> +	{Opt_cmd_ring_size_mb, "cmd_ring_size_mb=%d"},
>   	{Opt_err, NULL}
>   };
>   
> @@ -2509,6 +2511,41 @@ static int tcmu_set_data_pages_per_blk(struct tcmu_dev *udev, substring_t *arg)
>   	return ret;
>   }
>   
> +static int tcmu_set_cmd_ring_size_param(struct tcmu_dev *udev, substring_t *arg)

Please remove the "_param" suffix from function name, as the
other similar set functions don't have it also.

> +{
> +	int val, ret;
> +
> +	ret = match_int(arg, &val);
> +	if (ret < 0) {
> +		pr_err("match_int() failed for cmd_ring_size_mb=. Error %d.\n",
> +		       ret);
> +		return ret;
> +	}
> +
> +	if (val <= 0) {
> +		pr_err("Invalid cmd_ring_size_mb %d.\n", val);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&udev->cmdr_lock);
> +	if (udev->data_bitmap) {
> +		pr_err("Cannot set cmd_ring_size_mb after it has been enabled.\n");
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	udev->total_cmdr_size_byte = (val << 20);
> +	if (udev->total_cmdr_size_byte > MB_CMDR_SIZE) {

Would be
         udev->cmdr_size = (val << 20) - CMDR_OFF;
         if (val > (MB_CMDR_SIZE_DEF >> 20)) {

Please note: the check you coded is definitely wrong.
E.g. if someone entered the value 4096, which is 0x1000,
we would have ended up with udev->total_cmdr_size_byte
set to 0 ...

> +		pr_err("%d is too large. Adjusting cmd_ring_size_mb to global limit of %u\n",
> +		       val, (MB_CMDR_SIZE >> 20));
> +		udev->total_cmdr_size_byte = MB_CMDR_SIZE;

                 udev->cmdr_size = CMDR_SIZE_DEF;
> +	}
> +
> +unlock:
> +	mutex_unlock(&udev->cmdr_lock);
> +	return ret;
> +}
> +
>   static ssize_t tcmu_set_configfs_dev_params(struct se_device *dev,
>   		const char *page, ssize_t count)
>   {
> @@ -2563,6 +2600,9 @@ static ssize_t tcmu_set_configfs_dev_params(struct se_device *dev,
>   		case Opt_data_pages_per_blk:
>   			ret = tcmu_set_data_pages_per_blk(udev, &args[0]);
>   			break;
> +		case Opt_cmd_ring_size_mb:
> +			ret = tcmu_set_cmd_ring_size_param(udev, &args[0]);
> +			break;
>   		default:
>   			break;
>   		}
> @@ -2585,6 +2625,8 @@ static ssize_t tcmu_show_configfs_dev_params(struct se_device *dev, char *b)
>   	bl += sprintf(b + bl, "Size: %llu ", udev->dev_size);
>   	bl += sprintf(b + bl, "MaxDataAreaMB: %u ", udev->data_area_mb);
>   	bl += sprintf(b + bl, "DataPagesPerBlk: %u\n", udev->data_pages_per_blk);

I think we should print all the config values on one line.
So I'd like to remove the '\n' after DataPagesPerBlk.

> +	bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
> +		      (udev->total_cmdr_size_byte >> 20));
>   
>   	return bl;
>   }
> @@ -3059,6 +3101,17 @@ static ssize_t tcmu_free_kept_buf_store(struct config_item *item, const char *pa
>   }
>   CONFIGFS_ATTR_WO(tcmu_, free_kept_buf);
>   
> +static ssize_t tcmu_cmd_ring_size_mb_show(struct config_item *item, char *page)
> +{
> +	struct se_dev_attrib *da = container_of(to_config_group(item),
> +						struct se_dev_attrib, da_group);
> +	struct tcmu_dev *udev = TCMU_DEV(da->da_dev);
> +
> +	return snprintf(page, PAGE_SIZE, "%u\n",
> +			(udev->total_cmdr_size_byte >> 20));

			(udev->cmdr_size + CMDR_OFF) >> 20);
> +}
> +CONFIGFS_ATTR_RO(tcmu_, cmd_ring_size_mb);
> +

The attributes block_dev, reset_ring and free_kept_buf belong
to the separate action attribute group.
So shouldn't we shift this new attribute up in the code, e.q.
behind the line "CONFIGFS_ATTR_RO(tcmu_, data_pages_per_blk);"?


>   static struct configfs_attribute *tcmu_attrib_attrs[] = {
>   	&tcmu_attr_cmd_time_out,
>   	&tcmu_attr_qfull_time_out,
> @@ -3069,6 +3122,7 @@ static ssize_t tcmu_free_kept_buf_store(struct config_item *item, const char *pa
>   	&tcmu_attr_emulate_write_cache,
>   	&tcmu_attr_tmr_notification,
>   	&tcmu_attr_nl_reply_supported,
> +	&tcmu_attr_cmd_ring_size_mb,
>   	NULL,
>   };
>   
