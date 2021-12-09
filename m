Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B416746F745
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhLIXNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:13:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4240 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhLIXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:13:41 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J98pQ2d6dz67XmZ;
        Fri, 10 Dec 2021 07:08:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 10 Dec 2021 00:10:05 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 23:10:04 +0000
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <Viswas.G@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Niklas.Cassel@wdc.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
 <Ya4PAu4Xj8UGHEV7@x1-carbon>
 <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
 <6ee6fe1b-e811-cada-0c18-78149c313358@huawei.com>
 <PH0PR11MB51120361EB6F6931CCE023D6EC709@PH0PR11MB5112.namprd11.prod.outlook.com>
 <f41d2bed-f320-1b70-7d63-fe77caa2534d@huawei.com>
 <6ed96184-6291-ad37-0241-00a5389293e6@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <24a9ac51-ce60-b883-2284-023c703a7885@huawei.com>
Date:   Thu, 9 Dec 2021 23:09:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <6ed96184-6291-ad37-0241-00a5389293e6@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 22:38, Damien Le Moal wrote:
>> It seems that SSP and STP commands are not completing for some reason,
>> from the "busy: 222" line.
> I have this HBA:
> 
> c1:00.0 Serial Attached SCSI controller: ATTO Technology, Inc. ExpressSAS 12Gb/s
> SAS/SATA HBA (rev 06)
> 	Subsystem: ATTO Technology, Inc. ExpressSAS H120F
> 
> Which uses the pm80xx driver and I do not see such error. E.g.:
> 
> [335568.262395] pm80xx 0000:c1:00.0: pm80xx: driver version 0.1.40
> [335568.268931] :: pm8001_pci_alloc  529:Setting link rate to default value
> [335569.489392] scsi host18: pm80xx
> [335570.801031] sas: phy-18:4 added to port-18:0, phy_mask:0x10 (50010860002f5644)
> [335570.801225] sas: DOING DISCOVERY on port 0, pid:58830
> [335570.801310] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [335570.807638] sas: ata22: end_device-18:0: dev error handler
> [335570.964864] ata22.00: ATA-11: WDC  WUH721818ALN604, PCGNW232, max UDMA/133
> [335579.062526] ata22.00: 4394582016 sectors, multi 0: LBA48 NCQ (depth 32)
> [335579.070487] ata22.00: Features: NCQ-sndrcv NCQ-prio
> [335579.307260] ata22.00: configured for UDMA/133
> [335579.313018] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
> [335579.323512] scsi 18:0:0:0: Direct-Access     ATA      WDC  WUH721818AL W232
> PQ: 0 ANSI: 5
> [335579.333243] sas: DONE DISCOVERY on port 0, pid:58830, result:0
> [335579.333338] sas: phy-18:5 added to port-18:1, phy_mask:0x20 (50010860002f5645)
> [335579.333453] sas: DOING DISCOVERY on port 1, pid:58830
> [335579.333596] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [335579.341596] sas: ata23: end_device-18:1: dev error handler
> [335579.341640] sas: ata22: end_device-18:0: dev error handler
> [335579.500374] ata23.00: ATA-11: WDC  WUH721818ALN604, PCGNWTW2, max UDMA/133
> [335588.427115] ata23.00: 4394582016 sectors, multi 0: LBA48 NCQ (depth 32)
> [335588.435158] ata23.00: Features: NCQ-sndrcv NCQ-prio
> [335588.513212] ata23.00: configured for UDMA/133
> [335588.519027] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
> [335588.537683] scsi 18:0:1:0: Direct-Access     ATA      WDC  WUH721818AL WTW2
> PQ: 0 ANSI: 5
> [335588.565288] sas: DONE DISCOVERY on port 1, pid:58830, result:0
> [335588.565543] sas: phy-18:7 added to port-18:2, phy_mask:0x80 (50010860002f5647)
> [335588.566917] sas: DOING DISCOVERY on port 2, pid:58830
> [335588.567515] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [335588.574948] sas: ata22: end_device-18:0: dev error handler
> [335588.574971] sas: ata23: end_device-18:1: dev error handler
> [335588.574979] sas: ata24: end_device-18:2: dev error handler
> [335588.732190] ata24.00: ATA-11: WDC  WSH722020ALN604, PCGMW803, max UDMA/133
> [335597.778187] ata24.00: 4882956288 sectors, multi 0: LBA48 NCQ (depth 32)
> [335597.788081] ata24.00: Features: NCQ-sndrcv NCQ-prio
> [335597.850404] ata24.00: configured for UDMA/133
> [335597.856225] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
> [335597.866680] scsi 18:0:2:0: Direct-Access-ZBC ATA      WDC  WSH722020AL W803
> PQ: 0 ANSI: 7
> [335597.876485] sas: DONE DISCOVERY on port 2, pid:58830, result:0
> [335597.879720] sd 18:0:0:0: [sdd] 4394582016 4096-byte logical blocks: (18.0
> TB/16.4 TiB)
> [335597.881483] sd 18:0:0:0: Attached scsi generic sg3 type 0
> [335597.888827] sd 18:0:0:0: [sdd] Write Protect is off
> [335597.888830] sd 18:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [335597.888839] sd 18:0:0:0: [sdd] Write cache: enabled, read cache: enabled,
> doesn't support DPO or FUA
> [335597.968683] sd 18:0:1:0: [sde] 4394582016 4096-byte logical blocks: (18.0
> TB/16.4 TiB)
> [335597.969489] sd 18:0:1:0: Attached scsi generic sg4 type 0
> [335597.978210] sd 18:0:1:0: [sde] Write Protect is off
> [335597.978214] sd 18:0:1:0: [sde] Mode Sense: 00 3a 00 00
> [335597.978228] sd 18:0:1:0: [sde] Write cache: enabled, read cache: enabled,
> doesn't support DPO or FUA
> [335598.053869] sd 18:0:2:0: [sdf] Host-managed zoned block device
> [335598.054476] sd 18:0:2:0: Attached scsi generic sg5 type 20
> [335598.066428] sd 18:0:2:0: [sdf] 4882956288 4096-byte logical blocks: (20.0
> TB/18.2 TiB)
> [335598.093762] sd 18:0:2:0: [sdf] Write Protect is off
> [335598.100101] sd 18:0:2:0: [sdf] Mode Sense: 00 3a 00 00
> [335598.100119] sd 18:0:2:0: [sdf] Write cache: enabled, read cache: enabled,
> doesn't support DPO or FUA
> [335598.158832] sd 18:0:1:0: [sde] Attached SCSI disk
> [335598.158870] sd 18:0:0:0: [sdd] Attached SCSI disk
> [335600.015402] sd 18:0:2:0: [sdf] 74508 zones of 65536 logical blocks
> [335600.099235] sd 18:0:2:0: [sdf] Attached SCSI disk
> 
> The driver is uselessly verbose (for some reasons, the dbg messages show up),
> but no errors.


