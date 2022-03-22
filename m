Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512494E3E47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiCVMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiCVMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB03C6AA5A;
        Tue, 22 Mar 2022 05:16:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F589210F7;
        Tue, 22 Mar 2022 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647951407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEscCc8/86+SaueZ18oa40l5lgaI4P/Hsi1HHzCUq+s=;
        b=yAKxu05+9BNh7Tybv+lY+sc/0dYBJM1bYk4cevFQVfD/3ehwWmfXTJ7DjkQk2W3QFSeoe5
        /RMvuJq+koBBB2wi99InAMPcst7P70wWLZ9186uBLh13cXG8o5QmB1MGcvabI7X1mlxe4d
        mtI397K27aSAD1wm1TsmqO9gT8c1VKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647951407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEscCc8/86+SaueZ18oa40l5lgaI4P/Hsi1HHzCUq+s=;
        b=HiPOy+lnaN/XAX6nahHb2fSWq96171tVhiW3B7BB/L0S/jsf98FlEnAtv8xcVbPHMJu53Z
        c/u/kDzq2mJAN/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3774412FC5;
        Tue, 22 Mar 2022 12:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ayv1DC++OWJAYQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 22 Mar 2022 12:16:47 +0000
Message-ID: <b5df2ef1-2d6d-340e-e4b4-09132dc0516b@suse.de>
Date:   Tue, 22 Mar 2022 13:16:46 +0100
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
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
In-Reply-To: <cacc3f7b-c8be-0f72-1c52-562c15b468a4@huawei.com>
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

On 3/22/22 12:33, John Garry wrote:
> On 22/03/2022 11:18, Christoph Hellwig wrote:
>> On Tue, Mar 22, 2022 at 06:39:35PM +0800, John Garry wrote:
>>> Add an API to allocate a request queue which accepts a custom set of
>>> blk_mq_ops for that request queue.
>>>
>>> The reason which we may want custom ops is for queuing requests which we
>>> don't want to go through the normal queuing path.
>>
>> Eww.  I really do not think we should do separate ops per queue, as that
>> is going to get us into a deep mess eventually.
>>
> 
> Yeah... so far (here) it works out quite nicely, as we don't need to 
> change the SCSI blk mq ops nor allocate a scsi_device - everything is 
> just separate.
> 
> The other method mentioned previously was to add the request "reserved" 
> flag and add new paths in scsi_queue_rq() et al to handle this, but that 
> gets messy.
> 
> Any other ideas ...?
> 

As outlined in the other mail, I think might be useful is to have a 
_third_ type of requests (in addition to the normal and the reserved ones).
That one would be allocated from the normal I/O pool (and hence could 
fail if the pool is exhausted), but would be able to carry a different 
payload (type) than the normal requests.
And we could have a separate queue_rq for these requests, as we can 
differentiate them in the block layer.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
