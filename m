Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2745A26C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiHZLTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiHZLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:19:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA73CDABBE;
        Fri, 26 Aug 2022 04:19:29 -0700 (PDT)
Received: from [IPV6:2405:201:10:389d:42df:ae4c:c047:294c] (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1DC86601ECE;
        Fri, 26 Aug 2022 12:19:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661512768;
        bh=Rv62zworisULBtawBlqoGRXimBcHR+4UHAWyMfb3rCQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KZPsNVfqNqMm51JZBo3R8OKTVWn5pMG3PooEow6CVZrkxhHZX4PWwujGp18pSH0wy
         ZZkOuvl3vqrxcAvxE8hx26wlug8W71kOVST6QhyZGBVWhEKYwTJ7QEFMWlcIz/M+Wx
         Vhyji8mR4DBItLpTmI/SEUxB+bFaV7BRvR0xZ8RHw3bTD1W9hxSbwiwWqfHR0Lt7Pc
         cRrYFwkmvyMH2kd5uZN4B/4Ri+kqTioa3uPXwfTFFL4dYeF8+s0S5r394/qs5FNmEs
         Zdbc98+Jr35vcIQ7lnhB6MipstNwDG5eA92A13zPagyIYMdXMZuEiNDmYPbI66fsyt
         jZEMo4UOfdWhQ==
Message-ID: <90912685-33e3-d94e-c83f-2d11b967e3a1@collabora.com>
Date:   Fri, 26 Aug 2022 16:49:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] spi: amd: Configure device speed
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alvaro.soliverez@collabora.com, broonie@kernel.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sanju.mehta@amd.com, tanureal@opensource.cirrus.com
References: <20220825143132.253224-1-shreeya.patel@collabora.com>
 <e5ac1c95-a6b9-5cd6-3f6d-1134677f4fcb@wanadoo.fr>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <e5ac1c95-a6b9-5cd6-3f6d-1134677f4fcb@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/08/22 12:14, Christophe JAILLET wrote:
> Le 25/08/2022 à 16:31, Shreeya Patel a écrit :
>> From: Lucas Tanure 
>> <tanureal-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
>>
>> Number of clock frequencies are supported by AMD controller
>> which are mentioned in the amd_spi_freq structure table.
>>
>> Create mechanism to configure device clock frequency such
>> that it is strictly less than the requested frequency.
>>
>> Give priority to the device transfer speed and in case
>> it is not set then use the max clock speed supported
>> by the device.
>>
>> Signed-off-by: Lucas Tanure 
>> <tanureal-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
>> Co-developed-by: Shreeya Patel 
>> <shreeya.patel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> Signed-off-by: Shreeya Patel 
>> <shreeya.patel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>
>> Changes in v3
>>    - Make changes as per the current code and resend.
>>
>> Changes in v2
>>    - Improve the commit message.
>>
>>   drivers/spi/spi-amd.c | 97 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
>> index b3b3f5167c4c..264633c5ce0b 100644
>> --- a/drivers/spi/spi-amd.c
>> +++ b/drivers/spi/spi-amd.c
>> @@ -36,6 +36,18 @@
>>   #define AMD_SPI_FIFO_SIZE    70
>>   #define AMD_SPI_MEM_SIZE    200
>>   +#define AMD_SPI_ENA_REG        0x20
>> +#define AMD_SPI_ALT_SPD_SHIFT    20
>> +#define AMD_SPI_ALT_SPD_MASK    GENMASK(23, AMD_SPI_ALT_SPD_SHIFT)
>> +#define AMD_SPI_SPI100_SHIFT    0
>> +#define AMD_SPI_SPI100_MASK    GENMASK(AMD_SPI_SPI100_SHIFT, 
>> AMD_SPI_SPI100_SHIFT)
>> +#define AMD_SPI_SPEED_REG    0x6C
>> +#define AMD_SPI_SPD7_SHIFT    8
>> +#define AMD_SPI_SPD7_MASK    GENMASK(13, AMD_SPI_SPD7_SHIFT)
>> +
>> +#define AMD_SPI_MAX_HZ        100000000
>> +#define AMD_SPI_MIN_HZ        800000
>> +
>>   /**
>>    * enum amd_spi_versions - SPI controller versions
>>    * @AMD_SPI_V1:        AMDI0061 hardware version
>> @@ -46,14 +58,41 @@ enum amd_spi_versions {
>>       AMD_SPI_V2,
>>   };
>>   +enum amd_spi_speed {
>> +    F_66_66MHz,
>> +    F_33_33MHz,
>> +    F_22_22MHz,
>> +    F_16_66MHz,
>> +    F_100MHz,
>> +    F_800KHz,
>> +    SPI_SPD7,
>> +    F_50MHz = 0x4,
>> +    F_4MHz = 0x32,
>> +    F_3_17MHz = 0x3F
>> +};
>> +
>> +/**
>> + * struct amd_spi_freq - Matches device speed with values to write 
>> in regs
>> + * @speed_hz: Device frequency
>> + * @enable_val: Value to be written to "enable register"
>> + * @spd7_val: Some frequencies requires to have a value written at 
>> SPISPEED register
>> + */
>> +struct amd_spi_freq {
>> +    u32 speed_hz;
>> +    u32 enable_val;
>> +    u32 spd7_val;
>> +};
>> +
>>   /**
>>    * struct amd_spi - SPI driver instance
>>    * @io_remap_addr:    Start address of the SPI controller registers
>>    * @version:        SPI controller hardware version
>> + * @speed_hz:        Device frequency
>>    */
>>   struct amd_spi {
>>       void __iomem *io_remap_addr;
>>       enum amd_spi_versions version;
>> +    unsigned int speed_hz;
>>   };
>>     static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
>> @@ -185,11 +224,62 @@ static int amd_spi_master_setup(struct 
>> spi_device *spi)
>>       return 0;
>>   }
>>   +static const struct amd_spi_freq amd_spi_freq[] = {
>> +    { AMD_SPI_MAX_HZ,   F_100MHz,         0},
>> +    {       66660000, F_66_66MHz,         0},
>> +    {       50000000,   SPI_SPD7,   F_50MHz},
>> +    {       33330000, F_33_33MHz,         0},
>> +    {       22220000, F_22_22MHz,         0},
>> +    {       16660000, F_16_66MHz,         0},
>> +    {        4000000,   SPI_SPD7,    F_4MHz},
>> +    {        3170000,   SPI_SPD7, F_3_17MHz},
>> +    { AMD_SPI_MIN_HZ,   F_800KHz,         0},
>> +};
>> +
>
> Hi,
> I'm not sure to understand the logic here:
>
>> +static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
>> +{
>> +    unsigned int i, spd7_val, alt_spd;
>> +
>> +    if (speed_hz == amd_spi->speed_hz)
>> +        return 0;
>
> If we set a speed that is already the one in use --> return success
>
>> +
>> +    if (speed_hz < AMD_SPI_MIN_HZ)
>> +        return -EINVAL;
>
> If we request a speed below the lower possible --> return error.
>
>> +
>> +    for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++)
>> +        if (speed_hz >= amd_spi_freq[i].speed_hz)
>> +            break;
>
> Search the array for the speed that is just below or equal to the 
> requested one.
>
>> +
>> +    if (speed_hz == amd_spi_freq[i].speed_hz)
>> +        return 0;
>
> If it is an exact match --> return success
> ???
>
> So, if the requested value is one of the table, nothing is done and it 
> can't be selected.
>
> Is it what is expected?
> Without looking at the rest of the code or at the driver, I don't see 
> the point of this test.
>
>
> Should this be:
>     if (amd_spi->speed_hz == amd_spi_freq[i].speed_hz)
>         ^^^^^^^^^
> ?
>

