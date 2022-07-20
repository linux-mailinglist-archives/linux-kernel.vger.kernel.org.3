Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42657B20D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiGTHrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiGTHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:47:37 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DAE68DD0;
        Wed, 20 Jul 2022 00:47:35 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id v28so11519693qkg.13;
        Wed, 20 Jul 2022 00:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6OFt7NDDXTwc0PWSj7z7x7MOLnXeXvAiNcc7ZqxbqU=;
        b=cQReM7C+ScPTHHSF+yEmeMQ2CU1PZr4SrF8nr1TFSwjlUsCAaI5lmGAFHxGAPBrjEC
         n3yNPVOkZ7kUYJPK54PnczYnxjgflgBbq452T4NxU2V1ovGehsaT0wb3pXsvpSAK7KeP
         Flc3Aic1VNI/UY2IVWUb9ruuXQYQnjYsjJ1o3VH7CTGoAj7oBI2tQ8l0c+bGCEQxVKXs
         7RroQIkKT7ZKCP3tfJuYfb/jHY50e/5tph8uVGx41RZr1WHNTyzMz5UGg3s9UBpVb59S
         uFEteJdSYQsP82YNZd3KA09gNfIbFH4RbQyhOG8JbjjSZO80W7nkFgfYssw8s6irGKkE
         uVfg==
X-Gm-Message-State: AJIora/nzcM//Pn+5KtyNJTpzlZurCdD7anXt8nMVFABAYsoMkI6GtK6
        HEMvJOeke3AzFXawCn6P3jGqE//nsMpUQsVb
X-Google-Smtp-Source: AGRyM1vXPndfBHXf4z/PWgBIQNOrZDM/KFrNJlNkPcQSacUXKtkEaUUglsGGANnWOyIlGuzkAUDw7w==
X-Received: by 2002:a37:ccb:0:b0:6b5:e1ad:75b9 with SMTP id 194-20020a370ccb000000b006b5e1ad75b9mr11321220qkm.601.1658303254259;
        Wed, 20 Jul 2022 00:47:34 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006af20edff0csm16590008qko.58.2022.07.20.00.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 00:47:33 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c89653790so164715217b3.13;
        Wed, 20 Jul 2022 00:47:33 -0700 (PDT)
X-Received: by 2002:a0d:dd15:0:b0:31e:6ce3:e67f with SMTP id
 g21-20020a0ddd15000000b0031e6ce3e67fmr1231174ywe.316.1658303252881; Wed, 20
 Jul 2022 00:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org> <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
In-Reply-To: <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jul 2022 09:47:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
Message-ID: <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
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

On Wed, Jul 20, 2022 at 9:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Jul 19, 2022 at 8:14 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > On 7/19/22 02:26, Geert Uytterhoeven wrote:
> > > Thanks for your patch, which is now commit 88f1669019bd62b3 ("scsi: sd:
> > > Rework asynchronous resume support") in scsi/for-next.
> > >
> > > On the Salvator-XS development board[1] with a SATA hard drive
> > > connected, accessing the hard drive after resume from s2idle hangs.
> > > I have bisected this to the aformentioned commit, and reverting this
> > > commit fixes the issue.
> > >
> > > [1] arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts
> >
> > Thank you for having reported this. How about creating a bug report on
> > https://bugzilla.kernel.org/ and attaching the kernel logs with and
>
> I never created a bug report on bko before...
>
> > without this patch? It's probably better to upload the kernel logs
>
> Unfortunately the logs do not indicate anything went wrong.
> I.e. no difference before/after.

With more debug options enabled, it prints:

INFO: task kworker/0:7:283 blocked for more than 120 seconds.
      Not tainted 5.19.0-rc7-salvator-x-00794-g6780eb02b605 #1287
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:    0 pid:  283 ppid:     2 flags:0x00000008
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

This doesn't look like it's blocked in the R-Car SATA driver, but on
some I/O scheduling event in the block core?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
