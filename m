Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0809D486144
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiAFIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:09:24 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42419 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236364AbiAFIJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:09:23 -0500
Received: from [192.168.0.3] (ip5f5aed2d.dynamic.kabel-deutschland.de [95.90.237.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 68CD961E64846;
        Thu,  6 Jan 2022 09:09:22 +0100 (CET)
Message-ID: <734cc427-eee0-89e0-1edd-6b483191c502@molgen.mpg.de>
Date:   Thu, 6 Jan 2022 09:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 1/2] ahci: Rename flag `ATA_LFLAG_NO_DB_DELAY` to
 `ATA_LFLAG_NO_DEBOUNCE_DELAY`
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
 <d5130eed-d881-f654-3e24-b552609abce9@opensource.wdc.com>
 <e19a8764-2943-f370-f1d9-bb399a2aa1ac@molgen.mpg.de>
 <1665d5a4-994a-b9df-33a9-c748bd5c17be@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1665d5a4-994a-b9df-33a9-c748bd5c17be@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Damien,


Am 06.01.22 um 08:55 schrieb Damien Le Moal:
> On 1/6/22 16:35, Paul Menzel wrote:

>> Am 06.01.22 um 03:52 schrieb Damien Le Moal:
>>> On 1/6/22 00:36, Paul Menzel wrote:
>>>> The new name is longer, but clearer.
>>>
>>> It looks like you sent an incremental change on top of your previous
>>> patches. Please send a cleaned up series. One patch to introduce the
>>> ATA_LFLAG_NO_DEBOUNCE_DELAY flag & msleep bypass and another to add the
>>> AMD chipset.
>>>
>>> The commit message of this version patch 2 should be the explanation for
>>> the ATA_LFLAG_NO_DEBOUNCE_DELAY flag, not for adding a new chipset ID.
>>
>> Sorry, but I think you misread the patch. The flag
>> `ATA_LFLAG_NO_DB_DELAY` exists since commit e39b2bb3b7 (libata: skip
>> debounce delay on link resume).
> 
> Arg. Indeed. Ignore my comment :)
> 
> Let's wait to see if there are any more comments and I will queue this
> up for 5.17.

Thank you. In the second patch, I should have probably mentioned, that 
the flag already exists. Maybe you can amend that before applying them.

> Going forward, it would be interesting to work on reversing the default:
> no delay by default and mark all old & unknown adapters as needing the
> delay. As you mentioned, most modern AHCI adapters most likely do not
> need it.
> 
> Are you willing to take this and send a patches ?

Yes, I have it on my to-do list, but cannot promise anything.


Kind regards,

Paul


>>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> ---
>>>>    drivers/ata/ahci_brcm.c   | 2 +-
>>>>    drivers/ata/libata-sata.c | 2 +-
>>>>    include/linux/libata.h    | 2 +-
>>>>    3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
>>>> index 6e9c5ade4c2ea..649815c196ed0 100644
>>>> --- a/drivers/ata/ahci_brcm.c
>>>> +++ b/drivers/ata/ahci_brcm.c
>>>> @@ -333,7 +333,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
>>>>    
>>>>    static const struct ata_port_info ahci_brcm_port_info = {
>>>>    	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
>>>> -	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
>>>> +	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
>>>>    	.pio_mask	= ATA_PIO4,
>>>>    	.udma_mask	= ATA_UDMA6,
>>>>    	.port_ops	= &ahci_brcm_platform_ops,
>>>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>>>> index b9c77885b8726..67b2e7cf3cc4e 100644
>>>> --- a/drivers/ata/libata-sata.c
>>>> +++ b/drivers/ata/libata-sata.c
>>>> @@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
>>>>    		 * immediately after resuming.  Delay 200ms before
>>>>    		 * debouncing.
>>>>    		 */
>>>> -		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
>>>> +		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
>>>>    			ata_msleep(link->ap, 200);
>>>>    
>>>>    		/* is SControl restored correctly? */
>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>> index 2a8404b26083c..15802e644962d 100644
>>>> --- a/include/linux/libata.h
>>>> +++ b/include/linux/libata.h
>>>> @@ -191,7 +191,7 @@ enum {
>>>>    	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
>>>>    	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
>>>>    	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
>>>> -	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
>>>> +	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
>>>>    
>>>>    	/* struct ata_port flags */
>>>>    	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
>>>
>>>
