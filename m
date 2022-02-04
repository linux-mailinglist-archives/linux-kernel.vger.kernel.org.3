Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621004A9290
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356730AbiBDDDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:03:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22656 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBDDC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643943777; x=1675479777;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rARJEVCzcQpR9R2ulAO4q3XcUBilPiFV2HuRjvFumgw=;
  b=IQ12tmPBvxBCjZKqhsbn/IzFGfgltnIeR378FTrUubHQO9DdkPDnAeq9
   jNz1mKZJDYCj5EC34mIWtN8sOAwMQhXah912ZVIEf1dx6Evqwo010Q3Cv
   wrd9z402VfsP0kwkoNubELSfMmk5cy1AERUmeOmrrcnql9TvQOsVbBZs+
   2pXCu64yngjNe4F5fLCRB/1YV3qaiI97elmA3vk/rk3O9Nj7hcGbYeLTh
   V1IZPLZjmdNz0+hLtS6CMwkae2vVsiaebfO3VdDPSdo+/Y1NN0jsP1egR
   Mtf2YpAGVEI1vejOv4ij6rZkYrptwO7Gpk0lYoRVNk4EjJCeN9XDZVRwR
   A==;
X-IronPort-AV: E=Sophos;i="5.88,341,1635177600"; 
   d="scan'208";a="296224537"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 11:02:57 +0800
IronPort-SDR: hXtHrAZTUWzgWsDbnim8Y5II4rzY3bWARCqB8eW3K98nfRfsCx3punJ77iVTqrAbY0mFXzy379
 gOgV8xRiQIVcdheFVQijnLAwnUpF3WYz7kczMYt+aLaM9g1nChikCHqA8c/2UCkpCoK9Nw63aW
 ijEmFGQ/UazUTNsfLTSChJ712rhUROc4AFE+AXXiWzONg5HtPcnKtlpl+FnX3T8JooL7Cvv5yA
 KGZIw/L93I1YKimEW1KFUPb5xvwcZBz4JtF7auDAGlOdK7avY3FuIzQ7pLrkCLDt7DYudVbqyD
 ZdXndAWt70O2UI/ZY0gMiX79
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 18:36:04 -0800
IronPort-SDR: fd07+FSSm4alldbmpgil3kG5BzxU2v7rIepIFji5IcviiNu1VygR51+gMu/xkkP0ioMWbbi59b
 mHl13taVbUKTZJ5nMKgMOybiD6kgoRMW7CniBNtFJlslsXN7vJirNCNnw32wQ/HYV6Z4GSAXpy
 VOg0uMuVm5sNSHBMM53/MDNck5njY8JGKmHP846ote17YgZ4a+ftArZNliYTDfGZDp1g4m3tqf
 KNdQ1v5lmzHpW5wO20jB7BCDlyzPy7cy79R+jbXUtWmv7/gtsPgKHhQpHhGqnmd9FoO1OXj5kB
 m78=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 19:02:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqgMP2hBRz1SVnx
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 19:02:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643943774; x=1646535775; bh=rARJEVCzcQpR9R2ulAO4q3XcUBilPiFV2Hu
        RjvFumgw=; b=JtLaKoOQn2GlLuvbhcs2nLmhSFTYYdbm2YF2/B6XQtSMe/8xqvp
        GF2csmsgwyuVjJcODKRpH+8Pn/cxd5b0O86uLBDqmB9KyQPVHJGr8h9YNoQNBRbp
        K6g9CrbAlGp8626XD+kmp81lKVvD/5AG7x8W9/89xw4trqvjuO0/CuwehyMHswM7
        Kzd6c9GYN7qmwKWshcecw7DvTLm3m2EVcnBjpN4iGlEiaAeCjQwnSmG5JEdHyOyM
        1SW4kOJn+C3xEEI5eclko4qnEGlMeh7G/wMrmuM1IF+BuF9CeR5NhvGJOaZ3Nld9
        sO3Hnte8/7tgd6CiXozaknt4wiAICtdOXTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RzVM7sftqfd2 for <linux-kernel@vger.kernel.org>;
        Thu,  3 Feb 2022 19:02:54 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqgMJ0PcNz1Rwrw;
        Thu,  3 Feb 2022 19:02:51 -0800 (PST)
