Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12492591351
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiHLPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiHLPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:53:08 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9239F0CE;
        Fri, 12 Aug 2022 08:53:08 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id f65so1105126pgc.12;
        Fri, 12 Aug 2022 08:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Xy01o7r1qRYfvttKfpOME67HQkGgv0ZTEftFBcy3PP0=;
        b=xvfDT9kTzWCMsaT5/VZEbVYx3wjTXrON6TRSRHpntkGcMAoRxXpJBetpf5rJWeqPyA
         jxJ0Qo3TmZMlgHvWbfl5pOaOSYdjAGNjLmjiVAbuw4bmt8Ir2xTAS2YE3G187Nd9gxl8
         7nCbm8yYdprXL7C17El2t/0IGWJbOe4Jcdc+M9vGKLh5k9r+WwLFXSieHujsqXohLMe7
         N+xkJhGNqe7mBYcoejcyGeAWxtqMhea8YwB4rT0rpFLBn3IhaR4MyoUhlLkX3d8KKe+F
         iYDKypxls33QK2d8P3RfpO7PQYycOeGn8FwtEzE4lZUh5cUbvOBiOfvaKa6YIHzFL3WH
         SoLw==
X-Gm-Message-State: ACgBeo2Ro9PJftEen8aepgpAXujG8JufEmqlUxxk9+hMl736n5JewiNg
        rcinl03r2Pez14qKeFBvzhg=
X-Google-Smtp-Source: AA6agR74yU/cTSVmxEGOolFw3a8Q1u+dZCKeFfDPq9sYrAgjI8pdJEf+UWbe6og4QBp0o+MNIe3XLw==
X-Received: by 2002:a05:6a00:22cd:b0:52f:706a:5268 with SMTP id f13-20020a056a0022cd00b0052f706a5268mr4455511pfj.80.1660319587402;
        Fri, 12 Aug 2022 08:53:07 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2414:9f13:41de:d21d? ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id s15-20020a63ff4f000000b0040cb1f55391sm1501705pgk.2.2022.08.12.08.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 08:53:06 -0700 (PDT)
Message-ID: <14ec47f3-f3b8-61c7-2c64-d96d00dd7076@acm.org>
Date:   Fri, 12 Aug 2022 08:53:02 -0700
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
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
 <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org>
 <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 03:48, Geert Uytterhoeven wrote:
> sd_submit_start() is called once during suspend, and once during
> resume.  It does not hang.
> 
> Reading from /dev/sda hangs after resume (not in sd_submit_start(),
> which is never called for reading).
> 
> Two tasks are blocked in blk_mq_get_tag() calling io_schedule():
> 
> task:kworker/7:1     state:D stack:    0 pid:  122 ppid:     2 flags:0x00000008
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
> 
> task:hd              state:D stack:    0 pid: 1163 ppid:  1076 flags:0x00000000
> Call trace:
>   __switch_to+0xbc/0x124
>   __schedule+0x540/0x71c
>   schedule+0x58/0xa0
>   io_schedule+0x18/0x34
>   blk_mq_get_tag+0x138/0x244
>   __blk_mq_alloc_requests+0x130/0x2f0
>   blk_mq_submit_bio+0x44c/0x5b4
>   __submit_bio+0x24/0x5c
>   submit_bio_noacct_nocheck+0x8c/0x178
>   submit_bio_noacct+0x380/0x3b0
>   submit_bio+0x34/0x3c
>   mpage_bio_submit+0x28/0x38
>   mpage_readahead+0xa8/0x178
>   blkdev_readahead+0x14/0x1c
>   read_pages+0x4c/0x158
>   page_cache_ra_unbounded+0xd8/0x174
>   do_page_cache_ra+0x40/0x4c
>   page_cache_ra_order+0x14/0x1c
>   ondemand_readahead+0x124/0x2fc
>   page_cache_sync_ra+0x50/0x54
>   filemap_read+0x130/0x6e8
>   blkdev_read_iter+0xf0/0x164
>   new_sync_read+0x74/0xc0
>   vfs_read+0xbc/0xd8
>   ksys_read+0x6c/0xd4
>   __arm64_sys_read+0x14/0x1c
>   invoke_syscall+0x70/0xf4
>   el0_svc_common.constprop.0+0xbc/0xf0
>   do_el0_svc+0x18/0x20
>   el0_svc+0x30/0x84
>   el0t_64_sync_handler+0x90/0xf8
>   el0t_64_sync+0x14c/0x150

Hi Geert,

All that can be concluded from the above is that blk_mq_get_tag() is 
waiting for other I/O request(s) to finish. One or more other requests 
are in progress and either scsi_done() has not been called for these 
requests or the error handler got stuck. Since the issue reported above 
is not observed with other ATA interfaces, this may be related to the 
ATA interface driver used in your test setup.

Bart.

