Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14278596BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiHQIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHQIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:53:42 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C236745F;
        Wed, 17 Aug 2022 01:53:39 -0700 (PDT)
Received: from [192.168.1.103] (178.176.73.252) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 17 Aug
 2022 11:53:30 +0300
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
To:     Bart Van Assche <bvanassche@acm.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, <ericspero@icloud.com>,
        <jason600.groome@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20220630195703.10155-1-bvanassche@acm.org>
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
 <3c7e338e-332e-fe80-e419-b360535533c5@acm.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <56cf0251-159c-3f83-78d2-859048625633@omp.ru>
Date:   Wed, 17 Aug 2022 11:53:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3c7e338e-332e-fe80-e419-b360535533c5@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.73.252]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/17/2022 08:36:57
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 172266 [Aug 17 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 495 495 bb4e71e2e9e23696ab912b286436360a94c9b107
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.252 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.252
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/17/2022 08:39:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/17/2022 6:00:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 8/16/22 11:21 PM, Bart Van Assche wrote:

>> On Mon, Aug 15, 2022 at 3:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>> Would it be possible to share the output of the command below? That
>>> should reveal which ATA driver is active on the test setup.
>>>
>>> find /sys -name proc_name | xargs grep -aH .
>>
>> /sys/devices/platform/soc/ee300000.sata/ata1/host0/scsi_host/host0/proc_name:sata_rcar
> 
> Thanks Geert for the help. Although I already posted a revert, I'm still trying to
> root-cause this issue. Do you perhaps know whether sata_rcar controllers support NCQ

   They don't. :-)

> and if so, what queue depth these controllers support? I think that information is available in sysfs. Here is an example for a VM:
> 
> # (cd /sys/class/scsi_device && for a in */device/*/*/ncq_prio_enable; do p=${a%/ncq_prio_enable}; grep -qi ata $p/inquiry || continue; grep -aH . $p/{queue_depth,ncq*}; done)
> 2:0:0:0/device/driver/2:0:0:0/queue_depth:32
> 2:0:0:0/device/driver/2:0:0:0/ncq_prio_enable:0
> 2:0:0:0/device/driver/2:0:0:0/ncq_prio_supported:0
> 2:0:0:0/device/generic/device/queue_depth:32
> 2:0:0:0/device/generic/device/ncq_prio_enable:0
> 2:0:0:0/device/generic/device/ncq_prio_supported:0
> 6:0:0:1/device/driver/2:0:0:0/queue_depth:32
> 6:0:0:1/device/driver/2:0:0:0/ncq_prio_enable:0
> 6:0:0:1/device/driver/2:0:0:0/ncq_prio_supported:0
> 
> Thanks,
> 
> Bart.

MBR, Sergey
