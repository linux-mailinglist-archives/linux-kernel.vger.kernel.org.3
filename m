Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2D591575
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiHLS12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLS10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:27:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF2B2DB5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660328844; x=1691864844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J8PCRcRxT28IiRu+oG8WalqgKIw6ylYNh1g9F5tucFE=;
  b=KTDet4x/9qQSAyiF6F5Zj4kEU+edid8RGsSZUJcGv/2oyX7Oc0t/ZB48
   MOrx0SCdrVAiYxBZVG1mE185nHLZFpkL4qa+MWmUfBzMLK7Kxumf7oDz6
   OILu8pBRhNVYzv4zGcF1p+6je3jYWMz7Booxg62qFeyDKtg2nImTuJGMO
   rjQCJx9P2BgDNdYqDZv+LUsOKgYWGtAPRVIwt409W5vbGUdl0aLvVZgCi
   6DojK6cLGdGqoITPliTOUiVPkKL60nHOOdTAox29OkCpUCLfApqb1W3h0
   AAvfDBYr2NG7GLt3l8RJLf+JNLCWvU4J0muLTyHJtQrFkUJN9xP+VINEJ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654531200"; 
   d="scan'208";a="207055465"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2022 02:27:24 +0800
IronPort-SDR: 2dpmKh8UlJr3ogplGbqOtbRNQBJI79DOPSseS6gIBhHL5RHEjqPjrPsmJobUBj2bUk9Ef17NmA
 CaohUn/46udeoLdFnfOjrCs+Ptm08t4xHstWDc8Mwc8TE0/q4kLU0lcfT48ur7MHywV8sN5MQQ
 7+wckzBPZTGFseHU/etOJ9Ez2zebo9MwIb1bq1ncPTdGd/muJt/eZy1zNS4j2/xfo/I3gm5u/Z
 sLSHxNc3RUVQ77q+0PyyUH5fn/ilYtOgOixuIcZHOd/4Md7WG7fJ9rqalYfrU7zJ7j4Z9Oy4tW
 +GIremAnDhiYG2PLmkphWwYl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 10:42:56 -0700
IronPort-SDR: z0BQscGvmMBm1JTRCIfbL/KjpGXjYjZwBvvTHas67dbS7SnpMuiKIHh7F6LipD5VeCWKRnSuPe
 uSmIrrrHYkHxBUmE10ZJ4BSbuW5sONQiYIIrayiHAZtcK/jMl4EcELaUX5q3m37kMTqTiU0crg
 UduzETdkKKwPOKMgTLHxkNyasDoCSgU6mRhBkaYFEk3osrFgEV6enf0DfYdNJyg9AFtGzP0AvK
 n6z1LfSvW7SsWFXjJ+pJwRlovAMYEp8PtIEMDfTgRk5NvMrky/tjoJohEF+6NDzJY0Go+/YzSq
 Rj4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 11:27:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M4Bwq50Dyz1Rwqy
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:27:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660328842; x=1662920843; bh=J8PCRcRxT28IiRu+oG8WalqgKIw6ylYNh1g
        9F5tucFE=; b=qOjZ2eJigFW0bMEdf4pTu7XkilFMPaqV8LU/rsqiMzEgNo3MD8p
        LJ+T/7TijflwtiaYE0Q9JqQ/07i9X3G4HfNUvtxrKFpyzh2N+CwjiYe0tCBSAARK
        v1DhM78Ix7hFJAJF3R0hdJkCyHo8LSzmIAEjTjy4WDBkvrVR5eRHYRrqodx0Qe4Q
        UEiNag8pfV2UFyNDwB0cqcMVo/Wg9KgOes7yxK7mE6U7g09iRl7N2wXmChO+7CZj
        pL7s64hInkI6XqVt2sgeGywtw1N1fbuMG/bfL1YDSkSFGN3DN5QP8vo+JzVwyjq7
        QH32SYunbwB2VONkgLgnS48VEHs7tiLQGPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6QH7zQnVM9cp for <linux-kernel@vger.kernel.org>;
        Fri, 12 Aug 2022 11:27:22 -0700 (PDT)
Received: from [10.225.89.57] (cnd1221sqt.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M4Bwn4CJGz1RtVk;
        Fri, 12 Aug 2022 11:27:21 -0700 (PDT)
Message-ID: <840a5f98-a53c-ce08-2833-f41d8c9a015b@opensource.wdc.com>
Date:   Fri, 12 Aug 2022 11:27:20 -0700
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
 <4642848c-a386-d6a0-6255-8b16800e0548@opensource.wdc.com>
 <fd2b1dbe-8482-cb89-2568-4909db1239b0@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fd2b1dbe-8482-cb89-2568-4909db1239b0@huawei.com>
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

On 2022/08/12 10:17, John Garry wrote:
> On 12/08/2022 16:41, Damien Le Moal wrote:
>>>> we noticed the commit is already in mainline now, and in our tests, there is
>>>> still similar regression and also on other platforms.
>>>> could you guide us how to check "which host driver is being used for this
>>>> test"? hope to supply some useful information.
>>>>
>>> For me, a complete kernel log may help.
>> I had a look yesterday with my test rig. I did not see any difference in the
>> default max_sectors_kb values for various drives between 5.18 and 5.19 (current
>> linus tree). The test machine has 2 AHCI adapters: Intel and Marvell. Both use
>> the regular AHCI driver. I have another rig with different ATA adapters but it
>> is powered down and I am traveling... So cannot test that right now.
>>
> 
> FWIW, on QEMU I get a difference for IDE disk for ata_piix host.
> 
> Interestingly ata dev max_sectors kb also gets capped from 32MB (LBA48) 
> -> 256KB due to swiotlb max mapping size. (It would be capped by shost 
> default max sectors 512KB without that swiotlb limit). I assume capping 
> due to swiotlb limit is not occuring on Oliver's machine.

Yes, I was suspecting that we may be seeing a difference for anything that is
not AHCI, e.g. with other drivers.

But that seems to be the correct thing to do, no ? How was this working before
without applying the swiotlb limit ?

> 
> thanks,
> John
> 
> [    1.497233] ata7: found unknown device (class 0)
> [    1.498341] ata7.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
> [    1.499030] ata7.00: 209716 sectors, multi 16: LBA48
> [    1.623795] ata2: SATA link down (SStatus 0 SControl 300)
> [    1.624633] ata1: SATA link down (SStatus 0 SControl 300)
> [    1.633395] ata6: SATA link down (SStatus 0 SControl 300)
> [    1.634200] ata5: SATA link down (SStatus 0 SControl 300)
> [    1.635094] ata4: SATA link down (SStatus 0 SControl 300)
> [    1.635887] ata3: SATA link down (SStatus 0 SControl 300)
> [    1.636748] scsi 6:0:0:0: Direct-Access     ATA      QEMU HARDDISK 
>   2.5+ PQ: 0 ANSI: 5
> [    1.641298] sd 6:0:0:0: [sda] 209716 512-byte logical blocks: (107 
> MB/102 MiB)
> [    1.642188] sd 6:0:0:0: [sda] Write Protect is off
> [    1.642770] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.642783] sd 6:0:0:0: [sda] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [    1.644149] sd 6:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> [    1.645142] sd 6:0:0:0: Attached scsi generic sg0 type 0
> [    1.655145] sd 6:0:0:0: [sda] Attached SCSI disk


-- 
Damien Le Moal
Western Digital Research
