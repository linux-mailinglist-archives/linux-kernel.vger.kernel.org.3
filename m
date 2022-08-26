Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC55A31A0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiHZWAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHZWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:00:35 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0380B02A6;
        Fri, 26 Aug 2022 15:00:33 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id y127so2765605pfy.5;
        Fri, 26 Aug 2022 15:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=drYo/HPpt3swBa4tChpUwjOD5tPA9oSu7mOGrZPzAC8=;
        b=wbtimq+gfGmXS8rymNOXZR/A08vA4rHJH/Vy9KBRQ5Cl5ZBzhHeJ5xFgpNxUIMszKw
         tzyxpVSfsu4H4MjbR7yLH3MgMarjetbXj1PlL25oKj0d1QwTi2fxDCp4XicLp3XEQTur
         MnnwYImjoLkZ9euHfB9I557NP0JG5pxqNroCZ4ZspWsSU9JuhLY7P3GS+jCMMLE78Eo2
         9kH3/e7wkukICoycbDbiUF7xQk1aiYN08NL9CJxa4IYM2A50gAfHKiUT43YH4QHYHB9A
         DK5y6wsvadLnWBD8ie9OkQZC/XhaPA+P5Yf5PZD4uOM423HI0jU0ao0iP04DInCm6ETG
         iAgA==
X-Gm-Message-State: ACgBeo1RHupsWDYfkn2dPwh6ZiaL1loJT8+wSgNjeJWdk1cSZiD1+iRv
        Fqs1gvpKDFkEc1f86RGXhQM=
X-Google-Smtp-Source: AA6agR7vg8/aKDBrWQKRqBLO9T32XbxH+7iIBLMWlJ4dUIvlOM4CNbhI1XRH6aVmXDDnoZFCHOUh+A==
X-Received: by 2002:a65:42c8:0:b0:41a:8138:f47f with SMTP id l8-20020a6542c8000000b0041a8138f47fmr4831436pgp.476.1661551232944;
        Fri, 26 Aug 2022 15:00:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a12:b4b9:f1b3:ec63? ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id x187-20020a6263c4000000b00528c066678csm2248566pfb.72.2022.08.26.15.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 15:00:32 -0700 (PDT)
Message-ID: <95742dba-1dcd-090a-8920-31d0ef6eef49@acm.org>
Date:   Fri, 26 Aug 2022 15:00:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: ufs: ufsfbo: Introduce File Based Optimization
 feature
Content-Language: en-US
To:     Jiaming Li <lijiamingsofine@gmail.com>, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220824084633.14428-1-lijiamingsofine@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 01:46, Jiaming Li wrote:
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index 432df76e6318..57b0e8b14543 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -199,3 +199,12 @@ config SCSI_UFS_FAULT_INJECTION
>   	help
>   	  Enable fault injection support in the UFS driver. This makes it easier
>   	  to test the UFS error handler and abort handler.
> +
> +config SCSI_UFS_FBO
> +	bool "Support UFS File-based Optimization"
> +	depends on SCSI_UFSHCD
> +	help
> +	 The UFS FBO feature improves Sequential read performance. The Host can

Sequential -> sequential
Host -> host

> +	 send the LBA to device. The device will return a fragmented state. It

"The host can send the LBA to the device" is misleading since the host 
typically sends multiple LBAs to the device.

"The device will return a fragmented state." is wrong - did you perhaps 
want to write that the device will start defragmentation?

> +	FBO_DESC_PARAM_MAX_LBA_RANGE_CONUT	= 0xF,

What is "CONUT"? Did you perhaps want to write "COUNT"?

> +static void ufsfbo_scsi_unblock_requests(struct ufs_hba *hba)
> +{
> +	if (atomic_dec_and_test(&hba->scsi_block_reqs_cnt))
> +		scsi_unblock_requests(hba->host);
> +}
> +
> +static void ufsfbo_scsi_block_requests(struct ufs_hba *hba)
> +{
> +	if (atomic_inc_return(&hba->scsi_block_reqs_cnt) == 1)
> +		scsi_block_requests(hba->host);
> +}

Please use ufshcd_scsi_unblock_requests() and 
ufshcd_scsi_block_requests() instead of duplicating these.

> +static int ufsfbo_wait_for_doorbell_clr(struct ufs_hba *hba,
> +					u64 wait_timeout_us)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +	u32 tm_doorbell;
> +	u32 tr_doorbell;
> +	bool timeout = false, do_last_check = false;
> +	ktime_t start;
> +
> +	ufshcd_hold(hba, false);
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	/*
> +	 * Wait for all the outstanding tasks/transfer requests.
> +	 * Verify by checking the doorbell registers are clear.
> +	 */
> +	start = ktime_get();
> +	do {
> +		if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL) {
> +			ret = -EBUSY;
> +			goto out;
> +		}
> +		tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
> +		tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> +		if (!tm_doorbell && !tr_doorbell) {
> +			timeout = false;
> +			break;
> +		} else if (do_last_check) {
> +			break;
> +		}
> +		spin_unlock_irqrestore(hba->host->host_lock, flags);
> +		schedule();
> +		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
> +		    wait_timeout_us) {
> +			timeout = true;
> +			/*
> +			 * We might have scheduled out for long time so make
> +			 * sure to check if doorbells are cleared by this time
> +			 * or not.
> +			 */
> +			do_last_check = true;
> +		}
> +		spin_lock_irqsave(hba->host->host_lock, flags);
> +	} while (tm_doorbell || tr_doorbell);
> +	if (timeout) {
> +		dev_err(hba->dev,
> +			"%s: timedout waiting for doorbell to clear (tm=0x%x, tr=0x%x)\n",
> +			__func__, tm_doorbell, tr_doorbell);
> +		ret = -EBUSY;
> +	}
> +out:
> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
> +	ufshcd_release(hba);
> +	return ret;
> +}

