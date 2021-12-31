Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527A4482116
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 01:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbhLaAwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 19:52:08 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:61533 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237396AbhLaAwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 19:52:07 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JQ66Z61H8z1RvTh
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:52:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640911926; x=1643503927; bh=g4PGlbqSxsH3XvHoevA8bXvKml/4nf4L2PN
        JJQfqYqE=; b=uurV/T/exbzGU030HL7JdsD6jyObyqZ3vycPUyGnKW3hHak/Dsi
        lKQ5aOop3unRHy4JJTCJjw3tppcoY2q8cyolCZA2O7gWRa6lExJfZyGPi4g0yiKS
        hgMxMo2NMSnvpk8nIRfTcVzFX/OMXkLo1ocx0/SEPEpW8Qcs73sOMgdlnyej68AB
        tvdqaHAck5KqhCuwAObDMWjB83c4UjE7bOIbDp7UvRu/3W8/x7wmvYB/M9gkZEg7
        fB4YP1POwX3wk8OE1Pc4gSYxjdaLXD5n+ZpdSkDV4pX3KLcOLoBasJrFg7hmYhQ8
        scpmhqsnSGuZUehJIh7CC/2XCESvgAZnEYA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cjYZOTYvmXzJ for <linux-kernel@vger.kernel.org>;
        Thu, 30 Dec 2021 16:52:06 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JQ66Y4GQnz1RtVG;
        Thu, 30 Dec 2021 16:52:05 -0800 (PST)
Message-ID: <7b64d1c3-f798-d64b-9ee3-9669d98f4e28@opensource.wdc.com>
Date:   Fri, 31 Dec 2021 09:52:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms
 debounce delay in `sata_link_resume()`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-3-pmenzel@molgen.mpg.de>
 <5c333718-eaa5-b41c-e8ea-59d6e01254aa@opensource.wdc.com>
 <19f6cd93-9bd7-60dc-4471-18022bcf456c@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <19f6cd93-9bd7-60dc-4471-18022bcf456c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 20:08, Paul Menzel wrote:
>>>   	board_ahci_nomsi,
>>>   	board_ahci_noncq,
>>>   	board_ahci_nosntf,
>>> @@ -141,6 +142,13 @@ static const struct ata_port_info ahci_port_info[] = {
>>>   		.udma_mask	= ATA_UDMA6,
>>>   		.port_ops	= &ahci_ops,
>>>   	},
>>> +	[board_ahci_nodbdelay] = {
>>> +		.flags		= AHCI_FLAG_COMMON,
>>> +		.link_flags	= ATA_LFLAG_NO_DB_DELAY,
>>> +		.pio_mask	= ATA_PIO4,
>>> +		.udma_mask	= ATA_UDMA6,
>>> +		.port_ops	= &ahci_ops,
>>> +	},
>>>   	[board_ahci_nomsi] = {
>>>   		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
>>>   		.flags		= AHCI_FLAG_COMMON,
>>> @@ -437,6 +445,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>   		board_ahci_al },
>>>   	/* AMD */
>>>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci },
>>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI), board_ahci_nodbdelay },
>>
>> Patch 1 introduces this macro in pci_ids.h, but it is used only here. So
>> to keep with the current style in this structure, drop the macro (so
>> drop patch 1).
> 
> I wait for your answer of the second patch, and then I am going to sent v4.

Let's use the numeric value. No macro definition needed.

> 
>>>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>>   	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>>>   	/* AMD is using RAID class only for ahci controllers */
> 
> Do you have a AHCI device at hand, where you could also test if 
> everything works fine without the delay?

Unfortunately, I do not have any board with this adapter.

Cheers.


-- 
Damien Le Moal
Western Digital Research
