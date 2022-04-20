Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5C507F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359095AbiDTDJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbiDTDJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:09:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF94B6F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650424025; x=1681960025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pbeuy2xk8xRDACa3QwpaXLJV93qnP5SDMnbWZXjqneU=;
  b=rSYWufdE6MPLAtJzs3eKClzgKM9G23NAq385UBKFE4tMoZeLafmyFDw6
   y+YW0plhFKKJskjEnl6zIGJFmFvfSy0FHUXnm7Ne10m/VJa9FM/ZwEHoa
   595L/PzRGNY9QAI0d0FaQEZL3CSIjOVUUS/cRmjoggS7M8lsgMbbA1W3W
   wVvFm2PNXnkCwGvDvPiwUVbRe/Yz8tsVKiBaWhaBXHlHdyfcAOchJYDiH
   MIzTarD4gToOobWrM9a4B2jwJhJ378mxrygjSRizHzZarLnpTwrYQC0+m
   33e2B61GdJIdT5/KCeFR4Mz5I+DdZ/9zaoj4cPBPiO7KaXBMmPk8AMQD2
   g==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="310293627"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 11:04:18 +0800
IronPort-SDR: YIiMY4QrNvIrtgfr6uMB9jTjslaRKt9PEUhQXeb4Mt7U2Q7x8/O6yDmZYvPDaBTZZdgJWVmoZn
 a5tJiXeGOXUA0uDo2B9rzEKgxU1ekr1ADCdLg/YiUiL/tJVmm2QD3XOl+bavlFtLavsVV21Ytu
 AmpF6aY9G+sZj+fYD0AZPZphc+qFv5qA4Z8niLbrYLhw5qGApJzYuO9L2rMaWuxD6gE+Khy1P1
 7oDt+kn6iGDOrzitRQUvxKaTt/2XPn5MxRp/+Zzwl0wC1e2bELmISGYASMWzRfRodHeqQCzZ3v
 k+P/9JwzkBqNq3OkuT6WLCgI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:34:36 -0700
IronPort-SDR: iuST80qjmHt7+TGTsSSPNB5RxdhUfQ6+KAuLfWmx44hTtCYQajdSpK14T5pkrt2LosCX70sX5W
 4nvH7QsltLyIjd2jKbDFVNYTJcP2K2A+NKmdNWZR5piJKwerwKXnPLUpnAr+Y+4wNhAoTQFvsL
 LkZso4O6e0UK8KQ7mGGgR3osIUrJIwsnIZXr3Qw/ML4L4pGH6VvgpQW8aOah92MwOKszVPFe4w
 k97tB7ygXLv0pu9U2zC1lAgoWjJvOoTfUIX7MzD8sBQ4NJCe3/LJT5qmbeyvYyOYdEDvK7VQIl
 RlA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 20:04:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlrK5sdPz1SHwl
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:04:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650423857; x=1653015858; bh=Pbeuy2xk8xRDACa3QwpaXLJV93qnP5SDMnb
        WZXjqneU=; b=a21im3aPH9e4PbHCdxBP5DgI4S9oyG1UA7r/UBmW00mI3E3GgGE
        ZYzDOJF8kspG/BhnQruiDojVLrcbFy9fjhrXA300k2a2H2DUB/VcDrv/q9Bu09Jx
        BPGUpO7gdy5SZ6cm0qTfb3+symUWlXoKJW9WIAqngRp4EknOkTmXuAv9S3M7/saM
        2FDr3z2TfBUnW3B1nDO5Fewl8nl9lcm4Q1rTlG78wjdDq1lSFj9gopW0Afa8SHyD
        AtHXxfcjF0IZUpU+BFwZb8gywlqFR4Bh951YBZFWo2tftvUnw/doazowtJrcPW/9
        WaaEk1ndrkL45cpeG5PNdfV7+itpNESJcsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mF7hxWDNXu2g for <linux-kernel@vger.kernel.org>;
        Tue, 19 Apr 2022 20:04:17 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlrJ39j2z1Rvlx;
        Tue, 19 Apr 2022 20:04:16 -0700 (PDT)
Message-ID: <e7bd823c-c387-00e7-3060-97f224df6da4@opensource.wdc.com>
Date:   Wed, 20 Apr 2022 12:04:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [BUG] ata: pata_marvell: Warning when probing the module
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
 <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com>
 <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
 <3045fde1-2d5b-e731-ef18-6cf3f0987259@opensource.wdc.com>
 <CAMhUBjnG75XANF1E5KUyigKSmhxzvJytfapieC6_jpKdiFwzSg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMhUBjnG75XANF1E5KUyigKSmhxzvJytfapieC6_jpKdiFwzSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 11:21, Zheyu Ma wrote:
> On Wed, Apr 13, 2022 at 11:42 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 4/12/22 15:34, Zheyu Ma wrote:
>>> On Mon, Apr 11, 2022 at 7:53 AM Damien Le Moal
>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>
>>>> On 4/10/22 15:30, Zheyu Ma wrote:
>>>>> Hello,
>>>>>
>>>>> I found a bug in the pata_marvell module.
>>>>> When probing the driver, it seems to trigger the error path and
>>>>> executes the function marvell_cable_detect(), but the
>>>>> 'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.
>>>>
>>>> I do not have this hardware so I cannot debug this. Please debug it and
>>>> send a patch. bmdma_addr is normally set in ata_pci_bmdma_init(), but some
>>>> drivers set it manually in their probe functions. No idea about the
>>>> marvell driver, I have not checked it.
>>>
>>> To be honest I don't have a good solution to this problem, because
>>> other drivers don't have similar behavior. The marvell driver doesn't
>>> even initialize 'bmdma_addr' before calling 'cable_detect'.
>>
>> Then this is the bug that needs to be fixed, no ?
>>
>>> So a simple idea I have is to check if 'bmdma_addr' is 0 before
>>> reading it and if so return the error code ATA_CBL_NONE.
>>
>> And if indeed, even after it is initialized it is still 0, then yes, this
>> change seems sensible.
> 
> Sorry for the late reply, I found the root cause of this issue.
> The marvell driver execute the ata_pci_bmdma_init() function, but the
> driver just returned at the following code snippet.
> 
> if (pci_resource_start(pdev, 4) == 0) {
>       ata_bmdma_nodma(host, "BAR4 is zero");
>       return;
> }
> 
> So the driver didn't initialize the 'bmdma_addr' but used it in the
> cable_detect() function.
> It seems that the problem is caused by the hardware, is this a bug
> that we should fix?

So it looks like your adapter is saying: I do not support DMA.
In that case, having bmdma_addr as 0 should be expected and
pata_marvel_cable_detect() should check the address before attempting an
ioread8(). It is weird that the cable information is in that bar though...

In any case, you should check the adapter specs to verify how the cable
type can be detected. And if unknown when bmdma_addr is 0, then just
return ATA_CBL_PATA_UNK.

> 
> Zheyu Ma
> 
> 
> Zheyu Ma


-- 
Damien Le Moal
Western Digital Research
