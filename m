Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF350D662
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbiDYAs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiDYAsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:48:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131019C06
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650847547; x=1682383547;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8rRSUwHJlA2kIstcDcpcJ1bPHlVbpCs28zXsb0a5fI0=;
  b=rQSYns7VAHODMZRyGoLvOcd9wfCQIayl7ubfy2GCU6GwdrZfyGH5Cy+k
   /DeHPBRHLEq4wXs9il6N7yEYCoKNCOvGZb+7dDwA5u1VwuYDa+yDxJiuu
   sH6zVDnHGJRG0wPaIFhnIVCJVfZgkNttg0RcCcqfG10vFXfGxKGywZ7o8
   hH58nSDsoixtBmH/lG9T3L/AqblYADzqzaEqRLpGgdjfYPSRxBI5ejMpq
   1YwP2QqqzEuHWKW8t4AS0q12YWQNkR3V6GSXuv0LJ8N0EiAa8qrWW4ear
   e/fH3ehxAIpI+51SHlQbgQEB0xO2rY1iZWGdXWQJ5zOm4Ey/SxSHcCcf6
   g==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="197554696"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 08:45:44 +0800
IronPort-SDR: 1HowIHdSwOWWib7g7EvBX4uYzx+dOe/OMu1Sdkrp3f5RQuBNVjiwBeEWcaNYihDBhWncr2gcIn
 W6Yv/ntEGnGwdZSb24OsDyvNCP5YO+z2uocWBXRxG+IGsBQhUSIrcGv75PtiFTdQeN8I4HfQWZ
 1Iy/1LrjWrqIlZ3xInt/Zfv3ESiviBMRKR4cP0BCLDWlWswyTqUiW+4q+9c7UlMQ5Nj3el/6Wj
 UoMJuu8CfIGiI/jEkuyWlP3H7yoSbukLkZ3iI7tVHB5pQ5wD1c9khoD72T9I1tiEIXIzHB1Wt0
 rKh37jZC+dyr9Xml9sYbwV3x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:16:40 -0700
IronPort-SDR: JOkk5v9ZRRHg5jMUEOUy2ipfYtQY0n6EpUhWUFQ10skII73zTbFXVI+sM2crR+2g+NdJwbjcUQ
 OAeWdyXkZFVSHKoCO4vJnyq7DK7fqbikiOf5gffaR9FwvnxtMm2iPDz+nQIBBzrrip5w/Vwv3f
 bjr56KrUhyB7HnBrS06MAHDfwW0gjp+jwIrH43eN9SPU7vAInmXLk463i+XEP+rgj+m532tgJV
 nn3irEhSB2tvJtUSkR7ONhLYndfwQSUv/7oKaI2H3dBWiZ1tCrtS2wn2HSrjfe5B7n7fjUXid0
 3CY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:45:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmmX747Sgz1SVp1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:45:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650847542; x=1653439543; bh=8rRSUwHJlA2kIstcDcpcJ1bPHlVbpCs28zX
        sb0a5fI0=; b=AyGdqVpz6+RyaJV7VMTXLETh91ct2e79hDFfjp5erPGIBkr6k/m
        ZUpB+b05sF3Ff3PWqV3PoryU7Cp5+jgRBfcuWh66DI6T/J39C+s0cwYbgcRcW0vG
        zq8njdEwl/ETQAXAC/DAdBH0/e1aG8Ljcwe0sPqfjgZdmslUIrXgx2bx7qWiPXs5
        rGLMGcR6xJcgteLIUgvhWsNVLFBSE4MFWr+Gpet71/p27DlSxWTN2sc440/rSes9
        Fq6CtsfLSP/ssryG9baoPVMuu0e7Q2j4cHZpBg9YA72Htw91hlGxTDE6/6x/zdhr
        QNGPNX4Nim1S4zvmOZPczEV9ZgwwqmP146g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bD8xfRDfmVi1 for <linux-kernel@vger.kernel.org>;
        Sun, 24 Apr 2022 17:45:42 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmmX60m1Zz1Rvlx;
        Sun, 24 Apr 2022 17:45:41 -0700 (PDT)
Message-ID: <b0d4418c-710a-9fa1-32b8-1b190b512252@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 09:45:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next] ata: palmld: fix return value check in
 palmld_pata_probe()
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     arnd@arndb.de, b.zolnierkie@samsung.com, robert.jarzmik@free.fr
References: <20220424093420.2129779-1-yangyingliang@huawei.com>
 <b0469180-f6b5-acf7-735e-5eaaff77b670@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b0469180-f6b5-acf7-735e-5eaaff77b670@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 09:44, Damien Le Moal wrote:
> On 4/24/22 18:34, Yang Yingliang wrote:
>> If devm_platform_ioremap_resource() fails, it never return
>> NULL pointer, replace the check with IS_ERR().
>>
>> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
> 
> This commit ID does not exist in Linus tree. Is this a commit in the ARM
> tree ? If yes, then Arnd, can you take this patch ?

Forgot:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  drivers/ata/pata_palmld.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
>> index 400e65190904..51caa2a427dd 100644
>> --- a/drivers/ata/pata_palmld.c
>> +++ b/drivers/ata/pata_palmld.c
>> @@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device *pdev)
>>  
>>  	/* remap drive's physical memory address */
>>  	mem = devm_platform_ioremap_resource(pdev, 0);
>> -	if (!mem)
>> -		return -ENOMEM;
>> +	if (IS_ERR(mem))
>> +		return PTR_ERR(mem);
>>  
>>  	/* request and activate power and reset GPIOs */
>>  	lda->power = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
> 
> 


-- 
Damien Le Moal
Western Digital Research
