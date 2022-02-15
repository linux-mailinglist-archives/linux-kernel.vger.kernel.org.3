Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAA14B6CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiBOMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:52:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiBOMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB751D339
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644929551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcdJOUbrvRiT7BNK/B406u9Ktr5GqIc4L3/Tr001vTo=;
        b=O15LXRm5E9bmzvoIzyhUVvZlYwgtkJQbNLkfTcbrT8Lw4bPFvZOroG40Y2htg3iEkja2sn
        uVhK8KDPR5DWmj8QcSM+Wkh47wswWRoAIgEKERyR14evdrJKwrEo54jO151Vu6jyLHf7Yf
        75NzuFQ2XjJrnVcPTwPEiChqSyFIQa0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-eWHkCsNcPLy9jFLAKPucqg-1; Tue, 15 Feb 2022 07:52:30 -0500
X-MC-Unique: eWHkCsNcPLy9jFLAKPucqg-1
Received: by mail-ej1-f70.google.com with SMTP id gn20-20020a1709070d1400b006cf1fcb4c8dso2089908ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PcdJOUbrvRiT7BNK/B406u9Ktr5GqIc4L3/Tr001vTo=;
        b=JD4QgNi3HfLyyzKbc8GtXz5xlYlrBiZfm3KJy0q7neGA0c0mt0WAAKG/36Y2UwptOR
         uhPZYv8IacPT9eP58+8Zb3GF9Nj1LkV8GD/5715xfExwCwcmnitPkEIvy9RGWdC0jtp6
         HAlgiAylFPMtUYbRun8cJ+wtl59mnZlVXdHsOuSoGGCk6+iWvj9fezB7DzMBQZ8v3NF5
         BKTOcdzGYtl351dDjT3jPMh9ELU4H7Im0GySWd+1hFZU1wsPson2+VWBrcIFViCXYx5v
         bld5ay/S6OgAsmYx3lLdWqrhhP05EKBwnp6oCP6Z6gsaLxoGMyTBxs2t+Cv4NtHHheX3
         B5xA==
X-Gm-Message-State: AOAM530lWpaL+4XtlRvCTxShgu/0cZlGcLyMU39MQC6NQH6X6S8wOl9z
        YiE15ehnNm4GloGysdHmeeUCFgYApWq96DWMKUw1/bICdo4Um/1bWuCEbcSS5xiR0bRJSnLejwu
        abDd+mbFPz6vxPfPDXmTW4SD0
X-Received: by 2002:a05:6402:424f:: with SMTP id g15mr3895860edb.158.1644929548643;
        Tue, 15 Feb 2022 04:52:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX0pvkdcbr9boNxInJ3nhJsJQL28JVA/U6stWisGfEdGxl+AbNbCR1WxxLnnpKY5QjCEl4ww==
X-Received: by 2002:a05:6402:424f:: with SMTP id g15mr3895844edb.158.1644929548420;
        Tue, 15 Feb 2022 04:52:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id d25sm11708112ejz.4.2022.02.15.04.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:52:27 -0800 (PST)
Message-ID: <3a6f3090-e2b6-7ec1-d66d-f74449983937@redhat.com>
Date:   Tue, 15 Feb 2022 13:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] ahci: Add Green Sardine vendor ID as
 board_ahci_mobile
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
 <960946b8-8f73-9f81-735a-64e5cc555a9c@molgen.mpg.de>
 <DM4PR12MB516853204C9D7E7EAAFBC91FE2339@DM4PR12MB5168.namprd12.prod.outlook.com>
 <6c846941-151d-e8a5-3ce8-a392b97186a8@molgen.mpg.de>
 <6e7678ba-1d56-155f-f5b7-3257bbd0d929@redhat.com>
 <e146ff4c-a1c2-dfbd-d736-2515bb8201a9@molgen.mpg.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e146ff4c-a1c2-dfbd-d736-2515bb8201a9@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2/15/22 13:27, Paul Menzel wrote:
