Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7B590FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiHLKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiHLKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:48:16 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777C9FF8;
        Fri, 12 Aug 2022 03:48:15 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id b7so325501qvq.2;
        Fri, 12 Aug 2022 03:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T/2FZXIGpYCgsZ5/AhrQtZsSNuWBGq95VlFDnMpQa1w=;
        b=hlQKb3NdbPy6jaDgbmW4iBbYwRuHIMS8Le3K++MdPVp6+Nk8hy9VCaQ14q8fhH8oYy
         cWisbOis/tNdvENJdpGIbxlsPwuQZgi0KqH9pFEaXKDEwAnNq+oQgT/HVZJsRygPeMfV
         l4ELMa22T2yzjbhqt4EhkQOzsLmR7wHhpqvioVMQzExNNfwB4xhLEhefbqL5GOFSWxVY
         eZKSo3mOwrB7Fp9uPEFpVSQQl1bI9FdoHUFYzUovu59GZoJg81VVQRNj9rZd/XtytQ9X
         bcqY66g78cagIFRMMgWO93zJz9h4v7XBWFFu2WQc8bPSlEBWD4wNyq9joylBrTHNBpE9
         OefQ==
X-Gm-Message-State: ACgBeo3uX9TS0vQAa/+sdGgVIz90OfXoWBBvW6d3v/xQtA7M5pHoNoeE
        1zYySU/D1Tqx+Q331KGmhDOhgrzxoBsMtg==
X-Google-Smtp-Source: AA6agR63zvSfbSnFL2zmb1zqThSIu80vwXrWmJ2GlYraOaEMqtO2Lojivr14qVU41RI5Whl7ic38Pw==
X-Received: by 2002:ad4:4b30:0:b0:476:f037:8a2 with SMTP id s16-20020ad44b30000000b00476f03708a2mr2754488qvw.2.1660301294202;
        Fri, 12 Aug 2022 03:48:14 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b006b8cff25187sm1537953qkl.42.2022.08.12.03.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:48:13 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-32a17d3bba2so6123987b3.9;
        Fri, 12 Aug 2022 03:48:12 -0700 (PDT)
X-Received: by 2002:a81:13c2:0:b0:31f:3dc8:e01 with SMTP id
 185-20020a8113c2000000b0031f3dc80e01mr3214850ywt.316.1660301292378; Fri, 12
 Aug 2022 03:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org> <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org> <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org> <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
 <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org> <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
 <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org>
In-Reply-To: <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 12:48:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
Message-ID: <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

CC linux-ide

