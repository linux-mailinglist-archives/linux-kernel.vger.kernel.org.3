Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA65A14BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbiHYOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiHYOpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:45:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAEA41D0B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:45:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so11013101ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=w0V8b9BwzcRna/cnTVgVISeFHLFb8Xv8ObMLl0B9KB0=;
        b=dWplbibyQTa9GqMto7Prhh73iIYSWOgcgYUijwPvzYXsh0hWg3u3W0Jl5XPD5uVCw2
         NZRStMwzVPVc8v5H9eV8e/cUPT0mLflEAHi9RJe1MUD45HzlWhfNmIXWHUtsSQPaQMh/
         80b35r+fu7XhBZ90XQRRpdQC92MXxmsu5ALtkUkwpIx7mctf4Thx5FzyLfx6aw8y9sFA
         ByqQcl/Z59ibJuBw/brNPIB6wDZPMVvQQuuHCq1xI2wCC0CWWElN/Wyu7AwsyZALDxVF
         uSxOCJx1+U9aJukYap6VMLYYL9I+1h8PN4vL8Oi+eFYSG3uGlRv+n+xkLPEJP2HdECH9
         JYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=w0V8b9BwzcRna/cnTVgVISeFHLFb8Xv8ObMLl0B9KB0=;
        b=HhaWSIC+VLeP402o9/GftWjndHcoQYEIS95d9kIHb+ijBS4vlIkUrPjyfSHIo/qj99
         iqjWIJH/MNyv/qlw6WdysVYIPQbRmNwV9187XZFW3rRqIFkPhDsw5Ly4R0m//iQyEMwq
         HAovG8q8t6YOjoeoIlNjkIMNYSma1ihz074mzCkSI8sGcDwcJpKz0WuRsMD7eLIagz0n
         YHnub+xy69saVWhUlbw3vfX3LK32EhvtYY57waAcXtRbeHJmD2quy2tRxa2wfKYBgSgs
         Gjlaxmq+kdfS+8ASWUEr7RslEcG9516CFir5T6wUFoi6diyUjyY8n0ERTs4yfnxJUyOr
         VXYw==
X-Gm-Message-State: ACgBeo1K4BozhZXZpvy1HNt2PpYnhMHU9WJDXoo5c1YwgxzspDCaarii
        dL/HUgoJxkHh8w4MLlIQG5WiQQ==
X-Google-Smtp-Source: AA6agR6xyorSvpyoE4LxeTxy4bCVDQrvTNmCP+KwxfBnU6A6Em6HLpukkohN5jOssZ/9/qgsaW/O0w==
X-Received: by 2002:a17:906:4795:b0:73d:daa0:3cbf with SMTP id cw21-20020a170906479500b0073ddaa03cbfmr1006084ejc.693.1661438719419;
        Thu, 25 Aug 2022 07:45:19 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-70-87-20.cust.vodafonedsl.it. [93.70.87.20])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090631c800b0073dc6def190sm1535766ejf.158.2022.08.25.07.45.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:45:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
Date:   Thu, 25 Aug 2022 16:45:16 +0200
Cc:     Rory Chen <rory.c.chen@seagate.com>,
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
        Varun Boddu <varunreddy.boddu@seagate.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21A4C080-7FFB-4ABF-86C6-E8E05BD83E6C@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
 <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
To:     Tyler Erickson <tyler.erickson@seagate.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Il giorno 18 ago 2022, alle ore 17:40, Tyler Erickson =
<tyler.erickson@seagate.com> ha scritto:
>=20
> The libata layer is reporting correctly after the changes I submitted.
>=20
> The drive reports the actuator ranges as a starting LBA and a count of =
LBAs for the range.
> If the code reading the reported values simply does startingLBA + =
range, this is an incorrect ending LBA for that actuator. This is =
because LBAs are zero indexed and this simple addition is not taking =
that into account.
> The proper way to get the endingLBA is startingLBA + range - 1 to get =
the last LBA value for where to issue a final IO read/write to account =
for LBA values starting at zero rather than one.
>=20
> Here is an example from the output in SeaChest/openSeaChest:
> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>=20
> Range#     #Elements            Lowest LBA          # of LBAs     =20
>   0            1                                               0       =
    17578328064
>   1            1                         17578328064           =
17578328064
>=20
> If using the incorrect formula to get the final LBA for actuator 0, =
you would get 17578328064, but this is the starting LBA reported by the =
drive for actuator 1.
> So to be consistent for all ranges, the final LBA for a given actuator =
should be calculated as starting LBA + range - 1.
>=20

