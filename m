Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2313254D73C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347792AbiFPBiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350363AbiFPBif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:38:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7C56C10;
        Wed, 15 Jun 2022 18:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2DD4FCE229A;
        Thu, 16 Jun 2022 01:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3514BC3411A;
        Thu, 16 Jun 2022 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655343510;
        bh=d2MR8JbAHuYboCeL5LA8OVqbDSui4vBHdBkzOiJFe0Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m6sK9YN9ILtIsQcvKAHlSE3QS3ouzgUtU/8JiVmCFWZDAYzQ55Czrg4PxHXWF9WB7
         7yRPq98AHuZuwf2OBKZpVgx0R/ppyddT+LffzHvEYroAk0IZ2FoqE03QljNEiiwKvv
         TS4boBJ2pkphKEpltduDS4IiaYwPSG6jqTw/85TxHKtzUbYa5lQyZmxMG4bB3bORjm
         JdzaH12t5x1g+QKkpo7KQlqfPjJnC7Cy5X5ujUkxbsj08htOgZl17CY4g7g0UKhKcB
         +mhd2r1UGBq+3DWji8NA/2y6jY+YBiGPDqPu/Vv8V5sK+Ocs5OmbVBKnVyHjOyl5Wx
         mIahRrJ6A2roQ==
Message-ID: <7a446f83-8a32-7131-adb4-4dfcbb79a8d9@kernel.org>
Date:   Thu, 16 Jun 2022 09:38:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615153402.2233825-1-chao@kernel.org>
 <1c422582-b074-c15e-a2d2-94bddf089974@acm.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1c422582-b074-c15e-a2d2-94bddf089974@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/16 0:21, Bart Van Assche wrote:
> On 6/15/22 08:34, Chao Yu wrote:
>> As SCSI SBC4 specification section 5.30.2 describes that it can
>> support unmapping one or more LBA range in single UNMAP command,
>> however, previously we only pack one LBA range in UNMAP command
>> by default no matter device gives the block limits that says it
>> can support in-batch UNMAP.
> 
> The above sentence is too long. Please split it.
> 
>> This patch tries to set max_discard_segments config according to
>               ^^^^^^^^^^^^
> Consider changing "tries to set" into "sets".
> 
>> block limits of device, and supports in-batch UNMAP.
> 
> Consider changing "in-batch UNMAP" into "unmapping multiple LBA ranges with a single UNMAP command".
> 
>> +    blk_queue_max_discard_segments(q, sdkp->max_block_desc_count);
> 
> sdkp->max_block_desc_count is 32 bits wide while blk_queue_max_discard_segments() accepts an unsigned short as second argument. So the value 0x10002 will be converted into 2, which is not correct. Consider changing the second argument into min(U16_MAX, sdkp->max_block_desc_count).
> 
>>       sdkp->provisioning_mode = mode;
>>       switch (mode) {
>> @@ -836,9 +837,10 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>>       struct scsi_device *sdp = cmd->device;
>>       struct request *rq = scsi_cmd_to_rq(cmd);
>>       struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
>> -    u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
>> -    u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
>> -    unsigned int data_len = 24;
>> +    unsigned short segments = blk_rq_nr_discard_segments(rq);
>> +    unsigned int data_len = 8 + 16 * segments;
>> +    unsigned int data_offset = 8;
> 
> Please rename 'data_offset' into 'descriptor_offset' to match the SBC-4 terminology.
> 
>> @@ -2870,9 +2879,9 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
>>               goto out;
>>           lba_count = get_unaligned_be32(&vpd->data[20]);
>> -        desc_count = get_unaligned_be32(&vpd->data[24]);
>> +        sdkp->max_block_desc_count = get_unaligned_be32(&vpd->data[24]);
> 
> Consider adding /* Extract the MAXIMUM UNMAP BLOCK DESCRIPTOR COUNT. */ above the above statement.
> 
>> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
>> index 5eea762f84d1..bda9db5e2322 100644
>> --- a/drivers/scsi/sd.h
>> +++ b/drivers/scsi/sd.h
>> @@ -119,6 +119,7 @@ struct scsi_disk {
>>       u32        opt_xfer_blocks;
>>       u32        max_ws_blocks;
>>       u32        max_unmap_blocks;
>> +    u32        max_block_desc_count;
> 
> I do not agree with the choice of the name of this member variable. The name used in SBC-4 is "MAXIMUM UNMAP BLOCK DESCRIPTOR COUNT". Leaving out "unmap" when abbreviating that description into a member name makes it impossible to guess what the purpose of that member variable is.

Agreed, thanks for the review. I've updated the patch as you suggested.

Thanks,

> 
> Thanks,
> 
> Bart.
