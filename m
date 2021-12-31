Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAAD482293
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 08:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbhLaHIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 02:08:15 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43301 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229636AbhLaHIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 02:08:14 -0500
Received: from [192.168.0.3] (ip5f5aea97.dynamic.kabel-deutschland.de [95.90.234.151])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E7E7B61EA1922;
        Fri, 31 Dec 2021 08:08:11 +0100 (CET)
Message-ID: <fbfd865f-c88c-6ee1-6cb9-8194e170cd3a@molgen.mpg.de>
Date:   Fri, 31 Dec 2021 08:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms
 debounce delay in `sata_link_resume()`
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-3-pmenzel@molgen.mpg.de>
 <5c333718-eaa5-b41c-e8ea-59d6e01254aa@opensource.wdc.com>
 <19f6cd93-9bd7-60dc-4471-18022bcf456c@molgen.mpg.de>
 <7b64d1c3-f798-d64b-9ee3-9669d98f4e28@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <7b64d1c3-f798-d64b-9ee3-9669d98f4e28@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Damien,


Am 31.12.21 um 01:52 schrieb Damien Le Moal:
> On 12/30/21 20:08, Paul Menzel wrote:
>>>>    	board_ahci_nomsi,
>>>>    	board_ahci_noncq,
>>>>    	board_ahci_nosntf,
>>>> @@ -141,6 +142,13 @@ static const struct ata_port_info ahci_port_info[] = {
>>>>    		.udma_mask	= ATA_UDMA6,
>>>>    		.port_ops	= &ahci_ops,
>>>>    	},
>>>> +	[board_ahci_nodbdelay] = {
>>>> +		.flags		= AHCI_FLAG_COMMON,
>>>> +		.link_flags	= ATA_LFLAG_NO_DB_DELAY,
>>>> +		.pio_mask	= ATA_PIO4,
>>>> +		.udma_mask	= ATA_UDMA6,
>>>> +		.port_ops	= &ahci_ops,
>>>> +	},
>>>>    	[board_ahci_nomsi] = {
>>>>    		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
>>>>    		.flags		= AHCI_FLAG_COMMON,
>>>> @@ -437,6 +445,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>>    		board_ahci_al },
>>>>    	/* AMD */
>>>>    	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci },
>>>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI), board_ahci_nodbdelay },
>>>
>>> Patch 1 introduces this macro in pci_ids.h, but it is used only here. So
>>> to keep with the current style in this structure, drop the macro (so
>>> drop patch 1).
>>
>> I wait for your answer of the second patch, and then I am going to sent v4.
> 
> Let's use the numeric value. No macro definition needed.

Alright. I am going to follow the maintainers wishes.

>>>>    	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>>>    	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>>>>    	/* AMD is using RAID class only for ahci controllers */
>>
>> Do you have a AHCI device at hand, where you could also test if
>> everything works fine without the delay?
> 
> Unfortunately, I do not have any board with this adapter.

Sorry, we misunderstand each other. (I wrote a reply to my own patch [1].)

I think the delay is not necessary for any modern AHCI controller. It’d 
be great, if you could test, if it’s also true on the systems you have 
by just skipping the delay.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-ide/20211227162658.11314-2-pmenzel@molgen.mpg.de/T/#m697d2121463a4c946730e6b83940e12d6d7e6700
