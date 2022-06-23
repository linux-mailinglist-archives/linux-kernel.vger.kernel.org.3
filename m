Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F955752E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiFWIOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiFWIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:13:59 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 01:13:53 PDT
Received: from frontdoor.pr.hu (frontdoor.pr.hu [IPv6:2a02:808:3:101:250:56ff:fe8e:1370])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2343AF3;
        Thu, 23 Jun 2022 01:13:53 -0700 (PDT)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
        by frontdoor.pr.hu with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <zboszor@pr.hu>)
        id 1o4Hjj-0008L3-G3; Thu, 23 Jun 2022 09:58:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
        s=pr20170203; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ijw29va7e9GjYEvDhYSV4GaaJPfxvijzkTXyC52jbc0=; b=f4o8FWaet1jmFLzeHwcEZMG7Nv
        c04/9OtyQitceucrg++QARmZeAuoMIKMc5bowZFGZrTec13G4RSXW+FR2bCnkL1ZTPK0f6zwEoZpO
        dx4+UuTBm9y2glifRLrXhqOVOfgqBtlcPQlcpB4/U9l8UuwEdsrABxJcQT1Ow2xZndWO9f9+XXLki
        82QhCLgokcfwrTWG+udIDFntmy4mv4IPHbWMRLaP6zJrPQ1+kq1issASroU0gY1PjrL2qsxFRBbwr
        U8dn1QW4BXa0lo80j5JKAMFKP9l+xLT4YeVY/8no+DdZqMeZqxoh/UkMjMIc/fmaIVjzHc/NG12+9
        pMir7Gbw==;
Received: from host-87-242-32-154.prtelecom.hu ([87.242.32.154] helo=[192.168.1.143])
        by mail.pr.hu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <zboszor@pr.hu>)
        id 1o4Hjb-0006xF-0d; Thu, 23 Jun 2022 09:58:45 +0200
Message-ID: <6fedf197-2a85-2ee8-5ae2-12b955ad5fae@pr.hu>
Date:   Thu, 23 Jun 2022 09:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20220204125750.1771303-1-zboszor@pr.hu>
 <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
 <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
In-Reply-To: <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -11.1 (-----------)
X-Scan-Signature: 6a8c5092fa5a4f65eed44a44a14f0c19
X-Spam-Tracer: backend.mail.pr.hu -11.1 20220623075845Z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022. 06. 23. 9:47 keltezéssel, Böszörményi Zoltán írta:
> 2022. 02. 08. 9:07 keltezéssel, Damien Le Moal írta:
>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>> From: Zoltán Böszörményi <zboszor@gmail.com>
>>>
>>> This device is a CF card, or possibly an SSD in CF form factor.
>>> It supports NCQ and high speed DMA.
>>>
>>> While it also advertises TRIM support, I/O errors are reported
>>> when the discard mount option fstrim is used. TRIM also fails
>>> when disabling NCQ and not just as an NCQ command.
>>>
>>> TRIM must be disabled for this device.
>>>
>>> Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
>>> ---
>>>   drivers/ata/libata-core.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 67f88027680a..4a7f58fcc411 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>       /* devices that don't properly handle TRIM commands */
>>>       { "SuperSSpeed S238*",        NULL,    ATA_HORKAGE_NOTRIM, },
>>> +    { "M88V29*",            NULL,    ATA_HORKAGE_NOTRIM, },
>>>       /*
>>>        * As defined, the DRAT (Deterministic Read After Trim) and RZAT
>> Applied to for-5.17-fixes. Thanks !
> 
> Thank you. However, I have second thoughts about this patch.
> The device advertises this:
> 
> # hdparm -iI /dev/sda
> ...
>   Enabled Supported
>      *    Data Set Management TRIM supported (limit 1 block)
> ...

Here's the complete hdparm output:

/dev/sda:

  Model=M88V29 32GB, FwRev=181019i, SerialNo=20211023AA20A0656011
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/15/63, TrkSize=0, SectSize=0, ECCbytes=4
  BuffType=unknown, BuffSize=unknown, MaxMultSect=1, MultSect=off
  CurCHS=16383/15/63, CurSects=15481935, LBA=yes, LBAsects=62533296
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
  AdvancedPM=yes: unknown setting
  Drive conforms to: Unspecified:  ATA/ATAPI-5,6,7

  * signifies the current active mode


CompactFlash ATA device
	Model Number:       M88V29 32GB
	Serial Number:      20211023AA20A0656011
	Firmware Revision:  181019i
Standards:
	Supported: 8 7 6 5
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		15	15
	sectors/track	63	63
	--
	CHS current addressable sectors:    15481935
	LBA    user addressable sectors:    62533296
	LBA48  user addressable sectors:    62533296
	Logical/Physical Sector size:           512 bytes
	device size with M = 1024*1024:       30533 MBytes
	device size with M = 1000*1000:       32017 MBytes (32 GB)
	cache/buffer size  = unknown
	Nominal Media Rotation Rate: Solid State Device
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Vendor, with device specific minimum
	R/W multiple sector transfer: Max = 1	Current = 0
	Advanced power management level: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Look-ahead
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	   *	CFA feature set
	   *	Advanced Power Management feature set
	   *	48-bit Address feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	DOWNLOAD MICROCODE DMA command
	   *	Data Set Management TRIM supported (limit 1 block)
	   *	Deterministic read data after TRIM
		CFA max advanced io_udma cycle time: 80ns
		CFA max advanced mem_udma cycle time: 80ns
	   *	CFA advanced modes: pio5 pio6 mdma3 mdma4 io_udma4 io_udma5 io_udma6 io_udma7 
io_udma8 *io_udma9 mem_udma4 mem_udma5 mem_udma6 mem_udma7 mem_udma8 *mem_udma9
		CFA Power Level 1  not supported (max 100mA)
Security:
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	4min for SECURITY ERASE UNIT. 4min for ENHANCED SECURITY ERASE UNIT.
HW reset results:
	CBLID- above Vih
	Device num = 0
Checksum: correct

> 
> but the I/O failures always reported higher number of blocks,
> IIRC the attempted number of block was 8 or so.
> 
> Can the kernel limit or split TRIM commands according to the
> advertised limit? If not (or not yet) then the quirk is good for now.
> 
> Best regards,
> Zoltán Böszörményi
> 

