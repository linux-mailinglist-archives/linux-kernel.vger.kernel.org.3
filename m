Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44F4D41A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiCJHOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiCJHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:14:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F8B7C7D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=LVAExn3w5aeNwsHAd7SriaIk6t6xKhhxqhBZamx3rXE=; b=er3xROCz7xDDqsGLVkoYEBukjl
        2XJX9lCBlQFCKQlpD19N6SzaRNkYSqmiypWF74S896vE9uIknI4o4eg7mOpvDEwYSmxqudB3gKcND
        m6LpTHt5k1ChO4+JX2eE7fHjCFNOcw7A1PtoIYYMJ1UwhHylQSrYPVYsOxcjPAZTNLv272I3Y76pQ
        pdGyPeUNtt1VMRmEVqDVVtLdMGmDoBk1qX1rBJ9kRUDzaVCXuRXdvrJDHXDX9GS5RaNWZwTippE0Q
        ffHkISShc9+ntUM/JOmDhsnkFm8mdp9HGYJSGR6flaWW6QmHY3c2BzKW1Ox5i26OLHtYZ/JVQqpHK
        88KvpfAA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSCyy-00H2ob-E7; Thu, 10 Mar 2022 07:13:08 +0000
Message-ID: <3c0422d9-8ce9-64d8-f332-e07bc8e207c4@infradead.org>
Date:   Wed, 9 Mar 2022 23:13:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] drivers: ddcci: upstream DDCCI driver
Content-Language: en-US
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk
References: <20220310055922.459460-1-yusisamerican@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220310055922.459460-1-yusisamerican@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/22 21:59, Yusuf Khan wrote:
> This patch upstreams the DDCCI driver by Christoph Grenz into
> the kernel. The original gitlab page is loacted at https://gitlab
> .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
> v2: Fix typos.
> 
> v3: Add documentation, move files around, replace semaphores with
> mutexes, and replaced <asm-generic/fcntl.h> with <linux/fcntl.h>.
> "imirkin"(which due to his involvement in the dri-devel irc channel
> I cant help but assume to be a DRM developer) said that the DDC/CI
> bus does not intefere with the buses that DRM is involved with.
> 
> v4: Move some documentation, fix grammer mistakes, remove usages of
> likely(), and clarify some documentation.
> ---
>  Documentation/ABI/testing/sysfs-driver-ddcci |   37 +
>  Documentation/driver-api/ddcci.rst           |  107 +
>  drivers/char/Kconfig                         |   10 +
>  drivers/char/Makefile                        |    1 +
>  drivers/char/ddcci.c                         | 1887 ++++++++++++++++++
>  drivers/video/backlight/Kconfig              |   10 +
>  drivers/video/backlight/Makefile             |    1 +
>  drivers/video/backlight/ddcci-backlight.c    |  411 ++++
>  include/linux/ddcci.h                        |  164 ++
>  9 files changed, 2628 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ddcci
>  create mode 100644 Documentation/driver-api/ddcci.rst
>  create mode 100644 drivers/char/ddcci.c
>  create mode 100644 drivers/video/backlight/ddcci-backlight.c
>  create mode 100644 include/linux/ddcci.h
> 

> diff --git a/Documentation/driver-api/ddcci.rst b/Documentation/driver-api/ddcci.rst
> new file mode 100644
> index 000000000000..b4a4b694d326
> --- /dev/null
> +++ b/Documentation/driver-api/ddcci.rst
> @@ -0,0 +1,107 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
...

> +
> +options ddcci dyndbg
> +options ddcci-backlight dyndbg
> \ No newline at end of file

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 740811893c57..ec36fae7ee38 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -451,4 +451,14 @@ config RANDOM_TRUST_BOOTLOADER
>  	pool. Otherwise, say N here so it will be regarded as device input that
>  	only mixes the entropy pool.
>  
> +config DDCCI
> +	tristate "DDCCI display protocol support"

Add:
	depends on I2C

> +	help
> +	  Display Data Channel Command Interface is a

	                                         is an
(as in my previous comments)

> +	  interface that allows the kernel to "talk"
> +	  to most displays made after 2005. Check your
> +	  display's specification to see if it has
> +	  support for this. This depends on I2C to
> +	  compile.
> +
>  endmenu

