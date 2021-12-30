Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF7481B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhL3LBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:01:39 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45903 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235057AbhL3LBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:01:37 -0500
Received: from [192.168.0.3] (ip5f5aeaad.dynamic.kabel-deutschland.de [95.90.234.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 364B161E6478B;
        Thu, 30 Dec 2021 12:01:35 +0100 (CET)
Message-ID: <0a32d475-33c7-b29d-d30d-e80bdd821af6@molgen.mpg.de>
Date:   Thu, 30 Dec 2021 12:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/3] ahci: Use macro PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-2-pmenzel@molgen.mpg.de>
 <88daa493-dc08-06ea-97d3-94a9a3d7e51c@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <88daa493-dc08-06ea-97d3-94a9a3d7e51c@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Damien,


Am 30.12.21 um 03:13 schrieb Damien Le Moal:
> On 12/30/21 01:11, Paul Menzel wrote:
>> Use the defined macro from `include/linux/pci_ids.h`.
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   drivers/ata/ahci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 1e1167e725a4..6a2432e4adda 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -436,7 +436,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>   		.class_mask = 0xffffff,
>>   		board_ahci_al },
>>   	/* AMD */
>> -	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci }, >
> That breaks the style of the declarations here... And since
> PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE is used only in drivers/pci/quirks.c,
> I do not really see the point of this change.

1.  It makes the comment superfluous.
2.  `git grep 0x7800` in the Linux source returns 1034 hits, so getting 
the macro name from the header `pci_ids.h` and then grepping for that is 
more straight forward.

I agree, that it breaks the style, and, if you agree, I could try to fix 
up the whole file.

>>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>   	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>>   	/* AMD is using RAID class only for ahci controllers */


Kind regards,

Paul
