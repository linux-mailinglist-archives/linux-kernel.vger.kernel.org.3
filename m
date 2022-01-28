Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7F49F6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiA1J6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:58:50 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41003 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237775AbiA1J6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:58:49 -0500
Received: from [192.168.0.2] (ip5f5aecde.dynamic.kabel-deutschland.de [95.90.236.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 64FCE61EA1923;
        Fri, 28 Jan 2022 10:58:46 +0100 (CET)
Message-ID: <d9c4e80e-87ca-9e68-f97d-d2c709e54ff3@molgen.mpg.de>
Date:   Fri, 28 Jan 2022 10:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] ata: ahci: Skip 200 ms debounce delay for Marvell
 88SE9235
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220127233527.445659-1-pmenzel@molgen.mpg.de>
 <1ef3e995-3f61-ef53-0d5e-03bb41a52624@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1ef3e995-3f61-ef53-0d5e-03bb41a52624@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Damien,


Thank you for the quick reply.


Am 28.01.22 um 00:40 schrieb Damien Le Moal:
> On 1/28/22 08:35, Paul Menzel wrote:
>> The 200 ms delay before debouncing the PHY in `sata_link_resume()` is
>> not needed for the Marvell 88SE9235.
>>
>>      $ lspci -nn -s 0021:0e:00.0
>>      0021:0e:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9235 PCIe 2.0 x2 4-port SATA 6 Gb/s Controller [1b4b:9235] (rev 11)
>>
>> So, remove it. Tested on IBM S822LC with current Linux 5.17-rc1:
>>
>> Without this patch (with 200 ms delay):
>>
>>      [    3.358158] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000100 irq 39
>>      [    3.358175] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000180 irq 39
>>      [    3.358191] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000200 irq 39
>>      [    3.358207] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000280 irq 39
>>      […]
>>      [    3.677542] ata3: SATA link down (SStatus 0 SControl 300)
>>      [    3.677719] ata4: SATA link down (SStatus 0 SControl 300)
>>      [    3.839242] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>      [    3.839828] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
>>      [    3.840029] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
>>      [    3.841796] ata2.00: configured for UDMA/133
>>      [    3.843231] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>      [    3.844083] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
>>      [    3.844313] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
>>      [    3.846043] ata1.00: configured for UDMA/133
>>
>> With patch (no delay):
>>
>>      [    3.624259] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000100 irq 39
>>      [    3.624436] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000180 irq 39
>>      [    3.624452] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000200 irq 39
>>      [    3.624468] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000280 irq 39
>>      […]
>>      [    3.731966] ata3: SATA link down (SStatus 0 SControl 300)
>>      [    3.732069] ata4: SATA link down (SStatus 0 SControl 300)
>>      [    3.897448] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>      [    3.897678] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>      [    3.898140] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
>>      [    3.898175] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
>>      [    3.898287] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
>>      [    3.898349] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
>>      [    3.900070] ata1.00: configured for UDMA/133
>>      [    3.900166] ata2.00: configured for UDMA/133
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   drivers/ata/ahci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index ab5811ef5a53..edca4e8fd44e 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -582,6 +582,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>   	  .driver_data = board_ahci_yes_fbs },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
>>   	  .driver_data = board_ahci_yes_fbs },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
>> +	  .driver_data = board_ahci_no_debounce_delay },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
>>   	  .driver_data = board_ahci_yes_fbs },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
> 
> Looks good. But for the commit message, instead of the dmesg copy-paste,
> could you simply write the gains in terms of shortened scan time ? That
> would make it easier to understand the benefits of the patch.

I can do:

> Tested on IBM S822LC with current Linux 5.17-rc1, and the 200 ms is
> gone, and the drives are still detected.
I would still like to keep the Linux logs, as then it’s clear what I 
tested with (drives), and what ports were populated.

> Also, there is no need for the lspci output.

In my opinion, it prooves I used the correct PCI vendor and device 
codes, and also shows the revision number of the device I tested with.


Kind regards,

Paul
