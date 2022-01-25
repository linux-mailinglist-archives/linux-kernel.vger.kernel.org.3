Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA949B80D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582619AbiAYPzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:55:12 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53633 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582656AbiAYPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:52:49 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C8AE422246;
        Tue, 25 Jan 2022 16:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643125962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgF/ZD7vL2e+O+i/4RHMv30Axibez91DuCFdcEl0Yj0=;
        b=TGRpOi2KDh/+tnQ46MfFo6NzLp6WgOiXdnz9L+RH32yrgRXsA4moYAan4yC+/YeelYJq8f
        zPW7E3sTVOy3HhdhjuFIgyLAcZhivG9Z9nCHQAnNpuEUsP514yvak6IVuC1IEB4IwpNOL4
        o2I1Kx9b7euNUH+iOozWdJSJknAFTUs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jan 2022 16:52:41 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
Cc:     dianders@chromium.org, tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        sartgarg@codeaurora.org
Subject: Re: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip
In-Reply-To: <SJ0PR02MB8449372A38A34EC5FAC16765CD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <db1d17bbdcf7af2b8b58f6e7fa82062c@walle.cc>
 <SJ0PR02MB8449372A38A34EC5FAC16765CD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ce590c8dc41c64bc56d9c241f4c7dd9a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-01-25 16:36, schrieb Sajida Bhanu (Temp) (QUIC):
> Am 2022-01-20 10:54, schrieb Shaik Sajida Bhanu:
>> Add support for winbond W25Q512NW-IM chip.
>> 
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> ---
>> 
>> Changes since V1:
>> 	- Added space before name of the flash part as suggested by Doug.
>> 
>> Changes since V2:
>> 	- Updated chip name as w25q512nwm as suggested by Doug.
>> 
>> Changes since V3:
>> 	- Updated flash_info flags passing according to below patch
> 
> Thanks!
> 
> Please note, that you also have to supply a SFDP dump, see [1].
> 
>> https://lore.kernel.org/all/20211207140254.87681-7-tudor.ambarus@microchip.com/
>> 	 As suggested by Tudor Ambarus.
>> ---
>>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/winbond.c
>> b/drivers/mtd/spi-nor/winbond.c index 675f32c..c4be225 100644
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] = 
>> {
>>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>>  			      SPI_NOR_DUAL_READ) },
>> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
>> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> +			      SPI_NOR_QUAD_READ) },
> 
> Could you try adding OTP_INFO(256, 3, 0x1000, 0x1000), this should
> enable OTP support. Could you please test this using the
> flash_otp_{dump,info,erase,write} tools and add that line?
> 
> I've checked ID duplications, because there is the w25qNNjw series.
> There doesn't seem to exist a w25q512jw, so we are safe for now. There
> is only a w25q512jv and it has the id 0xef4020.
> 
> fun fact.. the w25q512nwm describes the OTP lock bit for the first OTP
> region (the one which is not documented and I've found out that its
> used for storing the SFDP) as SFDP lock bit. See ch "7.1.1 Security
> Register Lock Bits (LB3, LB2, LB1, SFDP Lock bit)". So we finally have
> evidence :)
> 
> -michael
> 
> Hi,
> 
> Thanks for the review..
> 
> Can you please share the documentation about OTP_INFO
> settings(Advantages etc..) if any.

I would like to see support for OTP right from the start, and
because you have that specific flash chip, you are in the position
to test it :)

With this line (it should already be exact that line I provided,
I checked the datasheet), you just enable access to a seperate
OTP memory inside that flash. The datasheet calls them Security
Registers, you can have a look there.

> Can you please share more info on
> flash_otp_{dump,info,erase,write} tools.

What do you mean? You can find these tools in the mtd-utils
package or at http://www.linux-mtd.infradead.org/ (couldn't check,
website seems to be down for me at least).

You should make sure to have the latest version, which has a
bugfix for the flash_otp_dump and only newer versions have the
flash_otp_erase tool.

Examples:

# flash_otp_dump -u /dev/mtd0 0
OTP user data for /dev/mtd0
0x0000: 56 01 55 53 44 30 47 30 30 30 32 00 00 00 00 00
0x0010: 00 00 a0 a5 5c 6b 62 7b ff ff ff ff ff ff ff ff
0x0020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[..]

# flash_otp_info -u /dev/mtd0
Number of OTP user blocks on /dev/mtd0: 3
block  0:  offset = 0x0000  size = 256 bytes  [locked]
block  1:  offset = 0x0100  size = 256 bytes  [unlocked]
block  2:  offset = 0x0200  size = 256 bytes  [unlocked]

# echo -n hello world | flash_otp_write -u /dev/mtd0 0x100
Writing OTP user data on /dev/mtd0 at offset 0x100
Wrote 11 bytes of OTP user data

# flash_otp_dump -u /dev/mtd0 0x100
OTP user data for /dev/mtd0
0x0100: 68 65 6c 6c 6f 20 77 6f 72 6c 64 ff ff ff ff ff
0x0110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[..]

# flash_otp_erase -u /dev/mtd0 0x100 0x200
# flash_otp_dump -u /dev/mtd0 0x100
OTP user data for /dev/mtd0
0x0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[..]

For completeness, there is also flash_otp_lock, but that
is not reversible and you'd lock the OTP area forever.

HTH,
-michael
