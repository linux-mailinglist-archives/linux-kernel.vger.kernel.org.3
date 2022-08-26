Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617B5A2109
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbiHZGol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245071AbiHZGoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:44:38 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D347D1E20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:44:35 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RT4xoMkam09yuRT4xonQ8Y; Fri, 26 Aug 2022 08:44:32 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Aug 2022 08:44:32 +0200
X-ME-IP: 90.11.190.129
Message-ID: <e5ac1c95-a6b9-5cd6-3f6d-1134677f4fcb@wanadoo.fr>
Date:   Fri, 26 Aug 2022 08:44:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] spi: amd: Configure device speed
Content-Language: en-US
To:     shreeya.patel@collabora.com
Cc:     alvaro.soliverez@collabora.com, broonie@kernel.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sanju.mehta@amd.com, tanureal@opensource.cirrus.com
References: <20220825143132.253224-1-shreeya.patel@collabora.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220825143132.253224-1-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/08/2022 à 16:31, Shreeya Patel a écrit :
> From: Lucas Tanure <tanureal-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
> 
> Number of clock frequencies are supported by AMD controller
> which are mentioned in the amd_spi_freq structure table.
> 
> Create mechanism to configure device clock frequency such
> that it is strictly less than the requested frequency.
> 
> Give priority to the device transfer speed and in case
> it is not set then use the max clock speed supported
> by the device.
> 
> Signed-off-by: Lucas Tanure <tanureal-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
> Co-developed-by: Shreeya Patel <shreeya.patel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> Signed-off-by: Shreeya Patel <shreeya.patel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> 
> Changes in v3
>    - Make changes as per the current code and resend.
> 
> Changes in v2
>    - Improve the commit message.
> 
>   drivers/spi/spi-amd.c | 97 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
> index b3b3f5167c4c..264633c5ce0b 100644
> --- a/drivers/spi/spi-amd.c
> +++ b/drivers/spi/spi-amd.c
> @@ -36,6 +36,18 @@
>   #define AMD_SPI_FIFO_SIZE	70
>   #define AMD_SPI_MEM_SIZE	200
>   
> +#define AMD_SPI_ENA_REG		0x20
> +#define AMD_SPI_ALT_SPD_SHIFT	20
> +#define AMD_SPI_ALT_SPD_MASK	GENMASK(23, AMD_SPI_ALT_SPD_SHIFT)
> +#define AMD_SPI_SPI100_SHIFT	0
> +#define AMD_SPI_SPI100_MASK	GENMASK(AMD_SPI_SPI100_SHIFT, AMD_SPI_SPI100_SHIFT)
> +#define AMD_SPI_SPEED_REG	0x6C
> +#define AMD_SPI_SPD7_SHIFT	8
> +#define AMD_SPI_SPD7_MASK	GENMASK(13, AMD_SPI_SPD7_SHIFT)
> +
> +#define AMD_SPI_MAX_HZ		100000000
> +#define AMD_SPI_MIN_HZ		800000
> +
>   /**
>    * enum amd_spi_versions - SPI controller versions
>    * @AMD_SPI_V1:		AMDI0061 hardware version
> @@ -46,14 +58,41 @@ enum amd_spi_versions {
>   	AMD_SPI_V2,
>   };
>   
> +enum amd_spi_speed {
> +	F_66_66MHz,
> +	F_33_33MHz,
> +	F_22_22MHz,
> +	F_16_66MHz,
> +	F_100MHz,
> +	F_800KHz,
> +	SPI_SPD7,
> +	F_50MHz = 0x4,
> +	F_4MHz = 0x32,
> +	F_3_17MHz = 0x3F
> +};
> +
> +/**
> + * struct amd_spi_freq - Matches device speed with values to write in regs
> + * @speed_hz: Device frequency
> + * @enable_val: Value to be written to "enable register"
> + * @spd7_val: Some frequencies requires to have a value written at SPISPEED register
> + */
> +struct amd_spi_freq {
> +	u32 speed_hz;
> +	u32 enable_val;
> +	u32 spd7_val;
> +};
> +
>   /**
>    * struct amd_spi - SPI driver instance
>    * @io_remap_addr:	Start address of the SPI controller registers
>    * @version:		SPI controller hardware version
> + * @speed_hz:		Device frequency
>    */
>   struct amd_spi {
>   	void __iomem *io_remap_addr;
>   	enum amd_spi_versions version;
> +	unsigned int speed_hz;
>   };
>   
>   static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
> @@ -185,11 +224,62 @@ static int amd_spi_master_setup(struct spi_device *spi)
>   	return 0;
>   }
>   
> +static const struct amd_spi_freq amd_spi_freq[] = {
> +	{ AMD_SPI_MAX_HZ,   F_100MHz,         0},
> +	{       66660000, F_66_66MHz,         0},
> +	{       50000000,   SPI_SPD7,   F_50MHz},
> +	{       33330000, F_33_33MHz,         0},
> +	{       22220000, F_22_22MHz,         0},
> +	{       16660000, F_16_66MHz,         0},
> +	{        4000000,   SPI_SPD7,    F_4MHz},
> +	{        3170000,   SPI_SPD7, F_3_17MHz},
> +	{ AMD_SPI_MIN_HZ,   F_800KHz,         0},
> +};
> +

