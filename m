Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC4593039
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiHONtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiHONtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:49:18 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A422BCE;
        Mon, 15 Aug 2022 06:49:16 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso14483909pjq.4;
        Mon, 15 Aug 2022 06:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gVwXRsOgJI+Cnx7zqybxmCG71vWgxYHCtyi19HC0Kc8=;
        b=ytol3Hc2EN52t7A/I5knS1WwWcfTfPVzAmSBnDvLqPwwWKYHjMNUJz0MuqtSGIC7Ix
         hLHz93Jr3mSHCkBcSmrgk+NLq/5P9DC9A93EyMfI7QS94mNTSmtWLtuNYZo4kEH3AEY/
         MJqSaoWhYTJv2vFlBpGnDUXq4tlAvDCNKdjiepYtAvbEhP2rs2kSVGwbAKoFp/ROflo7
         zlxksIaxzJxzCyHSd72+uRhpJ2XSKUZJAzbTB/muQaWoe3Qn5q2A/FSpnGkJkyKCT8sn
         m5Ba3dV36tCZeZi7xgWDSoq7TfLo5IZR3gjNdRejuCFhSzK1IXtBZRHOP4nSfqO0mdRt
         2l2w==
X-Gm-Message-State: ACgBeo293AInyIbZJxEWuEAYVFPJIWrzta81loeAUnbQIcb7qO4eB0d4
        IefMt1sWm3BlYhVRNZTwpKI=
X-Google-Smtp-Source: AA6agR5e2cZfn3HgeXo5E8txEycPGs6tblIkJci3N7OcvN2/8u50r5xhXS1mLhci6L3BQHh1yVvHPQ==
X-Received: by 2002:a17:902:e154:b0:171:4e75:a282 with SMTP id d20-20020a170902e15400b001714e75a282mr17453864pla.90.1660571355461;
        Mon, 15 Aug 2022 06:49:15 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b0016be596c8afsm6957795plh.282.2022.08.15.06.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:49:14 -0700 (PDT)
Message-ID: <40700595-8c83-1b61-ea93-ea9554bfb2db@acm.org>
Date:   Mon, 15 Aug 2022 06:49:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
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
        linux-ide@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
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
 <14ec47f3-f3b8-61c7-2c64-d96d00dd7076@acm.org>
 <CAMuHMdW7nGxV_3Z2JV_TCM+WtTdYv5P+0cE6Tw=6krcseNCdAw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdW7nGxV_3Z2JV_TCM+WtTdYv5P+0cE6Tw=6krcseNCdAw@mail.gmail.com>
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

On 8/15/22 03:13, Geert Uytterhoeven wrote:
> Showing all locks held in the system:
> 1 lock held by rcu_tasks_kthre/10:
>   #0: ffff800009575c38 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at:
> rcu_tasks_one_gp+0x34/0x4c8
> 4 locks held by kworker/0:10/104:
>   #0: ffff0004c0008738 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work+0x1f4/0x6a0
>   #1: ffff80000a90bde0
> ((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at:
> process_one_work+0x1f4/0x6a0
>   #2: ffff0004c2b6bf60 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at:
> ata_scsi_dev_rescan+0x28/0x118
>   #3: ffff0004c2902368 (&dev->mutex){....}-{3:3}, at:
> scsi_rescan_device+0x28/0x78
> 1 lock held by in:imklog/636:
>   #0: ffff0004c5ee86e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x54/0x68
> 1 lock held by hd/1013:
>   #0: ffff0004c06388b8 (mapping.invalidate_lock#2){.+.+}-{3:3}, at:
> page_cache_ra_unbounded+0x64/0x1a8

Thank you for having shared this information. I will take a closer look 
and see what I can derive from the above information.

> I've just tried with a USB storage device on the same platform,
> and it can be read fine after s2idle.  So it looks like the issue
> is related to SATA.

Unfortunately the above does not learn us anything new. The code 
modified by commit 88f1669019bd ("scsi: sd: Rework asynchronous resume 
support") is only called if sdev->manage_start_stop != 1. Only the SATA 
code, the Firewire code and the manage_start_stop sysfs attribute store 
method set that member variable:

$ git grep -nH 'manage_start_stop = '
drivers/ata/libata-scsi.c:1083:		sdev->manage_start_stop = 1;
drivers/firewire/sbp2.c:1521:		sdev->manage_start_stop = 1;
drivers/scsi/sd.c:240:	sdp->manage_start_stop = v;

Would it be possible to share the output of the command below? That 
should reveal which ATA driver is active on the test setup.

find /sys -name proc_name | xargs grep -aH .

Thanks,

Bart.