This looks like a copy of ufshcd_wait_for_doorbell_clr()? Please do not 
duplicate existing code but instead reuse it. The same comment holds for 
all the functions below that have been copy/pasted from ufshcd.c.

> +int ufsfbo_read_frag_level(struct ufsfbo_dev *fbo, char *buf)
> +{
[ ... ]
> +	hba->host->eh_noresume = 1;

Why is this set? This should be documented.

> +int ufsfbo_init_lba_buffer(struct ufsfbo_dev *fbo, const char *buf, char *lba_buf)
> +{
> +	int ret = 0;
> +	char *buf_ptr;
> +	char *lba;
> +	u64 lba_value_pre, lba_value_post;
> +	int len_index = 1, lba_index = FBO_HEADER_SIZE + FBO_BODY_HEADER_SIZE;
> +
> +	buf_ptr = kzalloc(strlen(buf) + 1, GFP_KERNEL);
> +	if (!buf_ptr) {
> +		FBO_ERR_MSG("alloc buffer fail");
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +	memcpy(buf_ptr, buf, strlen(buf) + 1);

Please use kstrdup() instead of open-coding it.

> +	/*create lba range buf send for device*/
> +	lba_buf[5] = fbo->fbo_lba_count; //lba range count
> +	lba_buf[6] = fbo->fbo_wholefile; //calculate whole file

C++-style comments are not allowed in kernel code.

> +	while ((lba = strsep(&buf_ptr, ",")) != NULL) {

Another style violation. Please check patches with checkpatch before 
posting these.

> +int ufsfbo_lba_list_write(struct ufsfbo_dev *fbo, const char *buf)
> +{

[ ... ]

> +	hba->host->eh_noresume = 1;

Again, why is this set here? Please document this.

> +void ufsfbo_init(struct ufs_hba *hba)
> +{

[ ... ]

> +	ret = ufsfbo_create_sysfs(fbo);

Please do not call sysfs_create_file() nor kobject_add() directly but 
instead add an attribute group to ufshcd_driver_groups.

> +	ufsfbo_set_state(hba, FBO_PRESENT);

Consider renaming FBO_PRESENT into FBO_SUPPORTED.

> +/* SYSFS DEFINE */
> +#define define_sysfs_ro(_name) __ATTR(_name, 0444,			\
> +				      ufsfbo_sysfs_show_##_name, NULL)
> +#define define_sysfs_wo(_name) __ATTR(_name, 0200,			\
> +				       NULL, ufsfbo_sysfs_store_##_name)
> +#define define_sysfs_rw(_name) __ATTR(_name, 0644,			\
> +				      ufsfbo_sysfs_show_##_name,	\
> +				      ufsfbo_sysfs_store_##_name)

Why are these macros necessary? Why can't any of the existing macros be 
used to define these sysfs attributes, e.g. DEVICE_ATTR_RO()?

> diff --git a/drivers/scsi/ufs/ufsfbo.h b/drivers/scsi/ufs/ufsfbo.h
> new file mode 100644
> index 000000000000..c2549032815e
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufsfbo.h
> @@ -0,0 +1,143 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Universal Flash Storage File-based Optimization
> + *
> + * Copyright (C) 2022 Xiaomi Mobile Software Co., Ltd
> + *
> + * Authors:
> + *		lijiaming <lijiaming3@xiaomi.com>
> + */
> +
> +#ifndef _UFSFBO_H_
> +#define _UFSFBO_H_

Please insert a blank line between the header guard and the include 
directives.

> +#include <linux/interrupt.h>

Why has this header file been included? Please minimize include directives.

> +#include <linux/blktrace_api.h>

Why has this header file been included?

> +#include <linux/blkdev.h>
> +#include <linux/bitfield.h>

Why has this header file been included?


> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 2f6468f22b48..9c377c514e17 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4956,6 +4956,14 @@ static void ufshcd_hpb_configure(struct ufs_hba *hba, struct scsi_device *sdev)
>   	ufshpb_init_hpb_lu(hba, sdev);
>   }
>   
> +static void ufshcd_fbo_configure(struct ufs_hba *hba, struct scsi_device *sdev)
> +{
> +#ifdef CONFIG_SCSI_UFS_FBO
> +	if (sdev->lun == 0)
> +		hba->fbo.sdev_ufs_lu = sdev;
> +#endif
> +}

Shouldn't this function occur in the file with FBO functions? 
Additionally, please document why the SCSI device for LUN zero is stored 
since this is not required by the FBO specification.

Thanks,

Bart.
