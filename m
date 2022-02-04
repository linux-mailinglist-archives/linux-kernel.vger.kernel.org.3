Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC84A9863
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358380AbiBDL1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:27:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31153 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358367AbiBDL1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643974071; x=1675510071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4oT3kO7idKuxI/WBc6gpRwbrYnMZASbJD3/zTJR4xr8=;
  b=lKhOl2YCjbG41Wb/mNvLy3qd2POEJKfJh9okSWFOlmN/kKpCqYGS9OFI
   JMm3Lv83XUhosQvFhDQIaBAM91BGTk3TlmU2Eqksv40fssspX1scrBXdS
   PXCxRpsLCTsK4Y+4c2Vp0dVJAgfb8xzg8RirDmFcc9W7Jp6S9Ufw7nu7R
   iuCiursdfAZLCS/qvJxHuhQJv2SllDGsDa/ta0tW6iPQvVcn9xHNtPO4S
   +RiGo5Tm3RafOKckgqJdHt8si1303gQWVnXm+ssTiEmZyrBFH97gOXjF8
   ZMKgi/VFU2GN/nQo2cZNHvngu3yXJTGwMQ+i0N4qtLOK6k0xc/7hou3SE
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="191096827"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 19:27:51 +0800
IronPort-SDR: wS4ow1BBk1IZdSNauPyh8OtgJPIuuoj1bxn+UGuhqQ/KBzTlx/oVVJpZeKe6iAWTuQ9iRfIKOB
 0mUEcBMODQNDPmTBTYr4ijCHoH2Nhnocsg90OfPNCilNd7smXkCHhgNrhrfX83MqTjmEnED8bF
 EaWYGtV2BWVzzZcI9iVoDcZfxMYbVGCX25MMCRztyXc9Tai/s+8NKxsy2JTym2k/F9EWiJSsHG
 1suzGukF3ybHrUXUMa9ie+qo8mNBuVPB6NkzuhPbyHtf9OY4Qx31XpzEVle+jA9FiFx+5qgjrR
 kG5QN2F9/Zw9zRxOFEOtlsbi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 03:00:57 -0800
IronPort-SDR: sw41qkXwKvb2adIn/Q1MIZNG0vukZjai30ite6C71mMSCPS8Zyvdr/lbG9/a9Upbf2VS45X7nK
 4+tE3A/OIOkNeRLwN/Gw4V7kNR3VqBOUf2squJk5vz0sJ4lJAO7HyCKJHsQ+AtfDC/6z0hk5Yb
 iPcvRSLIzv/u/sC/9ELomCkmprugil1rva0J4yUuGIbhehseCfcY+DkGD9iU5uYkpuPul8/M+M
 VKTq+k9IiRDThwbrwO7dAUgoRJ90HJ0oCkD04QdpDfMjpMZMunqmuEB8rawfTeLFDP5eCsftC6
 i80=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 03:27:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqtYy2pSvz1SVp2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:27:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643974069; x=1646566070; bh=4oT3kO7idKuxI/WBc6gpRwbrYnMZASbJD3/
        zTJR4xr8=; b=CWYZLUnXALPwYORPL9cnl/0n4lB5vnZiQ7uEM8R+h9vq0rf53wS
        95oBTBomiTC2lfaX2meHJtypav0dibLWMp/jv3VUeNYJJQ+EVq0GIQlPtU/MhTvE
        Gigi4hlqK3iGv5cDi7W8XwPl+/3/7662bC9mbMBRCIgaC4Q5x1IA7eqxjKo/hh2F
        n7aSnfIh9l5ZDLHQ31oQ1m71MgOPvKaVOFDBolr56Z6FZTxdC9MOcLzxmn5XFRbe
        18xg1ldN1lny+Q37MBnz1EC2aczk5nQ7RcVo522P1IoubfL2S2mni+A4mqsijcVR
        ViyTx6jRKj+iP1Bp2Gk/2zdl+ZBNg8f/9Kg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pKDep_N8jnyx for <linux-kernel@vger.kernel.org>;
        Fri,  4 Feb 2022 03:27:49 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqtYt6mbbz1Rwrw;
        Fri,  4 Feb 2022 03:27:46 -0800 (PST)
Message-ID: <2bd15f44-0b56-b6e0-8ef8-c33ba9ee7caa@opensource.wdc.com>
Date:   Fri, 4 Feb 2022 20:27:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
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
 <62e56609-7026-93a1-a446-a6fd68328653@opensource.wdc.com>
 <e8af9d55-bf36-faa0-defb-3a9a4931826e@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e8af9d55-bf36-faa0-defb-3a9a4931826e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 19:36, John Garry wrote:
> On 04/02/2022 03:02, Damien Le Moal wrote:
>>> The inconsistency is this line says:
>>> [  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
>>> Which seems to be sensical for NCQ_NON_DATA command, but then, this line
>>> seems wrong:
>>> [  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len = 8
>>>
>>> I need to go and check the specs what the FIS reply format is for
>>> NCQ_NON_DATA.
>>>
>>>
>>> [  137.187184] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec device
>>> [  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
>>> [  137.199339] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
>>> command 0x63 inb 4
>>> [  137.207577] pm80xx0:: pm8001_mpi_msg_consume  1446:: CI=46 PI=47
>>> msgHeader=8104200d
>>> [  137.215399] pm80xx0:: mpi_sata_completion  2481:IO_SUCCESS
>>> [  137.220961] pm80xx0:: mpi_sata_completion  2503:SAS_PROTO_RESPONSE
>>> len = 20
>>> [  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len = 8
>>> [  137.233878] pm80xx0:: pm8001_mpi_msg_free_set  1403: CI=47 PI=47
>>> [  137.236696] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec device
>>> [  137.247102] pm80xx0:: pm80xx_chip_sata_req  4585:DMA
>>> [  137.252186] pm80xx0:: pm80xx_chip_sata_req  4593:FPDMA
>>> [  137.257400] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
>>> command 0x65 inb f
>>> [  167.506280] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
>>> [  167.512363] sas: sas_scsi_find_task: aborting task 0x00000000aa372627
>>> [  167.519049] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag = 2, abort
>>> task tag = 0x1
>>> [  187.969173] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
>>> timeout.
> 
> As I mentioned, having this fail is a red flag. If I was pushed to guess 
> what has happened, I'd say the FW is faulting due to some erroneous 
> driver behaviour.

I am still thinking that there is something wrong with the handling of
NCQ NON DATA command. There are several places where the code determines
non-data vs pio vs dma vs fpdma (ncq), and NCQ NON DATA always falls in
the fpdma bucket, which is wrong.

>> This is the submission path, not completion. The code is:
>>
>> (gdb) list *(pm8001_queue_command+0x842)
>> 0x3d42 is in pm8001_queue_command (drivers/scsi/pm8001/pm8001_sas.c:491).
>> 486				atomic_dec(&pm8001_dev->running_req);
>> 487				goto err_out_tag;
>> 488			}
>> 489			/* TODO: select normal or high priority */
>> 490			spin_lock(&t->task_state_lock);
>> 491			t->task_state_flags |= SAS_TASK_AT_INITIATOR;
>> 492			spin_unlock(&t->task_state_lock);
>> 493		} while (0);
>> 494		rc = 0;
>> 495		goto out_done;
>>
>> So the task is already completed when the submission path tries to set
>> the state flag ? Debugging...
> 
> Yeah, that's how it looks.
> 
> I already mentioned this problem here:
> 
> https://lore.kernel.org/linux-scsi/0cc0c435-b4f2-9c76-258d-865ba50a29dd@huawei.com/
> 
> Maybe we should just fix it now to rule it out of possibly causing other 
> issues... I was reluctant to fix it as many places seems to need to be 
> touched. Let me check it.

Here is my current fix:

diff --git a/drivers/scsi/pm8001/pm8001_sas.c
b/drivers/scsi/pm8001/pm8001_sas.c
index 1b95c73d12d1..16c101577dd3 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -453,13 +453,18 @@ int pm8001_queue_command(struct sas_task *task,
gfp_t gfp_flags)
                ccb->ccb_tag = tag;
                ccb->task = t;
                ccb->device = pm8001_dev;
+
+               /* TODO: select normal or high priority */
+               atomic_inc(&pm8001_dev->running_req);
+               spin_lock(&t->task_state_lock);
+               t->task_state_flags |= SAS_TASK_AT_INITIATOR;
+               spin_unlock(&t->task_state_lock);
+
                switch (task_proto) {
                case SAS_PROTOCOL_SMP:
-                       atomic_inc(&pm8001_dev->running_req);
                        rc = pm8001_task_prep_smp(pm8001_ha, ccb);
                        break;
                case SAS_PROTOCOL_SSP:
-                       atomic_inc(&pm8001_dev->running_req);
                        if (is_tmf)
                                rc = pm8001_task_prep_ssp_tm(pm8001_ha,
                                        ccb, tmf);
@@ -468,7 +473,6 @@ int pm8001_queue_command(struct sas_task *task,
gfp_t gfp_flags)
                        break;
                case SAS_PROTOCOL_SATA:
                case SAS_PROTOCOL_STP:
-                       atomic_inc(&pm8001_dev->running_req);
                        rc = pm8001_task_prep_ata(pm8001_ha, ccb);
                        break;
                default:
@@ -480,13 +484,12 @@ int pm8001_queue_command(struct sas_task *task,
gfp_t gfp_flags)

                if (rc) {
                        pm8001_dbg(pm8001_ha, IO, "rc is %x\n", rc);
+                       spin_lock(&t->task_state_lock);
+                       t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
+                       spin_unlock(&t->task_state_lock);
                        atomic_dec(&pm8001_dev->running_req);
                        goto err_out_tag;
                }
-               /* TODO: select normal or high priority */
-               spin_lock(&t->task_state_lock);
-               t->task_state_flags |= SAS_TASK_AT_INITIATOR;
-               spin_unlock(&t->task_state_lock);
        } while (0);
        rc = 0;
        goto out_done;

With this, No KASAN complaint. I will send a proper patch ASAP.

Of note is that I cannot see what the flag SAS_TASK_AT_INITIATOR is for.
It is set and unset only, never tested anywhere in libsas nor pm8001
driver. This flag seems totally useless to me, unless this is something
that the HW can see ?

-- 
Damien Le Moal
Western Digital Research