Message-ID: <62e56609-7026-93a1-a446-a6fd68328653@opensource.wdc.com>
Date:   Fri, 4 Feb 2022 12:02:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com,
        Ajish.Koshy@microchip.com
Cc:     yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
 <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
 <a8fae323-1877-058a-b03e-d175a725213f@opensource.wdc.com>
 <a2de1656-b1ec-2fb7-caab-657e27dacb48@huawei.com>
 <49da4d80-5cc3-35c3-ccaa-6def8165eb65@huawei.com>
 <59a198a8-1d87-bc09-d2d8-2d495ed74c16@opensource.wdc.com>
 <098f988e-1f12-c412-3111-60393dfe0f0b@huawei.com>
 <f3362c6f-b4b6-2914-0652-d786e19b6b03@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f3362c6f-b4b6-2914-0652-d786e19b6b03@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 09:36, Damien Le Moal wrote:
> On 2/4/22 00:55, John Garry wrote:
>> On 03/02/2022 09:44, Damien Le Moal wrote:
>>
>> Hi Damien,
>>
>>>>>> [=C2=A0 385.102073] sas: Enter sas_scsi_recover_host busy: 1 faile=
d: 1
>>>>>> [=C2=A0 385.108026] sas: sas_scsi_find_task: aborting task 0x00000=
0007068ed73
>>>>>> [=C2=A0 405.561099] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0=
 757:TMF task
>>
>> Contrary to mentioning TMF in the log, this is not a TMF but rather an=
=20
>> internal abort timing out. I don't think that this should ever happen.=
=20
>> This command should just abort pending IO commands in the controller a=
nd=20
>> not send anything to the target. So for this to timeout means a HW fau=
lt=20
>> or driver bug. And I did not touch this code for pm8001.
>>
>>>>>> timeout.
>>>>>> [=C2=A0 405.568236] sas: sas_scsi_find_task: task 0x000000007068ed=
73 is
>>>>>> aborted
>>>>>> [=C2=A0 405.574930] sas: sas_eh_handle_sas_errors: task 0x00000000=
7068ed73 is
>>>>>> aborted
>>>>>> [=C2=A0 411.192602] ata21.00: qc timeout (cmd 0xec)
>>>>>> [=C2=A0 431.672122] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0=
 757:TMF task
>>>>>> timeout.
>>>>>> [=C2=A0 431.679282] ata21.00: failed to IDENTIFY (I/O error, err_m=
ask=3D0x4)
>>>>>> [=C2=A0 431.685544] ata21.00: revalidation failed (errno=3D-5)
>>>>>> [=C2=A0 441.911948] ata21.00: qc timeout (cmd 0xec)
>>>>>> [=C2=A0 462.391545] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0=
 757:TMF task
