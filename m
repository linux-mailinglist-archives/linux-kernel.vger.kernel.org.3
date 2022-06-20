Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44390551046
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiFTGYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiFTGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:24:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E786263CD;
        Sun, 19 Jun 2022 23:24:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 008CF21B85;
        Mon, 20 Jun 2022 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655706273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hr3/37jxG57EYxXXjTqzWDrdvvVL4USOVNoiGW+pHA=;
        b=Rr1/KkVRBJ+ZUD2nvBMQN1PV/3c7aN4qMju4I8xNfL8sWQ3/7HVsXNaIaaW+sjW8IDhC7Z
        WYinOQ8eS12NDrHjCiCLbUGUIPF2tUT4q7S3sPjU8GY7vgRSsgDK7kvhoz9XQqA/TKBMIb
        yrtJErkFNddWSAQg58nh8hlg6XwQo74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655706273;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hr3/37jxG57EYxXXjTqzWDrdvvVL4USOVNoiGW+pHA=;
        b=Lufj3gO3lhaDPcfTBR0VXuX9XnMPF1bUaPtCCGho4nHy+2s+DysRi5wqRVTGMMkKWCLuEW
        kEaJDOYx3cwaGBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1701513638;
        Mon, 20 Jun 2022 06:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aFmkA5sSsGLEagAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:24:27 +0000
Message-ID: <88d192b5-741b-7104-7f72-0178aa18bafb@suse.de>
Date:   Mon, 20 Jun 2022 08:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 09:01, Damien Le Moal wrote:
> On 6/9/22 19:29, John Garry wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Quite some drivers are using management commands internally, which
>> typically use the same hardware tag pool (ie they are being allocated
>> from the same hardware resources) as the 'normal' I/O commands.
>> These commands are set aside before allocating the block-mq tag bitmap,
>> so they'll never show up as busy in the tag map.
>> The block-layer, OTOH, already has 'reserved_tags' to handle precisely
>> this situation.
>> So this patch adds a new field 'nr_reserved_cmds' to the SCSI host
>> template to instruct the block layer to set aside a tag space for these
>> management commands by using reserved tags.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/hosts.c     |  3 +++
>>   drivers/scsi/scsi_lib.c  |  6 +++++-
>>   include/scsi/scsi_host.h | 22 +++++++++++++++++++++-
>>   3 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>> index 8352f90d997d..27296addaf63 100644
>> --- a/drivers/scsi/hosts.c
>> +++ b/drivers/scsi/hosts.c
>> @@ -474,6 +474,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>>   	if (sht->virt_boundary_mask)
>>   		shost->virt_boundary_mask = sht->virt_boundary_mask;
>>   
>> +	if (sht->nr_reserved_cmds)
>> +		shost->nr_reserved_cmds = sht->nr_reserved_cmds;
>> +
>>   	device_initialize(&shost->shost_gendev);
>>   	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>>   	shost->shost_gendev.bus = &scsi_bus_type;
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 6ffc9e4258a8..f6e53c6d913c 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1974,8 +1974,12 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>>   	else
>>   		tag_set->ops = &scsi_mq_ops_no_commit;
>>   	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
>> +
>>   	tag_set->nr_maps = shost->nr_maps ? : 1;
>> -	tag_set->queue_depth = shost->can_queue;
>> +	tag_set->queue_depth =
>> +		shost->can_queue + shost->nr_reserved_cmds;
>> +	tag_set->reserved_tags = shost->nr_reserved_cmds;
>> +
>>   	tag_set->cmd_size = cmd_size;
>>   	tag_set->numa_node = dev_to_node(shost->dma_dev);
>>   	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index 59aef1f178f5..149dcbd4125e 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -366,10 +366,19 @@ struct scsi_host_template {
>>   	/*
>>   	 * This determines if we will use a non-interrupt driven
>>   	 * or an interrupt driven scheme.  It is set to the maximum number
>> -	 * of simultaneous commands a single hw queue in HBA will accept.
>> +	 * of simultaneous commands a single hw queue in HBA will accept
>> +	 * excluding internal commands.
>>   	 */
>>   	int can_queue;
>>   
>> +	/*
>> +	 * This determines how many commands the HBA will set aside
>> +	 * for internal commands. This number will be added to
>> +	 * @can_queue to calcumate the maximum number of simultaneous
> 
> s/calcumate/calculate
> 
> But this is weird. For SATA, can_queue is 32. Having reserved commands,
> that number needs to stay the same. We cannot have more than 32 tags.
> I think keeping can_queue as the max queue depth with at most
> nr_reserved_cmds tags reserved is better.
> 
I had been thinking about this for quite a while, and figured that the 
'reserved' commands model from blk-mq doesn't fit nicely with the SATA 
protocol.

So my idea for SATA is simply _not_ to use reserved tags.
Any TMF functions (or the equivalent thereof) should always be sent as 
non-NCQ commands. And when doing so we're back to QD=1 on SATA anyway, 
so there _must_ be tags available. Consequently the main reason for 
having reserved tags (namely to guarantee that tags are available for 
TMF) doesn't apply here.

Which is why in my initial patchset I've always been referrring to 
'internal' commands, and drivers could select if the 'internal' commands 
are mappend on reserved tags or not.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