> diff --git a/drivers/char/ddcci.c b/drivers/char/ddcci.c
> new file mode 100644
> index 000000000000..0a7bc9f63261
> --- /dev/null
> +++ b/drivers/char/ddcci.c
> @@ -0,0 +1,1887 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  DDC/CI sub-bus driver
> + *
> + *  Copyright (c) 2015 Christoph Grenz
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +


...

> +/* Write a message to the DDC/CI bus using i2c_smbus_write_byte() */
> +static int __ddcci_write_bytewise(struct i2c_client *client, unsigned char addr,
> +				  bool p_flag, const unsigned char *__restrict buf,
> +				  unsigned char len)
> +{
> +	int ret = 0;
> +	unsigned char outer_addr = (unsigned char)(client->addr << 1);
> +	unsigned int xor = outer_addr; /* initial xor value */
> +
> +	/* Consistency checks */
> +	if (len > 127)
> +		return -EINVAL;
> +
> +	/* Special case: sender to 0x6E is always 0x51 */

What does that comment mean?

> +	if (addr == DDCCI_DEFAULT_DEVICE_ADDR) {
> +		addr = DDCCI_HOST_ADDR_ODD;
> +	} else {
> +		/* When sending the odd address is used */
> +		addr = addr | 1;
> +	}
> +
> +	/* first byte: sender address */
> +	xor ^= addr;
> +	ret = i2c_smbus_write_byte(client, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* second byte: protocol flag and message size */
> +	xor ^= ((p_flag << 7) | len);
> +	ret = i2c_smbus_write_byte(client, (p_flag << 7)|len);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* send payload */
> +	while (len--) {
> +		xor ^= (*buf);
> +		ret = i2c_smbus_write_byte(client, (*buf));
> +		if (ret < 0)
> +			return ret;
> +		buf++;
> +	}
> +
> +	/* send checksum */
> +	ret = i2c_smbus_write_byte(client, xor);
> +	return ret;
> +}
> +
> +/* Write a message to the DDC/CI bus using i2c_master_send() */
> +static int __ddcci_write_block(struct i2c_client *client, unsigned char addr,
> +			       unsigned char *sendbuf, bool p_flag,
> +			       const unsigned char *data, unsigned char len)
> +{
> +	unsigned char outer_addr = (unsigned char)(client->addr << 1);
> +	unsigned int xor = outer_addr;	/* initial xor value */
> +	unsigned char *ptr = sendbuf;
> +
> +	/* Consistency checks */
> +	if (len > 127)
> +		return -EINVAL;
> +
> +	/* Special case: sender to 0x6E is always 0x51 */
> +	if (addr == DDCCI_DEFAULT_DEVICE_ADDR) {
> +		addr = DDCCI_HOST_ADDR_ODD;
> +	} else {
> +		/* When sending the odd address is used */
> +		addr = addr | 1;
> +	}
> +
> +	/* first byte: sender address */
> +	xor ^= addr;
> +	*(ptr++) = addr;
> +	/* second byte: protocol flag and message size */
> +	xor ^= ((p_flag << 7) | len);
> +	*(ptr++) = (p_flag << 7)|len;

Fix spacing above. (add some spaces)

> +	/* payload */
> +	while (len--) {
> +		xor ^= (*data);
> +		*(ptr++) = (*data);
> +		data++;
> +	}
> +	/* checksum */
> +	(*ptr) = xor;
> +
> +	/* Send it */
> +	return i2c_master_send(client, sendbuf, ptr - sendbuf + 1);
> +}
> +
> +/*
> + * Write a message to the DDC/CI bus.
> + *
> + * You must hold the bus mutex when calling this function.
> + */
> +static int ddcci_write(struct i2c_client *client, unsigned char addr,
> +		       bool p_flag, const unsigned char *data,
> +		       unsigned char len)
> +{
> +	struct ddcci_bus_drv_data *drv_data;
> +	unsigned char *sendbuf;
> +	int ret;
> +
> +	drv_data = i2c_get_clientdata(client);
> +
> +
> +	pr_debug("sending to %d:%02x:%02x: %*ph\n", client->adapter->nr,
> +		 client->addr << 1, addr, len, data);
> +	if (drv_data->quirks & DDCCI_QUIRK_WRITE_BYTEWISE) {
> +		ret = __ddcci_write_bytewise(client, addr, p_flag, data, len);
> +	} else {
> +		sendbuf = drv_data->recv_buffer;
> +		ret = __ddcci_write_block(client, addr, sendbuf, p_flag, data, len);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Read a response from the DDC/CI bus with headers directly into a buffer.
> + * Always check for DDCCI_QUIRK_SKIP_FIRST_BYTE when using this function.
> + * The returned length contains the whole unmodified response.
> + * If -EMSGSIZE is returned, the buffer contains the response up to `len`.
> + * If any other negative error code is returned, the buffer content is
> + * unspecified.
> + */
> +static int __ddcci_read(struct i2c_client *client, unsigned char addr,
> +			bool p_flag, unsigned long quirks, unsigned char *buf,
> +			unsigned char len)
> +{
> +	int i, payload_len, packet_length, ret;
> +	unsigned char xor = DDCCI_HOST_ADDR_EVEN;
> +
> +	/* Consistency checks */
> +	if (len < 3)
> +		return -EINVAL;
> +
> +	/* Read frame */
> +	ret = i2c_master_recv(client, buf, len);
> +	if (ret < 0)
> +		goto out_err;
> +	packet_length = ret;
> +
> +	/* Skip first byte if quirk active */
> +	if ((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE) && ret > 0 && len > 0) {
> +		ret--;
> +		len--;
> +		buf++;
> +	}
> +
> +	/* If answer too short (= incomplete) break out */
> +	if (ret < 3) {
> +		ret = -EIO;
> +		goto out_err;
> +	}
> +
> +	/* validate first byte */
> +	if (unlikely(buf[0] != addr)) {
> +		ret = (buf[0] == '\0') ? -EAGAIN : -EIO;
> +		goto out_err;
> +	}
> +
> +	/* validate second byte (protocol flag) */
> +	if (unlikely((buf[1] & 0x80) != (p_flag << 7))) {
> +		if (!p_flag || !(quirks & DDCCI_QUIRK_NO_PFLAG)) {
> +			ret = -EIO;
> +			goto out_err;
> +		}
> +	}
> +
> +	/* get and check payload length */
> +	payload_len = buf[1] & 0x7F;
> +	if (3+payload_len > packet_length)
> +		return -EBADMSG;
> +	if (3+payload_len > len)
> +		return -EMSGSIZE;
> +
> +	/* calculate checksum */
> +	for (i = 0; i < 3+payload_len; i++)
> +		xor ^= buf[i];
> +
> +	/* verify checksum */
> +	if (xor != 0) {
> +		dev_err(&client->dev, "invalid DDC/CI response, corrupted data - xor is 0x%02x, length 0x%02x\n",
> +			xor, payload_len);
> +		ret = -EBADMSG;
> +		goto out_err;
> +	}
> +
> +	/* return result */
> +	ret = payload_len+3+((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)?1:0);

ugly :(

> +
> +out_err:
> +	return ret;
> +}
> +

and it still contains too much use of likely() and unlikely().



> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index e32694c13da5..8b7efde28cfd 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -289,6 +289,16 @@ config BACKLIGHT_QCOM_WLED
>  	  If you have the Qualcomm PMIC, say Y to enable a driver for the
>  	  WLED block. Currently it supports PM8941 and PMI8998.
>  
> +config BACKLIGHT_DDCCI
> +	tristate "DDCCI Backlight Driver"

add line:
	depends on I2C

> +	help
> +	  If you have a DDC/CI supporing monitor, say Y to enable a driver

	                       supporting

> +	  to control its backlight using DDC/CI. This could be useful if
> +	  your monitor does not include a backlight driver. For this to be
> +	  useful you need to enable DDCCI support which can be found in
> +	  Device Drivers -> Character devices and that further depends on
> +	  I2C.
> +
>  config BACKLIGHT_RT4831
>  	tristate "Richtek RT4831 Backlight Driver"
>  	depends on MFD_RT4831




-- 
~Randy
