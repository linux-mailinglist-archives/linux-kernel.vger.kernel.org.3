Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0E55F2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiF2Bf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiF2BfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:35:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3612C28E10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656466520; x=1688002520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s/ZcR4rZ2s2VxX2a+v+kNduBcbXrq+qY3otwjZQxkI8=;
  b=GdGlovSHW1VzfS6loM7P0/LU3HzMYtWbnxnbVcOlAdCdivTNhYtUBbCF
   cwFOz5oZsuNrPMVZ28hp49QIlUFRd5K6N1MbijAj031pVD+uc/7pYUuc8
   Tf4YSYplJvsCl5giL+Szyo0X8HkvXVovLkIP8Ss6OUEk9SL6tIcttfaQk
   SIt+UOJ7PmWEv4XqasLhkN/eDybgH4EpgLfx6+tZZ1bBzYfdhFZgS5rsu
   d9wpEX9wHJrpzivOLJWJzUFMobLUroM4J6QfdEPvLveC24S87CgiGp+uy
   3zAX2hiyJr1Ms0ZVxBXtV+9xZwdxI2S24/Ft4xD+kFzUPF9D5GGDOISJw
   A==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="203017039"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 09:35:18 +0800
IronPort-SDR: 3KWwTgnn3IAx3X7GhYv7k9wGOfKKzN84FsS8hT+NMC/K7ocwCDEf5J0xoNMq8D6iDYeLlB3Ggx
 GbQLR31PjYlry1giYrOSwAYgq9wcUQTcN1trRPgRk6JzRwv97Ya7AkdBSxoTyaXu0akaVGLdpv
 SAOvqkw5E2xTaRhoJQCCUS4JmSOGP6/o0el1oNoZzIahWSf6aUGCNEEl8N3OffX9KXZXOhJ2oz
 8mg5FBcPSAzv3Lr/asiyg1FuluTxdyDRswb9jYp1tMJ5p/LRT8gRMQaDq6wX8lK28t743XB9OX
 AKEAba4l5PEAUQbPhKnt08gz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 17:52:58 -0700
IronPort-SDR: WZ/mnv4VfxAzopf059nm6rEPqGKUbA9DLsiIB0IM7cZ7T4l+knagsdEviw2u9zUQBOjvh9Qalj
 qz2XW4+bJJGtRdan4e7LP4dSGy0eho7P8OtRz3jHLwG/Mgf4u/bTSGeXykYkR7G5PIjwyjmDCI
 tYXdWoo7aWT6PCRm4yY0Rj/wrfpnFq0Pq0j3WwTSpLykpdTKuhyyiOhWySCy1Vv5M8Kn31ydr4
 IzbpxwXb7Q3TmwLe5tXbv48IIX4WyMhCE3+zZSnY3LsNH1feYFxDZpSZQB1ECvh0HYDP1R5gDf
 Cgc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:35:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXkYL2Hglz1Rwry
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:35:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656466516; x=1659058517; bh=s/ZcR4rZ2s2VxX2a+v+kNduBcbXrq+qY3ot
        wjZQxkI8=; b=OmeTcmBgcAZrnVoZTECVFgEfp9RwKPbEgdJUcSqX4PVm0TaRTaz
        1tErG/4HgZKYjBqGsGZ19zTSkypuS5zKKrqYOSBRtWhkxftZoe6shd6MWeNJFqvK
        WPV6lZuYkZdo5+R/+wCJ58+C9FTWmcu6GVfPIDl5umJEXCg65xkI3XhcvxiZUZXK
        NUQ4SKY4wjw2vxGOKgF1jZcEGukCoqWeAcZgOu95Eu9+NnLopNANsn5AFPK/ce0J
        hJ1EAb15HS/rzSx6SpUbrdd0gZunylqO2pmmlOnPFrAfg2DlDEHm6yRjk18vFc6s
        1nQKrlae7I4bFc21qpizbg//DRPfFPKQ3bA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wZmIl_76zyiV for <linux-kernel@vger.kernel.org>;
        Tue, 28 Jun 2022 18:35:16 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXkYG5x5vz1RtVk;
        Tue, 28 Jun 2022 18:35:14 -0700 (PDT)