Here's my log on my arm64 machine:

root@(none)$ echo 0000:04:00.0 > bind
[83.872341] pm80xx 0000:04:00.0: pm80xx: driver version 0.1.40
[83.878359] :: pm8001_pci_alloc  530:Setting link rate to default value
[84.932057] scsi host0: pm80xx
[87.288239] sas: target proto 0x0 at 500e004aaaaaaa1f:0x10 not handled
[87.294793] sas: ex 500e004aaaaaaa1f phy16 failed to discover
[87.360228] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[89.734180] ata4.00: ATA-8: SAMSUNG HM320JI, 2SS00_01, max UDMA7
[89.740185] ata4.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 32)
[93.237158] ata4.00: configured for UDMA/133
[93.241435] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[93.262941] scsi 0:0:0:0: Direct-Access  SEAGATE  ST2000NM0045  N004 PQ: 
0 ANSI: 6
[93.275710] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 
TB/1.82 TiB)
[93.284159] sd 0:0:0:0: [sda] Write Protect is off
[93.284423] scsi 0:0:1:0: Direct-Access  SEAGATE  ST2000NM0045  N004 PQ: 
0 ANSI: 6
[93.298317] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
supports DPO and FUA
[93.300128] scsi 0:0:2:0: Direct-Access  ATASAMSUNG HM320JI  0_01 PQ: 0 
ANSI: 5
[93.301689] sd 0:0:1:0: [sdb] 3907029168 512-byte logical blocks: (2.00 
TB/1.82 TiB)
[93.302366] sd 0:0:1:0: [sdb] Write Protect is off
[93.303636] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, 
supports DPO and FUA
[93.311335]  sdb: sdb1
[93.315129] sd 0:0:2:0: [sdc] 625142448 512-byte logical blocks: (320 
GB/298 GiB)
[93.315678]  sda: sda1
[93.315898] scsi 0:0:3:0: Direct-Access  SEAGATE  ST1000NM0023  0006 PQ: 
0 ANSI: 6
[93.321138] sd 0:0:0:0: [sda] Attached SCSI disk
[93.328114] sd 0:0:1:0: [sdb] Attached SCSI disk
[93.335947] sd 0:0:2:0: [sdc] Write Protect is off
[93.344840] scsi 0:0:4:0: EnclosureHUAWEIExpander 12Gx16  128  PQ: 0 
ANSI: 6
[93.345274] sd 0:0:3:0: [sdd] 1953525168 512-byte logical blocks: (1.00 
TB/932 GiB)
[93.345634] sd 0:0:3:0: [sdd] Write Protect is off
[93.346268] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: enabled, 
supports DPO and FUA
[93.351997]  sdd: sdd1 sdd2
[93.355067] sd 0:0:3:0: [sdd] Attached SCSI disk
[93.356196] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[93.401162]  sdc: sdc1 sdc2 sdc3
[93.406853] sd 0:0:2:0: [sdc] Attached SCSI disk
[93.425508] sas: ex 500e004aaaaaaa1f phy08 change count has changed
[93.435927] sas: target proto 0x0 at 500e004aaaaaaa1f:0x11 not handled
[93.442480] sas: ex 500e004aaaaaaa1f phy17 failed to discover
[93.448737] sas: target proto 0x0 at 500e004aaaaaaa1f:0x12 not handled
[93.455288] sas: ex 500e004aaaaaaa1f phy18 failed to discover
[93.461527] sas: target proto 0x0 at 500e004aaaaaaa1f:0x13 not handled
[93.468081] sas: ex 500e004aaaaaaa1f phy19 failed to discover
[93.479734] sas: ex 500e004aaaaaaa1f phys DID NOT change
[93.500240] sas: ex 500e004aaaaaaa1f phys DID NOT change
[93.510489] sas: ex 500e004aaaaaaa1f phys DID NOT change
[93.520714] sas: ex 500e004aaaaaaa1f phys DID NOT change
[93.531000] sas: ex 500e004aaaaaaa1f phys DID NOT change
[93.541351] sas: ex 500e004aaaaaaa1f phys DID NOT change
[93.551721] sas: ex 500e004aaaaaaa1f phys DID NOT change
[93.562066] sas: ex 500e004aaaaaaa1f phys DID NOT change
root@(none)$
root@(none)$
root@(none)$