>>>>>> timeout.
>>>>>> [=C2=A0 462.398696] ata21.00: failed to IDENTIFY (I/O error, err_m=
ask=3D0x4)
>>>>>> [=C2=A0 462.404992] ata21.00: revalidation failed (errno=3D-5)
>>>>>> [=C2=A0 492.598769] ata21.00: qc timeout (cmd 0xec)
>>>>>> ...
>>>>>>
>>
>> Do you have a fuller dmesg with my series?
>=20
> Here it is below. Conditions: I rebased everything on Linus latest
> master, applied your series and the patch you sent below, rebooted with
> pm80xx module option logging_level=3D31.
>=20
> Device scan is all OK. With the system idle, I simply start libzbc test=
s
> on the SATA SMR drive I have on the HBA.
>=20
> The first command issued is 0x63 =3D=3D NCQ NON DATA and seems to be OK=
, but
> it seems that there are inconsistencies. And that may be what breaks th=
e
> adapter/driver state because everything after that command miserably
> fails and does not complete.
>=20
> The inconsistency is this line says:
> [  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
> Which seems to be sensical for NCQ_NON_DATA command, but then, this lin=
e
> seems wrong:
> [  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len =3D 8
>=20
> I need to go and check the specs what the FIS reply format is for
> NCQ_NON_DATA.
>=20
>=20
> [  137.187184] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec dev=
ice
> [  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
> [  137.199339] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
> command 0x63 inb 4
> [  137.207577] pm80xx0:: pm8001_mpi_msg_consume  1446:: CI=3D46 PI=3D47
> msgHeader=3D8104200d
> [  137.215399] pm80xx0:: mpi_sata_completion  2481:IO_SUCCESS
> [  137.220961] pm80xx0:: mpi_sata_completion  2503:SAS_PROTO_RESPONSE
> len =3D 20
> [  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len =3D 8
> [  137.233878] pm80xx0:: pm8001_mpi_msg_free_set  1403: CI=3D47 PI=3D47
> [  137.236696] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec dev=
ice
> [  137.247102] pm80xx0:: pm80xx_chip_sata_req  4585:DMA
> [  137.252186] pm80xx0:: pm80xx_chip_sata_req  4593:FPDMA
> [  137.257400] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
> command 0x65 inb f
> [  167.506280] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [  167.512363] sas: sas_scsi_find_task: aborting task 0x00000000aa37262=
7
> [  167.519049] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 2, ab=
ort
> task tag =3D 0x1
> [  187.969173] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
> timeout.
> [  187.976450] sas: sas_scsi_find_task: task 0x00000000aa372627 is abor=
ted
> [  187.983244] sas: sas_eh_handle_sas_errors: task 0x00000000aa372627 i=
s
> aborted
> [  188.144734] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec dev=
ice
> [  188.151555] pm80xx0:: pm80xx_chip_sata_req  4588:PIO
> [  188.156648] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
> command 0xec inb 8
> [  193.600813] ata21.00: qc timeout (cmd 0xec)
> [  193.605976] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 4, ab=
ort
> task tag =3D 0x3
> [  214.080236] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
> timeout.
> [  214.087563] ata21.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> [  214.093929] ata21.00: revalidation failed (errno=3D-5)
> [  214.256233] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec dev=
ice
> [  214.263043] pm80xx0:: pm80xx_chip_sata_req  4588:PIO
> [  214.268128] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
> command 0xec inb 8
> [  224.319899] ata21.00: qc timeout (cmd 0xec)
> [  224.324317] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 6, ab=
ort
> task tag =3D 0x5
> [  244.799433] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
> timeout.
> [  244.806750] ata21.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> [  244.813110] ata21.00: revalidation failed (errno=3D-5)
> [  244.975500] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec dev=
ice
> [  244.982314] pm80xx0:: pm80xx_chip_sata_req  4588:PIO
> [  244.987400] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
> command 0xec inb 8
> [  275.006814] ata21.00: qc timeout (cmd 0xec)
> [  275.011236] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 8, ab=
ort
> task tag =3D 0x7
> [  295.486387] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
> timeout.
> [  295.494025] ata21.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> [  295.500390] ata21.00: revalidation failed (errno=3D-5)
> [  295.509179] ata21.00: disable device
> [  295.670556] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1
> tries: 1
> [  295.670570] sd 19:0:2:0: [sdj] REPORT ZONES start lba 0 failed
> [  295.689972] sd 19:0:2:0: [sdj] REPORT ZONES: Result: hostbyte=3DDID_=
OK
> driverbyte=3DDRIVER_OK
> [  295.700621] sd 19:0:2:0: [sdj] Sense Key : Not Ready [current]
> [  295.708975] sd 19:0:2:0: [sdj] Add. Sense: Logical unit not ready,
> hard reset required
> [  295.719331] sd 19:0:2:0: [sdj] 0 4096-byte logical blocks: (0 B/0 B)
> [  295.728727] sd 19:0:2:0: [sdj] Write Protect is on
> [  295.737928] sdj: detected capacity change from 39063650304 to 0
> [  295.826347] sd 19:0:2:0: [sdj] tag#158 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  295.838761] sd 19:0:2:0: [sdj] tag#158 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  295.920864] sd 19:0:2:0: [sdj] tag#780 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  295.933341] sd 19:0:2:0: [sdj] tag#780 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.010417] sd 19:0:2:0: [sdj] tag#248 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.022275] sd 19:0:2:0: [sdj] tag#248 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.101348] sd 19:0:2:0: [sdj] tag#949 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.113924] sd 19:0:2:0: [sdj] tag#949 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.192258] sd 19:0:2:0: [sdj] tag#25 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.204788] sd 19:0:2:0: [sdj] tag#25 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.284546] sd 19:0:2:0: [sdj] tag#273 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.297126] sd 19:0:2:0: [sdj] tag#273 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.376896] sd 19:0:2:0: [sdj] tag#653 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.389475] sd 19:0:2:0: [sdj] tag#653 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.468095] sd 19:0:2:0: [sdj] tag#159 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.479974] sd 19:0:2:0: [sdj] tag#159 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.560861] sd 19:0:2:0: [sdj] tag#274 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.572792] sd 19:0:2:0: [sdj] tag#274 CDB: Test Unit Ready 00 00 00
> 00 00 00
> [  296.654506] sd 19:0:2:0: [sdj] tag#727 FAILED Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  296.667151] sd 19:0:2:0: [sdj] tag#727 CDB: Test Unit Ready 00 00 00
> 00 00 00
>=20
> After these messages, the tests exit on failure (drive dropped) and
> there are no more messages. Doing rmmod or anything else get stuck too.
> I have to reset the machine to get back to a good state.
>=20
> I am starting to think that NCQ NON DATA command is being very badly
> handled... Switching the tests to run with all non-NCQ commands is
> working fine, albeit horribly slow (much slower than with other HBAs,
> e.g. Broadcom).
>=20
> Digging...

I missed a KASAN splat during device scan on boot:

   33.725184]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   33.746168] BUG: KASAN: use-after-free in __lock_acquire+0x41a5/0x5b50
[   33.764181] Read of size 8 at addr ffff88818a318660 by task
kworker/u64:6/583
[   33.786726]
[   33.802181] CPU: 6 PID: 583 Comm: kworker/u64:6 Not tainted
5.17.0-rc2+ #1425
[   33.823777] Hardware name: Supermicro Super Server/H12SSL-NT, BIOS
2.1 06/02/2021
[   33.845112] Workqueue: events_unbound async_run_entry_fn
[   33.864185] Call Trace:
[   33.880147]  <TASK>
[   33.896183]  dump_stack_lvl+0x45/0x59
[   33.913180]  print_address_description.constprop.0+0x1f/0x120
[   33.932108]  ? __lock_acquire+0x41a5/0x5b50
[   33.949156]  kasan_report.cold+0x83/0xdf
[   33.965184]  ? __lock_acquire+0x41a5/0x5b50
[   33.982178]  __lock_acquire+0x41a5/0x5b50
[   33.998919]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[   34.019831]  ? pm8001_mpi_build_cmd+0x3ad/0x780 [pm80xx]
[   34.039171]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[   34.057941]  ? pm80xx_chip_sata_req+0xa78/0x1cb0 [pm80xx]
[   34.076181]  lock_acquire+0x194/0x490
[   34.092185]  ? pm8001_queue_command+0x842/0x1150 [pm80xx]
[   34.113174]  ? lock_release+0x6b0/0x6b0
[   34.130184]  _raw_spin_lock+0x2c/0x40
[   34.147848]  ? pm8001_queue_command+0x842/0x1150 [pm80xx]
[   34.165964]  pm8001_queue_command+0x842/0x1150 [pm80xx]
[   34.185178]  ? __raw_spin_lock_init+0x3b/0x110
[   34.202748]  sas_ata_qc_issue+0x6d8/0xba0 [libsas]
[   34.220097]  ata_qc_issue+0x4f8/0xcc0 [libata]
[   34.242185]  ata_exec_internal_sg+0xacd/0x1790 [libata]
[   34.261176]  ? ata_qc_issue+0xcc0/0xcc0 [libata]
[   34.279059]  ? memset+0x20/0x40
[   34.296170]  ata_read_log_page+0x361/0x5d0 [libata]
[   34.313999]  ? ata_dev_set_feature+0x330/0x330 [libata]
[   34.332183]  ? ata_dev_set_feature+0x330/0x330 [libata]
[   34.353174]  ? vsprintf+0x10/0x10
[   34.369194]  ata_identify_page_supported+0xb8/0x2e0 [libata]
[   34.388168]  ata_dev_configure+0x161b/0x4b90 [libata]
[   34.407172]  ? _raw_spin_trylock_bh+0x50/0x70
[   34.424188]  ? ata_do_dev_read_id+0xe0/0xe0 [libata]
[   34.442100]  ? ata_hpa_resize+0xce0/0xce0 [libata]
[   34.458927]  ? memcpy+0x39/0x60
[   34.475172]  ? ata_dev_read_id+0xf70/0xf70 [libata]
[   34.492172]  ata_dev_revalidate+0x172/0x2b0 [libata]
[   34.508945]  ata_do_set_mode+0x11f5/0x2410 [libata]
[   34.525762]  ? find_held_lock+0x2c/0x110
[   34.542169]  ? ata_dev_revalidate+0x2b0/0x2b0 [libata]
[   34.558174]  ? ata_eh_recover+0x181e/0x33e0 [libata]
[   34.575698]  ata_set_mode+0x2e8/0x3f0 [libata]
[   34.592016]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   34.609166]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
[   34.625180]  ? trace_hardirqs_on+0x1c/0x110
[   34.641190]  ata_eh_recover+0x23be/0x33e0 [libata]
[   34.658188]  ? sas_ata_hard_reset+0x310/0x310 [libsas]
[   34.675144]  ? sas_ata_qc_fill_rtf+0x90/0x90 [libsas]
[   34.691182]  ? ata_link_nr_enabled+0x50/0x50 [libata]
[   34.708173]  ? find_held_lock+0x2c/0x110
[   34.723717]  ? lock_release+0x1dd/0x6b0
[   34.740168]  ? ata_scsi_port_error_handler+0x4d1/0xe60 [libata]
[   34.758180]  ? sas_ata_hard_reset+0x310/0x310 [libsas]
[   34.774868]  ? sas_ata_hard_reset+0x310/0x310 [libsas]
[   34.791740]  ? sas_ata_qc_fill_rtf+0x90/0x90 [libsas]
[   34.808169]  ata_do_eh+0x75/0x150 [libata]
[   34.824178]  ? trace_hardirqs_on+0x1c/0x110
[   34.840176]  ata_scsi_port_error_handler+0x536/0xe60 [libata]
[   34.857110]  ? sas_fail_probe.constprop.0+0xb5/0xb5 [libsas]
[   34.874168]  async_sas_ata_eh+0xcf/0x112 [libsas]
[   34.890978]  async_run_entry_fn+0x93/0x500
[   34.907184]  process_one_work+0x7f0/0x1310
[   34.923188]  ? lock_release+0x6b0/0x6b0
[   34.939169]  ? pwq_dec_nr_in_flight+0x230/0x230
[   34.955754]  ? rwlock_bug.part.0+0x90/0x90
[   34.972232]  worker_thread+0x598/0xf70
[   34.987993]  ? process_one_work+0x1310/0x1310
[   35.004971]  kthread+0x28f/0x330
[   35.020168]  ? kthread_complete_and_exit+0x20/0x20
[   35.037168]  ret_from_fork+0x1f/0x30
[   35.052525]  </TASK>
[   35.066623]
[   35.081181] Allocated by task 583:
[   35.097188]  kasan_save_stack+0x1e/0x40
[   35.113930]  __kasan_slab_alloc+0x64/0x80
[   35.130571]  kmem_cache_alloc+0x1a6/0x450
[   35.148041]  sas_alloc_task+0x1b/0x80 [libsas]
[   35.163187]  sas_ata_qc_issue+0x1a8/0xba0 [libsas]
[   35.180145]  ata_qc_issue+0x4f8/0xcc0 [libata]
[   35.195456]  ata_exec_internal_sg+0xacd/0x1790 [libata]
[   35.213179]  ata_read_log_page+0x361/0x5d0 [libata]
[   35.228915]  ata_identify_page_supported+0xb8/0x2e0 [libata]
[   35.246182]  ata_dev_configure+0x161b/0x4b90 [libata]
[   35.262189]  ata_dev_revalidate+0x172/0x2b0 [libata]
[   35.280168]  ata_do_set_mode+0x11f5/0x2410 [libata]
[   35.296178]  ata_set_mode+0x2e8/0x3f0 [libata]
[   35.311176]  ata_eh_recover+0x23be/0x33e0 [libata]
[   35.327168]  ata_do_eh+0x75/0x150 [libata]
[   35.342188]  ata_scsi_port_error_handler+0x536/0xe60 [libata]
[   35.360166]  async_sas_ata_eh+0xcf/0x112 [libsas]
[   35.376365]  async_run_entry_fn+0x93/0x500
[   35.392175]  process_one_work+0x7f0/0x1310
[   35.408169]  worker_thread+0x598/0xf70
[   35.424172]  kthread+0x28f/0x330
[   35.439850]  ret_from_fork+0x1f/0x30
[   35.456177]
[   35.469109] Freed by task 0:
[   35.482174]  kasan_save_stack+0x1e/0x40
[   35.496889]  kasan_set_track+0x21/0x30
[   35.512165]  kasan_set_free_info+0x20/0x30
[   35.527168]  __kasan_slab_free+0xd8/0x110
[   35.542454]  kmem_cache_free.part.0+0x67/0x170
[   35.559111]  mpi_sata_completion+0x99c/0x2d70 [pm80xx]
[   35.576044]  process_oq+0xbd2/0x7c20 [pm80xx]
[   35.592169]  pm80xx_chip_isr+0x94/0x130 [pm80xx]
[   35.608180]  tasklet_action_common.constprop.0+0x24b/0x2f0
[   35.625171]  __do_softirq+0x1b5/0x82d
[   35.640187]
[   35.653755] The buggy address belongs to the object at ffff88818a31864=
0
[   35.653755]  which belongs to the cache sas_task of size 320
[   35.688176] The buggy address is located 32 bytes inside of
[   35.688176]  320-byte region [ffff88818a318640, ffff88818a318780)
[   35.723167] The buggy address belongs to the page:
[   35.740168] page:000000006ae5e64e refcount:1 mapcount:0
mapping:0000000000000000 index:0xffff88818a3184c0 pfn:0x18a318
[   35.762689] flags: 0x20000000000200(slab|node=3D0|zone=3D2)
[   35.780183] raw: 0020000000000200 ffff888100f02440 ffff888100f02440
ffff888100f09e00
[   35.800300] raw: ffff88818a3184c0 ffff88818a318040 0000000100000008
0000000000000000
[   35.821174] page dumped because: kasan: bad access detected
[   35.840167]
[   35.855170] Memory state around the buggy address:
[   35.873169]  ffff88818a318500: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[   35.893918]  ffff88818a318580: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[   35.913172] >ffff88818a318600: fc fc fc fc fc fc fc fc fa fb fb fb fb
fb fb fb
[   35.932176]                                                        ^
[   35.953171]  ffff88818a318680: fb fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb
[   35.974171]  ffff88818a318700: fb fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb
[   35.994168]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is the submission path, not completion. The code is:

(gdb) list *(pm8001_queue_command+0x842)
0x3d42 is in pm8001_queue_command (drivers/scsi/pm8001/pm8001_sas.c:491).
486				atomic_dec(&pm8001_dev->running_req);
487				goto err_out_tag;
488			}
489			/* TODO: select normal or high priority */
490			spin_lock(&t->task_state_lock);
491			t->task_state_flags |=3D SAS_TASK_AT_INITIATOR;
492			spin_unlock(&t->task_state_lock);
493		} while (0);
494		rc =3D 0;
495		goto out_done;

So the task is already completed when the submission path tries to set
the state flag ? Debugging...


--=20
Damien Le Moal
Western Digital Research
