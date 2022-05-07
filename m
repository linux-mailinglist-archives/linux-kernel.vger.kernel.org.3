Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28F51E9C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447028AbiEGTyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447195AbiEGTyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:54:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523671110;
        Sat,  7 May 2022 12:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D60D5B8068C;
        Sat,  7 May 2022 19:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0456C385A5;
        Sat,  7 May 2022 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651953027;
        bh=TcRzqdXiPQXDauGzaFhRN18HUzqbYBeZwhnB7l7+7kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTIdKzjrhT3FZwJ1k2oJZr43Z/OzdxkG8O+IaE9HYLvEQEzAhHdJU3xqi20DN9yxv
         7RC2/Y7ap3t7XDf68vtDrr1XY2DOdSvM4KElZY6Wf5w8WFBDJw7wDAuATIdXtDaHZb
         VAtrjPS+q/BlWXoUFKCK0k5FLQSfiMIEu8EtYCRNl9H5/6kjm5rwCP40I2oXTV5s3a
         fs40uif1kq7MY0llkVCWYRCIkoy7wUIDv07AkmfYWpi8ICftjoE3FG1lzoY/wXB353
         qqLoMwZczCdPBacPQq+jP2m9hk6swLJ8SnkSXr+ZuShGe/O3j6ZoIv36m5J6bx5kND
         /TfETxF09U3uA==
