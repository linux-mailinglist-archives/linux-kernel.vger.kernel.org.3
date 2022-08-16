Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E05963AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiHPUVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHPUV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:21:28 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092AA5E579;
        Tue, 16 Aug 2022 13:21:28 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id y141so10281438pfb.7;
        Tue, 16 Aug 2022 13:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=th+lC17Fiwo20XamRjMxkbAxnNSnosmeVziZqkBDOMs=;
        b=gVu0NiivUMfgQECcfR3Abw37hHyBYq//M0H37uRr9fAMh+pGIuUJUDX855uBCBYK/1
         sbOOqVx5TahNmn9e2PgSXjePADpCPwCbFPGVffKn2UeZCr8c9YI2X0sqfbtsH+3PxVdz
         7hMhWiocSV5x1PpHyU59ZBGOgiKxe6BtjnwU86nYdW4xH6mLtKX3wjvz83pKQATp3Q0x
         1DNBgYN3TWRaJ2ibXZR2DC18xp2RnoG/5bV+J/0EDMiGQIMFqEmMu64uyQDlPoYzbesB
         qBIekmJ8gkvud6jIVhKw06e/Sq8lVRwd9o0RA3Ly8tdnuy3A0RXFlH3dWpdYgl4+HZiV
         CzuQ==
X-Gm-Message-State: ACgBeo1O3fdmR39cuWgR0LgbenqSgquGfy8oe4RKM/c7wi0k4I1qC4BZ
        TugDGCmaw/vYT0SPTudXxDw=
X-Google-Smtp-Source: AA6agR45di+TBD2Dgd1RBlQEBtB16uBAPGH0WxD12cQE9McWLupyyuS0VS2/uH8LE9n7XEx+3EG7ZQ==
X-Received: by 2002:a63:4e25:0:b0:41c:62a2:ecc3 with SMTP id c37-20020a634e25000000b0041c62a2ecc3mr19472574pgb.596.1660681287364;
        Tue, 16 Aug 2022 13:21:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ff4b:545d:11c8:da9f? ([2620:15c:211:201:ff4b:545d:11c8:da9f])
        by smtp.gmail.com with ESMTPSA id 5-20020a621505000000b0052b6ed5ca40sm8782792pfv.192.2022.08.16.13.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 13:21:26 -0700 (PDT)
Message-ID: <3c7e338e-332e-fe80-e419-b360535533c5@acm.org>
Date:   Tue, 16 Aug 2022 13:21:24 -0700
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
        linux-ide@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20220630195703.10155-1-bvanassche@acm.org>
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
 <40700595-8c83-1b61-ea93-ea9554bfb2db@acm.org>
 <CAMuHMdV_hzvd2YkJfRqXm8SmKuibWiUy-c7XpGCnEr86HMx=_Q@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdV_hzvd2YkJfRqXm8SmKuibWiUy-c7XpGCnEr86HMx=_Q@mail.gmail.com>
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

On 8/15/22 11:26, Geert Uytterhoeven wrote:
> On Mon, Aug 15, 2022 at 3:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> Would it be possible to share the output of the command below? That
>> should reveal which ATA driver is active on the test setup.
>>
>> find /sys -name proc_name | xargs grep -aH .
> 
> /sys/devices/platform/soc/ee300000.sata/ata1/host0/scsi_host/host0/proc_name:sata_rcar

Thanks Geert for the help. Although I already posted a revert, I'm still 
trying to root-cause this issue. Do you perhaps know whether sata_rcar 
controllers support NCQ and if so, what queue depth these controllers 
support? I think that information is available in sysfs. Here is an 
example for a VM:

# (cd /sys/class/scsi_device && for a in */device/*/*/ncq_prio_enable; 
do p=${a%/ncq_prio_enable}; grep -qi ata $p/inquiry || continue; grep 
-aH . $p/{queue_depth,ncq*}; done)
2:0:0:0/device/driver/2:0:0:0/queue_depth:32
2:0:0:0/device/driver/2:0:0:0/ncq_prio_enable:0
2:0:0:0/device/driver/2:0:0:0/ncq_prio_supported:0
2:0:0:0/device/generic/device/queue_depth:32
2:0:0:0/device/generic/device/ncq_prio_enable:0
2:0:0:0/device/generic/device/ncq_prio_supported:0
6:0:0:1/device/driver/2:0:0:0/queue_depth:32
6:0:0:1/device/driver/2:0:0:0/ncq_prio_enable:0
6:0:0:1/device/driver/2:0:0:0/ncq_prio_supported:0

Thanks,

Bart.
