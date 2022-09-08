Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1F5B1AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIHKyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIHKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:54:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5596AF7545
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:54:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb36so37074951ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=dTTp3UPbIUZ484c7Rv7tFudBLX8O9RKutGfh3CuJqww=;
        b=rX80mENez1R/TY76z09PYBLIJuoWB9vCbsfxWPwPxvGvyTVZ6ILr/cK9m7EA9eO4G9
         qJvRBrlhTZ+Ilge1T58ecxuuHwUsus5TNBf5FPBfmaXY2pPtUNchMrivW+4XA/hgMx4G
         VfAaQaVMtZBmJRiNYrHWKcqOc7o+4DdcBlegmLdGodvic+uRzgpP3SFItrnCZBIf3eiY
         aJ96XHzRkEcV47dlOO/WWK8Q8EKFCdwGHCIWl/dEPIvEcuqzGXlgXn7Wz8gc9e5rxs1G
         jWHomxuvUXzqmDbnsUGTSGha8Dbt+PA7Kd0bOpOiUlad/dcjdPpwwiRA2plHJimPVd7C
         qrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dTTp3UPbIUZ484c7Rv7tFudBLX8O9RKutGfh3CuJqww=;
        b=eHQJg55I/KfGhAhPGCpJeJnXk7jcyFlrgbrQBnfVyGpHGoAP8YBXAM1M5JQBmyycX/
         QDKeNHNCUpFkjsttBJTbE08Am6uUCAsEkwLN2yarPye10Nr1irx2FBUPcRcCKK1+BIT5
         iC0ZBPXMDadCE1qeMvkmWc9FhSMZX/syuWGTbiIvZq6gz/bAJS86FLyzdHG5lUILtFZn
         4jgkVYltbrESdbsAYstGql9A5tlErmK4nsMNd4x7ulZwV8uuLTs0gUBVemoKqWMTJNrh
         Zn8AAyN+nQRIIRJ+ZZK4RjEh0jSLu1tCNaqBqesjp4sPxHhniySTQZdw5d1Yk3jsj3U3
         8zTg==
X-Gm-Message-State: ACgBeo0r2RGcpWeYZ64G+WX1Gw2HEu/KHe4wEWRDI/WmzewgUHII3Rbn
        XEkigl/vLc795/PsPZaCcYgwHw==
X-Google-Smtp-Source: AA6agR4pSUGvCh1aYOhFwZs7MOoKuqElGcYstFgQJ4eEsnunMuVQ8vfa/5KNo4j9UgmocXqs4Y8jrA==
X-Received: by 2002:a17:906:cc5d:b0:741:38a8:a50a with SMTP id mm29-20020a170906cc5d00b0074138a8a50amr5483007ejb.650.1662634452844;
        Thu, 08 Sep 2022 03:54:12 -0700 (PDT)
Received: from wifi-122-dhcprange-122-207.wifi.unimo.it (wifi-122-dhcprange-122-207.wifi.unimo.it. [155.185.122.207])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906538a00b00774f2fbfcbbsm569727ejo.38.2022.09.08.03.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 03:54:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <SJ0PR20MB44098A7A5D1904FD68DFE73BA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
Date:   Thu, 8 Sep 2022 12:54:07 +0200
Cc:     Tyler Erickson <tyler.erickson@seagate.com>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D21B6E4C-F190-4B53-88A7-4650020DB6A5@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
 <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
 <21A4C080-7FFB-4ABF-86C6-E8E05BD83E6C@linaro.org>
 <SJ0PR20MB44098A7A5D1904FD68DFE73BA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
To:     Rory Chen <rory.c.chen@seagate.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 8 set 2022, alle ore 04:46, Rory Chen =
<rory.c.chen@seagate.com> ha scritto:
>=20
> I change the comparison condition and it can eliminate the warning.

Yep. The crash you reported also goes away?