And then it's the mounting a partition or examining it which hangs quite 
reliably:

root@(none)$ mount /dev/sda1 mnt
[  104.232655] EXT4-fs (sda1): recovery complete
[  104.237021] EXT4-fs (sda1): mounted filesystem with ordered data 
mode. Opts: (null). Quota mode: none.
root@(none)$ ls mnt
[  136.842085] sas: Enter sas_scsi_recover_host busy: 203 failed: 203
[  136.848286] sas: sas_scsi_find_task: aborting task 0x(____ptrval____)
[  157.280267] pm80xx1:: pm8001_exec_internal_tmf_task  756:TMF 
task[1]timeout.
[  171.283579] pm80xx1:: mpi_ssp_completion  1935:sas IO status 0x1
[  171.283584] pm80xx1:: pm8001_abort_task  1327:rc= -5
[  171.289579] pm80xx1:: mpi_ssp_completion  1946:SAS Address of IO 
Failure Drive:5000c500a7b95a49
[  171.289583] pm80xx1:: mpi_ssp_completion  2184:task 
0x(____ptrval____) done with io_status 0x1 resp 0x0 stat 0x8d but 
aborted by upper layer!
[  171.315904] sas: sas_eh_handle_sas_errors: task 0x(____ptrval____) is 
done
[  171.322769] sas: sas_scsi_find_task: aborting task 0x(____ptrval____)

Earlier today it was the mount command which was hanging. From debugging 
that, I found that the very first SSP command when mounting is sent the 
HW successfully but no completion interrupt ever occurs there - I really 
don't know why. Other SSP commands complete successfully before this and 
after (TMFs in the error handling), including ones which have sgls.

sda is a SAS drive, but I think SATA has the same issue - I was just 
looking at sda.

One thing I noticed in the driver is that it uses mb() in between 
writing to the DMA memory and initiating the HW - I don't think mb is 
strong enough. However I don't think that is my issue - it wouldn't fail 
reliably if it was.

Thanks,
John
