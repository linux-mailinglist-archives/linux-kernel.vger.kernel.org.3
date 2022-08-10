Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DCF58EDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiHJN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiHJN6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:58:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571166C756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660139880; x=1691675880;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ClWPfH+Jd93qt/z4FiCRJJBeEEPfi5NziKxB5M5sGPk=;
  b=NCm/9BqPNdVckCepXwac6fEuZAdbsmZDAUR3Vs/XJSzzI3nBJuQEGv00
   rS7gStmlKOYzhD8Uv8MkWGFMUGmRC/wCW6MnmQEzxEYLLOjL0WgKuXV9Q
   cKH+mgR5dkrm/PoYPYfHPZrGcsTwJkX0m8R5lqfHkaOkYFPeO+BTvAz7D
   i+nIDeBj3vvNAosEG7R1ZAyWl6K5kdH8f3wj/AKrGqxS1YclerAFiqElt
   F4Gat5QU7BsOQPrecLtF2QlyLH44c5b9rAPJm9xGAqu6519MRBJk+xo7n
   prvKcmg9KRLnz2Ex5DyODLBSeLIaOWgqRh/AL+cYtaQz1vPhXqE1SYO6G
   w==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="206843688"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2022 21:57:57 +0800
IronPort-SDR: /iKMhND9sYPUgzy06HH4V7AtQq/Ev7LQeS5gyxpUXrX9QFN1wRIppWC3UzW6xRPygJAPBilL1p
 UbWeqMdt92MC8OCU/DOFL2XKEkcWXNKhZvs7rvhttH9hodctdIGGLMBHxyo9uDPd6pM72nKAAo
 843odqY6wQRAGXzarWnWX2vA5eg23p+/XBXRY8LSx+vJjKNUpujY6XYhW/AKeZ/31gXPT3AKNd
 kZsOvqhmBCa98ysmxeaG60NHWmDWtVOU2QRqK8waD8L30zONrmcq0+/mcP4sCsxyOOH4B2hLOJ
 xRBYjx13k0LNkXMpShMk1Z1w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:18:53 -0700
IronPort-SDR: Di/cOSpedOtA05HAeag1i7AfoO2WvLUorSi7eosChl3lm8rUvk1KIfMwAIEpAk3RdEczsQL/Sr
 WZeZ+jVJXFzVtY+YrsjprqTXsP/t42TGuWjbt+6OgNVtFPwtr1WmrxsLb3g3v9q0aZ+fEyaKcZ
 VUhy2gYqFs0l4HesMnvsKI/Wy2T8KidbAqxdUDMBwE4mMc+28TUiO9Ho9ai6zkCwKsZXOlF4TX
 0KJYNrBgJG5qAFnZF9Fmr8PXSGuHY0EbDLFcR88VB6IdO5ybsY9qZUtHVATEMyytdFYdVFOu3d
 RJ0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:57:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2s2s3v2Vz1RwsB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:57:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660139876; x=1662731877; bh=ClWPfH+Jd93qt/z4FiCRJJBeEEPfi5NziKx
        B5M5sGPk=; b=ZV+zKlNpoD39suCWpwEcYuB/3MZlb0ERjRhMZuhlayBRa5A51aa
        bTMhqp5RXQe97OilXZA4z4IJkCpXb8SEdl36emCG+zT1gsIBQfetv90QA/oPH85A
        /OWZahkSW10yOkgvtI1i3gWieZG5MEo2rwqM71m0EeC52fPDjSS92bwHxuGO7qoT
        QZzlEdwVTuYt2dAcaDNlWhVOnG+Iy01+FddWXvhfVbXkkIJOUzhgT26hBFhVPWkG
        D1/40D0TsrO2a4tnCJhQzAaRI1PmM6iLSu3rBqLu6KMhUTarD2cru6vpxPOHtInM
        JqB5NyyTOPzpFMOiABuvx2q+1oSgP0oT1LA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0nx1dqXxVgux for <linux-kernel@vger.kernel.org>;
        Wed, 10 Aug 2022 06:57:56 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2s2r0RJJz1RtVk;
        Wed, 10 Aug 2022 06:57:55 -0700 (PDT)
Message-ID: <b082ed3f-e2de-450f-acc6-9508d7689290@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 06:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        John Garry <john.garry@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <c4b45c0e06af473abe17e3471e1bb948@AcuMS.aculab.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c4b45c0e06af473abe17e3471e1bb948@AcuMS.aculab.com>
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

On 2022/08/09 8:16, David Laight wrote:
> ...
>>>> Without knowing what the device adapter is, hard to say where the problem is. I
>>>> suspect that with the patch applied, we may be ending up with a small default
>>>> max_sectors value, causing overhead due to more commands than necessary.
>>>>
>>>> Will check what I see with my test rig.
>>>
>>> As far as I can see, this patch should not make a difference unless the
>>> ATA shost driver is setting the max_sectors value unnecessarily low.
>>
>> That is my hunch too, hence my question about which host driver is being used
>> for this test... That is not apparent from the problem report.
> 
> No one's fallen over the old problem and managed to limit
> the number of sectors in a read to the number of sectors
> in (IIRC) a 'multi sector' read that uses a single DMA burst?
> 
> Was always a good way of killing disk performance.
> 
> IIRC the maximum number of sectors for an ATA disk transfer is 255.

That is for super old pata/ide devices. Modern SATA/AHCI disks can do a lot more
than that with NCQ/DMA. The default max_sectors_kb for AHCI connected devices is
1280 KB = 2560 sectors, max_segments = 168 and max_segment_size = 65536 B, which
gives a reliable command size of at least 168 * 4096 = 688128 B (1344 sectors)
with 4KB page size architectures.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)


-- 
Damien Le Moal
Western Digital Research