> <               if (end >=3D iar->sector + 1 && end < iar->sector + =
iar->nr_sectors + 1)
>>              if (end >=3D iar->sector && end < iar->sector + =
iar->nr_sectors)
>=20
> I don't know if this change is appropriate

Unfortunately your change conflicts with the standard code, taken from
the original patches on access ranges [1].  I've CCed Damien, the
author of this patch series.

[1] =
https://lwn.net/ml/linux-block/20210909023545.1101672-2-damien.lemoal@wdc.=
com/

Thanks,
Paolo

> but  bio_end_sector deducting 1 said by Tyler seems to make sense.
>=20
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Thursday, August 25, 2022 10:45 PM
> To: Tyler Erickson <tyler.erickson@seagate.com>
> Cc: Rory Chen <rory.c.chen@seagate.com>; Arie van der Hoeven =
<arie.vanderhoeven@seagate.com>; Muhammad Ahmad =
<muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org =
<linux-block@vger.kernel.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; =
andrea.righi@canonical.com <andrea.righi@canonical.com>; =
glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk =
<axboe@kernel.dk>; Michael English <michael.english@seagate.com>; Andrew =
Ring <andrew.ring@seagate.com>; Varun Boddu =
<varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support =
multi-actuator drives
>=20
>=20
> This message has originated from an External Source. Please use proper =
judgment and caution when opening attachments, clicking links, or =
responding to this email.
>=20
>=20
> Hi
>=20
>> Il giorno 18 ago 2022, alle ore 17:40, Tyler Erickson =
<tyler.erickson@seagate.com> ha scritto:
>>=20
>> The libata layer is reporting correctly after the changes I =
submitted.
>>=20
>> The drive reports the actuator ranges as a starting LBA and a count =
of LBAs for the range.
>> If the code reading the reported values simply does startingLBA + =
range, this is an incorrect ending LBA for that actuator. This is =
because LBAs are zero indexed and this simple addition is not taking =
that into account.
>> The proper way to get the endingLBA is startingLBA + range - 1 to get =
the last LBA value for where to issue a final IO read/write to account =
for LBA values starting at zero rather than one.
>>=20
>> Here is an example from the output in SeaChest/openSeaChest:
>> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>>=20
>> Range#     #Elements            Lowest LBA          # of LBAs
>>  0            1                                               0       =
    17578328064
