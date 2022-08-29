Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351B85A43CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiH2HfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiH2HfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:35:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB4659F;
        Mon, 29 Aug 2022 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661758519; x=1693294519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUB6493Q1pZjoX9Bwip7PW18Z1ZeqNdC0dzgAAKfa84=;
  b=Q4I4KS+5Nm65dFy0A0PjH91OkuNX3Zl/P8XAo+MRRf06vbu5j1oQCo05
   +lpssY44S+xyWqg6CESx035X+vAZ+DF/v+YFGq5nQ/J7VOL5RUsROrbfn
   NO2Z5wPo9LSL0LDwrkdiNtxr6pqodSpiPFY5Gr8rPNUYJY1IQo78rV0Bw
   CVgTvCJf8T3ODvLNKQ69etLolGLmE71d2qqBvsLG6zxLMBwbLOdZBhr9R
   I3ghLfniPNqMphfwJ4073HUhhPWLgHc293lSqL2dv4CXRleL1+iAc5Wo0
   WC9yM1sVgkaA3v9g7K9RVVo9an27Q2Cs+AYZkGeYlzuujkLVszVNPBBv9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="274582402"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="274582402"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="588065545"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2022 00:34:59 -0700
Date:   Mon, 29 Aug 2022 15:25:41 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v8 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Ywxp9XgcjM0LIIC2@yilunxu-OptiPlex-7050>
References: <20220825112433.14583-1-i.bornyakov@metrotek.ru>
 <20220825112433.14583-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825112433.14583-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-25 at 14:24:32 +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
> FPGAs over slave SPI sysCONFIG interface.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/Kconfig                 |   7 +
>  drivers/fpga/Makefile                |   1 +
>  drivers/fpga/lattice-sysconfig-spi.c | 630 +++++++++++++++++++++++++++
>  3 files changed, 638 insertions(+)
>  create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 6c416955da53..991d9d976dca 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -263,4 +263,11 @@ config FPGA_MGR_MICROCHIP_SPI
>  	  programming over slave SPI interface with .dat formatted
>  	  bitstream image.
>  
> +config FPGA_MGR_LATTICE_SPI
> +	tristate "Lattice sysCONFIG SPI FPGA manager"
> +	depends on SPI
> +	help
> +	  FPGA manager driver support for Lattice FPGAs programming over slave
> +	  SPI sysCONFIG interface.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 42ae8b58abce..115dba916024 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
>  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> +obj-$(CONFIG_FPGA_MGR_LATTICE_SPI)	+= lattice-sysconfig-spi.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>  
> diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
> new file mode 100644
> index 000000000000..145b5b27b88d
> --- /dev/null
> +++ b/drivers/fpga/lattice-sysconfig-spi.c
> @@ -0,0 +1,630 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lattice FPGA programming over slave SPI sysCONFIG interface.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/of_device.h>
> +#include <linux/spi/spi.h>
> +
> +#define	SYSCONFIG_ISC_ENABLE		{0xC6, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_ISC_DISABLE		{0x26, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_ISC_ERASE		{0x0E, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_ISC_PROGRAM_DONE	{0x5E, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_READ_STATUS	{0x3C, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_CHECK_BUSY	{0xF0, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_INIT_ADDR		{0x46, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_BITSTREAM_BURST	{0x7a, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_PROG_INCR_NV	{0x70, 0x00, 0x00, 0x01}
> +
> +#define	SYSCONFIG_STATUS_DONE		BIT(8)
> +#define	SYSCONFIG_STATUS_BUSY		BIT(12)
> +#define	SYSCONFIG_STATUS_FAIL		BIT(13)
> +#define	SYSCONFIG_STATUS_ERR		(BIT(23) | BIT(24) | BIT(25))
> +
> +#define	SYSCONFIG_POLL_RETRIES		100000
> +
> +#define	ECP5_SPI_MAX_SPEED_HZ		60000000
> +#define	ECP5_ISC_ERASE_OPERAND		0x01
> +
> +#define	MACHXO2_SPI_MAX_SPEED_HZ	66000000
> +#define	MACHXO2_PAGE_SIZE		16
> +#define	MACHXO2_ISC_ENABLE_OPERAND	0x08
> +#define	MACHXO2_ISC_ERASE_OPERAND	0x04

You need to deliver the meaning of each operand, rather than just point
out this is for machxo2, that is for esp5. I assume the sysCONFIG will
not deliberately design different commands with the exact same
functionality for different boards.

