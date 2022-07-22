Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3F57E615
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiGVR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiGVR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:56:13 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179D4C619;
        Fri, 22 Jul 2022 10:56:12 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d7so5151906plr.9;
        Fri, 22 Jul 2022 10:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K6H8ybl2+ag7idCYOoYVw/oCxdPB2Pr7niRGvSl53OA=;
        b=NA6Va0F0RIvgen9z1fpVvPHFI0qhOk/O9Pfdmq2MlZ80VgZk3D4Ppaer3AijwbYvQU
         PYsM34iG2GzdWqYHYB8p8xMoT9bX2kGfWyLS3HVT2LKAY7fAtkHM3bbtL720LW5BMWiI
         hDzy/UvI5nYcz7CMokFkqicX7cfncbi7mdD2sXRl/sA7XMy5Vfg2ymv9qJk3+VjOiat0
         Hxc1h1tFXpVtBsRmYe8oe6IrHBf5shpuva2Ft7d4A+fYz6veYQdVUZYYVNM1fWWo4YFD
         5471sE8189nZw091jvpMua+ogZLtIhwMXb6gCIy75JdwIvdpGAUTBc1UBRk8KFpT3B6g
         LUAw==
X-Gm-Message-State: AJIora+DEw3eAKjfbOxpOCKbrXQgyULBf0hUqVMFQgWm9p8CW1/V37DV
        Kpac/8jM97Vpu2x56Bp9LkE=
X-Google-Smtp-Source: AGRyM1vCHU8qGyA8pLRAYfvadi7jDT5J7KiHVcv7GaY3IC+IUt3kg/RktDKh1wIJu/8+y40eAeoQfQ==
X-Received: by 2002:a17:90b:33d2:b0:1f0:3a40:982d with SMTP id lk18-20020a17090b33d200b001f03a40982dmr840647pjb.60.1658512572066;
        Fri, 22 Jul 2022 10:56:12 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cf6:7e29:d977:6fc7? ([2620:15c:211:201:9cf6:7e29:d977:6fc7])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b0016c6a6d8967sm4065003plb.83.2022.07.22.10.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:56:11 -0700 (PDT)
Message-ID: <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org>
Date:   Fri, 22 Jul 2022 10:56:09 -0700
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
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org>
 <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
 <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org>
 <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 01:53, Geert Uytterhoeven wrote:
> During s2idle, the following trace data is generated:
> 
>     kworker/u16:9-325     [000] ...2.   230.478731: block_rq_issue: 8,0
> N 0 () 0 + 0 [kworker/u16:9]
>     kworker/u16:9-325     [000] ...2.   230.478745:
> scsi_dispatch_cmd_start: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0
> cmnd=(SYNCHRONIZE_CACHE - raw=35 00 00 00 00 00 00 00 00 00)
>            <idle>-0       [007] d.h3.   230.478832:
> scsi_dispatch_cmd_done: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0
> cmnd=(SYNCHRONIZE_CACHE - raw=35 00 00 00 00 00 00 00 00 00)
> result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE
> status=SAM_STAT_GOOD)
>            <idle>-0       [000] ..s2.   230.478851: block_rq_complete:
> 8,0 N () 18446744073709551615 + 0 [0]
>     kworker/u16:9-325     [000] ...2.   230.483134: block_rq_issue: 8,0
> N 0 () 0 + 0 [kworker/u16:9]
>     kworker/u16:9-325     [000] ...2.   230.483136:
> scsi_dispatch_cmd_start: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1
> cmnd=(START_STOP - raw=1b 00 00 00 00 00)
>            <idle>-0       [007] d.h3.   230.624530:
> scsi_dispatch_cmd_done: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1
> cmnd=(START_STOP - raw=1b 00 00 00 00 00) result=(driver=DRIVER_OK
> host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
>            <idle>-0       [000] d.s4.   230.624634: scsi_eh_wakeup: host_no=0
>            <idle>-0       [000] ..s2.   230.624642: block_rq_complete:
> 8,0 N () 18446744073709551615 + 0 [0]
>    kworker/u16:14-1027    [007] d..3.   231.393642: scsi_eh_wakeup: host_no=0
> 
> When reading from hard drive after s2idle, no more trace data
> is generated.

I think the above commands come from the suspend sequence. '1b 00 00 00 
00 00' stops a block device. The lowest bit in byte 4 needs to be set to 
start a block device.

Something that is not yet clear is whether or not sd_submit_start() 
hangs during the resume process. How about verifying whether or not 
sd_submit_start() hangs by either issuing SysRq-t or by adding pr_info() 
statements in that function?

Thanks,

Bart.
