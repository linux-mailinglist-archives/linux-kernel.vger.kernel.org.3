Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E970949E1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiA0L5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:57:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63514 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiA0L4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643284606; x=1674820606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0K9fD7qQnc4VGb8wlCEDk+u6ux8RT3G+/u+kJA7nYIc=;
  b=Fmyclkxa8xbI7bEwV6/zXqES990h1mIvuUANFnmE6PoS1kZJEbECFD0N
   q0y6VfCdZdKwEtrlqNMRJ0FeoWIDUn11KgoUCvBSdgnbMj0oriktB+z35
   HSJAWSy1HWAzo0/9T8BveZ2owH22n80CjU7HpWffOyejrXbcqcXzSn9G+
   xjXsoGiVDI1zQM6nv6M2ONSimsHC7+CmbxYlTQrMKvz410O1BUHsyYMVF
   BrsKPuv5Bj3jTfrek3NYGumQ8b7bpHczXGyUTmnhsZqTr0Jyq9HrYIPC3
   iEjjmuYy1i5QVcoGno7untqkGcFrjKHYy9t7Ej9hvrjiTivJXDZ9coVAm
   A==;
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="190470630"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2022 19:56:45 +0800
IronPort-SDR: 7avWreOG3y7/pk4Q29mBTvqpsRmiA77JZVTzv01f2YIsGuN0zj6ZoL4v/OyLUnT+SvplHGAuUP
 WmnVsDMyzWuWb77GKJI5RO2ose4IakH5xchdTrYszQibLMzQ3kc/KxSnWqe2nmE9qpJLOAvIK7
 ksxT135l51T/60fQrBs9jSu27EIw6UYkvD9q7ePHPi17AvEYmLXJh9pYcbvCUTqhLPNQeU3OAi
 Se2qvdZCgaa+JL2a6pxAkg0PQQijcqsH0KtUZPLKSNWswYpK+adD9frgIli/F0ag+uvcInfB8k
 jswvTqoaOUGdYEy17f28y/dG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:30:03 -0800
IronPort-SDR: D2Ki+bYn2JaGaXQkSwVsOqArw4tyGN0jDs/BEALeRLMazYDI8zXT4L9mnt54W7fhDdxj9rs2pN
 s9FpOgPTfatfRCgNjNk0GjHQ2f2lBbYkjPddvIa03gFDLWaHE/A7iOFovRKeJTF5PcMJ9QmDEW
 +dk0iKU8qpDVL6lq+rXPKZrzPyDc1oOvTxrCYnho5ZY2CaTPgVwR8LJL7mV2gwg9r2Oq1UYknI
 nBr5S+VZhNUTRpdkCDLmnS+lFUFmRq04Sv7psk0xnfiIavvFMoMOc91OvEPk19XyV+xRnSyjzC
 4iE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:56:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jkzb13NXLz1SVp4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:56:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643284604; x=1645876605; bh=0K9fD7qQnc4VGb8wlCEDk+u6ux8RT3G+/u+
        kJA7nYIc=; b=MRYgURMtdAT0Iz8nKjiy7QOAwMLs4HrHbiQGE0XE0sM73CBhmgE
        e6fft7fy0LSjIzbdpApMsrodhzPJ03U2eEGEbju/cji66AN++/Z7KmXUjiONEO4B
        4yur1omjSNK9E/d0WeCvOCD/AcI6fv4eBsrxZ5zKWlLnHrp38YbsyUkB9HIO7IiT
        tw1mpkzHP5voNQYOV2cn2i4nbwRHsaevxF8qRKuIWNNh6LDgIO91KugF9y8NFvQ+
        mHDA7zNzVqpFTIN1IxjirNcISr20S6lxGBs2/gdwa1VKwTOs7BO1zedMXAcy3huf
        xcpI3OWJ8GphEa74Ydb1pUOYoLCWcv2SNVw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ep90G1DIK9Gi for <linux-kernel@vger.kernel.org>;
        Thu, 27 Jan 2022 03:56:44 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JkzZy2Swgz1RvlN;
        Thu, 27 Jan 2022 03:56:42 -0800 (PST)
Message-ID: <b49f8c20-355b-42f4-1910-4cb7b8e1b7fb@opensource.wdc.com>
Date:   Thu, 27 Jan 2022 20:56:10 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 19:17, John Garry wrote:
> On 27/01/2022 06:37, Damien Le Moal wrote:
> 
> Hi Damien,
> 
>> I did some light testing of this series (boot + some fio runs) and
>> everything looks good using my "ATTO Technology, Inc. ExpressSAS 12Gb/s
>> SAS/SATA HBA (rev 06)" HBA (x86_64 host).
> 
> Yeah, unfortunately these steps prob won't exercise much of the code 
> changes here since I figure error handling would not kick in.

I have SMR drives on that adapter, and generating errors with these is
*really* easy :)
ZBC test suite forces errors to check ASC/ASCQ so it will be a good test.

> 
> However using this same adapter type on my arm64 system has error 
> handling kick in almost straight away - and the handling looks sane. A 
> silver lining, I suppose ..
> 
>>
>> Of note is that "make W=1 M=drivers/scsi" complains with:
>>
>> drivers/scsi/pm8001/pm80xx_hwi.c:3938: warning: Function parameter or
>> member 'circularQ' not described in 'process_one_iomb'
> 
> That's per-existing. I'll send a patch for that now along with another 
> fix I found for that driver. ....
> 
>>
>> And sparse/make C=1 complains about:
>>
>> drivers/scsi/libsas/sas_port.c:77:13: warning: context imbalance in
>> 'sas_form_port' - different lock contexts for basic block
> 
> I think it's talking about the port->phy_list_lock usage - it prob 
> doesn't like segments where we fall out a loop with the lock held (which 
> was grabbed in the loop). Anyway it looks ok. Maybe we can improve this.
> 
>>
>> But I have not checked if it is something that your series touch.
>>
>> And there is a ton of complaints about __le32 use in the pm80xx code...
>> I can try to have a look at these if you want, on top of your series.
> 
> I really need to get make C=1 working for me - it segfaults in any env I 
> have :(

Weird... All I did was install sparse (dnf install) and it works for me.
Running Fedora.

I will send patches for these.

> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