Hi,
I'm not sure to understand the logic here:

> +static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
> +{
> +	unsigned int i, spd7_val, alt_spd;
> +
> +	if (speed_hz == amd_spi->speed_hz)
> +		return 0;

If we set a speed that is already the one in use --> return success

> +
> +	if (speed_hz < AMD_SPI_MIN_HZ)
> +		return -EINVAL;

If we request a speed below the lower possible --> return error.

> +
> +	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++)
> +		if (speed_hz >= amd_spi_freq[i].speed_hz)
> +			break;

Search the array for the speed that is just below or equal to the 
requested one.

> +
> +	if (speed_hz == amd_spi_freq[i].speed_hz)
> +		return 0;

If it is an exact match --> return success
???

So, if the requested value is one of the table, nothing is done and it 
can't be selected.

Is it what is expected?
Without looking at the rest of the code or at the driver, I don't see 
the point of this test.


Should this be:
     if (amd_spi->speed_hz == amd_spi_freq[i].speed_hz)
         ^^^^^^^^^
?


If so, the first 'if (speed_hz == amd_spi->speed_hz)' looks redundant. 
(I guess it is a slow path, so should it be an optimization, it 
should'nt really matter)

CJ

> +
> +	amd_spi->speed_hz = amd_spi_freq[i].speed_hz;
> +
> +	alt_spd = (amd_spi_freq[i].enable_val << AMD_SPI_ALT_SPD_SHIFT)
> +		   & AMD_SPI_ALT_SPD_MASK;
> +	amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, alt_spd,
> +			       AMD_SPI_ALT_SPD_MASK);
> +
> +	if (amd_spi->speed_hz == AMD_SPI_MAX_HZ)
> +		amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, 1,
> +				       AMD_SPI_SPI100_MASK);
> +
> +	if (amd_spi_freq[i].spd7_val) {
> +		spd7_val = (amd_spi_freq[i].spd7_val << AMD_SPI_SPD7_SHIFT)
> +			    & AMD_SPI_SPD7_MASK;
> +		amd_spi_setclear_reg32(amd_spi, AMD_SPI_SPEED_REG, spd7_val,
> +				       AMD_SPI_SPD7_MASK);
> +	}
> +
> +	return 0;
> +}
> +
>   static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
>   				    struct spi_master *master,
>   				    struct spi_message *message)
>   {
>   	struct spi_transfer *xfer = NULL;
> +	struct spi_device *spi = message->spi;
>   	u8 cmd_opcode = 0, fifo_pos = AMD_SPI_FIFO_BASE;
>   	u8 *buf = NULL;
>   	u32 i = 0;
> @@ -197,6 +287,11 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
>   
>   	list_for_each_entry(xfer, &message->transfers,
>   			    transfer_list) {
> +		if (xfer->speed_hz)
> +			amd_set_spi_freq(amd_spi, xfer->speed_hz);
> +		else
> +			amd_set_spi_freq(amd_spi, spi->max_speed_hz);
> +
>   		if (xfer->tx_buf) {
>   			buf = (u8 *)xfer->tx_buf;
>   			if (!tx_len) {
> @@ -313,6 +408,8 @@ static int amd_spi_probe(struct platform_device *pdev)
>   	master->num_chipselect = 4;
>   	master->mode_bits = 0;
>   	master->flags = SPI_MASTER_HALF_DUPLEX;
> +	master->max_speed_hz = AMD_SPI_MAX_HZ;
> +	master->min_speed_hz = AMD_SPI_MIN_HZ;
>   	master->setup = amd_spi_master_setup;
>   	master->transfer_one_message = amd_spi_master_transfer;
>   	master->max_transfer_size = amd_spi_max_transfer_size;

