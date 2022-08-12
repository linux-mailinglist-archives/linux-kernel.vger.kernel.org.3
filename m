Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B69591572
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiHLSYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLSYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:24:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4151B2DA7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660328669; x=1691864669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mEcxvF4PsnkvmosCiuHJl4/pNrL0uzzasoDTrheGJ/k=;
  b=XR2BA6YILmYFSbsV76qrG/z91ZvcecLAogLd188ZaMNtt6WxIv44tnBa
   X0yL42tdLPsf1qpJH7QRsBQlB/l496OQ5JoMVjZ5BLWvR/5amx5uAVbVp
   VWFJwU6X9m637i9p4jYjONc/K8HIkZB5C2Yp7FIT7vFbVAyUR59pMRV5i
   kiznIVmhGQ7DGicXQrdvLcGLDkXYDU+kYQ3Tn7VANqCaAIBS4yuyZVreH
   uwsFOfjcLOSH9r4JuSQCyEisylgGycb4Gc2DXc04S9WG+o19dkh6UYanh
   PxLelkPalE5HkBq+LKwXmaVaYnMbm5AtaJgSL8xSpyCFcM+/b+U+xoZ/f
   w==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654531200"; 
   d="scan'208";a="213615035"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2022 02:24:28 +0800
IronPort-SDR: PGlkCOeqdsEV8eTKuZm6nJsrEdlrWyEdQo+rhd01GI4X6HrJqu4d/sVIPlhSYrL9xMoJVR3vl9
 MiiMOHBnPLjjw4fVMPY/AtTyxLjkPqshwvhXzorTZD7em72sM1Y6OEnx5T5GNowxbxo3rzq4HT
 K2DPXP6EALWtkOX/0B8xPaGCiVgNZk4nCewPXeMVDDkJTMG6rf/QPWLldx9vT7rOZt87/vX2Gw
 E15Jlu5KzPXoqfb+P5RLZf0zO2uQf2uRhl6Fld6VBSCCXWZC/lgWl3o78k1jRZfcGmKAFGctCj
 npppuSIkPe/hChN++SHvcQkI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 10:45:21 -0700
IronPort-SDR: ijtl1BG7mi4g/osYBxkWCrdopBJ1syjXQjO/3TwnreFETBbzzjdW050z1AVatiSdqFqJ2GT78O
 Lbid/LBive523M8dqRFN74JqB96BbMkdBYNOpsViXSTOOSb6y3FSW0zJiWHWzQPVZFVHcmOPjz
 aPyEKRbFj5DPmc5GQcRhlsngUXXVWnqWcrgHvCvBgGHNHtNEHXyXt3pM4ejKYSPve5scBJ9DzU
 k4a5FljQhodTIR6CIvolu3kgKql7Ip3I6/FJBu/ycUPL6HRCFofF8o3aFhQqL1EnaBRvtpmaAZ
 n7c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 11:24:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M4BsS5MKtz1Rwnx
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:24:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660328668; x=1662920669; bh=mEcxvF4PsnkvmosCiuHJl4/pNrL0uzzasoD
        TrheGJ/k=; b=iP/EfqddkoWeEahQTsLpHPlzd+/jopWhRUQrhVcvSfdkGEZkjZv
        p8W5DE5SEr5Sc9CDw6F5JzwqeE1ZRgcTRkL5lmAgBf1ueU1BqD5YSIYIaVgHiy1g
        41QpId638ZpOgD25N9pyAssz+lbo0k6plOW9qcIwJ6poTGSqlx+icb6LqKP/KeMa
        MLgL8GL0wZ6SlidrjZP7jQOJBKZhozz7f1LdLeYN/QoXgOvjHnCygL/jsvX8lxiz
        OvSrFacww4a53apercLfEqTT1nSMa9erpw2CEqzsT+y1d/2HiTKmFX+GjxEMSi06
        w3autX2M8m9ypNuPBny8vcUkbQlEQdKaDDw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fabyOcYwwmsD for <linux-kernel@vger.kernel.org>;
        Fri, 12 Aug 2022 11:24:28 -0700 (PDT)
Received: from [10.225.89.57] (cnd1221sqt.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M4BsR2yDxz1RtVk;
        Fri, 12 Aug 2022 11:24:27 -0700 (PDT)
Message-ID: <ed444e22-5eeb-444d-5164-a67be2b55bd5@opensource.wdc.com>
Date:   Fri, 12 Aug 2022 11:24:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/6] libsas and drivers: NCQ error handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        yangxingui@huawei.com, chenxiang66@hisilicon.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
 <d2e27cb7-d90a-2f0a-1848-e1ec8faf7899@opensource.wdc.com>
 <437abe43-7ddd-6f49-9386-d8ed04c659bf@huawei.com>
 <15bfd5e0-7fcd-fdee-a546-7720b55eb108@opensource.wdc.com>
 <34bdd9a8-26bf-95b0-ed62-a6af5db05654@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <34bdd9a8-26bf-95b0-ed62-a6af5db05654@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/12 9:33, John Garry wrote:
> On 12/08/2022 16:39, Damien Le Moal wrote:
>>> For this specific test we don't seem to run a hardreset after the
>>> autopsy, but we do seem to be getting an NCQ error. That's interesting.
>>>
>>> We have noticed this scenario for hisi_sas NCQ error, whereby the
>>> autopsy decided a reset is not required or useful, such as a medium
>>> error. Anyway the pm8001 driver relies on the reset being run always for
>>> the NCQ error. So I am thinking of tweaking sas_ata_link_abort() as follows:
>>>
>>> void sas_ata_link_abort(struct domain_device *device)
>>> {
>>> 	struct ata_port *ap = device->sata_dev.ap;
>>> 	struct ata_link *link = &ap->link;
>>>
>>> 	link->eh_info.err_mask |= AC_ERR_DEV;
>>> +	link->eh_info.action |= ATA_EH_RESET;
>>> 	ata_link_abort(link);
>>> }
>>>
>>> This should force a reset.
>> This is an unaligned write to a sequential write required zone on SMR. So
>> definitely not worth a reset. Forcing hard resetting the link for such error is
>> an overkill. I think it is better to let ata_link_abort() -> ... -> scsi & ata
>> EH decide on the disposition.
> 
> Do you know if this triggered the pm8001 IO_XFER_ERROR_ABORTED_NCQ_MODE 
>   error?
> 
> If I do not set ATA_EH_RESET then I need to trust that libata will 
> always decide to do the reset for pm8001 IO_XFER_ERROR_ABORTED_NCQ_MODE 
> error. That is because it is in the reset that I send the pm8001 "abort 
> all" command - I could not find a better place for it.

Not sure what error it was. Will need to add a print of it to check. Easy to do.

> 
>>
>> Note that patch 3 did not apply cleanly to the current Linus tree. So a rebase
>> for the series is needed.
>>
> 
> That might be just git am, which always seems temperamental. The patches 
> still apply from cherry-pick'ing for me. Anyway, I'll send a new version 
> next week.

Yes, it was a "bad ancestor" thing. Direct patching worked just fine.

> 
> Thanks,
> John
> 


-- 
Damien Le Moal
Western Digital Research
