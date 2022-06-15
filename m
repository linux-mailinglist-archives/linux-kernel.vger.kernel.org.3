Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B150F54CE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355124AbiFOQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiFOQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:21:30 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC139FD1;
        Wed, 15 Jun 2022 09:21:29 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 184so11791181pga.12;
        Wed, 15 Jun 2022 09:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oxwx2XCF+I1I4h/9eZc3yiqrH4E8gBYoc+9xhREdn5Y=;
        b=CQhOQWWT+uBu3d7WHmxmNP04saC5VYeoZRnt5DSxhUjwBgW4j2GN/R+QbksL63Ide3
         TwPgeRJJc96pzgmnsyW3y/FBD/JfFodYW9iAzbAOsS+oshqfNEkxxUZvAHSXsiLqoK3H
         ITyWTSz3oarmdtBfoQn47beZy4X8p6jQdlMwEJDzoA87Wc3c3yua98e+tNtpZWTyPz37
         dL6gzV8gvSp5WDcV5BAdA21VuCXXRfK6SLDuJglnH6VkuUtF7dpg6rxzVDAsoyaE55jA
         ijJ5PBSN5meNQ4LDtZtb7tEL7Fsb9uSP5OcnuqR894OXsXhr7NyOSCXdb9wSohUZQsni
         LnLQ==
X-Gm-Message-State: AJIora8czxyHRqfXmnQXzfwYMD1tWNj3DK6z7+TQex1ZmFIZLqhQnpD6
        o/IqLowrf7M8F30pgu0Q35M=
X-Google-Smtp-Source: AGRyM1voI3CsDZUvl6kUayV5lUz/OC0ud0TYUc7dOhuNQy/iTKJCGRND7+ozOR8158DkbFk6UxzRxg==
X-Received: by 2002:a05:6a00:4504:b0:51b:f04e:a130 with SMTP id cw4-20020a056a00450400b0051bf04ea130mr409348pfb.52.1655310088948;
        Wed, 15 Jun 2022 09:21:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id m17-20020a056a00081100b0051b9c0af43dsm10224124pfk.155.2022.06.15.09.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:21:28 -0700 (PDT)
Message-ID: <1c422582-b074-c15e-a2d2-94bddf089974@acm.org>
Date:   Wed, 15 Jun 2022 09:21:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615153402.2233825-1-chao@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615153402.2233825-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 08:34, Chao Yu wrote:
> As SCSI SBC4 specification section 5.30.2 describes that it can
> support unmapping one or more LBA range in single UNMAP command,
> however, previously we only pack one LBA range in UNMAP command
> by default no matter device gives the block limits that says it
> can support in-batch UNMAP.

The above sentence is too long. Please split it.

> This patch tries to set max_discard_segments config according to
              ^^^^^^^^^^^^
Consider changing "tries to set" into "sets".

> block limits of device, and supports in-batch UNMAP.

Consider changing "in-batch UNMAP" into "unmapping multiple LBA ranges 
with a single UNMAP command".

> +	blk_queue_max_discard_segments(q, sdkp->max_block_desc_count);

sdkp->max_block_desc_count is 32 bits wide while 
blk_queue_max_discard_segments() accepts an unsigned short as second 
argument. So the value 0x10002 will be converted into 2, which is not 
correct. Consider changing the second argument into min(U16_MAX, 
sdkp->max_block_desc_count).

>   	sdkp->provisioning_mode = mode;
>   
>   	switch (mode) {
> @@ -836,9 +837,10 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>   	struct scsi_device *sdp = cmd->device;
>   	struct request *rq = scsi_cmd_to_rq(cmd);
>   	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
> -	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
> -	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
> -	unsigned int data_len = 24;
> +	unsigned short segments = blk_rq_nr_discard_segments(rq);
> +	unsigned int data_len = 8 + 16 * segments;
> +	unsigned int data_offset = 8;

Please rename 'data_offset' into 'descriptor_offset' to match the SBC-4 
terminology.

> @@ -2870,9 +2879,9 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
>   			goto out;
>   
>   		lba_count = get_unaligned_be32(&vpd->data[20]);
> -		desc_count = get_unaligned_be32(&vpd->data[24]);
> +		sdkp->max_block_desc_count = get_unaligned_be32(&vpd->data[24]);

Consider adding /* Extract the MAXIMUM UNMAP BLOCK DESCRIPTOR COUNT. */ 
above the above statement.

> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index 5eea762f84d1..bda9db5e2322 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -119,6 +119,7 @@ struct scsi_disk {
>   	u32		opt_xfer_blocks;
>   	u32		max_ws_blocks;
>   	u32		max_unmap_blocks;
> +	u32		max_block_desc_count;

I do not agree with the choice of the name of this member variable. The 
name used in SBC-4 is "MAXIMUM UNMAP BLOCK DESCRIPTOR COUNT". Leaving 
out "unmap" when abbreviating that description into a member name makes 
it impossible to guess what the purpose of that member variable is.

Thanks,

Bart.
