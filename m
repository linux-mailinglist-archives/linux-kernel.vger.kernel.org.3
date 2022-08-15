Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE79592BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiHOKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbiHOKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:14:21 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1DE1EC66;
        Mon, 15 Aug 2022 03:13:52 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id mz1so116867qvb.4;
        Mon, 15 Aug 2022 03:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o6xCOA86Hungq+d+MPhC/+jht0io7Fvy+/Zhbi5ZEAs=;
        b=bFb3HODVMgxuuXVCxbHtv0h1hrzn9Hfvv6Ic6zP76t/z3EcbYDuuG4ZkDWnUV7d285
         BGH+UQUGD/zQKPuiKUVNtoESdjd25ogXzZ3UTtUV6GWZVwGqyKC5wRTa5+dukPYTooLD
         kvJysdtAsf+FtAoX/Gl0ja8rFBXUr8DKmWdyNkz+90CC8azrPBNbVHDfRGp3XkDugDno
         wWJapqweK+H54/HUGqRexY/yn0CbRF+D2zJA9AfotSU9RSSSCHw1nLXBHEmh9WbCuoDW
         zRtHQPra2LpgNlk620kvN9obiKuVTU4Tdz4eAyUOq3VjODsIE05j69G7uiygJaQtONus
         ng4Q==
X-Gm-Message-State: ACgBeo3/4zXdYv4Nix5+qHrqRWzjW/pItJ5WAbidVAIXO/O2nj7dJu4i
        8limkfhn12b6Hlq5ymeKcOOuqXrDAR9pYf9c
X-Google-Smtp-Source: AA6agR7QViD+S0O2H9qc6JvlauZv7z9vQuWsyYfm+yuZ9qj1yCm83Qtjib25s8Juebm8sL+tSh7/ew==
X-Received: by 2002:ad4:4eeb:0:b0:474:8435:1508 with SMTP id dv11-20020ad44eeb000000b0047484351508mr12943269qvb.5.1660558431299;
        Mon, 15 Aug 2022 03:13:51 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a284500b006b9a24dc9d7sm8008240qkp.7.2022.08.15.03.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 03:13:49 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 21so11519699ybf.4;
        Mon, 15 Aug 2022 03:13:49 -0700 (PDT)
X-Received: by 2002:a25:da0b:0:b0:67a:7fb6:8ae with SMTP id
 n11-20020a25da0b000000b0067a7fb608aemr11373117ybf.89.1660558429300; Mon, 15
 Aug 2022 03:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org> <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org> <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org> <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
 <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org> <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
 <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org> <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
 <14ec47f3-f3b8-61c7-2c64-d96d00dd7076@acm.org>
In-Reply-To: <14ec47f3-f3b8-61c7-2c64-d96d00dd7076@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Aug 2022 12:13:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7nGxV_3Z2JV_TCM+WtTdYv5P+0cE6Tw=6krcseNCdAw@mail.gmail.com>
Message-ID: <CAMuHMdW7nGxV_3Z2JV_TCM+WtTdYv5P+0cE6Tw=6krcseNCdAw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Bart,

On Fri, Aug 12, 2022 at 5:53 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On 8/12/22 03:48, Geert Uytterhoeven wrote:
> > sd_submit_start() is called once during suspend, and once during
> > resume.  It does not hang.
> >
> > Reading from /dev/sda hangs after resume (not in sd_submit_start(),
> > which is never called for reading).

FTR, this issue is now present in v6.0-rc1. Reverting commit
88f1669019bd62b3 ("scsi: sd: Rework asynchronous resume support")
fixes it.

> > Two tasks are blocked in blk_mq_get_tag() calling io_schedule():
> >
> > task:kworker/7:1     state:D stack:    0 pid:  122 ppid:     2 flags:0x00000008
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
> >
> > task:hd              state:D stack:    0 pid: 1163 ppid:  1076 flags:0x00000000
> > Call trace:
> >   __switch_to+0xbc/0x124
> >   __schedule+0x540/0x71c
> >   schedule+0x58/0xa0
> >   io_schedule+0x18/0x34
> >   blk_mq_get_tag+0x138/0x244
> >   __blk_mq_alloc_requests+0x130/0x2f0
> >   blk_mq_submit_bio+0x44c/0x5b4
> >   __submit_bio+0x24/0x5c
> >   submit_bio_noacct_nocheck+0x8c/0x178
> >   submit_bio_noacct+0x380/0x3b0
> >   submit_bio+0x34/0x3c
> >   mpage_bio_submit+0x28/0x38
> >   mpage_readahead+0xa8/0x178
> >   blkdev_readahead+0x14/0x1c
> >   read_pages+0x4c/0x158
> >   page_cache_ra_unbounded+0xd8/0x174
> >   do_page_cache_ra+0x40/0x4c
> >   page_cache_ra_order+0x14/0x1c
> >   ondemand_readahead+0x124/0x2fc
> >   page_cache_sync_ra+0x50/0x54
> >   filemap_read+0x130/0x6e8
> >   blkdev_read_iter+0xf0/0x164
> >   new_sync_read+0x74/0xc0
> >   vfs_read+0xbc/0xd8
> >   ksys_read+0x6c/0xd4
> >   __arm64_sys_read+0x14/0x1c
> >   invoke_syscall+0x70/0xf4
> >   el0_svc_common.constprop.0+0xbc/0xf0
> >   do_el0_svc+0x18/0x20
> >   el0_svc+0x30/0x84
> >   el0t_64_sync_handler+0x90/0xf8
> >   el0t_64_sync+0x14c/0x150
>
> All that can be concluded from the above is that blk_mq_get_tag() is
> waiting for other I/O request(s) to finish. One or more other requests
> are in progress and either scsi_done() has not been called for these
> requests or the error handler got stuck. Since the issue reported above
> is not observed with other ATA interfaces, this may be related to the
> ATA interface driver used in your test setup.

I have added debug prints to all ata_port_operations in
sata_rcar_port_ops.  After s2idle, running "hd /dev/sda | head -70"
hangs before any of these functions are called.

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/10:
 #0: ffff800009575c38 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at:
rcu_tasks_one_gp+0x34/0x4c8
4 locks held by kworker/0:10/104:
 #0: ffff0004c0008738 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x1f4/0x6a0
 #1: ffff80000a90bde0
((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at:
process_one_work+0x1f4/0x6a0
 #2: ffff0004c2b6bf60 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at:
ata_scsi_dev_rescan+0x28/0x118
 #3: ffff0004c2902368 (&dev->mutex){....}-{3:3}, at:
scsi_rescan_device+0x28/0x78
1 lock held by in:imklog/636:
 #0: ffff0004c5ee86e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x54/0x68
1 lock held by hd/1013:
 #0: ffff0004c06388b8 (mapping.invalidate_lock#2){.+.+}-{3:3}, at:
page_cache_ra_unbounded+0x64/0x1a8

I've just tried with a USB storage device on the same platform,
and it can be read fine after s2idle.  So it looks like the issue
is related to SATA.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