> Dear Hans,
> 
> 
> Am 15.02.22 um 12:43 schrieb Hans de Goede:
> 
>> On 2/15/22 08:05, Paul Menzel wrote:
> 
>>> Am 14.02.22 um 17:07 schrieb Limonciello, Mario:
>>>
>>>> +Hans
>>>>
>>>>> (For the records, is part of Linux since 5.16-rc2 (commit 1527f69204fe).)
>>>>>
>>>>> Am 12.11.21 um 21:15 schrieb Mario Limonciello:
>>>>>> AMD requires that the SATA controller be configured for devsleep in order
>>>>>> for S0i3 entry to work properly.
>>>>>>
>>>>>> commit b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with
>>>>>> SLP_S0") sets up a kernel policy to enable devsleep on Intel mobile
>>>>>> platforms that are using s0ix.  Add the PCI ID for the SATA controller in
>>>>>> Green Sardine platforms to extend this policy by default for AMD based
>>>>>> systems using s0i3 as well.
>>>>>>
>>>>>> Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
>>>>>> BugLink:
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
>>>>> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cm
>>>>> ario.limonciello%40amd.com%7Ca32a202d437544cd2cbb08d9ef9112c0%7C3d
>>>>> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637804228648002522%7CU
>>>>> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>>>>> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CbfImBnwc8uV1L5QRBuV
>>>>> PLkP72wpS9yif1UbUwykhNI%3D&amp;reserved=0
>>>
>>> You have to love Microsoft Outlook.
>>>
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>     drivers/ata/ahci.c | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>>>> index d60f34718b5d..1e1167e725a4 100644
>>>>>> --- a/drivers/ata/ahci.c
>>>>>> +++ b/drivers/ata/ahci.c
>>>>>> @@ -438,6 +438,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>>>>         /* AMD */
>>>>>>         { PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>>>>>         { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>>>>> +    { PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>>>>>
>>>>> Aren't 0x7900 and 0x7901 the same device only in different modes? I
>>>>> wonder, why different boards and different comments are used.
>>>>
>>>> No they aren't the same device in different modes.
>>>>
>>>> Reference:
>>>> https://www.amd.com/en/support/tech-docs/processor-programming-reference-ppr-for-amd-family-19h-model-51h-revision-a1
>>>> Page 33 has a table.
>>>
>>> That table misses 0x7900h. (Where can I find it?) coreboot has 0x7900 defined for Cezanne:
>>>
>>>      src/include/device/pci_ids.h:#define PCI_DEVICE_ID_AMD_CZ_SATA  0x7900
>>>      src/soc/amd/stoneyridge/include/soc/pci_devs.h: * SATA_IDE_IDEVID              0x7900
>>>
>>> The PCI database too [3]:
>>>
>>>> FCH SATA Controller [IDE mode]
>>>
>>>
>>>>> Additionally, the device 0x7901 is also present in desktop systems like
>>>>> Dell OptiPlex 5055 and MSI B350 MORTAR. Is `board_ahci_mobile` the right
>>>>> board then? Or should the flag `AHCI_HFLAG_IS_MOBILE` be renamed to
>>>>> avoid confusion?
>>>>
>>>> Are you having a problem or just want clarity in the enum definition?
>>>
>>> It’s more about clarity, and understanding the two different entries.
>>>
>>>> This was introduced by Hans in commit ebb82e3c79d2a to set LPM policy properly
>>>> for a number of mobile devices.
>>>>
>>>> My opinion here is that the policy being for "mobile" devices only is short sighted as power
>>>> consumption policy on desktops is also relevant as OEMs ship desktops that need to meet
>>>> various power regulations for those too.
>>>>
>>>> So I would be in the camp for renaming the flags.
>>>
>>> Why can’t the LPM policy, if available(?), not be set for `board_ahci` by default, so `board_ahci_mobile` could be removed?
>>
>> When I added this, which was around the Haswell / Broadwell times, enabling
>> LPM on mobile devices was not so much important for the direct power-saving,
>> but to allow the entire package (integrated southbridge-ish) to go to deeper
>> sleep (aka PC) states.
>>
>> Without this laptops would drain their batteries much faster, but at the same
>> time there were reports of LPM causing crashes and data corruption on some
>> systems, also see the list of ATA ids with a ATA_HORKAGE_NOLPM flag in
>> drivers/ata/libata-core.c . Which was added and grown over time to allow
>> enabling LPM by default without causing regressions.
> 
> This seems to be related to the hard driver though, and not the chipset?

It is related to both, as mentioned sometimes BIOS updates (presumably
involving SATA chipset settings tweaks) resolved LPM issues.

A drive having the ATA_HORKAGE_NOLPM flag basically means that it is know
to cause (serious) issues with at least one of the mobile marked chipsets.

For another example of sometimes issues being chipset specific see the
recently added ATA_HORKAGE_NO_NCQ_ON_ATI quirk, which fixes a bad
interaction between early AMD/ATI sata chihpsets and Samsung SSD 860
and Samsung SSD 870 series drives.

>> So when adding support for enabling LPM modes by default, to get the
>> desired power-savings by default I tried to do this on a minimal set of
>> devices, to avoid causing regressions.
>>
>> Another factor here is that in some cases LPM related issues went away
>> after either BIOS or disk/ssd firmware updates. So the motherboard firmware
>> is also a factor here and enabling LPM by default on non laptop(ish)
>> motherboards has never been tested.
>>
>> Also enabling some of the deeper LPM modes comes at a latency cost which
>> may be undesirable at servers. Note this just sets the initial default
>> LPM mode, this can always be changed by userspace later.
> 
> Thank you for the elaborate explanation. What do you suggest in regards the 1022:7901, present in laptops and desktop systems?

I would suggest to go with board_ahci_mobile as is done in Mario's
original patch. We really want this for laptops and for desktops
using the same chipset I don't expect this to cause any issues.

Regards,

Hans

