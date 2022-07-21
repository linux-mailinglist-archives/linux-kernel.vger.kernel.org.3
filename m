Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB557C3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiGUFkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGUFk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:40:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2C2CC95;
        Wed, 20 Jul 2022 22:40:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D87E209D2;
        Thu, 21 Jul 2022 05:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658382025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfVQON7xknHl8TJztdxmdrLLY/PURiJN0ES1Nfd6CUI=;
        b=Hi8uXc5bJMCrpd4CfWMoAAjovSJ9T02dqd1xtj29juhpfFnEANdkiTdyMhiSYSJwc4I3AB
        pPNKsLv5HKY1ylk7Cb5/2N70ZzqxmoCAAJb6D66fltsRfsGL5WGJI092YSUhD5bptQIQmE
        WmqG0prcN4GwGpezJAk2L+pk7vFkWCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658382025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfVQON7xknHl8TJztdxmdrLLY/PURiJN0ES1Nfd6CUI=;
        b=4TqtpuVqhzEYjt12/Qu0xXKiARsEpll5uU4bwAZDwjjHdPZNc6Bpj/feGBoHkuO83MO6GB
        QJTTAC+WlZ2IqcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4330134CF;
        Thu, 21 Jul 2022 05:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IB76Msjm2GJSZgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 21 Jul 2022 05:40:24 +0000
Message-ID: <d0a3007a-930f-4ae3-2830-ee35585e01d7@suse.de>
Date:   Thu, 21 Jul 2022 07:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220630195703.10155-1-bvanassche@acm.org>
 <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org>
 <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 18:51, Bart Van Assche wrote:
> On 7/20/22 00:47, Geert Uytterhoeven wrote:
>> With more debug options enabled, it prints:
>>
>> INFO: task kworker/0:7:283 blocked for more than 120 seconds.
>>        Not tainted 5.19.0-rc7-salvator-x-00794-g6780eb02b605 #1287
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:kworker/0:7     state:D stack:    0 pid:  283 ppid:     2 
>> flags:0x00000008
>> Workqueue: events ata_scsi_dev_rescan
>> Call trace:
>>   __switch_to+0xbc/0x124
>>   __schedule+0x540/0x71c
>>   schedule+0x58/0xa0
>>   io_schedule+0x18/0x34
>>   blk_mq_get_tag+0x138/0x244
>>   __blk_mq_alloc_requests+0x130/0x2f0
>>   blk_mq_alloc_request+0x74/0xa8
>>   scsi_alloc_request+0x10/0x30
>>   __scsi_execute+0x5c/0x18c
>>   scsi_vpd_inquiry+0x7c/0xdc
>>   scsi_get_vpd_size+0x34/0xa8
>>   scsi_get_vpd_buf+0x28/0xf4
>>   scsi_attach_vpd+0x44/0x170
>>   scsi_rescan_device+0x30/0x98
>>   ata_scsi_dev_rescan+0xc8/0xfc
>>   process_one_work+0x2e0/0x474
>>   worker_thread+0x1cc/0x270
>>   kthread+0xd8/0xe8
>>   ret_from_fork+0x10/0x20
>>
>> This doesn't look like it's blocked in the R-Car SATA driver, but on
>> some I/O scheduling event in the block core?
> 
> I'm not familiar with the SATA code but from a quick look it seems like 
> the above code is only triggered from inside the ATA error handler 
> (ata_do_eh() -> ata_eh_recover() -> ata_eh_revalidate_and_attach() -> 
> schedule_work(&(ap->scsi_rescan_task) -> ata_scsi_dev_rescan()). It 
> doesn't seem normal to me that the ATA error handler gets invoked during 
> a resume. How about testing the following two code changes?

Sadly, that _is_ the normal workflow. SATA EH gets invoked regularly, 
and is handling the device resets after resume.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