Date:   Sat, 7 May 2022 22:52:01 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v2 1/4] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Message-ID: <YnbN4RbxMVCjR5LB@iki.fi>
References: <20220506170013.22598-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506170013.22598-1-johannes.holland@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 07:00:11PM +0200, Johannes Holland wrote:
> Implement the TCG I2C Interface driver, as specified in the TCG PC
> Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
> revision 14, section 8, I2C Interface Definition.
> 
> This driver supports Guard Times. That is, if required by the TPM, the
> driver has to wait by a vendor-specific time after each I2C read/write.
> The specific time is read from the TPM_I2C_INTERFACE_CAPABILITY register.
> 
> Unfortunately, the TCG specified almost but not quite compatible
> register addresses. Therefore, the TIS register addresses need to be
> mapped to I2C ones. The locality is stripped because for now, only
> locality 0 is supported.
> 
> Add a sanity check to I2C reads of e.g. TPM_ACCESS and TPM_STS. This is
> to detect communication errors and issues due to non-standard behaviour
> (E.g. the clock stretching quirk in the BCM2835, see 4dbfb5f4401f). In
> case the sanity check fails, attempt a retry.
> 
> The CRC over the FIFO register is not implemented here since a new call
> has to be added to the API (tpm_tis_phy_ops).
> 
> Co-developed-by: Alexander Steffen <alexander.steffen@infineon.com>
> Signed-off-by: Alexander Steffen <alexander.steffen@infineon.com>
> Co-developed-by: Amir Mizinski <amirmizi6@gmail.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
> Changelog:
>  * v2:
>    * move CCs from copyright comment to commit message
>    * fix an unchecked return code
>  
> As discussed, kselftest runs successfully. However, it can time out.
> I will fix this in a subsequent patch. Basically:
> 
> echo timeout=1500 > tools/testing/selftests/tpm2/settings
> 
> The line coverage for tpm_tis_i2c.c is 98.1%.
> 
>  drivers/char/tpm/Kconfig       |  12 ++
>  drivers/char/tpm/Makefile      |   1 +
>  drivers/char/tpm/tpm_tis_i2c.c | 359 +++++++++++++++++++++++++++++++++
>  3 files changed, 372 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_tis_i2c.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 4a5516406c22..927088b2c3d3 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
>  	  If you have a H1 secure module running Cr50 firmware on SPI bus,
>  	  say Yes and it will be accessible from within Linux.
>  
> +config TCG_TIS_I2C
> +	tristate "TPM Interface Specification 1.3 Interface / TPM 2.0 FIFO Interface - (I2C - generic)"
> +	depends on I2C
> +	select CRC_CCITT
> +	select TCG_TIS_CORE
> +	help
> +	  If you have a TPM security chip, compliant with the TCG TPM PTP
> +	  (I2C interface) specification and connected to an I2C bus master,
> +	  say Yes and it will be accessible from within Linux.
> +	  To compile this driver as a module, choose M here;
> +	  the module will be called tpm_tis_i2c.
> +
>  config TCG_TIS_SYNQUACER
>  	tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
>  	depends on ARCH_SYNQUACER || COMPILE_TEST
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 66d39ea6bd10..0222b1ddb310 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -29,6 +29,7 @@ tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>  
>  obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
>  
> +obj-$(CONFIG_TCG_TIS_I2C) += tpm_tis_i2c.o
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> new file mode 100644
> index 000000000000..34d12f78e7ab
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2021 Nuvoton Technology corporation
> + * Copyright (C) 2019-2022 Infineon Technologies AG
> + *
> + * This device driver implements the TPM interface as defined in the TCG PC
> + * Client Platform TPM Profile (PTP) Specification for TPM 2.0 v1.04
> + * Revision 14.
> + *
> + * It is based on the tpm_tis_spi device driver.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/wait.h>
> +#include <linux/acpi.h>
> +#include <linux/freezer.h>
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_gpio.h>
> +#include <linux/tpm.h>
> +#include "tpm_tis_core.h"
> +
> +/* TPM registers */
> +#define TPM_I2C_LOC_SEL 0x00
> +#define TPM_I2C_ACCESS 0x04
> +#define TPM_I2C_INTERFACE_CAPABILITY 0x30
> +#define TPM_I2C_DEVICE_ADDRESS 0x38
> +#define TPM_I2C_DATA_CSUM_ENABLE 0x40
> +#define TPM_I2C_DID_VID 0x48
> +#define TPM_I2C_RID 0x4C
> +
> +/* TIS-compatible register address to avoid clash with TPM_ACCESS (0x00) */
> +#define TPM_LOC_SEL 0x0FFF
> +
> +/* Mask to extract the I2C register from TIS register addresses */
> +#define TPM_TIS_REGISTER_MASK 0x0FFF
> +
> +/*
> + * Guard Time:
> + * After each I2C operation, the TPM might require the master to wait.
> + * The time period is vendor-specific and must be read from the
> + * TPM_I2C_INTERFACE_CAPABILITY register.
> + *
> + * Before the Guard Time is read (or after the TPM failed to send an I2C NACK),
> + * a Guard Time of 250�s applies.
> + *
> + * Various flags in the same register indicate if a guard time is needed:
> + *  - SR: <I2C read with repeated start> <guard time> <I2C read>
> + *  - RR: <I2C read> <guard time> <I2C read>
> + *  - RW: <I2C read> <guard time> <I2C write>
> + *  - WR: <I2C write> <guard time> <I2C read>
> + *  - WW: <I2C write> <guard time> <I2C write>
> + *
> + * See TCG PC Client PTP Specification v1.04, 8.1.10 GUARD_TIME
> + */
> +
> +/* Default Guard Time until interface capability register is read */
> +#define GUARD_TIME_DEFAULT_MIN 250
> +#define GUARD_TIME_DEFAULT_MAX 300
> +
> +/* Guard Time after I2C slave NACK */
> +#define GUARD_TIME_ERR_MIN 250
> +#define GUARD_TIME_ERR_MAX 300
> +
> +/* Guard Time bit masks; SR is repeated start, RW is read then write, etc. */
> +#define TPM_GUARD_TIME_SR_MASK 0x40000000
> +#define TPM_GUARD_TIME_RR_MASK 0x00100000
> +#define TPM_GUARD_TIME_RW_MASK 0x00080000
> +#define TPM_GUARD_TIME_WR_MASK 0x00040000
> +#define TPM_GUARD_TIME_WW_MASK 0x00020000
> +#define TPM_GUARD_TIME_MIN_MASK 0x0001FE00
> +#define TPM_GUARD_TIME_MIN_SHIFT 9
> +
> +/* Masks with bits that must be read zero */
> +#define TPM_ACCESS_READ_ZERO 0x48
> +#define TPM_INT_ENABLE_ZERO 0x7FFFFF6
> +#define TPM_STS_READ_ZERO 0x23
> +#define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
> +#define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
> +
> +struct tpm_tis_i2c_phy {
> +	struct tpm_tis_data priv;
> +	struct i2c_client *i2c_client;
> +	bool guard_time_read;
> +	bool guard_time_write;
> +	u16 guard_time_min;
> +	u16 guard_time_max;
> +	u8 *io_buf;
> +};
> +
> +static inline struct tpm_tis_i2c_phy *
> +to_tpm_tis_i2c_phy(struct tpm_tis_data *data)
> +{
> +	return container_of(data, struct tpm_tis_i2c_phy, priv);
> +}
> +
> +static u8 address_to_register(u32 addr)

