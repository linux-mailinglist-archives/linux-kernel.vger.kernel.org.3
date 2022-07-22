Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12A57DCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiGVIy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiGVIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:54:08 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A769A0B89;
        Fri, 22 Jul 2022 01:53:45 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id o1so3132001qkg.9;
        Fri, 22 Jul 2022 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkGCXdGrrR21H+gPhC+HTZtp3NIUq/FDdVR5xNrLgrU=;
        b=n62ZjNsoIMLr1NMdeouw1ULM32KQyppQ9oSZWuxAEyzWBCSDa0A8+vIFokB4VeidcK
         rmg9vxGwfmC2SNsTx5rGXjNK4jzn0eG64iW+hMAh97tAYXjD15DAjpFPHhjvwjFMZFTk
         MpcYb/PtIFg2MkK5NJBqbDsNzXqIe4cbFFwx9k6uWcUbI2+vE7OFNw8GmBT4uPniNSKV
         g7xz8bJY+qMU97mplvvc8eUNPAD5dITBWd1Ci3ntKhK5+43B1SzxGuOI1whBjelfMku5
         GOp9JEEsgjFg1Br7HHSAkDulZdj2bOe4Mex+N82z6VSVecxRuIgTH1nrXoIVXGd6YQz8
         KvUg==
X-Gm-Message-State: AJIora98V06g36QJ1HXLdRdCLqZrKH8VGioeoMRlIjUBf906/TbRfHOo
        Mge161S6wXHKs3KQEgKcHG59hUxkq3s89A==
X-Google-Smtp-Source: AGRyM1tRZaiH7NkhwV1WjAGSZ9ku1vt9TeyqfZKJSRJRCn5R0sYUj7tGBc8Z750GVDs04IR/darABA==
X-Received: by 2002:a05:620a:4606:b0:6b6:1df6:8ea7 with SMTP id br6-20020a05620a460600b006b61df68ea7mr1734143qkb.276.1658480024470;
        Fri, 22 Jul 2022 01:53:44 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id s34-20020a05622a1aa200b003177969a48fsm2842952qtc.21.2022.07.22.01.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 01:53:43 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id r3so6970327ybr.6;
        Fri, 22 Jul 2022 01:53:43 -0700 (PDT)
X-Received: by 2002:a25:bc8e:0:b0:66e:fe43:645c with SMTP id
 e14-20020a25bc8e000000b0066efe43645cmr2054022ybk.202.1658480022775; Fri, 22
 Jul 2022 01:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org> <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org> <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org> <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
 <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org>
In-Reply-To: <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jul 2022 10:53:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
Message-ID: <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
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

Hoi Bart,

On Thu, Jul 21, 2022 at 8:15 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On 7/21/22 01:07, Geert Uytterhoeven wrote:
> > On Wed, Jul 20, 2022 at 8:04 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> That's surprising. Is there anything unusual about the test setup that I
> >> should know, e.g. very small number of CPU cores or a very small queue
> >> depth of the SATA device? How about adding pr_info() statements at the
> >> start and end of the following functions and also before the return
> >> statements in these functions to determine where execution of the START
> >> command hangs?
> >> * sd_start_done().
> >> * sd_start_done_work().
> >
> > None of these functions seem to be called at all?
>
> That's weird. This means that either sd_submit_start() hangs or that the
> execution of the START command never finishes. The latter is unlikely
> since the SCSI error handler is assumed to abort commands that hang. It
> would also be weird if sd_submit_start() would hang before the START
> command is submitted since the code flow for submitting the START
> command is very similar to the code flow for submitting the START
> command without patch "scsi: sd: Rework asynchronous resume support"
> (calling scsi_execute()).

I think you misunderstood: none of these functions seem to be called,
even when reading from hard drive works fine.

> What is also weird is that there are at least two SATA setups on which
> this code works fine, including my Qemu setup.
>
> Although it is possible to enable tracing at boot time, adding the
> following parameters to the kernel command line would generate too much
> logging data:
>
> tp_printk
> trace_event=block_rq_complete,block_rq_error,block_rq_insert,block_rq_issue,block_rq_merge,block_rq_remap,block_rq_requeue,scsi_dispatch_cmd_done,scsi_dispatch_cmd_start,scsi_eh_wakeup,scsi_dispatch_cmd_error,scsi_dispatch_cmd_timeout
> scsi_mod.scsi_logging_level=32256
>
> I'm not sure what the best way is to proceed since I cannot reproduce
> this issue.

During s2idle, the following trace data is generated:

   kworker/u16:9-325     [000] ...2.   230.478731: block_rq_issue: 8,0
N 0 () 0 + 0 [kworker/u16:9]
   kworker/u16:9-325     [000] ...2.   230.478745:
scsi_dispatch_cmd_start: host_no=0 channel=0 id=0 lun=0 data_sgl=0
prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0
cmnd=(SYNCHRONIZE_CACHE - raw=35 00 00 00 00 00 00 00 00 00)
          <idle>-0       [007] d.h3.   230.478832:
scsi_dispatch_cmd_done: host_no=0 channel=0 id=0 lun=0 data_sgl=0
prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0
cmnd=(SYNCHRONIZE_CACHE - raw=35 00 00 00 00 00 00 00 00 00)
result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE
status=SAM_STAT_GOOD)
          <idle>-0       [000] ..s2.   230.478851: block_rq_complete:
8,0 N () 18446744073709551615 + 0 [0]
   kworker/u16:9-325     [000] ...2.   230.483134: block_rq_issue: 8,0
N 0 () 0 + 0 [kworker/u16:9]
   kworker/u16:9-325     [000] ...2.   230.483136:
scsi_dispatch_cmd_start: host_no=0 channel=0 id=0 lun=0 data_sgl=0
prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1
cmnd=(START_STOP - raw=1b 00 00 00 00 00)
          <idle>-0       [007] d.h3.   230.624530:
scsi_dispatch_cmd_done: host_no=0 channel=0 id=0 lun=0 data_sgl=0
prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1
cmnd=(START_STOP - raw=1b 00 00 00 00 00) result=(driver=DRIVER_OK
host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
          <idle>-0       [000] d.s4.   230.624634: scsi_eh_wakeup: host_no=0
          <idle>-0       [000] ..s2.   230.624642: block_rq_complete:
8,0 N () 18446744073709551615 + 0 [0]
  kworker/u16:14-1027    [007] d..3.   231.393642: scsi_eh_wakeup: host_no=0

When reading from hard drive after s2idle, no more trace data
is generated.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
