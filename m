Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A35AF808
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIFWfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIFWfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:35:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB483BD2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662503709; x=1694039709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1hG10Gj+FolNTclFGb1Q/V1q7pYCjSYlKl0N3KHDLfM=;
  b=L1lOVr0qJyUmI+YA/ndZEgyVZUo2gOKdAGL65Vy26UvWbfEfCCW8nbCJ
   25Z+7NdMzKFja+PgAzkqQVzVdKVghLbUPFQfSfa/v8r2oeu9R1xeLZHD+
   1avX6CEqw9AleqymDNENajA4OXYmHSQhR0nE8EAdTqoXrEolzZwkrAIr2
   6cTWTunEFrun0wKOUEASdPgPKiJM1Uhg6wvCb1IkZm/67sn/9ECw7Ea9Z
   Gd4dT4PZqbhP7/FzAQrOMVI1STSFf6kT0mYI5wJsyMFbNyEFIME8QsoxR
   fykqqnEdjFUKou2g9uArJGSJFcDA7VK0+sc1eFc3Et69G3kcperLHwPBZ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654531200"; 
   d="scan'208";a="211150867"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2022 06:35:08 +0800
IronPort-SDR: BSB8931Dynw1fJT6F0SGbPFczRGcFhCPT9bE4UrF3khpt5Y/AJrM+PY1eELfiqH+4eHx+7TFwJ
 4tjK5T+Sz55yoe4J0X2M0pJ7l6Gcy5WGAIQ2OpySwQLxJPbO2W+FWZLFPCc3FENWWlf+R5sIsy
 9XxMDhWYSWlQTEaqf4O2KbO/foHsMo9XyXpDugpVgaBSVjSXkizfUDu829YtENLjrxCWkUgI6o
 5cLjHGmD4aG3rEpYBkqHFt6koFVNnVPqHxLfjchxGGlmFS9rLRiXIZ+TbnbxQVErrUc9PHk/fC
 esrcNwpYJKCwYiIjoOmofAXG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2022 14:55:30 -0700
IronPort-SDR: RQvsjzU8KoouFbBLaqDWQUcnwgPbpOFuPDq+9BP+7I+/rcdDRMYmERXFEgcmZAvoXSx4lgHMp6
 awsrG2gtDp/FlHyETbrdQvJTwmp+vBfj/OGePO0x196HLw7J96vBRdeoR0Y/uyU6nx44Ah484h
 ms5Y15IwGnxXtYAKPnv+IIiGqNB+930HbaG1n6lgHmXDrRsbSLLyTAE9/wRwf4KPkOn0l2qkQr
 7ixhS5HnLUeAVOAVtA0Y5vUEgrgci59CWKhdwo40EyOIuw6FLz0z1Cr6lQBQ8a+WimvxZdhP1Q
 NWM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2022 15:35:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MMgF82tnVz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:35:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662503707; x=1665095708; bh=1hG10Gj+FolNTclFGb1Q/V1q7pYCjSYlKl0
        N3KHDLfM=; b=SK7/C38l1h+3nsVCQlwjum2y9DMHR7UrmRsyw8q/w/9qNo27TX3
        sTpTssMfpIX99y7cz7zum5yC8Xk1umVfurzhGd/bMCv765GOZlHmOUzmizvw/ghs
        wQktCFdzMNHXlNugF6kUwSq56raNj5aMt2bzw1M2dAeSkG1eegux5iRvMvAcXqzY
        g15/gtPyXG09JzmEGonOev26FPSAyNDbOKNQo86EtQFDR5T74ZgHNCTGqcn5n3BP
        YfiXsMiOyabjc4AFrYWBN8EBCEKckCoDQ9FY21Cdyzlg0cV4NJipTRNrWNyyU0Pm
        WSnLg1CRpFnhLAWHTgyd2VBKOZ4H+GCHlTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BDFkviqHCD_u for <linux-kernel@vger.kernel.org>;
        Tue,  6 Sep 2022 15:35:07 -0700 (PDT)
Received: from [10.225.163.64] (unknown [10.225.163.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MMgF601rnz1RvLy;
        Tue,  6 Sep 2022 15:35:05 -0700 (PDT)
Message-ID: <8154fb0a-4cda-a4bc-29ef-8435a3edb264@opensource.wdc.com>
Date:   Wed, 7 Sep 2022 07:35:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] nvmet: fix mar and mor off-by-one errors
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
 <d3b4ef13-62fc-1bf4-3a5d-3cc740df82b8@nvidia.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d3b4ef13-62fc-1bf4-3a5d-3cc740df82b8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 06:53, Chaitanya Kulkarni wrote:
> On 9/6/22 00:39, Dennis Maisenbacher wrote:
>> From: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
>>
>> Maximum Active Resources (MAR) and Maximum Open Resources (MOR) are 0's
>> based vales where a value of 0xffffffff indicates that there is no limit.
>>
>> Decrement the values that are returned by bdev_max_open_zones and
>> bdev_max_active_zones as the block layer helpers are not 0's based.
>> A 0 returned by the block layer helpers indicates no limit, thus convert
>> it to 0xffffffff (U32_MAX).
>>
>> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
>> Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
>> Signed-off-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
>> ---
>> Changes in v2:
>>      - Add explicit check if block layer helpers return a 0 and if so
>>      convert it to U32_MAX.
>>      - Add Fixes tag.
>>
>>   drivers/nvme/target/zns.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
>> index c7ef69f29fe4..eae81f939067 100644
>> --- a/drivers/nvme/target/zns.c
>> +++ b/drivers/nvme/target/zns.c
>> @@ -100,6 +100,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>   	struct nvme_id_ns_zns *id_zns;
>>   	u64 zsze;
>>   	u16 status;
>> +	u32 mar, mor;
> 
> consider :-
>   +	u32 mar, mor;
>     	u64 zsze;
>     	u16 status;
> 
>>   
>>   	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>>   		req->error_loc = offsetof(struct nvme_identify, nsid);
>> @@ -130,8 +131,20 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>   	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
>>   					req->ns->blksize_shift;
>>   	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
>> -	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
>> -	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
>> +
>> +	mor = bdev_max_open_zones(req->ns->bdev);
>> +	if (!mor)
>> +		mor = U32_MAX;
>> +	else
>> +		--mor;
>> +	id_zns->mor = cpu_to_le32(mor);
>> +
>> +	mar = bdev_max_active_zones(req->ns->bdev);
>> +	if (!mar)
>> +		mar = U32_MAX;
>> +	else
>> +		--mar;
>> +	id_zns->mar = cpu_to_le32(mar);
>>   
> 
> above 14 lines of code can be simplified as in 4-5 lines :-

Simplified ? It is much harder to read in my opinion...

> 
> mor = bdev_max_open_zones(req->ns->bdev);
> id->zns->mor = cpu_tp_le32(mor ? mor - 1 : U32_MAX);
> 
> mar = bdev_max_active_zones(req->ns->bdev);
> id->zns->mar = cpu_tp_le32(mar ? mar - 1 : U32_MAX);
> 
>>   done:
>>   	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
> 
> 
> either way,
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 

-- 
Damien Le Moal
Western Digital Research

