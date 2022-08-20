Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514559AF0C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbiHTQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 12:36:48 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E6DFE
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661013407; x=1692549407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nvlj510pwDSr2D9r08GYwC0oOLAPDKEbOI+Rme7ojmo=;
  b=QwrvOsUq7uo4/o4ZgJhGD3vYNj4tCi5Or0eXpQHY4TagXIAuVprGmSQB
   af2iFS9PS8j86CxjUrJP70AC19iW2bY+/2J743CZNM2z9ZxxLYuX4Am6k
   1N6kLj0XHHpYyPvMYHbWYuJNGu64fcJBAeGbSaB01dwhpoU5pvNcXMjuY
   /PNfZxtZzs4vkzgjyD5IPocvFFp6kV5BUx+HmuEa5jDxGnXyvrKoIq/uZ
   HXE/kzb6b9YZ0/yBLSAulKiUHvLje5i9y5LkRPFI8tPUeaqMh3GGOBwmS
   9qMIFXdo5tmk8Ro0KKALM0c4YQ0ZFBTLiI9RxVzhXDgR8eMtXMSqlbgfg
   w==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654531200"; 
   d="scan'208";a="209733387"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2022 00:36:47 +0800
IronPort-SDR: ZEd+sO1nY0izNFE+I1GIaHMIw5BWFnYAFns/3IPJzN2R6VNhtZVxYSEVicx/9higxxXdTldmho
 kuf4w9yw0NWp2n7D6bqHbqUL/PEGRrlTafRb3irQvAj2sMlguTeejW7oLAmxzJQaR9R9+6/lNy
 y3Oe7fiCm3ZB//WtBJOVNdwfWRswvmVvMbs3O/rfbijjnTyC1eTDP4M4xQS41iUm9LoQHrk+PA
 Pws3HHkWtIivdiZgAzRNapEpz6gIPht7nEQhSI6zTExJlkKfJ2JcpJq+h0Hw9/y8IPYhSvZaDP
 ZkhYhinOKQ7vJB8QMEFle5om
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2022 08:52:10 -0700
IronPort-SDR: pt/LLsHka0IwGQtL1C+/AREPQD011icEwc9B/oG1FHWSQNGBJMIe+bhfgOi6dqZ48zVe7kqH90
 6H+XPD0XwpmhV7zZFXJGNljMyCiLffdw5H/cT1w6ne+/lY+l11Gakp35fGWJ0iCWaqUo6iBeeM
 d7ohz6Vr2tFDkocL+hN0hYXlKGwoJ9sOuBXYJWJx9dMU02MTmje+4r4azVeEUnPOiHo/HIux7k
 9soyUD4bWuV5NWi8tOgKbjm6OL3AQJwBUn+mQ0cFAIaH++EEOzq1sx/RcoyA28mgrYLoC3xQz2
 zPU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2022 09:36:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M945W1cNnz1Rwnm
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 09:36:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661013406; x=1663605407; bh=nvlj510pwDSr2D9r08GYwC0oOLAPDKEbOI+
        Rme7ojmo=; b=frvmEaj9ZiicYG44GqFxXEYPdYodlwaZvO6Dd4u9xOpwdRLfVfc
        TRnnJIF/8eOyf6mNcBYCZy7A3GWe9/AxOak8/5P0wTXkekwobZ1UCGZAQbR7jRrZ
        d0XuuYHGwDQl1IodFS9qU+X6HC7HaeeGlRt9ltINAa8TuwAMAhmXBk3oRe6Txd2D
        gH5c5OlAuLvXgq0fWxbXRREYnz4EzASMUkQys4Q5tEpS55BDR0BRk261knd36i3B
        oQf/+woNXgIplBa7nA6u3HQ/1iyGgacu9UehNZH4GxBnI/IZnItUrJugo8BQ1An5
        czGSkBSpuQczFs3CgZAcDegk9G4rtdeWuHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZUCUdVrorGs9 for <linux-kernel@vger.kernel.org>;
        Sat, 20 Aug 2022 09:36:46 -0700 (PDT)
Received: from [10.225.89.57] (74r92j3.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M945T2QDBz1RtVk;
        Sat, 20 Aug 2022 09:36:45 -0700 (PDT)
Message-ID: <05b55329-6e55-c3ff-0c41-5254a5625473@opensource.wdc.com>
Date:   Sat, 20 Aug 2022 09:36:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>,
        John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ide@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
 <YvzyZJUblfqN6Xj3@xsang-OptiPlex-9020>
 <743867a6-b266-58e4-a8a6-542757916f0a@huawei.com>
 <Yv2euLFLjl8bEaeI@xsang-OptiPlex-9020>
 <d1b1d434-059d-4d76-5fc6-092ab9ba6e16@huawei.com>
 <Yv8sg3J8PLD56osY@xsang-OptiPlex-9020>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yv8sg3J8PLD56osY@xsang-OptiPlex-9020>
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

On 2022/08/18 23:24, Oliver Sang wrote:
> On Thu, Aug 18, 2022 at 10:28:30AM +0100, John Garry wrote:
>> On 18/08/2022 03:06, Oliver Sang wrote:
>>
>> Hi Oliver,
>>
>>>>> did I do the right thing?
>>>> Sorry but I was not really interested in 4cbfca5f77 and I see where that
>>>> build error is coming, but don't be concerned with it. However, for
>>>> avoidance of doubt, if you have results for vanilla v6.0-rc1 then that would
>>>> be appreciated.
>>> for v6.0-rc1, it's still 512/512
>>>
>>>> I will also send a separate patch for testing if you don't mind.
>>> sure! we are very glad that we could help.
>>
>> As you probably saw, I sent "[RFT PATCH] ata: libata: Set __ATA_BASE_SHT
>> max_sectors" for testing on top of v6.0-rc1, and I hope that then we can get
>> same performance as v5.19
> 
> yeah, our test confirmed your expectation:
> 
> stress-ng.copy-file.ops_per_sec
> v5.19                 - 26.85
> v6.0-rc1              - 23.03
> v6.0-rc1 + your patch - 26.94

Thanks for testing Oliver. I pushed the fix and sent it out as an rc2 fix.

> 
>>
>> Thanks,
>> John


-- 
Damien Le Moal
Western Digital Research