This would require some explanation, i.e. what address to what
register. Please document. Also, tpm_tis_i2c_ prefix would be
preferable (e.g. for grepping source tree).

> +{
> +	addr &= TPM_TIS_REGISTER_MASK;
> +
> +	switch (addr) {
> +	case TPM_ACCESS(0):
> +		return TPM_I2C_ACCESS;
> +	case TPM_LOC_SEL:
> +		return TPM_I2C_LOC_SEL;
> +	case TPM_DID_VID(0):
> +		return TPM_I2C_DID_VID;
> +	case TPM_RID(0):
> +		return TPM_I2C_RID;
> +	default:
> +		return addr;
> +	}
> +}

Please document the whole logic, e.g. the special cases. This
function is quite in the center of the driver, even if it is
internal.

> +
> +static int retry_i2c_transfer_until_ack(struct tpm_tis_data *data,
> +					struct i2c_msg *msg)
> +{
> +	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +	bool guard_time;
> +	int i = 0;
> +	int ret;
> +
> +	if (msg->flags & I2C_M_RD)
> +		guard_time = phy->guard_time_read;
> +	else
> +		guard_time = phy->guard_time_write;
> +
> +	do {
> +		ret = i2c_transfer(phy->i2c_client->adapter, msg, 1);
> +		if (ret < 0)
> +			usleep_range(GUARD_TIME_ERR_MIN, GUARD_TIME_ERR_MAX);
> +		else if (guard_time)
> +			usleep_range(phy->guard_time_min, phy->guard_time_max);
> +		/* retry on TPM NACK */
> +	} while (ret < 0 && i++ < TPM_RETRY);
> +
> +	return ret;
> +}
> +
> +/* Check that bits which must be read zero are not set */
> +static int sanity_check_read(u8 reg, u16 len, u8 *buf)
> +{
> +	u32 value;
> +	u32 zero_mask;

Nit: I would prefer reverse christmas tree order.

> +
> +	switch (len) {
> +	case sizeof(u8):
> +		value = buf[0];
> +		break;
> +	case sizeof(u16):
> +		value = le16_to_cpup((__le16 *)buf);
> +		break;
> +	case sizeof(u32):
> +		value = le32_to_cpup((__le32 *)buf);
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	switch (reg) {
> +	case TPM_I2C_ACCESS:
> +		zero_mask = TPM_ACCESS_READ_ZERO;
> +		break;
> +	case TPM_INT_ENABLE(0) & TPM_TIS_REGISTER_MASK:
> +		zero_mask = TPM_INT_ENABLE_ZERO;
> +		break;
> +	case TPM_STS(1) & TPM_TIS_REGISTER_MASK:
> +		zero_mask = TPM_STS_READ_ZERO;
> +		break;
> +	case TPM_INTF_CAPS(0) & TPM_TIS_REGISTER_MASK:
> +		zero_mask = TPM_INTF_CAPABILITY_ZERO;
> +		break;
> +	case TPM_I2C_INTERFACE_CAPABILITY:
> +		zero_mask = TPM_I2C_INTERFACE_CAPABILITY_ZERO;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (unlikely((value & zero_mask) != 0x00)) {
> +		pr_debug("TPM I2C read of register 0x%02x failed sanity check: 0x%x\n", reg, value);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
> +				  u8 *result, enum tpm_tis_io_mode io_mode)
> +{
> +	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +	struct i2c_msg msg = { .addr = phy->i2c_client->addr };
> +	u8 reg = address_to_register(addr);
> +	int i = 0;
> +	int ret;
> +
> +	do {
> +		/* write register */
> +		msg.len = sizeof(reg);
> +		msg.buf = &reg;
> +		msg.flags = 0;
> +		ret = retry_i2c_transfer_until_ack(data, &msg);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* read data */
> +		msg.buf = result;
> +		msg.len = len;
> +		msg.flags = I2C_M_RD;
> +		ret = retry_i2c_transfer_until_ack(data, &msg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = sanity_check_read(reg, len, result);
> +		if (ret == 0)
> +			return 0;
> +
> +		usleep_range(GUARD_TIME_ERR_MIN, GUARD_TIME_ERR_MAX);
> +	} while (i++ < TPM_RETRY);
> +
> +	return ret;
> +}
> +
> +static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
> +				   const u8 *value,
> +				   enum tpm_tis_io_mode io_mode)
> +{
> +	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +	struct i2c_msg msg = { .addr = phy->i2c_client->addr };
> +	u8 reg = address_to_register(addr);
> +	int ret;
> +
> +	if (len > TPM_BUFSIZE - 1)
> +		return -EIO;
> +
> +	/* write register and data in one go */
> +	phy->io_buf[0] = reg;
> +	memcpy(phy->io_buf + sizeof(reg), value, len);
> +
> +	msg.len = sizeof(reg) + len;
> +	msg.buf = phy->io_buf;
> +	ret = retry_i2c_transfer_until_ack(data, &msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int init_guard_time(struct tpm_tis_i2c_phy *phy)
> +{
> +	u32 i2c_caps;
> +	int ret;
> +
> +	phy->guard_time_read = true;
> +	phy->guard_time_write = true;
> +	phy->guard_time_min = GUARD_TIME_DEFAULT_MIN;
> +	phy->guard_time_max = GUARD_TIME_DEFAULT_MAX;
> +
> +	ret = tpm_tis_i2c_read_bytes(&phy->priv, TPM_I2C_INTERFACE_CAPABILITY,
> +				     sizeof(i2c_caps), (u8 *)&i2c_caps,
> +				     TPM_TIS_PHYS_32);
> +	if (ret)
> +		return ret;
> +
> +	phy->guard_time_read = (i2c_caps & TPM_GUARD_TIME_RR_MASK) ||
> +			       (i2c_caps & TPM_GUARD_TIME_RW_MASK);
> +	phy->guard_time_write = (i2c_caps & TPM_GUARD_TIME_WR_MASK) ||
> +				(i2c_caps & TPM_GUARD_TIME_WW_MASK);
> +	phy->guard_time_min = (i2c_caps & TPM_GUARD_TIME_MIN_MASK) >>
> +			      TPM_GUARD_TIME_MIN_SHIFT;
> +	/* guard_time_max = guard_time_min * 1.2 */
> +	phy->guard_time_max = phy->guard_time_min + phy->guard_time_min / 5;
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +
> +static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
> +	.read_bytes = tpm_tis_i2c_read_bytes,
> +	.write_bytes = tpm_tis_i2c_write_bytes,
> +};
> +
> +static int tpm_tis_i2c_probe(struct i2c_client *dev,
> +			     const struct i2c_device_id *id)
> +{
> +	struct tpm_tis_i2c_phy *phy;
> +	const u8 locality = 0;
> +	int ret;
> +
> +	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_i2c_phy),
> +			   GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->io_buf = devm_kzalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
> +	if (!phy->io_buf)
> +		return -ENOMEM;
> +
> +	phy->i2c_client = dev;
> +
> +	/* must precede all communication with the tpm */
> +	ret = init_guard_time(phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = tpm_tis_i2c_write_bytes(&phy->priv, TPM_LOC_SEL, sizeof(locality),
> +				      &locality, TPM_TIS_PHYS_8);
> +	if (ret)
> +		return ret;
> +
> +	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_ops,
> +				 NULL);
> +}
> +
> +static int tpm_tis_i2c_remove(struct i2c_client *client)
> +{
> +	struct tpm_chip *chip = i2c_get_clientdata(client);
> +
> +	tpm_chip_unregister(chip);
> +	tpm_tis_remove(chip);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id tpm_tis_i2c_id[] = {
> +	{ "tpm_tis_i2c", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> +
> +static const struct of_device_id of_tis_i2c_match[] = {
> +	{ .compatible = "infineon,slb9673", },
> +	{ .compatible = "tcg,tpm-tis-i2c", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> +
> +static struct i2c_driver tpm_tis_i2c_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "tpm_tis_i2c",
> +		.pm = &tpm_tis_pm,
> +		.of_match_table = of_match_ptr(of_tis_i2c_match),
> +	},
> +	.probe = tpm_tis_i2c_probe,
> +	.remove = tpm_tis_i2c_remove,
> +	.id_table = tpm_tis_i2c_id,
> +};
> +module_i2c_driver(tpm_tis_i2c_driver);
> +
> +MODULE_DESCRIPTION("TPM Driver for native I2C access");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

BR, Jarkko
