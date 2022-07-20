Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81F957BD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiGTSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiGTSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:04:38 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1355C94E;
        Wed, 20 Jul 2022 11:04:37 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id b10so7515634pjq.5;
        Wed, 20 Jul 2022 11:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2DLDLzdBIlj0E3CffW9I9SY+0ccLj39YX6IMsm99lYc=;
        b=aktSf1liK7of1YwjvV9Y/NSr3TtEtRPNaKxtQSq4pp2JID/Pt9zhicE7jlgMmigwkA
         gd/KLTj/krDm/GCEk3tPoQZ9Hv6xLnGPnLukLPiPHuuzZfdsGf2rCY2d+TSpp4KMN6UQ
         anipZDoabQ9XbeclH2Pg0xyjBVjmQiu5rPJlfgJfvnKDbj1DRs1NowN8r7Uo/JSfis3T
         t/jplDRnBFcU1qWAxEdZhoOI8KeC832dyQPyiruU9/8fdUawEPtcMmp255VVaDxKE0zU
         qJQUfYjx0zHhzmRLIL6j9SoX3OfQE5EC/L1iQva15W3kc9mlJO3W2g8TldwXINfithAU
         wUNQ==
X-Gm-Message-State: AJIora8tjeqmSjYE+wr3IR2LrAwijAA4CZv2pX1yjDT6IqUZihGd1Oy3
        W/clhg0Al80hZ9Y1sPmAVHg=
X-Google-Smtp-Source: AGRyM1t+npjVzNapGvdQOe6XU0uS9zS90ajnTnj2KhB8ABZvLighBBWMxjla7Skn/TpMUn71XUu7Vw==
X-Received: by 2002:a17:90a:9406:b0:1f1:a0c0:75d4 with SMTP id r6-20020a17090a940600b001f1a0c075d4mr6846032pjo.198.1658340276699;
        Wed, 20 Jul 2022 11:04:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a7e0:78fc:9269:215b? ([2620:15c:211:201:a7e0:78fc:9269:215b])
        by smtp.gmail.com with ESMTPSA id g1-20020a632001000000b004119deff40dsm12176331pgg.23.2022.07.20.11.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:04:35 -0700 (PDT)
Message-ID: <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org>
Date:   Wed, 20 Jul 2022 11:04:33 -0700
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
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
 <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
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

On 7/20/22 10:44, Geert Uytterhoeven wrote:
> On Wed, Jul 20, 2022 at 6:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> I'm not familiar with the SATA code but from a quick look it seems like
>> the above code is only triggered from inside the ATA error handler
>> (ata_do_eh() -> ata_eh_recover() -> ata_eh_revalidate_and_attach() ->
>> schedule_work(&(ap->scsi_rescan_task) -> ata_scsi_dev_rescan()). It
>> doesn't seem normal to me that the ATA error handler gets invoked during
>> a resume. How about testing the following two code changes?
> 
> Thanks for your suggestions!
> 
>> * In sd_start_stop_device(), change "return sd_submit_start(sdkp, cmd,
>> sizeof(cmd))" into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and below
>> that call add "flush_work(&sdkp->start_done_work)". This makes
>> sd_start_stop_device() again synchronous. This will learn us whether the
>> behavior change is caused by submitting the START command from another
>> context or by not waiting until the START command has finished.
> 
> Unfortunately this doesn't have any impact.
> 
>> * Back out the above change, change "return sd_submit_start(sdkp, cmd,
>> sizeof(cmd))" again into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and
>> below that statement add a call to
>> scsi_run_queue(sdkp->device->request_queue). If this change helps it
> 
> (that's the static scsi_run_queue() in drivers/scsi/scsi_lib.c?)
> 
>> means that the scsi_run_queue() call is necessary to prevent reordering
>> of the START command with other SCSI commands.
> 
> Unfortunately this doesn't have any impact either.

That's surprising. Is there anything unusual about the test setup that I 
should know, e.g. very small number of CPU cores or a very small queue 
depth of the SATA device? How about adding pr_info() statements at the 
start and end of the following functions and also before the return 
statements in these functions to determine where execution of the START 
command hangs?
* sd_start_done().
* sd_start_done_work().

Thanks,

Bart.
