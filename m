Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE33F595F88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiHPPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiHPPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:45:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DFD3ECDC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660664568; x=1692200568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4pLJV4ar6F2DZGfMkGTvI6mAYr0kU7DMXxSq+tx3CnI=;
  b=RNxZ44BjOGqrZ6joIz08tkrEniCmylJLOOpjnz6apaSirBhNW06MAi4z
   QSJjwRdDlqDtCiFH+A62IAlwQ5Mc+FEmne742xc/Aei4SC5o+/OsuD5su
   zGn5bFVEqrPu8b1FAbKqVeGEvRd2d8ZaA6XMUoEmHjgpk9FYHh1TH02gX
   chQArVtNfO9hva4RjIiCWSh6IGpeloXWZGNCvroC+0hS7BO2zfHOeQ1oy
   StYx2C9ij9wdelA1qk65fdAinrUOBitwAYOm2g87hsARQe7rvJGmhMBCp
   aZVO53noFm2z288pyudIJHKl1MWUFxLf5MujpjfWwIXP/TDEb7/xHawqZ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654531200"; 
   d="scan'208";a="207324725"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 23:42:45 +0800
IronPort-SDR: UNQeAfpjJ4UD74Y6kWy5Jb1i92Ah2FgP+v0PBBEAjnvhOJB2Ca/913sWbhH5MrtpyQi9C+xRMa
 DID4HTS9Vst1lgfPu6xvnHSgaGjnER/VT9+uRLq6bolz7w9vxd8i0bNWhgg4f5LHMGfiXVXHRH
 KHNBjYJ0SGUzrm9wOcOAlRGH/57FePD7eKRUd644n5fxZImjA1zi436Z27czU26HljGlOZzia2
 qCnxhM4eqP2LedviYjTuSQ/1D4iWKH/n8nWqadkigzlvIwFDgFClnxdahUwAHnV+bKsvtgRV6s
 MDDjueh44or9OzPno/V7c5Pj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2022 08:03:33 -0700
IronPort-SDR: RZNEZijJk1KkzvlF2BkPqIhYiWgoEZGnSKVInhlc6uPqnG/wR2YPTYqgp4jmokUnyWz8b2Mx/o
 R4+1/hJ1J6d3w1G7GKHEOc+Ali+NHfn2xZPAUJ5cb6ZwXyaST51vn+iHWe5QpwCChg6xfnK7d7
 1pe0EUBHWiMak0j8/Yp4nECQe5hr7hGoxLeopb7xY5iWnc6NQs8Vr/nFL5x+Kh9aJeeNWbflmz
 t7NGN3B58WaV2Ct8dhclBhVSJYGQaoQCD/VEKWDUDpHWG8VnZbD8MSTXK1Psgzjp5YpMIyo5yl
 cYI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2022 08:42:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M6b505pp2z1Rws0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:42:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660664563; x=1663256564; bh=4pLJV4ar6F2DZGfMkGTvI6mAYr0kU7DMXxS
        q+tx3CnI=; b=e0qjTEK1a/CGS/wzw8PO1PPgqa5Mh4ewGrb9xtlNIw/XtP6zjNb
        t4gQD91p3DRj1OF7hSAPR8ENxjL3nGvWhVqHV3j5cULreJvOxbSPo7+b7S4EEFuV
        9uMJ1mR1wUnNU0WJdMLvxzVY8hLkJB6bEWCBelCx5JPJSCyfmtiM69KUc1LisJjY
        6ZCvFZXvEBZyOOeKOgKqGNX9uCy096KNfrLGCZuhLGiSBc+TfBr6rxH/cy7BBrRe
        kr8+bH/VKtIjiXK8F2M6W6zo/c6QLxPJwSXWjZUo+YtJZBzfChhxcUPjjLtgoIHD
        bkCrXBWIu2AGeRtNv0lvxxmTDi440sArQZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eqQPiUxcnfjq for <linux-kernel@vger.kernel.org>;
        Tue, 16 Aug 2022 08:42:43 -0700 (PDT)
Received: from [10.111.64.29] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.64.29])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M6b4z2HJkz1RtVk;
        Tue, 16 Aug 2022 08:42:43 -0700 (PDT)
Message-ID: <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
Date:   Tue, 16 Aug 2022 08:42:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Oliver Sang <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ide@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/16 3:35, John Garry wrote:
> On 16/08/2022 07:57, Oliver Sang wrote:
>>>> For me, a complete kernel log may help.
>>> and since only 1HDD, the output of the following would be helpful:
>>>
>>> /sys/block/sda/queue/max_sectors_kb
>>> /sys/block/sda/queue/max_hw_sectors_kb
>>>
>>> And for 5.19, if possible.
>> for commit
>> 0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
>>
>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
>> 512
>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
>> 512
>>
>> for both commit
>> 4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
>> and v5.19
>>
>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
>> 1280
>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
>> 32767
>>
> 
> thanks, I appreciate this.
> 
>  From the dmesg, I see 2x SATA disks - I was under the impression that 
> the system only has 1x.
> 
> Anyway, both drives show LBA48, which means the large max hw sectors at 
> 32767KB:
> [   31.129629][ T1146] ata6.00: 1562824368 sectors, multi 1: LBA48 NCQ 
> (depth 32)
> 
> So this is what I suspected: we are capped from the default shost max 
> sectors (1024 sectors).
> 
> This seems like the simplest fix for you:
> 
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1382,7 +1382,8 @@ extern const struct attribute_group 
> *ata_common_sdev_groups[];
>         .proc_name              = drv_name,                     \
>         .slave_destroy          = ata_scsi_slave_destroy,       \
>         .bios_param             = ata_std_bios_param,           \
> -       .unlock_native_capacity = ata_scsi_unlock_native_capacity
> +       .unlock_native_capacity = ata_scsi_unlock_native_capacity,\
> +       .max_sectors = ATA_MAX_SECTORS_LBA48

This is crazy large (65535 x 512 B sectors) and never result in that being
exposed as the actual max_sectors_kb since other limits will apply first
(mapping size).

The regression may come not from commands becoming tiny, but from the fact that
after the patch, max_sectors_kb is too large, causing a lot of overhead with
qemu swiotlb mapping and slowing down IO processing.

Above, it can be seen that we ed up with max_sectors_kb being 1280, which is the
default for most scsi disks (including ATA drives). That is normal. But before
that, it was 512, which likely better fits qemu swiotlb and does not generate
overhead. So the above fix will not change anything I think...

> A concern is that other drivers which use libata may have similar 
> issues, as they use default in SCSI_DEFAULT_MAX_SECTORS for max_sectors:
> hisi_sas
> pm8001
> aic9xxx
> mvsas
> isci
> 
> So they may be needlessly hobbled for some SATA disks. However I have a 
> system with hisi_sas controller and attached LBA48 disk. I tested 
> performance for v5.19 vs 6.0 and it was about the same for fio rw=read @ 
> ~120K IOPS. I can test this further.
> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