Ok

> I had reached out to Seagate's T10 and T13 representatives for =
clarification and verification and this is most likely what is causing =
the error is a missing - 1 somewhere after getting the information =
reported by the device. They agreed that the reporting from the drive =
and the SCSI to ATA translation is correct.
>=20
> I'm not sure where this is being read and calculated, but it is not an =
error in the low-level libata or sd level of the kernel. It may be in =
bfq, or it may be in some other place after the sd layer.

This apparent mistake is in the macro bio_end_sector (defined in
include/linux/bio.h), which seems to be translated as sector+size.
Jens, can you shed a light on this point?

Thanks,
Paolo

> I know there were some additions to read this and report it up the =
stack, but I did not think those were wrong as they seemed to pass the =
drive reported information up the stack.
>=20
> Tyler Erickson
> Seagate Technology
>=20
>=20
> Seagate Internal
>=20
> -----Original Message-----
> From: Rory Chen <rory.c.chen@seagate.com>=20
> Sent: Wednesday, August 10, 2022 6:59 AM
> To: Paolo Valente <paolo.valente@linaro.org>
> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad =
Ahmad <muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org; =
linux-kernel@vger.kernel.org; Jan Kara <jack@suse.cz>; =
andrea.righi@canonical.com; glen.valante@linaro.org; axboe@kernel.dk; =
Tyler Erickson <tyler.erickson@seagate.com>; Michael English =
<michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; =
Varun Boddu <varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support =
multi-actuator drives
>=20
> The block trace shows the start sector is 35156656120 and transfer =
length is 8 sectors, which is within the max LBA 35156656127 of drive. =
And this IO is completed successfully from the slice of parsed block =
trace though reporting the warning message.
> 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 =
[systemd-udevd]
>  8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
>  8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 =
[systemd-udevd]
>  8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 =
[systemd-udevd]
>  8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]
>=20
> It may need to know where calculate "bio_end_sector" value as =
35156656128. I have patched libata and sd driver for Dual Actuator.
>=20
>=20
>=20
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Wednesday, August 10, 2022 6:22 PM
> To: Rory Chen <rory.c.chen@seagate.com>
> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad =
Ahmad <muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org =
<linux-block@vger.kernel.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; =
andrea.righi@canonical.com <andrea.righi@canonical.com>; =
glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk =
<axboe@kernel.dk>; Tyler Erickson <tyler.erickson@seagate.com>; Michael =
English <michael.english@seagate.com>; Andrew Ring =
<andrew.ring@seagate.com>; Varun Boddu <varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support =
multi-actuator drives
>=20
>=20
> This message has originated from an External Source. Please use proper =
judgment and caution when opening attachments, clicking links, or =
responding to this email.
>=20
>=20
>> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen =
<rory.c.chen@seagate.com> ha scritto:
>>=20
>> Resend the mail as plain text because previous mail with rich text=20
>> makes some mess and forget to add others at Seagate who worked on=20
>> validating the patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>>=20
>> Hi Paolo,
>>=20
>=20
> Hi
>=20
>> I am from Seagate China and face a problem when I'm evaluating the =
bfq patches. Could you please check?
>> Thanks
>>=20
>> Issue statement
>> When running performance test on bfq patch, I observed warning =
message "bfq_actuator_index: bio sector out of ranges: end=3D35156656128" =
and OS hung suddenly after some hours.
>> The warning message is reported from function bfq_actuator_index =
which determines IO request is in which index of actuators.  The =
bio_end_sector is 35156656128 but the max LBA for the drive is =
35156656127 so it's beyond the LBA range.
>=20
> Yep, this sanity check fails if the end sector of a new IO does not =
belong to any sector range.
>=20
>> I captured the block trace and didn't found request LBA 35156656128 =
instead only found max request LBA 35156656127.
>=20
> Maybe in the trace you see only start sectors?  The failed check si =
performed on end sectors instead.
>=20
> At any rate, there seems to be an off-by-one error in the value(s) =
stored in the sector field(s) of the blk_independent_access_range data =
structure.
>=20
> I guess we may need some help/feedback from people competent on this =
stuff.
>=20
>> I'm not sure if this warning message is related to later OS hung.
>>=20
>=20
> Not easy to say.  At any rate, we can try with a development version =
of bfq.  It can help us detect the possible cause of this hang.  But =
let's see where we get with this sector error first.
>=20
> Thank you for testing this extended version of bfq, Paolo
>=20
>>=20
>> Problem environment
>> Kernel base is 5.18.9
>> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
>> Actuator LBA mapping by reading VPD B9 Concurrent positioning ranges=20=

