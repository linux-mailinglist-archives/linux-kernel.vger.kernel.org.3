Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55FD5714C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiGLIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiGLIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:38:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DCBC23;
        Tue, 12 Jul 2022 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657615124; x=1689151124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ZoVk6RthLViHsyNCIRjtfOPZK/QZO4iMEC17tmb57A=;
  b=OqFKq+dGTfcn2i7XqFQnAuiuAK5dF7QO0JmO57Fyd7EO5pgcBNocOb9h
   G869Phifm7x0Z+y4xE/OUNwNwRA/gbhaDhut/67kCaCMoxXBbpwk+nHW4
   KbQUBLohAs0edd0oJzYKM7x3z88YyXsFno5NkCHoRZ3awHEFnCX2ctK9R
   8o0bLgQrMUzgHyo2MxuBvkc52LaYyLWrb3yJ0Hc71V4m+ZfmDTdma635L
   dC1WqW2XZTg/rLeUYxWXKTV6O1w1z1QOmllsQR84+X0LJNv5FVM8I3TTr
   AX4gs8WWmGuQIpkgy+V1VV5GvxZiM6MXHkawCh2ZkhM+QI36Z7Dt2SFce
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="371184545"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="371184545"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="737403984"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Jul 2022 01:38:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Jul 2022 11:38:39 +0300
Date:   Tue, 12 Jul 2022 11:38:39 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v2 3/4] usb: typec: ucsi: stm32g0: add bootloader support
Message-ID: <Ys0zD9tiqzEmmGXa@kuha.fi.intel.com>
References: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
 <20220711120122.25804-4-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711120122.25804-4-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 11, 2022 at 02:01:21PM +0200, Fabrice Gasnier kirjoitti:
