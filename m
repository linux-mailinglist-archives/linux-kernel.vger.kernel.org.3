Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B65938F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiHOStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiHOSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:43:45 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1212A27A;
        Mon, 15 Aug 2022 11:27:06 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id y18so6080648qtv.5;
        Mon, 15 Aug 2022 11:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Vcsd5KIyv5vV0yCbV3qFPHVddWMzIuIgoz3STTGEAYU=;
        b=uIiD6Ts40QOW1TjikMRkvOaMO7e6FKqka8Qn//VNQbDMVkPrUY8i774p3D2eMsthzx
         L9KCiTAZe1EmyFiWtjlPnER5jILnXeTh238ddrb9YYY8Xgt0UMLb8zqI7C0R2tmrEdY7
         mtT+pwXBymNagfhb00YjCOqK1T0ys4X043g91WPDASEZagGLtiw6/tfJY/rn41GY1M8g
         chiVHbbF8j/hutpzG0WJClfrkmfPHuW0G9535JRJnqjEd/+1xsn5WpduAoRgRnx9WnL+
         3M7nBU8WQ0T9VYftqAeHmSyAdRoxT8dFCdLOimj3e87evrJ2JNvambYmn/yHJyLUS8TU
         Lryw==
X-Gm-Message-State: ACgBeo38ZLPgNnF+feHoSdJ1l+YC+28luS/KlEvD1JBi3IR8FsBMZVh+
        3XSd/YF5Fu0jXWQihlwBthtm8Up8HCCoQziI
X-Google-Smtp-Source: AA6agR73fi5TMze5z6JjXEYZsN1wjE8krOqfrS0/e5sGppd1GBH6z3DpmA+z5Zf59Zf6ZDeVLGpT0Q==
X-Received: by 2002:ac8:574e:0:b0:344:555f:cbe4 with SMTP id 14-20020ac8574e000000b00344555fcbe4mr8382283qtx.276.1660588025872;
        Mon, 15 Aug 2022 11:27:05 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id r2-20020a05620a298200b006b5f68bc106sm10010153qkp.110.2022.08.15.11.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 11:27:04 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-32868f43dd6so93656047b3.8;
        Mon, 15 Aug 2022 11:27:04 -0700 (PDT)
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr11651790ybt.365.1660588023793; Mon, 15
 Aug 2022 11:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org> <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org> <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org> <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
 <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org> <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
 <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org> <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
 <14ec47f3-f3b8-61c7-2c64-d96d00dd7076@acm.org> <CAMuHMdW7nGxV_3Z2JV_TCM+WtTdYv5P+0cE6Tw=6krcseNCdAw@mail.gmail.com>
 <40700595-8c83-1b61-ea93-ea9554bfb2db@acm.org>
In-Reply-To: <40700595-8c83-1b61-ea93-ea9554bfb2db@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Aug 2022 20:26:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_hzvd2YkJfRqXm8SmKuibWiUy-c7XpGCnEr86HMx=_Q@mail.gmail.com>
Message-ID: <CAMuHMdV_hzvd2YkJfRqXm8SmKuibWiUy-c7XpGCnEr86HMx=_Q@mail.gmail.com>
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
        linux-ide@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Bart,

On Mon, Aug 15, 2022 at 3:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On 8/15/22 03:13, Geert Uytterhoeven wrote:
> > Showing all locks held in the system:
> > 1 lock held by rcu_tasks_kthre/10:
> >   #0: ffff800009575c38 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at:
> > rcu_tasks_one_gp+0x34/0x4c8
> > 4 locks held by kworker/0:10/104:
> >   #0: ffff0004c0008738 ((wq_completion)events){+.+.}-{0:0}, at:
> > process_one_work+0x1f4/0x6a0
> >   #1: ffff80000a90bde0
> > ((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at:
> > process_one_work+0x1f4/0x6a0
> >   #2: ffff0004c2b6bf60 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at:
> > ata_scsi_dev_rescan+0x28/0x118
> >   #3: ffff0004c2902368 (&dev->mutex){....}-{3:3}, at:
> > scsi_rescan_device+0x28/0x78
> > 1 lock held by in:imklog/636:
> >   #0: ffff0004c5ee86e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x54/0x68
> > 1 lock held by hd/1013:
> >   #0: ffff0004c06388b8 (mapping.invalidate_lock#2){.+.+}-{3:3}, at:
> > page_cache_ra_unbounded+0x64/0x1a8
>
> Thank you for having shared this information. I will take a closer look
> and see what I can derive from the above information.
>
> > I've just tried with a USB storage device on the same platform,
> > and it can be read fine after s2idle.  So it looks like the issue
> > is related to SATA.
>
> Unfortunately the above does not learn us anything new. The code
> modified by commit 88f1669019bd ("scsi: sd: Rework asynchronous resume
> support") is only called if sdev->manage_start_stop != 1. Only the SATA
> code, the Firewire code and the manage_start_stop sysfs attribute store
> method set that member variable:
>
> $ git grep -nH 'manage_start_stop = '
> drivers/ata/libata-scsi.c:1083:         sdev->manage_start_stop = 1;
> drivers/firewire/sbp2.c:1521:           sdev->manage_start_stop = 1;
> drivers/scsi/sd.c:240:  sdp->manage_start_stop = v;
>
> Would it be possible to share the output of the command below? That
> should reveal which ATA driver is active on the test setup.
>
> find /sys -name proc_name | xargs grep -aH .

/sys/devices/platform/soc/ee300000.sata/ata1/host0/scsi_host/host0/proc_name:sata_rcar

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
