Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0D4B6CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiBOMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:55:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiBOMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01E7C443C9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644929707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWpCV1vCh9SyEpjVGJpL1I8KMkGXWc7WBvjuBLVAcTE=;
        b=UV7ONcSHbFS2NuFBKp3d50YdJUicoui0VBD9nTeCIUmYLs3+4cvrhkZ08EECSk6eVVk3sd
        iOM7aFz9sCFnvrVlMAJbgm+jDQd1tUIbhSUuq4Dg+Dh+1TQiGReZclH25InkU8rT0ZSdqy
        9VmR6K8kqmhzig6cv397udEDsUarUUs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-dtyjZi6JM9GkZOnJ1up-iQ-1; Tue, 15 Feb 2022 07:55:06 -0500
X-MC-Unique: dtyjZi6JM9GkZOnJ1up-iQ-1
Received: by mail-ed1-f72.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso12352010edh.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UWpCV1vCh9SyEpjVGJpL1I8KMkGXWc7WBvjuBLVAcTE=;
        b=MsLnTQTWl3SOIlzIOHa+yPcpKCyj6EWFfZDORKq/yHE6f3doqBorYM2ApflVQ2vOM8
         4VmwaHq75rQ78Hl2mw9xsUf2xFF0ucJBNOAjS9HRtlgZoXtNrtSQuPvHxHtiMT09Iphd
         7eP9OS83i/bVL77yM79JPLIvDhDUAld+yHhdR+iOg5VbB3+JGEu+vR2NBBDBwUSP9jbS
         nGFBADcu3HL8uP4nqMPo+yM2DbRaZOuP5J+V3+V14cCU2Ldw2BGTG1xIicEn/uGihbSz
         4M4Bj9dkyivJPoJSe4wcYVnKCpb45DqwWrJ1Y+LtjU6sji33YQzAeCm6Axnsd0vlcDpV
         q33w==
X-Gm-Message-State: AOAM531qWn8sTRU/IwHFdkWNXbipXaRoWwpgXxoogiw/ErjDpKginzWv
        oH8lDJwjgq7bWAryeSy4A3eIbbY59l4V2PpCg5cHXiuT9d87B6UBBxuK4ztP5ESzkrRnSpkfLX2
        MT6xgrLE7SqM09SDKqLnIPJB3
X-Received: by 2002:aa7:cb8c:: with SMTP id r12mr3828836edt.174.1644929704741;
        Tue, 15 Feb 2022 04:55:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyp6YTfQVw9KzaZMgPXaH6ERIpB6ODZ9z4zJX6n5Pmg5Gr1u4KT4YHHDwsx57rgWb1vcWmEcQ==
X-Received: by 2002:aa7:cb8c:: with SMTP id r12mr3828814edt.174.1644929704515;
        Tue, 15 Feb 2022 04:55:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id r11sm8033894ejc.212.2022.02.15.04.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:55:04 -0800 (PST)
Message-ID: <48698051-ad31-3b42-046e-4d204b180d80@redhat.com>
Date:   Tue, 15 Feb 2022 13:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] ahci: Add Green Sardine vendor ID as
 board_ahci_mobile
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
 <960946b8-8f73-9f81-735a-64e5cc555a9c@molgen.mpg.de>
 <DM4PR12MB516853204C9D7E7EAAFBC91FE2339@DM4PR12MB5168.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <DM4PR12MB516853204C9D7E7EAAFBC91FE2339@DM4PR12MB5168.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/14/22 17:07, Limonciello, Mario wrote:
> [Public]
> 
> +Hans
> 
>> (For the records, is part of Linux since 5.16-rc2 (commit 1527f69204fe).)
>>
>> Am 12.11.21 um 21:15 schrieb Mario Limonciello:
>>> AMD requires that the SATA controller be configured for devsleep in order
>>> for S0i3 entry to work properly.
>>>
>>> commit b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with
>>> SLP_S0") sets up a kernel policy to enable devsleep on Intel mobile
>>> platforms that are using s0ix.  Add the PCI ID for the SATA controller in
>>> Green Sardine platforms to extend this policy by default for AMD based
>>> systems using s0i3 as well.
>>>
>>> Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
>>> BugLink:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
>> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cm
>> ario.limonciello%40amd.com%7Ca32a202d437544cd2cbb08d9ef9112c0%7C3d
>> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637804228648002522%7CU
>> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CbfImBnwc8uV1L5QRBuV
>> PLkP72wpS9yif1UbUwykhNI%3D&amp;reserved=0
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/ata/ahci.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index d60f34718b5d..1e1167e725a4 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -438,6 +438,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>   	/* AMD */
>>>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green
>> Sardine */
>>
>> Aren't 0x7900 and 0x7901 the same device only in different modes? I
>> wonder, why different boards and different comments are used.
> 
> No they aren't the same device in different modes.
> 
> Reference:
> https://www.amd.com/en/support/tech-docs/processor-programming-reference-ppr-for-amd-family-19h-model-51h-revision-a1
> Page 33 has a table.
> 
>>
>> Additionally, the device 0x7901 is also present in desktop systems like
>> Dell OptiPlex 5055 and MSI B350 MORTAR. Is `board_ahci_mobile` the right
>> board then? Or should the flag `AHCI_HFLAG_IS_MOBILE` be renamed to
>> avoid confusion?
> 
> Are you having a problem or just want clarity in the enum definition?
> 
> This was introduced by Hans in commit ebb82e3c79d2a to set LPM policy properly
> for a number of mobile devices.
> 
> My opinion here is that the policy being for "mobile" devices only is short sighted as power
> consumption policy on desktops is also relevant as OEMs ship desktops that need to meet
> various power regulations for those too.
> 
> So I would be in the camp for renaming the flags.

I have no objection against renaming the flags, maybe rename "mobile" to
"enable_lpm_by_default" ? That is a bit long, but it is what it is all
about. Alternatively we could go with "low_power" but that feels much less
descriptive.

Regards,

Hans