>>  1            1                         17578328064           =
17578328064
>>=20
>> If using the incorrect formula to get the final LBA for actuator 0, =
you would get 17578328064, but this is the starting LBA reported by the =
drive for actuator 1.
>> So to be consistent for all ranges, the final LBA for a given =
actuator should be calculated as starting LBA + range - 1.
>>=20
>=20
> Ok
>=20
>> I had reached out to Seagate's T10 and T13 representatives for =
clarification and verification and this is most likely what is causing =
the error is a missing - 1 somewhere after getting the information =
reported by the device. They agreed that the reporting from the drive =
and the SCSI to ATA translation is correct.
>>=20
>> I'm not sure where this is being read and calculated, but it is not =
an error in the low-level libata or sd level of the kernel. It may be in =
bfq, or it may be in some other place after the sd layer.
>=20
> This apparent mistake is in the macro bio_end_sector (defined in
> include/linux/bio.h), which seems to be translated as sector+size.
> Jens, can you shed a light on this point?
>=20
> Thanks,
> Paolo
>=20
>> I know there were some additions to read this and report it up the =
stack, but I did not think those were wrong as they seemed to pass the =
drive reported information up the stack.
>>=20
>> Tyler Erickson
>> Seagate Technology
>>=20
>>=20
>> Seagate Internal
>>=20
>> -----Original Message-----
>> From: Rory Chen <rory.c.chen@seagate.com>
>> Sent: Wednesday, August 10, 2022 6:59 AM
>> To: Paolo Valente <paolo.valente@linaro.org>
>> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad =
Ahmad <muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org; =
linux-kernel@vger.kernel.org; Jan Kara <jack@suse.cz>; =
andrea.righi@canonical.com; glen.valante@linaro.org; axboe@kernel.dk; =
Tyler Erickson <tyler.erickson@seagate.com>; Michael English =
<michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; =
Varun Boddu <varunreddy.boddu@seagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support =
multi-actuator drives
>>=20
>> The block trace shows the start sector is 35156656120 and transfer =
length is 8 sectors, which is within the max LBA 35156656127 of drive. =
And this IO is completed successfully from the slice of parsed block =
trace though reporting the warning message.
>> 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 =
[systemd-udevd]
>> 8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
>> 8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 =
[systemd-udevd]
>> 8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 =
[systemd-udevd]
>> 8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]
>>=20
>> It may need to know where calculate "bio_end_sector" value as =
35156656128. I have patched libata and sd driver for Dual Actuator.
>>=20
>>=20
>>=20
>> From: Paolo Valente <paolo.valente@linaro.org>
>> Sent: Wednesday, August 10, 2022 6:22 PM
>> To: Rory Chen <rory.c.chen@seagate.com>
>> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad =
Ahmad <muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org =
<linux-block@vger.kernel.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; =
andrea.righi@canonical.com <andrea.righi@canonical.com>; =
glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk =
<axboe@kernel.dk>; Tyler Erickson <tyler.erickson@seagate.com>; Michael =
English <michael.english@seagate.com>; Andrew Ring =
<andrew.ring@seagate.com>; Varun Boddu <varunreddy.boddu@seagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support =
multi-actuator drives
>>=20
>>=20
>> This message has originated from an External Source. Please use =
proper judgment and caution when opening attachments, clicking links, or =
responding to this email.
>>=20
>>=20
>>> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen =
<rory.c.chen@seagate.com> ha scritto:
>>>=20
>>> Resend the mail as plain text because previous mail with rich text
>>> makes some mess and forget to add others at Seagate who worked on
>>> validating the patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>>>=20
>>> Hi Paolo,
>>>=20
>>=20
>> Hi
>>=20
>>> I am from Seagate China and face a problem when I'm evaluating the =
bfq patches. Could you please check?
>>> Thanks
>>>=20
>>> Issue statement
>>> When running performance test on bfq patch, I observed warning =
message "bfq_actuator_index: bio sector out of ranges: end=3D35156656128" =
and OS hung suddenly after some hours.
>>> The warning message is reported from function bfq_actuator_index =
which determines IO request is in which index of actuators.  The =
bio_end_sector is 35156656128 but the max LBA for the drive is =
35156656127 so it's beyond the LBA range.
>>=20
>> Yep, this sanity check fails if the end sector of a new IO does not =
belong to any sector range.
>>=20
>>> I captured the block trace and didn't found request LBA 35156656128 =
instead only found max request LBA 35156656127.
>>=20
>> Maybe in the trace you see only start sectors?  The failed check si =
performed on end sectors instead.
>>=20
>> At any rate, there seems to be an off-by-one error in the value(s) =
stored in the sector field(s) of the blk_independent_access_range data =
structure.
>>=20
>> I guess we may need some help/feedback from people competent on this =
stuff.
>>=20
>>> I'm not sure if this warning message is related to later OS hung.
>>>=20
>>=20
>> Not easy to say.  At any rate, we can try with a development version =
of bfq.  It can help us detect the possible cause of this hang.  But =
let's see where we get with this sector error first.
>>=20
>> Thank you for testing this extended version of bfq, Paolo
>>=20
>>>=20
>>> Problem environment
>>> Kernel base is 5.18.9
>>> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
>>> Actuator LBA mapping by reading VPD B9 Concurrent positioning ranges
>>> VPD page:
>>> LBA range number:0
>>> number of storage elements:1
>>> starting LBA:0x0
>>> number of LBAs:0x417c00000 [17578328064] LBA range number:1 number =
of
>>> storage elements:1 starting LBA:0x417c00000 number of =
LBAs:0x417c00000
>>> [17578328064]
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> From: Paolo Valente <paolo.valente@linaro.org>
>>> Sent: Thursday, June 23, 2022 8:53 AM
>>> To: Jens Axboe <axboe@kernel.dk>
>>> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>;
>>> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
>>> jack@suse.cz <jack@suse.cz>; andrea.righi@canonical.com
>>> <andrea.righi@canonical.com>; glen.valante@linaro.org
>>> <glen.valante@linaro.org>; Arie van der Hoeven
>>> <arie.vanderhoeven@seagate.com>; Paolo Valente
>>> <paolo.valente@linaro.org>
>>> Subject: [PATCH 0/8] block, bfq: extend bfq to support =
multi-actuator
>>> drives
>>>=20
>>>=20
>>> This message has originated from an External Source. Please use =
proper judgment and caution when opening attachments, clicking links, or =
responding to this email.
>>>=20
>>>=20
>>> Hi,
>>> this patch series extends BFQ so as to optimize I/O dispatch to
>>> multi-actuator drives. In particular, this extension addresses the
>>> following issue. Multi-actuator drives appear as a single device to
>>> the I/O subsystem [1].  Yet they address commands to different
>>> actuators internally, as a function of Logical Block Addressing
>>> (LBAs). A given sector is reachable by only one of the actuators. =
For
>>> example, Seagate's Serial Advanced Technology Attachment (SATA)
>>> version contains two actuators and maps the lower half of the SATA =
LBA
>>> space to the lower actuator and the upper half to the upper =
actuator.
>>>=20
>>> Evidently, to fully utilize actuators, no actuator must be left idle
>>> or underutilized while there is pending I/O for it. To reach this
>>> goal, the block layer must somehow control the load of each actuator
>>> individually. This series enriches BFQ with such a per-actuator
>>> control, as a first step. Then it also adds a simple mechanism for
>>> guaranteeing that actuators with pending I/O are never left idle.
>>>=20
>>> See [1] for a more detailed overview of the problem and of the
>>> solutions implemented in this patch series. There you will also find
>>> some preliminary performance results.
>>>=20
>>> Thanks,
>>> Paolo
>>>=20
>>> [1]
>>> =
https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYeP
>>> =
rA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LR
>>> =
iTVoIOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLO
>>> =
NHEoI3p3e9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYB
>>> =
Fn5S2WjBDQq2kzDzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEV
>>> =
a1b6bQByX6grF5pn3pTIo0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIK
>>> =
DrNTALs3xQvg03DH4jLez-T2M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F
>>> =
%2Fwww.linaro.org%2Fblog%2Fbudget-fair-queueing-bfq-linux-io-scheduler
>>> -optimizations-for-multi-actuator-sata-hard-drives%2F
>>>=20
>>> Davide Zini (3):
>>> block, bfq: split also async bfq_queues on a per-actuator basis
>>> block, bfq: inject I/O to underutilized actuators  block, bfq: =
balance
>>> I/O injection among underutilized actuators
>>>=20
>>> Federico Gavioli (1):
>>> block, bfq: retrieve independent access ranges from request queue
>>>=20
>>> Paolo Valente (4):
>>> block, bfq: split sync bfq_queues on a per-actuator basis  block,
>>> bfq: forbid stable merging of queues associated with different
>>>  actuators
>>> block, bfq: turn scalar fields into arrays in bfq_io_cq  block, bfq:
>>> turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>>>=20
>>> block/bfq-cgroup.c  |  97 +++++----
>>> block/bfq-iosched.c | 488 =
+++++++++++++++++++++++++++++---------------
>>> block/bfq-iosched.h | 149 ++++++++++----
>>> block/bfq-wf2q.c    |   2 +-
>>> 4 files changed, 493 insertions(+), 243 deletions(-)
>>>=20
>>> --
>>> 2.20.1
>>>=20
>>>=20
>>> Seagate Internal
>>>=20
>>> Seagate Internal
>>=20
>> Seagate Internal
>=20
> Seagate Internal

