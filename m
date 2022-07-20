Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07C57BBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiGTQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiGTQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:51:26 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CDCE02C;
        Wed, 20 Jul 2022 09:51:24 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id s206so16918970pgs.3;
        Wed, 20 Jul 2022 09:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uec/oXr/Tjpv6wPvs6IdX7AlVzGoN0KQw6QozY3V18c=;
        b=z4/IqObr4z+IZlNEVPByOydzTKVwQAf3o89llzUgZqRMJ/S0CCc3CLddZA8NxHC5tG
         rQxMv/+bUgAr4ayyewsVEb9RFVjM2glydU5w6vylVVx03qXtWj3Jil1p26hjUVFmvTZK
         NPRE1EOBfMPgHB4vrAyNnothbXUhGdMWVrHoCAsnLGeqsI8AYKxRKGvumu9KIP59s14C
         AjLczqqRrq2iZ2wXK7FZllGabbDAIr0Lfn7ka9yupDmlCi7TdXf7q4OD9bvzUqBcH+cD
         nXU2sHhT4oR4WZmKsr8/I3EHxnCxegYNEgPA2ZZc+pHd4RiHcErO2QSMdURpSAbhfn7k
         dT3g==
X-Gm-Message-State: AJIora8SWpmPXsIHgQNcGBvvohTQSWdyTNtdILx9nJCm/RdGfBnp0B2j
        l9WusUPa3qGaJki8aq6I7Fc=
X-Google-Smtp-Source: AGRyM1uaU2qxU/0Zbhk4YttPSiycxVxEvIcS4KUr9UVGt5nOuB/Cq2h/iI2cdq1mpA+GiAyvhVh8ug==
X-Received: by 2002:a63:1648:0:b0:41a:49f9:77ae with SMTP id 8-20020a631648000000b0041a49f977aemr8822433pgw.377.1658335883867;
        Wed, 20 Jul 2022 09:51:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a7e0:78fc:9269:215b? ([2620:15c:211:201:a7e0:78fc:9269:215b])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090aa00600b001f2128b11a4sm1879933pjp.38.2022.07.20.09.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 09:51:23 -0700 (PDT)
Message-ID: <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
Date:   Wed, 20 Jul 2022 09:51:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 00:47, Geert Uytterhoeven wrote:
> With more debug options enabled, it prints:
> 
> INFO: task kworker/0:7:283 blocked for more than 120 seconds.
>        Not tainted 5.19.0-rc7-salvator-x-00794-g6780eb02b605 #1287
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:7     state:D stack:    0 pid:  283 ppid:     2 flags:0x00000008
> Workqueue: events ata_scsi_dev_rescan
> Call trace:
>   __switch_to+0xbc/0x124
>   __schedule+0x540/0x71c
>   schedule+0x58/0xa0
>   io_schedule+0x18/0x34
>   blk_mq_get_tag+0x138/0x244
>   __blk_mq_alloc_requests+0x130/0x2f0
>   blk_mq_alloc_request+0x74/0xa8
>   scsi_alloc_request+0x10/0x30
>   __scsi_execute+0x5c/0x18c
>   scsi_vpd_inquiry+0x7c/0xdc
>   scsi_get_vpd_size+0x34/0xa8
>   scsi_get_vpd_buf+0x28/0xf4
>   scsi_attach_vpd+0x44/0x170
>   scsi_rescan_device+0x30/0x98
>   ata_scsi_dev_rescan+0xc8/0xfc
>   process_one_work+0x2e0/0x474
>   worker_thread+0x1cc/0x270
>   kthread+0xd8/0xe8
>   ret_from_fork+0x10/0x20
> 
> This doesn't look like it's blocked in the R-Car SATA driver, but on
> some I/O scheduling event in the block core?

I'm not familiar with the SATA code but from a quick look it seems like 
the above code is only triggered from inside the ATA error handler 
(ata_do_eh() -> ata_eh_recover() -> ata_eh_revalidate_and_attach() -> 
schedule_work(&(ap->scsi_rescan_task) -> ata_scsi_dev_rescan()). It 
doesn't seem normal to me that the ATA error handler gets invoked during 
a resume. How about testing the following two code changes?
* In sd_start_stop_device(), change "return sd_submit_start(sdkp, cmd, 
sizeof(cmd))" into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and below 
that call add "flush_work(&sdkp->start_done_work)". This makes 
sd_start_stop_device() again synchronous. This will learn us whether the 
behavior change is caused by submitting the START command from another 
context or by not waiting until the START command has finished.
* Back out the above change, change "return sd_submit_start(sdkp, cmd, 
sizeof(cmd))" again into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and 
below that statement add a call to 
scsi_run_queue(sdkp->device->request_queue). If this change helps it 
means that the scsi_run_queue() call is necessary to prevent reordering 
of the START command with other SCSI commands.

Thanks,

Bart.