Yes you are right, it should be amd_spi->speed_hz instead of speed_hz. 
Thanks for pointing it out.
I'll send a fix for it.


Thanks,
Shreeya Patel

>
> If so, the first 'if (speed_hz == amd_spi->speed_hz)' looks redundant. 
> (I guess it is a slow path, so should it be an optimization, it 
> should'nt really matter)
>
> CJ
>
>> +
>> +    amd_spi->speed_hz = amd_spi_freq[i].speed_hz;
>> +
>> +    alt_spd = (amd_spi_freq[i].enable_val << AMD_SPI_ALT_SPD_SHIFT)
>> +           & AMD_SPI_ALT_SPD_MASK;
>> +    amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, alt_spd,
>> +                   AMD_SPI_ALT_SPD_MASK);
>> +
>> +    if (amd_spi->speed_hz == AMD_SPI_MAX_HZ)
>> +        amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, 1,
>> +                       AMD_SPI_SPI100_MASK);
>> +
>> +    if (amd_spi_freq[i].spd7_val) {
>> +        spd7_val = (amd_spi_freq[i].spd7_val << AMD_SPI_SPD7_SHIFT)
>> +                & AMD_SPI_SPD7_MASK;
>> +        amd_spi_setclear_reg32(amd_spi, AMD_SPI_SPEED_REG, spd7_val,
>> +                       AMD_SPI_SPD7_MASK);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
>>                       struct spi_master *master,
>>                       struct spi_message *message)
>>   {
>>       struct spi_transfer *xfer = NULL;
>> +    struct spi_device *spi = message->spi;
>>       u8 cmd_opcode = 0, fifo_pos = AMD_SPI_FIFO_BASE;
>>       u8 *buf = NULL;
>>       u32 i = 0;
>> @@ -197,6 +287,11 @@ static inline int amd_spi_fifo_xfer(struct 
>> amd_spi *amd_spi,
>>         list_for_each_entry(xfer, &message->transfers,
>>                   transfer_list) {
>> +        if (xfer->speed_hz)
>> +            amd_set_spi_freq(amd_spi, xfer->speed_hz);
>> +        else
>> +            amd_set_spi_freq(amd_spi, spi->max_speed_hz);
>> +
>>           if (xfer->tx_buf) {
>>               buf = (u8 *)xfer->tx_buf;
>>               if (!tx_len) {
>> @@ -313,6 +408,8 @@ static int amd_spi_probe(struct platform_device 
>> *pdev)
>>       master->num_chipselect = 4;
>>       master->mode_bits = 0;
>>       master->flags = SPI_MASTER_HALF_DUPLEX;
>> +    master->max_speed_hz = AMD_SPI_MAX_HZ;
>> +    master->min_speed_hz = AMD_SPI_MIN_HZ;
>>       master->setup = amd_spi_master_setup;
>>       master->transfer_one_message = amd_spi_master_transfer;
>>       master->max_transfer_size = amd_spi_max_transfer_size;
>
>