Message-ID: <3dade607-71a5-28ad-fb0b-f5b75c1b5392@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 10:35:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 12/23] ata: libahci: Extend port-cmd flags set with
 port capabilities
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-13-Sergey.Semin@baikalelectronics.ru>
 <d06e9910-527e-cfa2-f2df-737fb4799fe5@opensource.wdc.com>
 <20220615205819.uiqptkqm5qfdvrbj@mobilestation>
 <903e273a-9dc5-f0df-5391-e96e63318323@opensource.wdc.com>
 <20220617203100.jg2o7ponolaenf6r@mobilestation>
 <f560ca8b-d921-d228-64f0-74e320f8af67@opensource.wdc.com>
 <20220618081055.grsrjxa5gqiuhy2i@mobilestation>
 <20220628120820.3nprogcpe2l3bcm4@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220628120820.3nprogcpe2l3bcm4@mobilestation>
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

On 6/28/22 21:08, Serge Semin wrote:
> Damien,
> Any notes to the comments below?

Been very busy and had no time to look at this. Please post your latest
version of the series and we'll go from there.

> 
> -Sergey
> 
> On Sat, Jun 18, 2022 at 11:10:55AM +0300, Serge Semin wrote:
>> On Sat, Jun 18, 2022 at 03:52:28PM +0900, Damien Le Moal wrote:
>>> On 6/18/22 05:31, Serge Semin wrote:
>>>> On Thu, Jun 16, 2022 at 09:28:18AM +0900, Damien Le Moal wrote:
>>>>> On 2022/06/16 5:58, Serge Semin wrote:
>>>>>> On Tue, Jun 14, 2022 at 05:32:41PM +0900, Damien Le Moal wrote:
>>>>>>> On 6/10/22 17:17, Serge Semin wrote:
>>>>>>>> Currently not all of the Port-specific capabilities listed in the
>>>>>>>
>>>>>>> s/listed/are listed
>>>>>>>
>>>>>>>> PORT_CMD-enumeration. Let's extend that set with the Cold Presence
>>>>>>>> Detection and Mechanical Presence Switch attached to the Port flags [1] so
>>>>>>>> to closeup the set of the platform-specific port-capabilities flags.  Note
>>>>>>>> these flags are supposed to be set by the platform firmware if there is
>>>>>>>> one. Alternatively as we are about to do they can be set by means of the
>>>>>>>> OF properties.
>>>>>>>>
>>>>>>>> While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DMPS and fix the
>>>>>>>> comment there. In accordance with [2] that IRQ flag is supposed to
>>>>>>>> indicate the state of the signal coming from the Mechanical Presence
>>>>>>>> Switch.
>>>>>>>>
>>>>>>>> [1] Serial ATA AHCI 1.3.1 Specification, p.27
>>>>>>>> [2] Serial ATA AHCI 1.3.1 Specification, p.24, p.88
>>>>>>>>
>>>>>>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>>>>>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Changelog v4:
>>>>>>>> - Fix the DMPS macros name in the patch log. (@Sergei Shtylyov)
>>>>>>>> ---
>>>>>>>>  drivers/ata/ahci.h | 7 ++++++-
>>>>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>>>>>>>> index 7d834deefeb9..f501531bd1b3 100644
>>>>>>>> --- a/drivers/ata/ahci.h
>>>>>>>> +++ b/drivers/ata/ahci.h
>>>>>>>> @@ -138,7 +138,7 @@ enum {
>>>>>>>>  	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
>>>>>>>>  
>>>>>>>>  	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
>>>>>>>> -	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
>>>>>>>> +	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
>>>>>>>>  	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
>>>>>>>>  	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
>>>>>>>>  	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
>>>>>>>> @@ -166,6 +166,8 @@ enum {
>>>>>>>>  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
>>>>>>>>  	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
>>>>>>>>  	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
>>>>>>>> +	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
>>>>>>>> +	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
>>>>>>>>  	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
>>>>>>>>  	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
>>>>>>>>  	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
>>>>>>>> @@ -181,6 +183,9 @@ enum {
>>>>>>>>  	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
>>>>>>>>  	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
>>>>>>>>  
>>>>>>>> +	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
>>>>>>>> +				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
>>>>>>>
>>>>>>
>>>>>>> What is this one for ? A comment above it would be nice.
>>>>>>
>>>>>> Isn't it obviously inferrable from the definition and the item name?
>>>>>
>>>>
>>>>> I am guessing from the name. Am I guessing OK ? A comment would still be nice.
>>>>> Why just these bits ? There are more cap/support indicator bits in that port cmd
>>>>> bitfield. So why this particular set of bits ? What do they mean all together ?
>>>>
>>>> Normally the variable/constant name should be self-content (as the
>>>> kernel coding style doc states and what the common sense suggests). So
>>>> the reader could correctly guess its purpose/content/value. In this
>>>> case PORT_CMD_CAP - means PORT CMD capabilities mask. All of the
>>>> possible flags have been set in that mask. There are no more
>>>> capabilities in the PORT CMD register left undeclared. That's why the
>>>> name is selected the way it is and why I haven't added any comment in
>>>> here (what the kernel coding style says about the over-commenting the
>>>> code).
>>>
>>
>>> Yes, I understood from the name what it is. What I do NOT understand is
>>> why all the feature bits are not there. Why this subset only ? A comment
>>> about that would be nice so that the reason for it is not lost.
>>
>> Well, because it's indeed "PORT_CMD capabilities mask", and not features,
>> not setups, not settings, not status flags, etc. As I said all the port
>> Capabilities have been listed in that mask:
>> PORT_CMD_FBSCP	BIT(22) - FIS-based Switching Capable Port
>> PORT_CMD_ESP	BIT(21) - External SATA Port
>> PORT_CMD_CPD	BIT(20) - Cold Presence Detect
>> PORT_CMD_MPSP	BIT(19) - Mechanical Presence Switch Attached to Port
>> PORT_CMD_HPCP	BIT(18) - Hot Plug Capable Port
>> I've or'ed-them-up in a single mask => PORT_CMD_CAP in order to work
>> with them independently from the rest of the PORT_CMD CSR fields.
>>
>> Unlike the generic controller CAP/CAP2 registers, which consists of the
>> device capabilities only, PORT_CMD contains various R/W settings (PM, LED
>> driver, etc), RO status flags (CMD-list running, FIS recv running, etc)
>> and amongst other the RO/Wo !port-specific capabilities!. The later ones
>> indicate the platform-specific device features. Since the register
>> contains flags with the intermixed nature, I need to have a mask to at
>> least get the capabilities and preserve them between the device
>> resets. That's why the PORT_CMD_CAP has been introduced in the
>> framework of this patch. Its name was chosen with a reference to the
>> CAP registers, see:
>> HOST_CAP, HOST_CAP2, and finally my PORT_CMD_CAP.
>>
>>>
>>>>
>>>>>
>>>>> Sure I can go and read the specs to figure it out. But again, a comment would
>>>>> avoid readers of the code to have to decrypt all that.
>>>>
>>>> If you still insist on having an additional comment. I can add
>>>> something like "/* PORT_CMD capabilities mask */". Are you ok with it?
>>>
>>
>>> That does not help on its own. The macro name says that already. I would
>>> like a note about why only these features are selected.
>>
>> Please see the explanation above. I don't see what else to say about
>> that mask, because in short what I said above really means "PORT_CMD
>> capabilities mask". So should you have some more clever text, which
>> would be more suitable here, please tell me and I'll add it to the
>> patch.
>>
>> Regarding what you said earlier. In order to fully understand the
>> AHCI driver a hacker would always need to read the specs. There is
>> just no way to do that effectively enough without the controller
>> manual at hands. And the PORT_CMD capabilities isn't the most
>> complicated part of the device.
>>
>> -Sergey
>>
>>>
>>>>
>>>> -Sergey
>>>>
>>>>>
>>>>>>
>>>>>> -Sergey
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>  	/* PORT_FBS bits */
>>>>>>>>  	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
>>>>>>>>  	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
>>>>>>>
>>>>>>>
>>>>>>> -- 
>>>>>>> Damien Le Moal
>>>>>>> Western Digital Research
>>>>>
>>>>>
>>>>> -- 
>>>>> Damien Le Moal
>>>>> Western Digital Research
>>>
>>>
>>> -- 
>>> Damien Le Moal
>>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
