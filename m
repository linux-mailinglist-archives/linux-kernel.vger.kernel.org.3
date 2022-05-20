Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E31652E514
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbiETGdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiETGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:33:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0714CA03;
        Thu, 19 May 2022 23:33:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 010BD21CA9;
        Fri, 20 May 2022 06:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653028408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIdItr1/0sk8Hct1nUAzdlPfadG1r1sjxjLpyY6HNY0=;
        b=lO9Rxf1icYNXycNnpBFEiQdpXvMTjhY70jO4AaDn6Vhc4k5DazzpPsKO9PcXshBeF5/mmL
        ygo5+WzDKCp/BDi2ADlTq94VyARijKUut6GdeQysOPi09TUyXjd9q8zwCOBbSy3gruzG4h
        seCUY9tS3S5CM4gGB69TBAtRo/rkrDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653028408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIdItr1/0sk8Hct1nUAzdlPfadG1r1sjxjLpyY6HNY0=;
        b=b8ybhCvriW2Q+mSZmTSLE1dGuhFOwU4GvFZUT7LQNHTX8adlfNTotgiZuIJtuy6LuSBmDc
        uN9Mz2bcbpQ8HmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93A2113A5F;
        Fri, 20 May 2022 06:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4q0QIjc2h2LjGQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 20 May 2022 06:33:27 +0000
Message-ID: <eabd386f-9e25-b05c-654e-2b3da0217634@suse.de>
Date:   Fri, 20 May 2022 08:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
 <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
 <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
 <c2d252a1-7223-4899-e5c9-e4bb27e2fc8a@kernel.dk>
 <268233c7-88ad-6b5c-6991-e3a4f1ac2540@suse.de>
 <6f38a339-41b5-aafe-c788-bd34a1806d52@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <6f38a339-41b5-aafe-c788-bd34a1806d52@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 13:02, Randy Dunlap wrote:
> 
> 
> On 5/19/22 06:02, Hannes Reinecke wrote:
>> On 5/19/22 14:42, Jens Axboe wrote:
>>> On 5/19/22 6:40 AM, Jens Axboe wrote:
>>>> On Thu, May 19, 2022 at 6:38 AM Hannes Reinecke <hare@suse.de> wrote:
>>>>>
>>>>> On 5/19/22 14:14, Jens Axboe wrote:
>>>>>> On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
>>>>>>> Greetings,
>>>>>>>
>>>>>>> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>>>>
>>>>>>> Console Logs :
>>>>>>>
>>>>>>> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
>>>>>>> make -j 17 -s && make modules && make modules_install && make install
>>>>>>> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>>>> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>>>>>>> make: *** [Makefile:1914: modules] Error 2
>>>>>>> make: *** Waiting for unfinished jobs....
>>>>>>
>>>>>> Christoph, can you fix this up?
>>>>>>
>>>>> Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
>>>>> Please share details.
>>>>
>>>> The kerneltest bot also reported this a few days ago, you might be able
>>>> to find the details there as that includes config etc.
>>>
>>> Here: https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com/
>>>
>> Right. Send a patch.
> 
> 
> https://lore.kernel.org/all/20220518045704.GA30131@lst.de/
> 
> but it needs to be sent as a formal patch.
> 
I am confused.
The 'for-next' branch from Martin Petersen has the updated patch
(827fc630e4c8 ("scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()")
but linux-next is still on the old (v1) version.

Not sure what to do here.
Martin?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
