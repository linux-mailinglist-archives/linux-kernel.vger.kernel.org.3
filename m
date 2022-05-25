Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C295334C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbiEYBfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiEYBe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6C53B55;
        Tue, 24 May 2022 18:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6516160B67;
        Wed, 25 May 2022 01:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE334C34100;
        Wed, 25 May 2022 01:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653442496;
        bh=W8SLt4tLXE/qgKUWcBGimGv5PBPTXOM6nyfdhFEW/Qw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vPgk/cToQ4pzVDT1K3hmfF77Kn7lCCBLVhOvLwozICGzIlexpdMuEoHuTDpALX2fu
         r8IzmrjSGPLTUG9dCrnnip7+28AA874W1nEbnp9xSEMbKR7IWgiZiUmD1xsgOPaE9h
         /BJCdwhaF6MzMBqBGO62YFE4Wpope+VVYVCPINMMJjdGhc65bd7L6ufjIH8YrEUB9a
         era3G+gJx6y8s6TZxwFaBkHOLhetd0A5/XJygTkGTPKi+WjgpWAYK7e9BJaYUPJnpL
         lw2sfVC+9tD3e/5opgQtRm7g17mYwvadJ0k+FeWI5SHF8oON5XwLJTIFE4zy9KAeRE
         xQGPbU4WEPhIQ==
Message-ID: <138141eb-6bb9-88bc-cdb0-85f6df8b18cb@kernel.org>
Date:   Wed, 25 May 2022 09:34:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220521113259.3953757-1-chao@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220521113259.3953757-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

Any comments?

Thanks,

On 2022/5/21 19:32, Chao Yu wrote:
> As SPEC describes that it can support unmapping one or more LBA range
> in single UNMAP command, however, previously we only pack one LBA
> range in UNMAP command by default no matter device gives the block
> limits that says it can support in-batch UNMAP.
> 
> This patch tries to set max_discard_segments config according to block
> limits of device, and supports in-batch UNMAP.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   drivers/scsi/sd.c | 30 +++++++++++++++++++-----------
>   drivers/scsi/sd.h |  1 +
>   2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index dc6e55761fd1..be070457c78d 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -790,6 +790,7 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
>   	q->limits.discard_granularity =
>   		max(sdkp->physical_block_size,
>   		    sdkp->unmap_granularity * logical_block_size);
> +	blk_queue_max_discard_segments(q, sdkp->max_block_desc_count);
>   	sdkp->provisioning_mode = mode;
>   
>   	switch (mode) {
> @@ -837,10 +838,10 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>   {
>   	struct scsi_device *sdp = cmd->device;
>   	struct request *rq = scsi_cmd_to_rq(cmd);
> +	struct bio *bio;
>   	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
> -	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
> -	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
> -	unsigned int data_len = 24;
> +	unsigned short segments = blk_rq_nr_discard_segments(rq);
> +	unsigned int data_len = 8 + 16 * segments, i = 0;
>   	char *buf;
>   
>   	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
> @@ -853,13 +854,20 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>   
>   	cmd->cmd_len = 10;
>   	cmd->cmnd[0] = UNMAP;
> -	cmd->cmnd[8] = 24;
> +	cmd->cmnd[8] = data_len;
>   
>   	buf = bvec_virt(&rq->special_vec);
> -	put_unaligned_be16(6 + 16, &buf[0]);
> -	put_unaligned_be16(16, &buf[2]);
> -	put_unaligned_be64(lba, &buf[8]);
> -	put_unaligned_be32(nr_blocks, &buf[16]);
> +	put_unaligned_be16(6 + 16 * segments, &buf[0]);
> +	put_unaligned_be16(16 * segments, &buf[2]);
> +
> +	__rq_for_each_bio(bio, rq) {
> +		u64 lba = sectors_to_logical(sdp, bio->bi_iter.bi_sector);
> +		u32 nr_blocks = sectors_to_logical(sdp, bio_sectors(bio));
> +
> +		put_unaligned_be64(lba, &buf[8 + 16 * i]);
> +		put_unaligned_be32(nr_blocks, &buf[8 + 16 * i + 8]);
> +		i++;
> +	}
>   
>   	cmd->allowed = sdkp->max_retries;
>   	cmd->transfersize = data_len;
> @@ -2859,7 +2867,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
>   	sdkp->opt_xfer_blocks = get_unaligned_be32(&buffer[12]);
>   
>   	if (buffer[3] == 0x3c) {
> -		unsigned int lba_count, desc_count;
> +		unsigned int lba_count;
>   
>   		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&buffer[36]);
>   
> @@ -2867,9 +2875,9 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
>   			goto out;
>   
>   		lba_count = get_unaligned_be32(&buffer[20]);
> -		desc_count = get_unaligned_be32(&buffer[24]);
> +		sdkp->max_block_desc_count = get_unaligned_be32(&buffer[24]);
>   
> -		if (lba_count && desc_count)
> +		if (lba_count && sdkp->max_block_desc_count)
>   			sdkp->max_unmap_blocks = lba_count;
>   
>   		sdkp->unmap_granularity = get_unaligned_be32(&buffer[28]);
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index 0a33a4b68ffb..e396bcaf76ca 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -99,6 +99,7 @@ struct scsi_disk {
>   	u32		opt_xfer_blocks;
>   	u32		max_ws_blocks;
>   	u32		max_unmap_blocks;
> +	u32		max_block_desc_count;
>   	u32		unmap_granularity;
>   	u32		unmap_alignment;
>   	u32		index;
