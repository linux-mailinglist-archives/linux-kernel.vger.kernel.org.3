Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2B551211
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiFTICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbiFTICd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:02:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0011178;
        Mon, 20 Jun 2022 01:02:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B65B91F383;
        Mon, 20 Jun 2022 08:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655712150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3mIJEfos5FRczXq+evNYHSc2VMl3bK+FlH80Aaf4S4=;
        b=KG1ieZI3RKMCFozBnOgTGpV3xZogNkS7Q1rTjxmOTTDqxH2mG/t8MCit3Al4wh2LFIX77W
        AvYsx0ICW34GwE+I3iI7UITSDrhH+cJbdyVusEIcJpD9pJQEA3IQnQopQ+tiWkvngHWbeF
        tA1MMaLwlyVLwwTYPAWHE51AlXA4WXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655712150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3mIJEfos5FRczXq+evNYHSc2VMl3bK+FlH80Aaf4S4=;
        b=L5DmlH7Jm9YSeMGt37pfXDDG0KMrtRlgYLsEtgsHRuRzWyY1IvB6J26q9D+zHKxSBg+5r0
        4QuYubwK4ylsW9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C61F13638;
        Mon, 20 Jun 2022 08:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7G3cJZYpsGLsFwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:02:30 +0000
Message-ID: <c2ae8f65-5570-fdad-3b3a-c00bb10c98c8@suse.de>
Date:   Mon, 20 Jun 2022 10:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
 <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
 <3a27b6ff-e495-8f11-6925-1487c9d14fa9@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
In-Reply-To: <3a27b6ff-e495-8f11-6925-1487c9d14fa9@huawei.com>
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

On 6/15/22 09:35, John Garry wrote:
> On 15/06/2022 00:43, Damien Le Moal wrote:
>> On 6/15/22 03:20, Bart Van Assche wrote:
>>> On 6/13/22 00:01, Damien Le Moal wrote:
>>>> On 6/9/22 19:29, John Garry wrote:
>>>>> +    /*
>>>>> +     * This determines how many commands the HBA will set aside
>>>>> +     * for internal commands. This number will be added to
>>>>> +     * @can_queue to calcumate the maximum number of simultaneous
>>>>
>>>> s/calcumate/calculate
>>>>
>>>> But this is weird. For SATA, can_queue is 32. Having reserved commands,
>>>> that number needs to stay the same. We cannot have more than 32 tags.
>>>> I think keeping can_queue as the max queue depth with at most
>>>> nr_reserved_cmds tags reserved is better.
>>>>
>>>>> +     * commands sent to the host.
>>>>> +     */
>>>>> +    int nr_reserved_cmds;
>>>
>>> +1 for Damien's request. I also prefer to keep can_queue as the maximum
>>> queue depth, whether or not nr_reserved_cmds has been set.
>>
>> For non SATA drives, I still think that is a good idea. However, for 
>> SATA,
>> we always have the internal tag command that is special. With John's
>> change, it would have to be reserved but that means we are down to 31 max
>> QD,
> 
> My intention is to keep regular tag depth at 32 for SATA. We add an 
> extra tag as a reserved tag. Indeed, this is called a 'tag', but it's 
> just really the placeholder for what will be the ATA_TAG_INTERNAL request.
> 
> About how we set scsi_host.can_queue, in this series we set .can_queue 
> as max regular tags, and the handling is as follows:
> 
> scsi_mq_setup_tags():
> tag_set->queue_depth = shost->can_queue + shost->nr_reserved_cmds
> tag_set->reserved_tags = shost->nr_reserved_cmds
> 
> So we honour the rule that blk_mq_tag_set.queue_depth is the total tag 
> depth, including reserved.
> 
> Incidentally I think Christoph prefers to keep .can_queue at total max 
> tags including reserved:
> https://lore.kernel.org/linux-scsi/337339b7-6f4a-a25c-f11c-7f701b42d6a8@suse.de/ 
> 
> 
>> so going backward several years... That internal tag for ATA does not
>> need to be reserved since this command is always used when the drive is
>> idle and no other NCQ commands are on-going.
> 
> So do you mean that ATA_TAG_INTERNAL qc is used for other commands apart 
> from internal commands?
> 
Well.

The problem is that 'ATA_TAG_INTERNAL' currently is overloaded to
a) signal internal commands
b) 'magic' tag when looking up commands

My proposal would be to separate these use-cases, and use a flag (eg 
ATA_QCFLAG_INTERNAL) to determine internal commands.

The we'll be needing an internal tag-lookup map
(NCQ tag -> blk-mq tag) for ata_qc_from_tag() to retrieve the command 
corresponding to a driver tag.

I guess we'll need that anyway with libsas, as there we're working with 
a budget tag which has no relationship with the NCQ tag whatsoever ...

But with that we can kill 'ATA_TAG_INTERNAL', and let the driver figure 
out how to allocate internal tags.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
