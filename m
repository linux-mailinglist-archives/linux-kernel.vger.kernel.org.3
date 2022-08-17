Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10A5974E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiHQRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiHQRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:18:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1BC326CC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660756709; x=1692292709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bICho/OFUvjD7iVy2ce8Hlpf0jhWPnzAwWFMaOv0q3E=;
  b=a1p41c0XZ2mU9AYcQeWoBjTMmW2zNExmX/DUwoY/ZXDw40lw6ekkidtW
   n1zMJrNlzQKGxiS1hVt7Iw/4GhHlqQW1GYP1vw4zOERbjG1sMhgxlo0CU
   l4CSCEO2ujW8+YD7dj2PSdf+QEf2fIgUleEobg+IAtFFBgu+XZ4rdDjs8
   /UQ9H5nHa2k3JOvk6LQx01UcBRSkGXp7dkk5BEoJBfwa/RaN1ETREqKMM
   9hd6P6H0CHk3IcF6vRuZXK7PYlpxPVquHbtlI6AuduCcClqslyEBHsTNI
   uppRIZscBcc/4ndtnVBbuxoFC84TfBeXoILesUJFWS+Bc7a6SkEyF0Rc/
   w==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="208963529"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 01:14:12 +0800
IronPort-SDR: z8NUVS2AHK+WLjTOXbP39BlJ/wb2KofRoBUIKufQQA0fGFKQb6JxkPW14/zDpfnuq7lfuY8Obm
 5iuU3qnndPAc/4QdwQshZv6gLNEu5Cic3YpPXLl6s0JHVjB57g+zJ2szEygEAzaKj7TsgeX32R
 kEvEretGC9HEw2ZSiZgrz9dGx1pa9rBw672R8Agzr2j8PjGr1+PfdRBFGTwBU+fEQWxpsI/CnN
 ZvcejpSu4DxHWNXwqjPqgeWnkqygEw1AFSRwUJumGkg3RL452tp+Jjc+ay7hLDx5WdLso9Gml0
 uolBQs0X5tWWTTxVUdul1Mnj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:29:40 -0700
IronPort-SDR: ykuqYseerFGdiMuN6Z/V+P/nd18Dv65kBqa5c3npZvSrq7ZyGdI3XO3CyzkzwF/5lxvL7bw2z1
 6X6a6ylUb/vgDtg2VHHm1+WdgGfKm+1GYz/mNCo4bY5A/82eQoCN6IbGg97bxdb7ZJZDjNXKqw
 106Oi0y7htj8grACp92wH5VWMkPb4pOtOiOKM/AaqCQFRS2KFxPo79Pnwe3kwz3dNF1Q5jm30F
 RPPWUqqyKdRrJ2VfjkJeqBRhjXshv7226IgsJ+w4gagGu/2VPMCtiBmLqFbauWVprMGMctYiEM
 gQI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 10:14:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7F450XV0z1Rwnl
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:14:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660756451; x=1663348452; bh=bICho/OFUvjD7iVy2ce8Hlpf0jhWPnzAwWF
        MaOv0q3E=; b=tijYPoUIWJibVrNQT0jvV7l907t2miXk4MRFQ/QX6bPOrf1mMq4
        puCwHJ7Y/tZU/il9+oSEsQyGUaNpI0xbgPtDRqOeVoOxb841n8bRFiXYP/QroXmw
        n2y9XwnGQTkg3AgEkvWiq8Biqt568w4CZ2YHivXH0gLK5orYMRG/f8df/PfjVuBG
        NbW/NH73Tc3QsR0u4Ow/ChZ8T6mlhPTwMIfL8Ssh7/qms0VRX/CDnRaWEIAHsJAH
        jERHCeGy3ZbTV/ornfHVfM7U9p3z0kzBDt+3d33fWo2mcDIUSZXiIpAcoRyKfaU0
        9d+ensRlxmplZg5NT8mKn4qMJ9XpbD8XEcg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IpHF5Yw0DL5Z for <linux-kernel@vger.kernel.org>;
        Wed, 17 Aug 2022 10:14:11 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7F4329Smz1RtVk;
        Wed, 17 Aug 2022 10:14:11 -0700 (PDT)
Message-ID: <baf63982-810c-85eb-b28f-99ab0517c6ba@opensource.wdc.com>
Date:   Wed, 17 Aug 2022 10:14:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/6] scsi: libsas: Add sas_ata_device_link_abort()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        yangxingui@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, hare@suse.de
References: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
 <1660747934-60059-3-git-send-email-john.garry@huawei.com>
 <0bb6b134-7bad-7c39-ad6d-25d57bd343eb@opensource.wdc.com>
 <018080d5-fbc4-7f04-0d3f-587f2397cd20@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <018080d5-fbc4-7f04-0d3f-587f2397cd20@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/17 9:54, John Garry wrote:
