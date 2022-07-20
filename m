Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC65157BD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiGTRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGTRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:44:40 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEA84AD57;
        Wed, 20 Jul 2022 10:44:38 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id h18so4268385qvr.12;
        Wed, 20 Jul 2022 10:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MsTEfbt4L6FalHmKt8VsogFuWDPpiL5KzDKo6pfQR4=;
        b=Q4uIGpZUEySFurg+0mlmx/6VhKgrnHWuirSxhkP5cpX5oiTUdWfmrnQ3xZObLJwL3D
         JyprUhZ7B+VREFHU+3kKuBG7u3ldUENPoKSVuNLhhHknAcSeclIfDG8bj6XCr7+6Tbwo
         Y+bxTLRzGMy7VxcIWLb1CIrNq8ha72I62/hAnP+Joch+B/LCrqzfc4SHwv61RuOqnvDD
         CSjPpEAKjrn0o6ZwRsF9TSXyt2W+ILJ46l/FeaJAkgPBCRiTaDwIxyaJPbBQyVE1c41A
         t6q+1/n/oVPjTwJArYJUt9IW6sQtHGd4XkWO3cmyOWTChQeiWzCrZzDB0g4RcUet6rLc
         7STw==
X-Gm-Message-State: AJIora8w1uMyOl1A7rOMKfljpzLfyase+X21FSzn8TfeO95i7iDPIej6
        D7ymCkFHxR7h3gGOZSRlBXHegyoaA5in/Wa/
X-Google-Smtp-Source: AGRyM1sc2WgrP5H7OuBfP7BnrBBNksBpNwV28P7UWS9J7We0oYSjK2QE4LIxQFea7+nPpTKPZ8FwuQ==
X-Received: by 2002:a05:6214:2302:b0:470:2d10:b6e4 with SMTP id gc2-20020a056214230200b004702d10b6e4mr30784518qvb.72.1658339077139;
        Wed, 20 Jul 2022 10:44:37 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id c26-20020a05620a269a00b006b5ba7b9a6fsm16396283qkp.35.2022.07.20.10.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:44:36 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2ef5380669cso181756977b3.9;
        Wed, 20 Jul 2022 10:44:36 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr41950143ywb.502.1658339076192; Wed, 20
 Jul 2022 10:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org> <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com> <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
In-Reply-To: <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jul 2022 19:44:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
Message-ID: <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Wed, Jul 20, 2022 at 6:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On 7/20/22 00:47, Geert Uytterhoeven wrote:
> > With more debug options enabled, it prints:
> >
> > INFO: task kworker/0:7:283 blocked for more than 120 seconds.
> >        Not tainted 5.19.0-rc7-salvator-x-00794-g6780eb02b605 #1287
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:kworker/0:7     state:D stack:    0 pid:  283 ppid:     2 flags:0x00000008
> > Workqueue: events ata_scsi_dev_rescan
> > Call trace:
> >   __switch_to+0xbc/0x124
> >   __schedule+0x540/0x71c
> >   schedule+0x58/0xa0
> >   io_schedule+0x18/0x34
> >   blk_mq_get_tag+0x138/0x244
> >   __blk_mq_alloc_requests+0x130/0x2f0
> >   blk_mq_alloc_request+0x74/0xa8
> >   scsi_alloc_request+0x10/0x30
> >   __scsi_execute+0x5c/0x18c
> >   scsi_vpd_inquiry+0x7c/0xdc
> >   scsi_get_vpd_size+0x34/0xa8
> >   scsi_get_vpd_buf+0x28/0xf4
> >   scsi_attach_vpd+0x44/0x170
> >   scsi_rescan_device+0x30/0x98
> >   ata_scsi_dev_rescan+0xc8/0xfc
> >   process_one_work+0x2e0/0x474
> >   worker_thread+0x1cc/0x270
> >   kthread+0xd8/0xe8
> >   ret_from_fork+0x10/0x20
> >
> > This doesn't look like it's blocked in the R-Car SATA driver, but on
> > some I/O scheduling event in the block core?
>
> I'm not familiar with the SATA code but from a quick look it seems like
> the above code is only triggered from inside the ATA error handler
> (ata_do_eh() -> ata_eh_recover() -> ata_eh_revalidate_and_attach() ->
> schedule_work(&(ap->scsi_rescan_task) -> ata_scsi_dev_rescan()). It
> doesn't seem normal to me that the ATA error handler gets invoked during
> a resume. How about testing the following two code changes?

Thanks for your suggestions!

> * In sd_start_stop_device(), change "return sd_submit_start(sdkp, cmd,
> sizeof(cmd))" into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and below
> that call add "flush_work(&sdkp->start_done_work)". This makes
> sd_start_stop_device() again synchronous. This will learn us whether the
> behavior change is caused by submitting the START command from another
> context or by not waiting until the START command has finished.

Unfortunately this doesn't have any impact.

> * Back out the above change, change "return sd_submit_start(sdkp, cmd,
> sizeof(cmd))" again into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and
> below that statement add a call to
> scsi_run_queue(sdkp->device->request_queue). If this change helps it

(that's the static scsi_run_queue() in drivers/scsi/scsi_lib.c?)

> means that the scsi_run_queue() call is necessary to prevent reordering
> of the START command with other SCSI commands.

Unfortunately this doesn't have any impact either.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
