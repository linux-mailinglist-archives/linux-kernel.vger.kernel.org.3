Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DE25517DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbiFTL4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiFTL4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:56:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865617E03;
        Mon, 20 Jun 2022 04:56:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA00A21B73;
        Mon, 20 Jun 2022 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655726195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wkpLj1K+yPjMRJxi8utxl0ln69LqNl6bk/oJMw1gi4=;
        b=g5wKTYdSVahRen1Xx4ZVdANCmeFmjoi1EBy2+EXhQj5rhUeouBHw0KBx+D3YR3oHBfcIyj
        28t+BypWrSMddQIJPVhLC3xnTIm/70iAMX4vIpK2Lc6JiiGwBE/wWM8fGcKY6LOUIe1RrX
        26nadAcchEElh1vnT54ytH/5QTS8iZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655726195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wkpLj1K+yPjMRJxi8utxl0ln69LqNl6bk/oJMw1gi4=;
        b=8OP+PeX7Ag28Hlzm51S2jXkO8equavYlE3ZtDEYXl+ptjPVEPWhEB31PHL8TPGL1WXTi0Z
        PjfrpXODVaW6/RDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7FD7134CA;
        Mon, 20 Jun 2022 11:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0lWkMHNgsGIKEQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 11:56:35 +0000
Message-ID: <22bedb25-63ee-3106-f37d-b4ef19ac9e6f@suse.de>
Date:   Mon, 20 Jun 2022 13:56:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
 <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
 <3a27b6ff-e495-8f11-6925-1487c9d14fa9@huawei.com>
 <c702f06e-b7da-92be-3c4f-5dd405600235@opensource.wdc.com>
 <ecfb0694-21b8-55b4-c9b8-5e738f59ce8d@huawei.com>
 <98fa010d-3555-a82b-e960-f47aeeb38151@opensource.wdc.com>
 <7b046321-fdb3-33f0-94a0-78a25cbbe02e@suse.de>
 <9de5ed1b-e874-28ac-0532-cd5420892064@opensource.wdc.com>
 <20220620090543.GA13643@lst.de>
 <41fa0f12-cdcf-f2c4-7366-1abd04312f1f@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
In-Reply-To: <41fa0f12-cdcf-f2c4-7366-1abd04312f1f@opensource.wdc.com>
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

On 6/20/22 13:24, Damien Le Moal wrote:
> On 6/20/22 18:05, Christoph Hellwig wrote:
>> On Mon, Jun 20, 2022 at 06:02:30PM +0900, Damien Le Moal wrote:
>>> So reserving a tag/req to be able to do NCQ at the cost of max qd being 31
>>> works for that. We could keep max qd at 32 by creating one more "fake" tag
>>> and having a request for it, that is, having the fake tag visible to the
>>> block layer as a reserved tag, as John's series is doing, but for the
>>> reserved tags, we actually need to use an effective tag (qc->hw_tag) when
>>> issuing the commands. And for that, we can reuse the tag of one of the
>>> failed commands.
>>
>> Take a look at the magic flush request in blk-flush.c, which is
>> preallocated but borrows a tag from the request that wants a pre- or
>> post-flush.  The logic is rather ugly, but maybe it might actually
>> become cleaner by generalizing it a bit.
> 
> Thanks. Will check.
> I am also looking at scsi_unjam_host() and scsi_eh_get_sense(). These
> reuse a scsi command to do eh operations. So I could use that too, modulo
> making it work outside of eh context to keep the command flow intact.
> 

Tsk. I was hoping to be able to remove it (especially 
scsi_eh_get_sense()), but looks as if we actually do need it.
But it might be not a bad idea to have scsi_eh_get_sense() to run 
independent on the SCSI EH stuff; returning with a sense code is not 
necessary an error, so there are reasons for not always invoking SCSI EH.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