We should have a set of common configurations with finer granularity that
board specific fpga manager device could select from, rather than create
more and more similar macros for each new board.

Back to the 2 operands, what's the meaning of 0x1 & 0x4 for erase, also
0x0 & 0x8 for enable?

> +
> +struct sysconfig_priv {
> +	struct gpio_desc *program;
> +	struct gpio_desc *init;
> +	struct gpio_desc *done;
> +	struct spi_device *spi;
> +	u8 isc_enable_operand;
> +	u8 isc_erase_operand;
> +};
> +
> +static int sysconfig_poll_busy(struct sysconfig_priv *data)
> +{
> +	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
> +	int ret, retries = SYSCONFIG_POLL_RETRIES;
> +	u8 busy;
> +
> +	while (retries--) {
> +		ret = spi_write_then_read(data->spi,
> +					  lsc_check_busy, sizeof(lsc_check_busy),
> +					  &busy, sizeof(busy));
> +		if (ret)
> +			return ret;
> +
> +		if (!busy)
> +			return 0;
> +
> +		usleep_range(50, 100);
> +	}
> +
> +	return -EBUSY;
> +}
> +
> +static int sysconfig_read_status(struct sysconfig_priv *data, u32 *status)
> +{
> +	const u8 lsc_read_status[] = SYSCONFIG_LSC_READ_STATUS;
> +	__be32 device_status;
> +	int ret;
> +
> +	ret = spi_write_then_read(data->spi,
> +				  lsc_read_status, sizeof(lsc_read_status),
> +				  &device_status, sizeof(device_status));
> +	if (ret)
> +		return ret;
> +
> +	*status = be32_to_cpu(device_status);
> +
> +	return 0;
> +}
> +
> +static int sysconfig_poll_status(struct sysconfig_priv *data, u32 *status)
> +{
> +	int ret;
> +
> +	ret = sysconfig_poll_busy(data);
> +	if (ret)
> +		return ret;
> +
> +	return sysconfig_read_status(data, status);
> +}
> +
> +static int sysconfig_poll_gpio(struct gpio_desc *gpio, bool is_active)
> +{
> +	int value, retries = SYSCONFIG_POLL_RETRIES;
> +
> +	while (retries--) {
> +		value = gpiod_get_value(gpio);
> +		if (value < 0)
> +			return value;
> +
> +		if ((!is_active && !value) || (is_active && value))
> +			return 0;
> +
> +		ndelay(10);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int sysconfig_refresh(struct sysconfig_priv *data)
> +{
> +	static const u8 lsc_refresh[] = SYSCONFIG_LSC_REFRESH;
> +	int ret;
> +
> +	ret = spi_write(data->spi, lsc_refresh, sizeof(lsc_refresh));
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(4000, 8000);
> +
> +	return 0;
> +}
> +
> +static int sysconfig_isc_enable(struct sysconfig_priv *data)
> +{
> +	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
> +	u32 status;
> +	int ret;
> +
> +	isc_enable[1] = data->isc_enable_operand;
> +
> +	ret = spi_write(data->spi, isc_enable, sizeof(isc_enable));
> +	if (ret)
> +		return ret;
> +
> +	ret = sysconfig_poll_status(data, &status);
> +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> +		return ret ? : -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int sysconfig_isc_erase(struct sysconfig_priv *data)
> +{
> +	u8 isc_erase[] = SYSCONFIG_ISC_ERASE;
> +	u32 status;
> +	int ret;
> +
> +	isc_erase[1] = data->isc_erase_operand;
> +
> +	ret = spi_write(data->spi, isc_erase, sizeof(isc_erase));
> +	if (ret)
> +		return ret;
> +
> +	ret = sysconfig_poll_status(data, &status);
> +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> +		return ret ? : -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int sysconfig_isc_init(struct sysconfig_priv *data)
> +{
> +	int ret;
> +
> +	ret = sysconfig_isc_enable(data);
> +	if (ret)
> +		return ret;
> +
> +	return sysconfig_isc_erase(data);
> +}
> +
> +static int sysconfig_lsc_init_addr(struct sysconfig_priv *data)
> +{
> +	const u8 lsc_init_addr[] = SYSCONFIG_LSC_INIT_ADDR;
> +
> +	return spi_write(data->spi, lsc_init_addr, sizeof(lsc_init_addr));
> +}
> +
> +static int sysconfig_lsc_bitstream_burst(struct sysconfig_priv *data)
> +{
> +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> +	struct spi_transfer xfer = {
> +		.tx_buf = lsc_bitstream_burst,
> +		.len = sizeof(lsc_bitstream_burst),
> +		.cs_change = 1,
> +	};
> +	struct spi_message msg;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +
> +	return spi_sync_locked(data->spi, &msg);
> +}
> +
> +static int sysconfig_isc_prog_done(struct sysconfig_priv *data)
> +{
> +	const u8 isc_prog_done[] = SYSCONFIG_ISC_PROGRAM_DONE;
> +	u32 status;
> +	int ret;
> +
> +	ret = spi_write(data->spi, isc_prog_done, sizeof(isc_prog_done));
> +	if (ret)
> +		return ret;
> +
> +	ret = sysconfig_poll_status(data, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status & SYSCONFIG_STATUS_DONE)
> +		return 0;
> +
> +	return -EFAULT;
> +}
> +
> +static int sysconfig_isc_disable(struct sysconfig_priv *data)
> +{
> +	const u8 isc_disable[] = SYSCONFIG_ISC_DISABLE;
> +
> +	return spi_write(data->spi, isc_disable, sizeof(isc_disable));
> +}
> +
> +static enum fpga_mgr_states ecp5_ops_state(struct fpga_manager *mgr)
> +{
> +	struct sysconfig_priv *priv = mgr->priv;
> +
> +	return (gpiod_get_value(priv->done) > 0) ? FPGA_MGR_STATE_OPERATING :
> +						   FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int ecp5_ops_write_init(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info,
> +			       const char *buf, size_t count)
> +{
> +	struct sysconfig_priv *priv = mgr->priv;
> +	struct spi_device *spi = priv->spi;
> +	struct device *dev = &mgr->dev;
> +	struct gpio_desc *program;
> +	struct gpio_desc *init;
> +	struct gpio_desc *done;
> +	int ret;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(dev, "Partial reconfiguration is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	program = priv->program;
> +	init = priv->init;
> +	done = priv->done;
> +
> +	/* Enter init mode */
> +	gpiod_set_value(program, 1);

Same concern, provide gpio or command options for all board specific
fpga manager to select. 

I'll not list each features one by one below.

some more comments below.

> +
> +	ret = sysconfig_poll_gpio(init, true);
> +	if (!ret)
> +		ret = sysconfig_poll_gpio(done, false);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to go to init mode\n");
> +		return ret;
> +	}
> +
> +	/* Enter program mode */
> +	gpiod_set_value(program, 0);
> +
> +	ret = sysconfig_poll_gpio(init, false);
> +	if (ret) {
> +		dev_err(dev, "Failed to go to program mode\n");
> +		return ret;
> +	}
> +
> +	/* Enter ISC mode */
> +	ret = sysconfig_isc_init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to go to ISC mode\n");
> +		return ret;
> +	}
> +
> +	/* Initialize the Address Shift Register */
> +	ret = sysconfig_lsc_init_addr(priv);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to initialize the Address Shift Register\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> +	 * SPI bus will be released in ecp5_ops_write_complete() or on error.
> +	 */
> +	spi_bus_lock(spi->controller);
> +
> +	/* Prepare for bitstream burst write */
> +	ret = sysconfig_lsc_bitstream_burst(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to prepare for bitstream burst write\n");
> +		spi_bus_unlock(spi->controller);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ecp5_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct sysconfig_priv *priv = mgr->priv;
> +	struct spi_device *spi = priv->spi;
> +	struct spi_transfer xfer = {
> +		.tx_buf = buf,
> +		.len = count,
> +		.cs_change = 1,
> +	};
> +	struct spi_message msg;
> +	int ret;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +	ret = spi_sync_locked(spi, &msg);
> +	if (ret)
> +		spi_bus_unlock(spi->controller);
> +
> +	return ret;
> +}
> +
> +static int ecp5_ops_write_complete(struct fpga_manager *mgr,
> +				   struct fpga_image_info *info)
> +{
> +	struct sysconfig_priv *priv = mgr->priv;
> +	struct spi_device *spi = priv->spi;
> +	struct device *dev = &mgr->dev;
> +	int ret;
> +
> +	/* Bitstream burst write is done, release SPI bus */
> +	spi_bus_unlock(spi->controller);
> +
> +	/* Toggle CS and wait for bitstream write to finish */
> +	ret = spi_write(spi, NULL, 0);
> +	if (!ret)
> +		ret = sysconfig_poll_busy(priv);
> +
> +	if (ret) {
> +		dev_err(dev, "Error while waiting bitstream write to finish\n");
> +		return ret;
> +	}
> +
> +	/* Exit ISC mode */
> +	ret = sysconfig_isc_disable(priv);
> +	if (!ret)
> +		ret = sysconfig_poll_gpio(priv->done, true);
> +
> +	if (ret)
> +		dev_err(dev, "Failed to finish ISC\n");
> +
> +	return ret;
> +}
> +
> +static const struct fpga_manager_ops ecp5_fpga_ops = {
> +	.state = ecp5_ops_state,
> +	.write_init = ecp5_ops_write_init,
> +	.write = ecp5_ops_write,
> +	.write_complete = ecp5_ops_write_complete,
> +};
> +
> +static int ecp5_probe(struct sysconfig_priv *priv)
> +{
> +	struct spi_device *spi = priv->spi;
> +	struct device *dev = &spi->dev;
> +	struct fpga_manager *mgr;
> +	int ret;
> +
> +	if (spi->max_speed_hz > ECP5_SPI_MAX_SPEED_HZ) {
> +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> +			spi->max_speed_hz, ECP5_SPI_MAX_SPEED_HZ);
> +		return -EINVAL;
> +	}
> +
> +	priv->isc_erase_operand = ECP5_ISC_ERASE_OPERAND;
> +
> +	priv->done = devm_gpiod_get(dev, "done", GPIOD_IN);
> +	if (IS_ERR(priv->done)) {
> +		ret = PTR_ERR(priv->done);
> +		dev_err(dev, "Failed to get DONE GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->init = devm_gpiod_get(dev, "init", GPIOD_IN);
> +	if (IS_ERR(priv->init)) {
> +		ret = PTR_ERR(priv->init);
> +		dev_err(dev, "Failed to get INIT GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->program = devm_gpiod_get(dev, "program", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->program)) {
> +		ret = PTR_ERR(priv->program);
> +		dev_err(dev, "Failed to get PROGRAM GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mgr = devm_fpga_mgr_register(dev, "Lattice ECP5 SPI FPGA Manager",
> +				     &ecp5_fpga_ops, priv);
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> +
> +static enum fpga_mgr_states machxo2_ops_state(struct fpga_manager *mgr)
> +{
> +	struct sysconfig_priv *priv = mgr->priv;
> +	u32 status;
> +	int ret;
> +
> +	ret = sysconfig_read_status(priv, &status);
> +	if (ret || !(status & SYSCONFIG_STATUS_DONE))
> +		return FPGA_MGR_STATE_UNKNOWN;
> +
> +	return FPGA_MGR_STATE_OPERATING;
> +}
> +
> +static int machxo2_ops_write_init(struct fpga_manager *mgr,
> +				  struct fpga_image_info *info,
> +				  const char *buf, size_t count)
> +{
> +	struct sysconfig_priv *priv = mgr->priv;
> +	struct device *dev = &mgr->dev;
> +	int ret;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(dev, "Partial reconfiguration is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Enter ISC mode */
> +	ret = sysconfig_isc_init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to go to ISC mode\n");
> +		return ret;
> +	}
> +
> +	/* Initialize the Address Shift Register */
> +	ret = sysconfig_lsc_init_addr(priv);
> +	if (ret)
> +		dev_err(dev,
> +			"Failed to initialize the Address Shift Register\n");
> +
> +	return ret;
> +}
> +
> +static int machxo2_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	const u8 lsc_progincr[] = SYSCONFIG_LSC_PROG_INCR_NV;
> +	struct sysconfig_priv *priv = mgr->priv;
> +	struct device *dev = &mgr->dev;
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.tx_buf = lsc_progincr,
> +			.len = sizeof(lsc_progincr),
> +		}, {
> +			.len = MACHXO2_PAGE_SIZE,
> +		},
> +	};
> +	size_t i;
> +	int ret;
> +
> +	if (count % MACHXO2_PAGE_SIZE) {
> +		dev_err(dev, "Malformed payload.\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < count; i += MACHXO2_PAGE_SIZE) {
> +		xfers[1].tx_buf = buf + i;
> +
> +		ret = spi_sync_transfer(priv->spi, xfers, 2);
> +		if (!ret)
> +			ret = sysconfig_poll_busy(priv);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to write frame %zu of %zu\n",
> +				i / MACHXO2_PAGE_SIZE, count / MACHXO2_PAGE_SIZE);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void machxo2_cleanup(struct sysconfig_priv *data)
> +{
> +	sysconfig_isc_erase(data);
> +	sysconfig_refresh(data);
> +}
> +
> +static int machxo2_ops_write_complete(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info)
> +{
> +	int ret, retries = SYSCONFIG_POLL_RETRIES;
> +	struct sysconfig_priv *priv = mgr->priv;
> +	struct device *dev = &mgr->dev;
> +	u32 status;
> +
> +	ret = sysconfig_isc_prog_done(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable Self-Download Mode\n");
> +		goto fail;
> +	}
> +
> +	ret = sysconfig_isc_disable(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to disable Configuration Interface\n");
> +		goto fail;
> +	}
> +
> +	while (retries--) {
> +		ret = sysconfig_refresh(priv);
> +		if (!ret)
> +			ret = sysconfig_read_status(priv, &status);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to refresh\n");
> +			break;
> +		}
> +
> +		if (status & SYSCONFIG_STATUS_DONE &&
> +		    !(status & SYSCONFIG_STATUS_BUSY) &&
> +		    !(status & SYSCONFIG_STATUS_ERR))
> +			return 0;
> +	}
> +
> +fail:
> +	machxo2_cleanup(priv);
> +
> +	return -EFAULT;
> +}
> +
> +static const struct fpga_manager_ops machxo2_fpga_ops = {
> +	.state = machxo2_ops_state,
> +	.write_init = machxo2_ops_write_init,
> +	.write = machxo2_ops_write,
> +	.write_complete = machxo2_ops_write_complete,
> +};
> +
> +static int machxo2_probe(struct sysconfig_priv *priv)
> +{
> +	struct spi_device *spi = priv->spi;
> +	struct device *dev = &spi->dev;
> +	struct fpga_manager *mgr;
> +
> +	if (spi->max_speed_hz > MACHXO2_SPI_MAX_SPEED_HZ) {
> +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> +			spi->max_speed_hz, MACHXO2_SPI_MAX_SPEED_HZ);
> +		return -EINVAL;
> +	}
> +
> +	priv->isc_enable_operand = MACHXO2_ISC_ENABLE_OPERAND;
> +	priv->isc_erase_operand = MACHXO2_ISC_ERASE_OPERAND;
> +
> +	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
> +				     &machxo2_fpga_ops, priv);
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> +
> +typedef int (*lattice_fpga_probe_func)(struct sysconfig_priv *);
> +
> +static int sysconfig_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *dev_id;
> +	lattice_fpga_probe_func probe_func;
> +	struct device *dev = &spi->dev;
> +	struct sysconfig_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->spi = spi;
> +
> +	probe_func = of_device_get_match_data(&spi->dev);
> +	if (!probe_func) {
> +		dev_id = spi_get_device_id(spi);
> +		if (!dev_id)
> +			return -ENODEV;
> +
> +		probe_func = (lattice_fpga_probe_func)dev_id->driver_data;
> +	}
> +
> +	if (!probe_func)
> +		return -EINVAL;
> +
> +	return probe_func(priv);
> +}
> +
> +static const struct spi_device_id sysconfig_spi_ids[] = {
> +	{
> +		.name = "ecp5-fpga-mgr",
> +		.driver_data = (kernel_ulong_t)ecp5_probe,
> +	}, {
> +		.name = "machxo2-fpga-mgr",
> +		.driver_data = (kernel_ulong_t)machxo2_probe,

Putting the whole probe flow in driver_data is the same as providing 2
drivers. The purpose is not to put all the code in one file.

Thanks,
Yilun

> +	}, {},
> +};
> +MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
> +
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id sysconfig_of_ids[] = {
> +	{
> +		.compatible = "lattice,ecp5-fpga-mgr",
> +		.data = ecp5_probe,
> +	}, {
> +		.compatible = "lattice,machxo2-fpga-mgr",
> +		.data = machxo2_probe
> +	}, {},
> +};
> +MODULE_DEVICE_TABLE(of, sysconfig_of_ids);
> +#endif /* IS_ENABLED(CONFIG_OF) */
> +
> +static struct spi_driver lattice_sysconfig_driver = {
> +	.probe = sysconfig_probe,
> +	.id_table = sysconfig_spi_ids,
> +	.driver = {
> +		.name = "lattice_sysconfig_spi_fpga_mgr",
> +		.of_match_table = of_match_ptr(sysconfig_of_ids),
> +	},
> +};
> +
> +module_spi_driver(lattice_sysconfig_driver);
> +
> +MODULE_DESCRIPTION("Lattice sysCONFIG Slave SPI FPGA Manager");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.2
> 
> 