On Fri, Jul 22, 2022 at 7:56 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On 7/22/22 01:53, Geert Uytterhoeven wrote:
> > During s2idle, the following trace data is generated:
> >
> >     kworker/u16:9-325     [000] ...2.   230.478731: block_rq_issue: 8,0
> > N 0 () 0 + 0 [kworker/u16:9]
> >     kworker/u16:9-325     [000] ...2.   230.478745:
> > scsi_dispatch_cmd_start: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> > prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0
> > cmnd=(SYNCHRONIZE_CACHE - raw=35 00 00 00 00 00 00 00 00 00)
> >            <idle>-0       [007] d.h3.   230.478832:
> > scsi_dispatch_cmd_done: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> > prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0
> > cmnd=(SYNCHRONIZE_CACHE - raw=35 00 00 00 00 00 00 00 00 00)
> > result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE
> > status=SAM_STAT_GOOD)
> >            <idle>-0       [000] ..s2.   230.478851: block_rq_complete:
> > 8,0 N () 18446744073709551615 + 0 [0]
> >     kworker/u16:9-325     [000] ...2.   230.483134: block_rq_issue: 8,0
> > N 0 () 0 + 0 [kworker/u16:9]
> >     kworker/u16:9-325     [000] ...2.   230.483136:
> > scsi_dispatch_cmd_start: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> > prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1
> > cmnd=(START_STOP - raw=1b 00 00 00 00 00)
> >            <idle>-0       [007] d.h3.   230.624530:
> > scsi_dispatch_cmd_done: host_no=0 channel=0 id=0 lun=0 data_sgl=0
> > prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1
> > cmnd=(START_STOP - raw=1b 00 00 00 00 00) result=(driver=DRIVER_OK
> > host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
> >            <idle>-0       [000] d.s4.   230.624634: scsi_eh_wakeup: host_no=0
> >            <idle>-0       [000] ..s2.   230.624642: block_rq_complete:
> > 8,0 N () 18446744073709551615 + 0 [0]
> >    kworker/u16:14-1027    [007] d..3.   231.393642: scsi_eh_wakeup: host_no=0
> >
> > When reading from hard drive after s2idle, no more trace data
> > is generated.
>
> I think the above commands come from the suspend sequence. '1b 00 00 00
> 00 00' stops a block device. The lowest bit in byte 4 needs to be set to
> start a block device.
>
> Something that is not yet clear is whether or not sd_submit_start()
> hangs during the resume process. How about verifying whether or not
> sd_submit_start() hangs by either issuing SysRq-t or by adding pr_info()
> statements in that function?

sd_submit_start() is called once during suspend, and once during
resume.  It does not hang.

Reading from /dev/sda hangs after resume (not in sd_submit_start(),
which is never called for reading).

Two tasks are blocked in blk_mq_get_tag() calling io_schedule():

task:kworker/7:1     state:D stack:    0 pid:  122 ppid:     2 flags:0x00000008
Workqueue: events ata_scsi_dev_rescan
Call trace:
 __switch_to+0xbc/0x124
 __schedule+0x540/0x71c
 schedule+0x58/0xa0
 io_schedule+0x18/0x34
 blk_mq_get_tag+0x138/0x244
 __blk_mq_alloc_requests+0x130/0x2f0
 blk_mq_alloc_request+0x74/0xa8
 scsi_alloc_request+0x10/0x30
 __scsi_execute+0x5c/0x18c
 scsi_vpd_inquiry+0x7c/0xdc
 scsi_get_vpd_size+0x34/0xa8
 scsi_get_vpd_buf+0x28/0xf4
 scsi_attach_vpd+0x44/0x170
 scsi_rescan_device+0x30/0x98
 ata_scsi_dev_rescan+0xc8/0xfc
 process_one_work+0x2e0/0x474
 worker_thread+0x1cc/0x270
 kthread+0xd8/0xe8
 ret_from_fork+0x10/0x20


task:hd              state:D stack:    0 pid: 1163 ppid:  1076 flags:0x00000000
Call trace:
 __switch_to+0xbc/0x124
 __schedule+0x540/0x71c
 schedule+0x58/0xa0
 io_schedule+0x18/0x34
 blk_mq_get_tag+0x138/0x244
 __blk_mq_alloc_requests+0x130/0x2f0
 blk_mq_submit_bio+0x44c/0x5b4
 __submit_bio+0x24/0x5c
 submit_bio_noacct_nocheck+0x8c/0x178
 submit_bio_noacct+0x380/0x3b0
 submit_bio+0x34/0x3c
 mpage_bio_submit+0x28/0x38
 mpage_readahead+0xa8/0x178
 blkdev_readahead+0x14/0x1c
 read_pages+0x4c/0x158
 page_cache_ra_unbounded+0xd8/0x174
 do_page_cache_ra+0x40/0x4c
 page_cache_ra_order+0x14/0x1c
 ondemand_readahead+0x124/0x2fc
 page_cache_sync_ra+0x50/0x54
 filemap_read+0x130/0x6e8
 blkdev_read_iter+0xf0/0x164
 new_sync_read+0x74/0xc0
 vfs_read+0xbc/0xd8
 ksys_read+0x6c/0xd4
 __arm64_sys_read+0x14/0x1c
 invoke_syscall+0x70/0xf4
 el0_svc_common.constprop.0+0xbc/0xf0
 do_el0_svc+0x18/0x20
 el0_svc+0x30/0x84
 el0t_64_sync_handler+0x90/0xf8
 el0t_64_sync+0x14c/0x150

I hope this helps.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
