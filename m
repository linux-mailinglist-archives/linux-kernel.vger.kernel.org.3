Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8854D723
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiFPBh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347985AbiFPBhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185421E08;
        Wed, 15 Jun 2022 18:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB7D61CC8;
        Thu, 16 Jun 2022 01:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BC2C3411A;
        Thu, 16 Jun 2022 01:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655343439;
        bh=ujpHNITXakGv3AFhCLT/p17jcWhMfXKiaRZLtkA/Y18=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mKV2g3cVPknlB8Uv0bifMNAz90CBxvPaBmNkJr86o9Zln8Gg6RGwF/avlrPMKME55
         /3cg8BMJ6btV3D7P/vk+3ZIB/7uS5NAWWfEwM92grgi9OxPvWTCvEQbCtzCjobCnqm
         OoLZgpalBQ9OkKGWorjM4c2tGAI5XD5ZLgVuObrFXq2ihSecHco5ZjuMcncfedlAUn
         x8vf8DMHhUis94Tlyr7vUjLCvSGyeDDN7W2Ronst4/jHsTVpvIFWzNmIZxDJ+l/Alc
         9di1/KnsyC1wPD/smpnNs7SqVsqhc443I7DXgtnTAGee7ZuB6MhH57s6Vc9Symk0HH
         VObkAvlmsjfQw==
Message-ID: <f3aa27cb-f018-f056-6899-f635b4b6b728@kernel.org>
Date:   Thu, 16 Jun 2022 09:37:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615132846.2232920-1-chao@kernel.org>
 <YqngKHnfVIzq7Pgr@infradead.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YqngKHnfVIzq7Pgr@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 21:35, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 09:28:46PM +0800, Chao Yu wrote:
>> As SPEC describes that it can support unmapping one or more LBA range
> 
> s/SPEC/<insert SPC reference here>/
> 
>>   {
>>   	struct scsi_device *sdp = cmd->device;
>>   	struct request *rq = scsi_cmd_to_rq(cmd);
>> +	struct bio *bio;
>>   	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
>> +	unsigned short segments = blk_rq_nr_discard_segments(rq);
>> +	unsigned int data_len = 8 + 16 * segments, i = 0;
>>   	char *buf;
> 
> Nit: for readability I'd move the bio declaration just above the buf
> line.
> 
>> +
>> +	__rq_for_each_bio(bio, rq) {
>> +		u64 lba = sectors_to_logical(sdp, bio->bi_iter.bi_sector);
>> +		u32 nr_blocks = sectors_to_logical(sdp, bio_sectors(bio));
>> +
>> +		put_unaligned_be64(lba, &buf[8 + 16 * i]);
>> +		put_unaligned_be32(nr_blocks, &buf[8 + 16 * i + 8]);
> 
> Can we have a local variable here?
> 
> 	unsigned int data_offset = 8;
> 
> 	....
> 

Thanks for the review, I've updated the patch.

Thanks,

> 		put_unaligned_be64(lba, &buf[data_offset]);
> 		put_unaligned_be64(lba, &buf[data_offset + 8]);
> 		data_offset += 16;
> 	}
> 
