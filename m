Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5C588F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiHCPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiHCPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:22:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61FA13A4AF;
        Wed,  3 Aug 2022 08:22:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 395E911FB;
        Wed,  3 Aug 2022 08:22:20 -0700 (PDT)
Received: from [10.57.12.36] (unknown [10.57.12.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86C143F70D;
        Wed,  3 Aug 2022 08:22:18 -0700 (PDT)
Message-ID: <ae7e7d7b-bf90-7f23-8a27-e6358b3ff4f6@arm.com>
Date:   Wed, 3 Aug 2022 16:22:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: bitbang: Fix lsb-first Rx
Content-Language: en-GB
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <28324d8622da80461cce35a82859b003d6f6c4b0.1659538737.git.robin.murphy@arm.com>
 <YuqOBYJSP8Pm7Bz5@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YuqOBYJSP8Pm7Bz5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-03 16:02, Mark Brown wrote:
> On Wed, Aug 03, 2022 at 03:58:57PM +0100, Robin Murphy wrote:
>> Shifting the recieved bit by "bits" inserts it at the top of the
>> *currently remaining* Tx data, so we end up accumulating the whole
>> transfer into bit 0 of the output word. Oops.
>>
>> For the algorithm to work as intended, we need to remember where the
>> top of the *original* word was, and shift Rx to there.
> 
> So if this never worked we presumably have some systems out there which
> somehow rely on the old behaviour that we need to fix somehow - copying
> in everyone from the original change...

Hmm, I can't imagine anyone's relying too critically on data transfer 
corruption :/

Apparently these TM16x8 chips are the only thing so far to even want 
lsb-first bitbang support at all, so I strongly suspect I'm the first 
person to try the receive side of it (since Rockchip's SPI hardware 
doesn't seem to support 3-wire half-duplex). It actually took me quite a 
while to figure out that this wasn't my bug in trying to hook up the 
matrix-keymap stuff, since half the bytes I was expecting to get back do 
only have bit 0 set anyway.

Cheers,
Robin.

>> Fixes: 1847e3046c52 ("spi: gpio: Implement LSB First bitbang support")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/spi/spi-bitbang-txrx.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
>> index 267342dfa738..2dcbe166df63 100644
>> --- a/drivers/spi/spi-bitbang-txrx.h
>> +++ b/drivers/spi/spi-bitbang-txrx.h
>> @@ -116,6 +116,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
>>   {
>>   	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
>>   
>> +	u8 rxbit = bits - 1;
>>   	u32 oldbit = !(word & 1);
>>   	/* clock starts at inactive polarity */
>>   	for (; likely(bits); bits--) {
>> @@ -135,7 +136,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
>>   		/* sample LSB (from slave) on leading edge */
>>   		word >>= 1;
>>   		if ((flags & SPI_MASTER_NO_RX) == 0)
>> -			word |= getmiso(spi) << (bits - 1);
>> +			word |= getmiso(spi) << rxbit;
>>   		setsck(spi, cpol);
>>   	}
>>   	return word;
>> @@ -148,6 +149,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
>>   {
>>   	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
>>   
>> +	u8 rxbit = bits - 1;
>>   	u32 oldbit = !(word & 1);
>>   	/* clock starts at inactive polarity */
>>   	for (; likely(bits); bits--) {
>> @@ -168,7 +170,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
>>   		/* sample LSB (from slave) on trailing edge */
>>   		word >>= 1;
>>   		if ((flags & SPI_MASTER_NO_RX) == 0)
>> -			word |= getmiso(spi) << (bits - 1);
>> +			word |= getmiso(spi) << rxbit;
>>   	}
>>   	return word;
>>   }
>> -- 
>> 2.36.1.dirty
>>