>> VPD page:
>> LBA range number:0
>> number of storage elements:1
>> starting LBA:0x0
>> number of LBAs:0x417c00000 [17578328064] LBA range number:1 number of=20=

>> storage elements:1 starting LBA:0x417c00000 number of =
LBAs:0x417c00000=20
>> [17578328064]
>>=20
>>=20
>>=20
>>=20
>>=20
>> From: Paolo Valente <paolo.valente@linaro.org>
>> Sent: Thursday, June 23, 2022 8:53 AM
>> To: Jens Axboe <axboe@kernel.dk>
>> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>;=20
>> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;=20
>> jack@suse.cz <jack@suse.cz>; andrea.righi@canonical.com=20
>> <andrea.righi@canonical.com>; glen.valante@linaro.org=20
>> <glen.valante@linaro.org>; Arie van der Hoeven=20
>> <arie.vanderhoeven@seagate.com>; Paolo Valente=20
>> <paolo.valente@linaro.org>
>> Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator=20=

>> drives
>>=20
>>=20
>> This message has originated from an External Source. Please use =
proper judgment and caution when opening attachments, clicking links, or =
responding to this email.
>>=20
>>=20
>> Hi,
>> this patch series extends BFQ so as to optimize I/O dispatch to=20
>> multi-actuator drives. In particular, this extension addresses the=20
>> following issue. Multi-actuator drives appear as a single device to=20=

>> the I/O subsystem [1].  Yet they address commands to different=20
>> actuators internally, as a function of Logical Block Addressing=20
>> (LBAs). A given sector is reachable by only one of the actuators. For=20=

>> example, Seagate's Serial Advanced Technology Attachment (SATA)=20
>> version contains two actuators and maps the lower half of the SATA =
LBA=20
>> space to the lower actuator and the upper half to the upper actuator.
>>=20
>> Evidently, to fully utilize actuators, no actuator must be left idle=20=

>> or underutilized while there is pending I/O for it. To reach this=20
>> goal, the block layer must somehow control the load of each actuator=20=

>> individually. This series enriches BFQ with such a per-actuator=20
>> control, as a first step. Then it also adds a simple mechanism for=20
>> guaranteeing that actuators with pending I/O are never left idle.
>>=20
>> See [1] for a more detailed overview of the problem and of the=20
>> solutions implemented in this patch series. There you will also find=20=

>> some preliminary performance results.
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1]=20
>> =
https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYeP
>> =
rA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LR
>> =
iTVoIOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLO
>> =
NHEoI3p3e9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYB
>> =
Fn5S2WjBDQq2kzDzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEV
>> =
a1b6bQByX6grF5pn3pTIo0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIK
>> =
DrNTALs3xQvg03DH4jLez-T2M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F
>> =
%2Fwww.linaro.org%2Fblog%2Fbudget-fair-queueing-bfq-linux-io-scheduler
>> -optimizations-for-multi-actuator-sata-hard-drives%2F
>>=20
>> Davide Zini (3):
>> block, bfq: split also async bfq_queues on a per-actuator basis =20
>> block, bfq: inject I/O to underutilized actuators  block, bfq: =
balance=20
>> I/O injection among underutilized actuators
>>=20
>> Federico Gavioli (1):
>> block, bfq: retrieve independent access ranges from request queue
>>=20
>> Paolo Valente (4):
>> block, bfq: split sync bfq_queues on a per-actuator basis  block,=20
>> bfq: forbid stable merging of queues associated with different
>>   actuators
>> block, bfq: turn scalar fields into arrays in bfq_io_cq  block, bfq:=20=

>> turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>>=20
>> block/bfq-cgroup.c  |  97 +++++----
>> block/bfq-iosched.c | 488 =
+++++++++++++++++++++++++++++---------------
>> block/bfq-iosched.h | 149 ++++++++++----
>> block/bfq-wf2q.c    |   2 +-
>> 4 files changed, 493 insertions(+), 243 deletions(-)
>>=20
>> --
>> 2.20.1
>>=20
>>=20
>> Seagate Internal
>>=20
>> Seagate Internal
>=20
> Seagate Internal