> On 17/08/2022 17:04, Damien Le Moal wrote:
>> On 2022/08/17 7:52, John Garry wrote:
>>> Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
>>> ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLDDs
>>> to call to initiate a link abort.
>>>
>>> This will mark all outstanding QCs as failed and kick-off EH.
>>>
>>> Note:
>>> The ATA_EH_RESET flag is set for following reasons:
>>> - For hisi_sas, SATA device resources during error handling will only be
>>>    released during reset for ATA EH.
>>>    ATA EH could decide during autopsy that EH would not be required, so
>>>    ensure that it happens (by setting the flag).
>>> - Similar to hisi_sas, pm8001 NCQ error handling requires a hardreset to
>>>    ensure necessary recovery commands are sent (so again we require flag
>>>    ATA_EH_RESET to be set as an insurance policy).
>>>
>>> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/scsi/libsas/sas_ata.c | 11 +++++++++++
>>>   include/scsi/sas_ata.h        |  5 +++++
>>>   2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
>>> index d35c9296f738..9daae64be37e 100644
>>> --- a/drivers/scsi/libsas/sas_ata.c
>>> +++ b/drivers/scsi/libsas/sas_ata.c
>>> @@ -861,6 +861,17 @@ void sas_ata_wait_eh(struct domain_device *dev)
>>>   	ata_port_wait_eh(ap);
>>>   }
>>>   
>>> +void sas_ata_device_link_abort(struct domain_device *device)
>>> +{
>>> +	struct ata_port *ap = device->sata_dev.ap;
>>> +	struct ata_link *link = &ap->link;
>>> +
>>> +	link->eh_info.err_mask |= AC_ERR_DEV;
>>> +	link->eh_info.action |= ATA_EH_RESET;
>>
> 
> Hi Damien,
> 
> Warning: I'm going to write a bit of an essay here... :)
> 
>> I am still not convinced that we should set this here. ata_eh_link_autopsy() and
>> ata_eh_analyze_serror() are supposed to set the action based on the error. Can't
>> you reuse the link autopsy function ?
> 
> The link autopsy code works ok, but it may not decide to do the reset 
> which we may rely on.
> 
> For hisi_sas, consider this log from an NCQ error:
> 
> 174.385322] ata10.00: failed command: READ FPDMA QUEUED
> [ 174.385336] ata10.00: cmd 60/08:00:11:27:00/00:00:00:00:00/40 tag 0 
> ncq dma 4096 in
> res 41/40:08:11:27:00/00:00:00:00:00/00 Emask 0x409 (media error) <F>
> [ 174.385339] ata10.00: status: { DRDY ERR }
> [ 174.385343] ata10.00: error: { UNC }
> [ 174.385641] ata10.00: configured for UDMA/133
> [ 174.385697] sd 6:0:1:0: [sdb] tag#701 FAILED Result: hostbyte=DID_OK 
> driverbyte=DRIVER_SENSE
> [ 174.385710] sd 6:0:1:0: [sdb] tag#701 Sense Key : Medium Error [current]
> [ 174.385726] sd 6:0:1:0: [sdb] tag#701 Add. Sense: Unrecovered read 
> error - auto reallocate failed
> [ 174.385740] sd 6:0:1:0: [sdb] tag#701 CDB: Read(10) 28 00 00 00 27 11 
> 00 00 08 00
> [ 174.385745] print_req_error: I/O error, dev sdb, sector 10001
> [ 174.385827] ata10: EH complete
> 
> The ATA autopsy has a found medium error and decided that reset is not 
> required - this is similar in that regard to the "unaligned write to a 
> sequential write required zone on SMR" error you mentioned from your 
> test previously. The problem in this is that for hisi_sas we depend on 
> disk reset to release driver resources associated with ATA QCs. That is 
> because it is only after reset that we can guarantee that no IO 
> associated with the disk will complete in HW and it is safe to release 
> the resources.

If you had an error, then you already are guaranteed that you will not see any
completion at all since the SATA drive is in error mode already. But I see the
point here. The HBA internal qc resources need to be cleared and that seems to
be done only with a device reset big hammer.

> But pm8001 seems different here with regards releasing resources. I find 
> that when EH kicks in from NCQ error and libsas tries to abort missing 
> commands, the pm8001_abort_task() -> sas_execute_internal_abort_single() 
> causes the original IO to complete as aborted - this is good, as then we 
> may release the resources there. hisi_sas has no such feature.
> 
> But the pm8001 manual and current driver indicate that the 
> OPC_INB_SATA_ABORT command should be sent after read log ext when 
> handling NCQ error, regardless of an autopsy. I send OPC_INB_SATA_ABORT 
> in ata_eh_reset() -> pm8001_I_T_nexus_reset() -> pm8001_send_abort_all()

You lost me: ata_eh_recover() will call ata_eh_reset() only if the ATA_EH_RESET
action flag is set. So are you saying that even though it is not needed, you
still need to set ATA_EH_RESET for pm8001 ?

> As I mentioned before, I saw nowhere better to call 
> pm8001_send_abort_all() for this. I would rather not do it in 
> ata_eh_reset() -> pm8001_I_T_nexus_reset()

We could add a new op ->eh_link_autopsy which we can call if defined after the
call to ata_eh_analyze_ncq_error() in ata_eh_link_autopsy(). With that, you can
set ATA_EH_RESET for the hisi driver and only do pm8001_send_abort_all() for
pm8001 (that will be done after the read log 10h).

> 
> How about this modified approach:
> - Continue to set ATA_EH_RESET in sas_ata_device_link_abort()
> - pm8001_I_T_nexus_reset() will only call pm8001_send_abort_all() when 
> the driver is in NCQ error state and not do a hard reset in that case.
> 	- But I am not sure if that works as the autopsy for NCQ error may have 
> decided that a hardreset was really required. Hmmm..

See the above. the new op may decided a reset is needed (hisi case) and even if
the standard autopsy does not make that decision, the flag is set and
ata_eh_recover() will reset the device. For the pm8001 case, no reset set with
the new op, only pm8001_send_abort_all(). And even if ata_eh_link_autopsy()
decides that a reset is needed after calling the new op, that would still be OK
I think.

-- 
Damien Le Moal
Western Digital Research
