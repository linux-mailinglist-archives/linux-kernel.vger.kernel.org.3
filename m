Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8872B4E4309
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiCVPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbiCVPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:33:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E834582D1B;
        Tue, 22 Mar 2022 08:31:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8274A210F1;
        Tue, 22 Mar 2022 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647963099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1c/rJ5zsOe6izMAywNihCkRbKskhCC49AlHaBgO/6z4=;
        b=yDjr5talsyqmn0o1mnh+OtM/7FMwCxeS9ztI0XAL1ITVGrAfbufzT3zwBPOGrRf/T/6USD
        +RR24T2FU/64dNqwXpO1izHSx1oyAHkVNRJDQ/jfySCFVW6RAmQSbkntQ5xMCZ5KuW2Ila
        ZzHQQRPCSHUG5yEJ5CpJV+jox0Ss+0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647963099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1c/rJ5zsOe6izMAywNihCkRbKskhCC49AlHaBgO/6z4=;
        b=DJK0sRJR7Yl4zjn0P3a3t87Wq2xhF/fNbQ0iLuwVbQT0lhyI/GbQy0PRead0QMXxx3D/PC
        wK3oaNBz5X/jbGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63EFD133B6;
        Tue, 22 Mar 2022 15:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dFkVGNvrOWKxTQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 22 Mar 2022 15:31:39 +0000
Message-ID: <85bbf7a7-70c2-2410-6399-5f0454621c23@suse.de>
Date:   Tue, 22 Mar 2022 16:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        bvanassche@acm.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        ming.lei@redhat.com, chenxiang66@hisilicon.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, beanhuo@micron.com
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
 <1647945585-197349-2-git-send-email-john.garry@huawei.com>
 <20220322111848.GA29270@lst.de>
 <cacc3f7b-c8be-0f72-1c52-562c15b468a4@huawei.com>
 <b5df2ef1-2d6d-340e-e4b4-09132dc0516b@suse.de>
 <a5e42012-c1fc-082e-e636-594abc07dd70@huawei.com>
 <306df4cf-0ee0-2b1e-044c-aed6c70122f9@suse.de>
 <0f7b9765-8835-25b5-4cdb-bc78edddad37@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
In-Reply-To: <0f7b9765-8835-25b5-4cdb-bc78edddad37@huawei.com>
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

On 3/22/22 16:17, John Garry wrote:
> On 22/03/2022 14:03, Hannes Reinecke wrote:
>>>
>>> As mentioned in the cover letter response, it just seems best to keep 
>>> the normal scsi_cmnd payload but have other means to add on the 
>>> internal command data, like using host_scribble or scsi_cmnd priv data.
>>>
>> Well; I found that most drivers I had been looking at the scsi command 
>> payload isn't used at all; the drivers primarily cared about the 
>> (driver-provided) payload, and were completely ignoring the scsi 
>> command payload.
>>
>> Similar for ATA/libsas: you basically never issue real scsi commands, 
>> but either 'raw' ATA requests or SCSI TMFs. None of which are scsi 
>> commands, so providing them is a bit of a waste.
>>
>> (And causes irritations, too, as a scsi command requires associated 
>> pointers like ->device etc to be set up. Which makes it tricky to use 
>> for the initial device setup.)
> 
> A problem I see is that in scsi_mq_init_request() we allocate memories 
> like sense_buffer and prot_sdb and store the pointers in the scsi_cmnd 
> payload. If we then reuse a scsi_cmnd payload as an "internal" command 
> payload then this data may be lost.
> 
> It might be possible to reuse the scsi cmnd payload for the "internal", 
> but I would rather not get hung up on it now if possible.
> 
Or, keep the payload as is, and use the 'internal' marker to indicate 
that the scsi payload is not valid.
That would save us quite some checks during endio processing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
