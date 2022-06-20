Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341475512BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiFTI1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiFTI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:27:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8512766;
        Mon, 20 Jun 2022 01:27:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EAF721F383;
        Mon, 20 Jun 2022 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655713626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7a55sDqLr3nHehTjUE6NuY1NZojZC2QF9+TEU1BEDY=;
        b=iHniCPBhZgqE6ACKaQt/CaZy7KtMZC/fxgvc9n+lVZM0dw54H8nrLXbhnb8pbblGFVDiq3
        26G4XRueDKdPmgEDhOyAsEb8vpZ1g/bTGfApT4k4LN3RFjI8MZLDKcJyYHOCxdZcQ7zjXg
        kqVGNRJFqPDhbUZ3FNXm2xv1VcZdV4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655713626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7a55sDqLr3nHehTjUE6NuY1NZojZC2QF9+TEU1BEDY=;
        b=8nJkiEW8Wm7iLuxxe3h1VUGo1c7HEByQkf3hU++y2/S+Ta89yQB+1xiyB1Kej3Cay/uoMB
        oom8xYArmOyFeVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B910E13638;
        Mon, 20 Jun 2022 08:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /gHCLFovsGKIIwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:27:06 +0000
Message-ID: <7b046321-fdb3-33f0-94a0-78a25cbbe02e@suse.de>
Date:   Mon, 20 Jun 2022 10:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>,
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
 <c702f06e-b7da-92be-3c4f-5dd405600235@opensource.wdc.com>
 <ecfb0694-21b8-55b4-c9b8-5e738f59ce8d@huawei.com>
 <98fa010d-3555-a82b-e960-f47aeeb38151@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <98fa010d-3555-a82b-e960-f47aeeb38151@opensource.wdc.com>
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

On 6/16/22 10:41, Damien Le Moal wrote:
> On 2022/06/16 17:24, John Garry wrote:
>> On 16/06/2022 03:47, Damien Le Moal wrote:
>>>>> so going backward several years... That internal tag for ATA does not
>>>>> need to be reserved since this command is always used when the drive is
>>>>> idle and no other NCQ commands are on-going.
>>>>
>>>> So do you mean that ATA_TAG_INTERNAL qc is used for other commands
>>>> apart from internal commands?
>>>
>>> No. It is used only for internal commands. What I meant to say is that
>>> currently, internal commands are issued only on device scan, device
>>> revalidate and error handling. All of these phases are done with the
>>> device under EH with the issuing path stopped and all commands
>>> completed,
>>
>> If I want to allocate a request for an ATA internal command then could I
>> use 1x from the regular tags? I didn't think that this was possible as I
>> thought that all tags may be outstanding when EH kicks in. I need to
>> double check it.
> 
> When EH kicks in, the drive is in error mode and all commands are back to the
> host. From there, you need to get the drive out of error mode with read log 10h
> and then internal commands can be issued if needed. Then the aborted commands
> that are not in error are restarted.
> 
> For the non-error case (revalidate), ap->ops->qc_defer() will make sure that NCQ
> and non-NCQ commands are never mixed. Since all internal commands are non-ncq,
> when an internal command is issued, there are necessarily no other commands
> ongoing, but 32 NCQ commands may be waiting, without any free tag. The internal
> command being non-NCQ can still proceed since it does not need a real device tag.
> 
> The joy of ATA...
> 
>> Even if it were true, not using a reserved tag for ATA internal command
>> makes things more tricky as this command requires special handling for
>> scsi blk_mq_ops and there is no easy way to identify the command as
>> reserved (to know special handling is required).
> 
> Yes. Having the ATA_TAG_INTERNAL tag as a reserved tag is fine. But from the
> above, you can see that this is not really needed at all to make things work.
> The management of ATA_TAG_INTERNAL as a reserve tag is really about getting your
> API to simplify the code.
> 
> What I am thinking is that with your patches as is, it seems that we can never
> actually reserve a real tag for ATA to do internal NCQ commands... We do not
> really need that for now though, apart maybe for speeding up device revalidate.
> Everytime that one runs, one can see a big spike in read/write IO latencies
> because of the queue drain it causes.
> 
Hmm. But doesn't that mean the we can reserve one tag, _and_ set the 
queue depth to '32'?
We'll need to fiddle with the tag map on completion (cf my previous 
mail), but then we might need to do that anyway if we separate out 
ATA_QCFLAG_INTERNAL ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
