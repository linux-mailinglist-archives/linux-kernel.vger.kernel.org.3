Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8907957C5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiGUIHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGUIHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:07:49 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC037D1CA;
        Thu, 21 Jul 2022 01:07:48 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id r24so729054qtx.6;
        Thu, 21 Jul 2022 01:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeXUgWfSBwMA0/mnxBHkh+G2d6QD85lH1tvWPe7kfmU=;
        b=G8jYurc4SOoMRJRYTacFTd5Tpd+r/IknAy6t2pGlrwrBRj1qteES0bNDfFTdbw7EKX
         5dXSHkSgzkQujYqGo+9q65qnRuHJj4ta8MGnvictj1TpCXlgjOaVtCQ6tbL8zRVy2nRz
         eFQ9PJRWMTJiGnu59wiTOzdnwIdLkaUOC9p+J+cyPS0nuYtBqSIfqouY/T9pbr7jm2FH
         f42NcRZDaX61vy/Mf+u58Kz2E8dLDvIYjgLnSGDh3e5mapX5j5jmwFWriJMLa0INIvH7
         YopX+qvnnkWZpQbTcPAQHuFKDpUxEgARIYlwGSnmBEIsfEGie8AXj0QStfoE5Uo6az2F
         Yegg==
X-Gm-Message-State: AJIora9e82AMSb9/E41bNHwOLAKFyZMgnxH/nNvJZFcLDI6R8vtzZ7EH
        qXG823Y/Icrl+RmUUqyCuut83AMeijec9Q==
X-Google-Smtp-Source: AGRyM1uTzlTutYxDz89ACPZo4iqWinNStblbjjURUTlEfKPYJkdQjorAR4BJ98NZVCL1OLE3uk5j2Q==
X-Received: by 2002:ac8:5b44:0:b0:31f:775:c2a2 with SMTP id n4-20020ac85b44000000b0031f0775c2a2mr5175880qtw.122.1658390867025;
        Thu, 21 Jul 2022 01:07:47 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a244f00b006af3bc9c6bbsm1127499qkn.52.2022.07.21.01.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 01:07:46 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id c131so1520302ybf.9;
        Thu, 21 Jul 2022 01:07:46 -0700 (PDT)
X-Received: by 2002:a25:bc8e:0:b0:66e:fe43:645c with SMTP id
 e14-20020a25bc8e000000b0066efe43645cmr40553747ybk.202.1658390865825; Thu, 21
 Jul 2022 01:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org> <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org> <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org>
In-Reply-To: <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 10:07:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
Message-ID: <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Bart,

On Wed, Jul 20, 2022 at 8:04 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On 7/20/22 10:44, Geert Uytterhoeven wrote:
> > On Wed, Jul 20, 2022 at 6:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> I'm not familiar with the SATA code but from a quick look it seems like
> >> the above code is only triggered from inside the ATA error handler
> >> (ata_do_eh() -> ata_eh_recover() -> ata_eh_revalidate_and_attach() ->
> >> schedule_work(&(ap->scsi_rescan_task) -> ata_scsi_dev_rescan()). It
> >> doesn't seem normal to me that the ATA error handler gets invoked during
> >> a resume. How about testing the following two code changes?
> >
> > Thanks for your suggestions!
> >
> >> * In sd_start_stop_device(), change "return sd_submit_start(sdkp, cmd,
> >> sizeof(cmd))" into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and below
> >> that call add "flush_work(&sdkp->start_done_work)". This makes
> >> sd_start_stop_device() again synchronous. This will learn us whether the
> >> behavior change is caused by submitting the START command from another
> >> context or by not waiting until the START command has finished.
> >
> > Unfortunately this doesn't have any impact.
> >
> >> * Back out the above change, change "return sd_submit_start(sdkp, cmd,
> >> sizeof(cmd))" again into "sd_submit_start(sdkp, cmd, sizeof(cmd))" and
> >> below that statement add a call to
> >> scsi_run_queue(sdkp->device->request_queue). If this change helps it
> >
> > (that's the static scsi_run_queue() in drivers/scsi/scsi_lib.c?)
> >
> >> means that the scsi_run_queue() call is necessary to prevent reordering
> >> of the START command with other SCSI commands.
> >
> > Unfortunately this doesn't have any impact either.
>
> That's surprising. Is there anything unusual about the test setup that I
> should know, e.g. very small number of CPU cores or a very small queue
> depth of the SATA device? How about adding pr_info() statements at the
> start and end of the following functions and also before the return
> statements in these functions to determine where execution of the START
> command hangs?
> * sd_start_done().
> * sd_start_done_work().

None of these functions seem to be called at all?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