> STM32G0 comes with STM32 bootloader in its system memory. Add support
> for some I2C bootloader commands as described in application notes
> AN2606 and AN4221, to enable STM32G0 UCSI firmware update.
> 
> Upon probing, the driver needs to know the STM32G0 state:
> - In bootloader mode, STM32 G0 answers at i2c addr 0x51.
> - In running mode, STM32 G0 firmware may answer at two address.
>   - The main address specified in DT is used for UCSI.
>   - 0x51 addr can be re-used for FW controls like getting software version
>     or jump to booloader request.
> 
> So probe using the main firmware i2c address first, before attempting
> bootloader address (e.g. check for blank, erased or previously aborted
> firmware update).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in V2:
> - use kmalloc instead of kzalloc (update since Christophe's remarks on
>   previous patch)
> ---
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 533 +++++++++++++++++++++++++-
>  1 file changed, 520 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index bb5271bf7cdcf..b1d891c9a92c0 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -6,21 +6,324 @@
>   * Author: Fabrice Gasnier <fabrice.gasnier@foss.st.com>.
>   */
>  
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <asm/unaligned.h>
>  
>  #include "ucsi.h"
>  
> +/* STM32G0 I2C bootloader addr: 0b1010001x (See AN2606) */
> +#define STM32G0_I2C_BL_ADDR	(0xa2 >> 1)
> +
> +/* STM32G0 I2C bootloader max data size */
> +#define STM32G0_I2C_BL_SZ	256
> +
> +/* STM32 I2C bootloader commands (See AN4221) */
> +#define STM32_CMD_GVR		0x01	/* Gets the bootloader version */
> +#define STM32_CMD_GVR_LEN	1
> +#define STM32_CMD_RM		0x11	/* Reag memory */
> +#define STM32_CMD_WM		0x31	/* Write memory */
> +#define STM32_CMD_ADDR_LEN	5	/* Address len for go, mem write... */
> +#define STM32_CMD_ERASE		0x44	/* Erase page, bank or all */
> +#define STM32_CMD_ERASE_SPECIAL_LEN	3
> +#define STM32_CMD_GLOBAL_MASS_ERASE	0xffff /* All-bank erase */
> +
> +/* STM32 I2C bootloader answer status */
> +#define STM32G0_I2C_BL_ACK	0x79
> +#define STM32G0_I2C_BL_NACK	0x1f
> +#define STM32G0_I2C_BL_BUSY	0x76
> +
> +/* STM32G0 flash definitions */
> +#define STM32G0_USER_OPTION_BYTES	0x1fff7800
> +#define STM32G0_USER_OB_NBOOT0		BIT(26)
> +#define STM32G0_USER_OB_NBOOT_SEL	BIT(24)
> +#define STM32G0_USER_OB_BOOT_MAIN	(STM32G0_USER_OB_NBOOT0 | STM32G0_USER_OB_NBOOT_SEL)
> +#define STM32G0_MAIN_MEM_ADDR		0x08000000
> +
> +/* STM32 Firmware definitions: additional commands */
> +#define STM32G0_FW_GETVER	0x00	/* Gets the firmware version */
> +#define STM32G0_FW_GETVER_LEN	4
> +#define STM32G0_FW_RSTGOBL	0x21	/* Reset and go to bootloader */
> +#define STM32G0_FW_KEYWORD	0xa56959a6
> +
> +/* ucsi_stm32g0_fw_info located at the end of the firmware */
> +struct ucsi_stm32g0_fw_info {
> +	u32 version;
> +	u32 keyword;
> +};
> +
>  struct ucsi_stm32g0 {
>  	struct i2c_client *client;
> +	struct i2c_client *i2c_bl;
> +	bool in_bootloader;
> +	u8 bl_version;
>  	struct completion complete;
>  	struct device *dev;
>  	unsigned long flags;
> +	const char *fw_name;
>  	struct ucsi *ucsi;
>  };
>  
> +/*
> + * Bootloader commands helpers:
> + * - send command (2 bytes)
> + * - check ack
> + * Then either:
> + * - receive data
> + * - receive data + check ack
> + * - send data + check ack
> + * These operations depends on the command and have various length.
> + */
> +static int ucsi_stm32g0_bl_check_ack(struct ucsi *ucsi)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->i2c_bl;
> +	unsigned char ack;
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags  = I2C_M_RD,
> +			.len	= 1,
> +			.buf	= &ack,
> +		},
> +	};
> +	int ret;
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(g0->dev, "i2c bl ack (%02x), error: %d\n", client->addr, ret);
> +
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	/* The 'ack' byte should contain bootloader answer: ack/nack/busy */
> +	switch (ack) {
> +	case STM32G0_I2C_BL_ACK:
> +		return 0;
> +	case STM32G0_I2C_BL_NACK:
> +		return -ENOENT;
> +	case STM32G0_I2C_BL_BUSY:
> +		return -EBUSY;
> +	default:
> +		dev_err(g0->dev, "i2c bl ack (%02x), invalid byte: %02x\n",
> +			client->addr, ack);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ucsi_stm32g0_bl_cmd_check_ack(struct ucsi *ucsi, unsigned int cmd, bool check_ack)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->i2c_bl;
> +	unsigned char buf[2];
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags  = 0,
> +			.len	= sizeof(buf),
> +			.buf	= buf,
> +		},
> +	};
> +	int ret;
> +
> +	/*
> +	 * Send STM32 bootloader command format is two bytes:
> +	 * - command code
> +	 * - XOR'ed command code
> +	 */
> +	buf[0] = cmd;
> +	buf[1] = cmd ^ 0xff;
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_dbg(g0->dev, "i2c bl cmd %d (%02x), error: %d\n", cmd, client->addr, ret);
> +
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	if (check_ack)
> +		return ucsi_stm32g0_bl_check_ack(ucsi);
> +
> +	return 0;
> +}
> +
> +static int ucsi_stm32g0_bl_cmd(struct ucsi *ucsi, unsigned int cmd)
> +{
> +	return ucsi_stm32g0_bl_cmd_check_ack(ucsi, cmd, true);
> +}
> +
> +static int ucsi_stm32g0_bl_rcv_check_ack(struct ucsi *ucsi, void *data, size_t len, bool check_ack)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->i2c_bl;
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags  = I2C_M_RD,
> +			.len	= len,
> +			.buf	= data,
> +		},
> +	};
> +	int ret;
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(g0->dev, "i2c bl rcv %02x, error: %d\n", client->addr, ret);
> +
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	if (check_ack)
> +		return ucsi_stm32g0_bl_check_ack(ucsi);
> +
> +	return 0;
> +}
> +
> +static int ucsi_stm32g0_bl_rcv(struct ucsi *ucsi, void *data, size_t len)
> +{
> +	return ucsi_stm32g0_bl_rcv_check_ack(ucsi, data, len, true);
> +}
> +
> +static int ucsi_stm32g0_bl_rcv_woack(struct ucsi *ucsi, void *data, size_t len)
> +{
> +	return ucsi_stm32g0_bl_rcv_check_ack(ucsi, data, len, false);
> +}
> +
> +static int ucsi_stm32g0_bl_send(struct ucsi *ucsi, void *data, size_t len)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->i2c_bl;
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags  = 0,
> +			.len	= len,
> +			.buf	= data,
> +		},
> +	};
> +	int ret;
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(g0->dev, "i2c bl send %02x, error: %d\n", client->addr, ret);
> +
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	return ucsi_stm32g0_bl_check_ack(ucsi);
> +}
> +
> +/* Bootloader commands */
> +static int ucsi_stm32g0_bl_get_version(struct ucsi *ucsi, u8 *bl_version)
> +{
> +	int ret;
> +
> +	ret = ucsi_stm32g0_bl_cmd(ucsi, STM32_CMD_GVR);
> +	if (ret)
> +		return ret;
> +
> +	return ucsi_stm32g0_bl_rcv(ucsi, bl_version, STM32_CMD_GVR_LEN);
> +}
> +
> +static int ucsi_stm32g0_bl_send_addr(struct ucsi *ucsi, u32 addr)
> +{
> +	u8 data8[STM32_CMD_ADDR_LEN];
> +
> +	/* Address format: 4 bytes addr (MSB first) + XOR'ed addr bytes */
> +	put_unaligned_be32(addr, data8);
> +	data8[4] = data8[0] ^ data8[1] ^ data8[2] ^ data8[3];
> +
> +	return ucsi_stm32g0_bl_send(ucsi, data8, STM32_CMD_ADDR_LEN);
> +}
> +
> +static int ucsi_stm32g0_bl_global_mass_erase(struct ucsi *ucsi)
> +{
> +	u8 data8[4];
> +	u16 *data16 = (u16 *)&data8[0];
> +	int ret;
> +
> +	data16[0] = STM32_CMD_GLOBAL_MASS_ERASE;
> +	data8[2] = data8[0] ^ data8[1];
> +
> +	ret = ucsi_stm32g0_bl_cmd(ucsi, STM32_CMD_ERASE);
> +	if (ret)
> +		return ret;
> +
> +	return ucsi_stm32g0_bl_send(ucsi, data8, STM32_CMD_ERASE_SPECIAL_LEN);
> +}
> +
> +static int ucsi_stm32g0_bl_write(struct ucsi *ucsi, u32 addr, const void *data, size_t len)
> +{
> +	u8 *data8;
> +	int i, ret;
> +
> +	if (!len || len > STM32G0_I2C_BL_SZ)
> +		return -EINVAL;
> +
> +	/* Write memory: len bytes -1, data up to 256 bytes + XOR'ed bytes */
> +	data8 = kmalloc(STM32G0_I2C_BL_SZ + 2, GFP_KERNEL);
> +	if (!data8)
> +		return -ENOMEM;
> +
> +	ret = ucsi_stm32g0_bl_cmd(ucsi, STM32_CMD_WM);
> +	if (ret)
> +		goto free;
> +
> +	ret = ucsi_stm32g0_bl_send_addr(ucsi, addr);
> +	if (ret)
> +		goto free;
> +
> +	data8[0] = len - 1;
> +	memcpy(data8 + 1, data, len);
> +	data8[len + 1] = data8[0];
> +	for (i = 1; i <= len; i++)
> +		data8[len + 1] ^= data8[i];
> +
> +	ret = ucsi_stm32g0_bl_send(ucsi, data8, len + 2);
> +free:
> +	kfree(data8);
> +
> +	return ret;
> +}
> +
> +static int ucsi_stm32g0_bl_read(struct ucsi *ucsi, u32 addr, void *data, size_t len)
> +{
> +	int ret;
> +
> +	if (!len || len > STM32G0_I2C_BL_SZ)
> +		return -EINVAL;
> +
> +	ret = ucsi_stm32g0_bl_cmd(ucsi, STM32_CMD_RM);
> +	if (ret)
> +		return ret;
> +
> +	ret = ucsi_stm32g0_bl_send_addr(ucsi, addr);
> +	if (ret)
> +		return ret;
> +
> +	ret = ucsi_stm32g0_bl_cmd(ucsi, len - 1);
> +	if (ret)
> +		return ret;
> +
> +	return ucsi_stm32g0_bl_rcv_woack(ucsi, data, len);
> +}
> +
> +/* Firmware commands (the same address as the bootloader) */
> +static int ucsi_stm32g0_fw_cmd(struct ucsi *ucsi, unsigned int cmd)
> +{
> +	return ucsi_stm32g0_bl_cmd_check_ack(ucsi, cmd, false);
> +}
> +
> +static int ucsi_stm32g0_fw_rcv(struct ucsi *ucsi, void *data, size_t len)
> +{
> +	return ucsi_stm32g0_bl_rcv_woack(ucsi, data, len);
> +}
> +
> +/* UCSI ops */
>  static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t len)
>  {
>  	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> @@ -133,6 +436,191 @@ static const struct ucsi_operations ucsi_stm32g0_ops = {
>  	.async_write = ucsi_stm32g0_async_write,
>  };
>  
> +static int ucsi_stm32g0_register(struct ucsi *ucsi)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->client;
> +	int ret;
> +
> +	/* Request alert interrupt */
> +	ret = request_threaded_irq(client->irq, NULL, ucsi_stm32g0_irq_handler, IRQF_ONESHOT,
> +				   dev_name(g0->dev), g0);
> +	if (ret) {
> +		dev_err(g0->dev, "request IRQ failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ucsi_register(ucsi);
> +	if (ret) {
> +		dev_err_probe(g0->dev, ret, "ucsi_register failed\n");
> +		free_irq(client->irq, g0);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ucsi_stm32g0_unregister(struct ucsi *ucsi)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->client;
> +
> +	ucsi_unregister(ucsi);
> +	free_irq(client->irq, g0);
> +}
> +
> +static void ucsi_stm32g0_fw_cb(const struct firmware *fw, void *context)
> +{
> +	struct ucsi_stm32g0 *g0;
> +	const u8 *data, *end;
> +	const struct ucsi_stm32g0_fw_info *fw_info;
> +	u32 addr = STM32G0_MAIN_MEM_ADDR, ob, fw_version;
> +	int ret, size;
> +
> +	if (!context)
> +		return;
> +
> +	g0 = ucsi_get_drvdata(context);
> +
> +	if (!fw)
> +		goto fw_release;
> +
> +	fw_info = (struct ucsi_stm32g0_fw_info *)(fw->data + fw->size - sizeof(*fw_info));
> +
> +	if (!g0->in_bootloader) {
> +		/* Read running firmware version */
> +		ret = ucsi_stm32g0_fw_cmd(g0->ucsi, STM32G0_FW_GETVER);
> +		if (ret) {
> +			dev_err(g0->dev, "Get version cmd failed %d\n", ret);
> +			goto fw_release;
> +		}
> +		ret = ucsi_stm32g0_fw_rcv(g0->ucsi, &fw_version,
> +					  STM32G0_FW_GETVER_LEN);
> +		if (ret) {
> +			dev_err(g0->dev, "Get version failed %d\n", ret);
> +			goto fw_release;
> +		}
> +
> +		/* Sanity check on keyword and firmware version */
> +		if (fw_info->keyword != STM32G0_FW_KEYWORD || fw_info->version == fw_version)
> +			goto fw_release;
> +
> +		dev_info(g0->dev, "Flashing FW: %08x (%08x cur)\n", fw_info->version, fw_version);
> +
> +		/* Switch to bootloader mode */
> +		ucsi_stm32g0_unregister(g0->ucsi);
> +		ret = ucsi_stm32g0_fw_cmd(g0->ucsi, STM32G0_FW_RSTGOBL);
> +		if (ret) {
> +			dev_err(g0->dev, "bootloader cmd failed %d\n", ret);
> +			goto fw_release;
> +		}
> +		g0->in_bootloader = true;
> +
> +		/* STM32G0 reboot delay */
> +		msleep(100);
> +	}
> +
> +	ret = ucsi_stm32g0_bl_global_mass_erase(g0->ucsi);
> +	if (ret) {
> +		dev_err(g0->dev, "Erase failed %d\n", ret);
> +		goto fw_release;
> +	}
> +
> +	data = fw->data;
> +	end = fw->data + fw->size;
> +	while (data < end) {
> +		if ((end - data) < STM32G0_I2C_BL_SZ)
> +			size = end - data;
> +		else
> +			size = STM32G0_I2C_BL_SZ;
> +
> +		ret = ucsi_stm32g0_bl_write(g0->ucsi, addr, data, size);
> +		if (ret) {
> +			dev_err(g0->dev, "Write failed %d\n", ret);
> +			goto fw_release;
> +		}
> +		addr += size;
> +		data += size;
> +	}
> +
> +	dev_dbg(g0->dev, "Configure to boot from main flash\n");
> +
> +	ret = ucsi_stm32g0_bl_read(g0->ucsi, STM32G0_USER_OPTION_BYTES, &ob, sizeof(ob));
> +	if (ret) {
> +		dev_err(g0->dev, "read user option bytes failed %d\n", ret);
> +		goto fw_release;
> +	}
> +
> +	dev_dbg(g0->dev, "STM32G0_USER_OPTION_BYTES 0x%08x\n", ob);
> +
> +	/* Configure user option bytes to boot from main flash next time */
> +	ob |= STM32G0_USER_OB_BOOT_MAIN;
> +
> +	/* Writing option bytes will also reset G0 for updates to be loaded */
> +	ret = ucsi_stm32g0_bl_write(g0->ucsi, STM32G0_USER_OPTION_BYTES, &ob, sizeof(ob));
> +	if (ret) {
> +		dev_err(g0->dev, "write user option bytes failed %d\n", ret);
> +		goto fw_release;
> +	}
> +
> +	dev_info(g0->dev, "Starting, option bytes:0x%08x\n", ob);
> +
> +	/* STM32G0 FW boot delay */
> +	msleep(500);
> +
> +	/* Register UCSI interface */
> +	if (!ucsi_stm32g0_register(g0->ucsi))
> +		g0->in_bootloader = false;
> +
> +fw_release:
> +	release_firmware(fw);
> +}
> +
> +static int ucsi_stm32g0_probe_bootloader(struct ucsi *ucsi)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	int ret;
> +	u16 ucsi_version;
> +
> +	/* firmware-name is optional */
> +	if (device_property_present(g0->dev, "firmware-name")) {
> +		ret = device_property_read_string(g0->dev, "firmware-name", &g0->fw_name);
> +		if (ret < 0)
> +			return dev_err_probe(g0->dev, ret, "Error reading firmware-name\n");
> +	}
> +
> +	if (g0->fw_name) {
> +		/* STM32G0 in bootloader mode communicates at reserved address 0x51 */
> +		g0->i2c_bl = i2c_new_dummy_device(g0->client->adapter, STM32G0_I2C_BL_ADDR);
> +		if (IS_ERR(g0->i2c_bl)) {
> +			ret = dev_err_probe(g0->dev, PTR_ERR(g0->i2c_bl),
> +					    "Failed to register booloader I2C address\n");
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Try to guess if the STM32G0 is running a UCSI firmware. First probe the UCSI FW at its
> +	 * i2c address. Fallback to bootloader i2c address only if firmware-name is specified.
> +	 */
> +	ret = ucsi_stm32g0_read(ucsi, UCSI_VERSION, &ucsi_version, sizeof(ucsi_version));
> +	if (!ret || !g0->fw_name)
> +		return ret;
> +
> +	/* Speculatively read the bootloader version that has a known length. */
> +	ret = ucsi_stm32g0_bl_get_version(ucsi, &g0->bl_version);
> +	if (ret < 0) {
> +		i2c_unregister_device(g0->i2c_bl);
> +		return ret;
> +	}
> +
> +	/* Device in bootloader mode */
> +	g0->in_bootloader = true;
> +	dev_info(g0->dev, "Bootloader Version 0x%02x\n", g0->bl_version);
> +
> +	return 0;
> +}
> +
>  static int ucsi_stm32g0_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct device *dev = &client->dev;
> @@ -154,24 +642,41 @@ static int ucsi_stm32g0_probe(struct i2c_client *client, const struct i2c_device
>  
>  	ucsi_set_drvdata(g0->ucsi, g0);
>  
> -	/* Request alert interrupt */
> -	ret = request_threaded_irq(client->irq, NULL, ucsi_stm32g0_irq_handler, IRQF_ONESHOT,
> -				   dev_name(&client->dev), g0);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "request IRQ failed\n");
> +	ret = ucsi_stm32g0_probe_bootloader(g0->ucsi);
> +	if (ret < 0)
>  		goto destroy;
> +
> +	/*
> +	 * Don't register in bootloader mode: wait for the firmware to be loaded and started before
> +	 * registering UCSI device.
> +	 */
> +	if (!g0->in_bootloader) {
> +		ret = ucsi_stm32g0_register(g0->ucsi);
> +		if (ret < 0)
> +			goto freei2c;
>  	}
>  
> -	ret = ucsi_register(g0->ucsi);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "ucsi_register failed\n");
> -		goto freeirq;
> +	if (g0->fw_name) {
> +		/*
> +		 * Asynchronously flash (e.g. bootloader mode) or update the running firmware,
> +		 * not to hang the boot process
> +		 */
> +		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT, g0->fw_name, g0->dev,
> +					      GFP_KERNEL, g0->ucsi, ucsi_stm32g0_fw_cb);
> +		if (ret < 0) {
> +			dev_err_probe(dev, ret, "firmware request failed\n");
> +			goto unregister;
> +		}
>  	}
>  
>  	return 0;
>  
> -freeirq:
> -	free_irq(client->irq, g0);
> +unregister:
> +	if (!g0->in_bootloader)
> +		ucsi_stm32g0_unregister(g0->ucsi);
> +freei2c:
> +	if (g0->fw_name)
> +		i2c_unregister_device(g0->i2c_bl);
>  destroy:
>  	ucsi_destroy(g0->ucsi);
>  
> @@ -182,8 +687,10 @@ static int ucsi_stm32g0_remove(struct i2c_client *client)
>  {
>  	struct ucsi_stm32g0 *g0 = i2c_get_clientdata(client);
>  
> -	ucsi_unregister(g0->ucsi);
> -	free_irq(client->irq, g0);
> +	if (!g0->in_bootloader)
> +		ucsi_stm32g0_unregister(g0->ucsi);
> +	if (g0->fw_name)
> +		i2c_unregister_device(g0->i2c_bl);
>  	ucsi_destroy(g0->ucsi);
>  
>  	return 0;
> -- 
> 2.25.1

-- 
heikki
