Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07C858ED9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiHJNwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiHJNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:52:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF776A492
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660139526; x=1691675526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8p/CQBS45j5tICeYzJJVMoA/fdD7DghNb+CoI4HMZYI=;
  b=riaX0/IKweVNro3c/aTIpbudDaA4BbVcwdmTW4soSSIz5+0xbJa7T5Z4
   oNf/TKLjGkrz3UzABoqlJIefA+FtoP4CHc3fCy+XPXATx+Q5KiST8ddih
   BzspLN1BOAakYDt+n43FVPjQH9vxc9vKtm88vGbEbDth0gPkGV/5lfn1X
   xLaQuFIkbDpxzC1vyD30bLqa6erGNgKMacDCGcpMgZq9ogeYeBBPjEca2
   uFvjqZyiMsKVGu8cTFJiQ009dF+oLs3VsLxeY93PpNl1vaZ85sRmkFXo1
   uK1noKi+sPmlU8jbv4Zv+IudsM6Tam3SKi+sGiU//Mz5yliaCLDX0uKCf
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="208346232"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2022 21:52:05 +0800
IronPort-SDR: Vo5iWK4tDonXcLgapTvLwVsoJoBfTLJYlzMvxoBuxIRsQyrFynM0e5k0n6zkZvR2NpR0lhk1Ef
 XnxFGW47tXLgv4pkaO1+8tF60bzkvaZIdVX7RLcdIk1ULa8TJrOcjyCpPnlMTotmqicv7Wx2cv
 VihlNQjTcoNL44vxByouhPMweqs86b08ggX/LdyPF5X1+DK9/RskxrCtvHMhWIhUmC9/JlWrgl
 f4QXaaKNxIdGZT1QoGvQdJ1bU5gjvRQQlH0tC4+4ryoNv87z7a2m8rP0Qko+DmMZP7p+xmEKsh
 Ix1pvooR57z7R5Ch8EyH/XSn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:13:01 -0700
IronPort-SDR: VVY7Siw6ODQm0WNXXkjr1/Fg6mYH/NMspSvT7vB3SkJZ8N5rqddTU9hiH8hUX7n6DGXoKzcDwO
 c1yqXN9iuHasyilmKQSO+93c4+f1oed11cfjqN76b2DGQp7PFeuD1muq4h5qXbmhi/hkrAVtHU
 A8zGgb7bWYdZD09rDHV4LztyNBRu8arS6RKNqzvSx2265Lv7Kyd8cBhf8rJOOD15wv0ByXIBw3
 CmbR5nSqaz2HxvBQ8Bf1winkk022Mudjhbal64lKcxHsL7+0wZ/gEHFUUD6U5mfejMEsGBilCA
 8jE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:52:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2rw50Hk2z1Rwnm
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:52:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660139524; x=1662731525; bh=8p/CQBS45j5tICeYzJJVMoA/fdD7DghNb+C
        oI4HMZYI=; b=otEE04L7O38+4u+ZpwLBrDlSZUcEYa5JrBnDLS41uaCHAl947nQ
        LorvLUhPNZGApSJ6qhJJfz2aiSpFyt/tcxeHaVN0STPnS/tLnXFkLWzO0BcJL9BH
        8SZPTq3ibepP1sDLOyz5X3Xo+Y/BNUlgCbqvCxI6IG0dTnCjQVnCELdEGILYbUrl
        qNLVBj9n8r8EzOAx3iWGJtZEtO+X+D0wEjgA+32RPRwZcUMrbsvmfZ6YnFfeGT8R
        o8iatbjcu3hbRb4OmtvI8s/Oa/OhU9TT4FVFHWKG/t84gohcVnRURowKaSYiYJ/M
        EbvAq7gTpor3m5xtt8MB5JKPnQAGihWTmsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KzJbKsreAu9S for <linux-kernel@vger.kernel.org>;
        Wed, 10 Aug 2022 06:52:04 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2rw367vnz1RtVk;
        Wed, 10 Aug 2022 06:52:03 -0700 (PDT)
Message-ID: <b3ce0a28-0f94-6d2a-3f88-998da8f870b4@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 06:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
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
 <16f03f81-a8c7-bacf-c74c-67231f7f7202@huawei.com>
 <ef84d2dd-84ea-e1c7-05ef-f0a082d4f7d0@opensource.wdc.com>
 <82dbf4d6-2d43-20ff-22a7-857f9f11a5ce@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <82dbf4d6-2d43-20ff-22a7-857f9f11a5ce@huawei.com>
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

On 2022/08/10 1:33, John Garry wrote:
> On 09/08/2022 15:57, Damien Le Moal wrote:
>>>> As far as I can see, this patch should not make a difference unless the
>>>> ATA shost driver is setting the max_sectors value unnecessarily low.
>>> For __ATA_BASE_SHT, we don't set max_sectors. As such, we default
>>> shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS (=1024) in
>>> scsi_host_alloc(). I assume no shost dma mapping limit applied.
>>>
>>> Then - for example - we could select dev->max_sectors =
>>> ATA_MAX_SECTORS_LBA48 (=65535) in ata_dev_configure().
>>>
>>> So with commit 0568e6122574 we would have final max sectors = 1024, as
>>> opposed to 65535 previously. I guess that the problem is something like
>>> this.
>>>
>>> If so, it seems that we would need to apply the shost dma mapping limit
>>> separately in ata_scsi_dev_config() and not use shost->max_sectors.
>> OK. Will have a look at that.
>>
> 
> We may need to introduce something like shost->max_hw_sectors, which is 
> set according to sht max sectors and dma mapping limits. That could be 
> also used in USB scsiglue slave_configure()
> 
> Or else set max_sectors value for __ATA_BASE_SHT, but I don't know a 
> sane value there considering ATA_MAX_SECTORS_LBA48 gives max_sectors of 
> 65535.
> 
> Damien, please let me know if you need help now. I am just waiting for 
> you to test to prove this theory about dev->max_sectors being capped. I 
> don't have an AHCI setup readily-available for testing - just SAS cards 
> or QEMU.

I am on it.

> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
