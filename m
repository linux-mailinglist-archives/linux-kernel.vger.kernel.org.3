Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7F51CC16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386323AbiEEWgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386314AbiEEWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:36:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADAC53727
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95D29B830E6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C08BC385A4;
        Thu,  5 May 2022 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651789985;
        bh=MaHdE8LQ+7KwTUrg0nIeawEp1kmAQn/vOtH5ihVko3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PipJedFDNNhLNUR2uhPQJC+uIKCE0+BEj929ZdpNpCK5JkYRHIn7ZjmI2/v5oYP4w
         fwwqTU1+7bOBPDa5reIPv2DUSGwTvv4jwdqyznkdLNw2ECGNZpVUw6nN9SDXtrS35V
         pbZd+AYVdrx8jK3awzcJSm4kO2JUANHJnRnIKUnY=
Date:   Thu, 5 May 2022 21:20:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        mb@lightnvm.io, ckeepax@opensource.cirrus.com, mst@redhat.com,
        javier@javigon.com, mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        rvmanjumce@gmail.com, ashish.deshpande@nxp.com
Subject: Re: [PATCH v3] [PATCH v3] uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <YnQjhoVsaI6IteIe@kroah.com>
References: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:43:37PM +0530, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol
> 
> sr1xx is a new driver that supports the integrated UWB for
> Nxp SoCs, especially the sr1xx series and depends on the SPI module.
> 
> sr1xx driver works with Nxp UWB Subsystem(UWBS) which is FiRa Complaint.

What is the Nxp UWBS and where can it be found?  You have custom ioctls
here with no public user so we really can't take them, right?

> Corresponding UCI details available in Fira Consortuim website.

Have a link for this?

> sr1xx is flash less device  and it requires firmware download on every
> device boot.

Too many spaces in that sentence?

Lots of devices need firmware, that's not a big deal if you are using
the firmware api, right?  Wait, you are not using that api, so how is
the firwmare being downloaded?

> Internally driver will handle two modes of operation.
> 1.HBCI mode (sr1xx BootROM Code Interface)
>   Firmware download uses HBCI ptotocol packet structure which is
>   Nxp proprietary,Firmware File(.bin) stored in user space context
>   and during device init sequence pick the firmware packet in chunk
>   and send it to the driver with write() api call.

That's not ok, use the standard in-kernel firmware download api please.

>   Firmware acknowledge for every chunk packet sent and same thing
>   is monitored,in user space code(HAL layer).

What does a HAL layer have to do with anything here?

>   If any error Firmware download sequence will fail and reset the device.
>   If firmware download packet sent successfully at the end device will
>   send device status notification and its indication of device entered
>   UCI mode.Here after any command/response/notification will follow
>   UCI packet structure.

Again, just use the normal fiwmare download logic and you will not need
to worry about any of the above.  For obvious reasons you don't want us
to take a custom firmware api for every individual device that Linux
supports as that would be crazy :)

> 2.UCI mode (UWB Command interface)
>   Once Firmware download finishes sr1xx will switch to UCI mode packet
>   structure.Here this driver exchange command/response between user space
>   and sr1xx device.

Please have someone proof read this changelog before you resend.

>   Any response or notification received from sr1xx through SPI line
>   will convey to user space.User space(UCI lib) will take care of
>   UCI parsing logic.

As I said when we met to talk about this driver, why do you have a
custom api/interface at all?  Why can you not just use the normal
user/kernel api for SPI devices?

You should not need any read/write/ioctl api for this driver at all,
it's just a simple spi driver from what I can tell.  This should not be
complex to implement at all.

>   Its IRQ based driver and sr1xx specific irq handshake mechanism logic
>   implemented to avoid any race condition between write and read
>   during ranging sequence.

I do not understand this sentence at all, sorry.

>   UCI mode Write is same as HBCI mode sequence whatever command received
>   from user space will send to the sr1xx via SPI line.
>   In UCI mode read api called first and waiting on the IRQ line status
>   in order to avoid missing of interrupts after write sequence.
> 
>   This driver needs dts config update as per the sr1xx data sheet.
>   Corresponding document will be added in
>   Documentation/devicetree/bindings/uwb

We can not take drivers with dts requirements without the dts updates as
well, as you know.  Please make that the first patch in the series and
properly cc: the needed DT maintainers.  For that reason alone I
couldn't take this patch if I wanted to.

> Link: https://lore.kernel.org/r/20220315105205.2381997-1-manjunatha.venkatesh@nxp.com

What is this a link to?

> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---

You forgot to list what changed from previous versions below the ---
line like the documentation asks you to do.  Please fix that for the
next submission.  My patch bot normally would just reject the change for
that reason alone, documentation matters :)


>  MAINTAINERS               |   6 +
>  drivers/misc/Kconfig      |  15 +
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/sr1xx.c      | 784 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/misc/sr1xx.h |  79 ++++
>  5 files changed, 885 insertions(+)
>  create mode 100644 drivers/misc/sr1xx.c
>  create mode 100644 include/uapi/misc/sr1xx.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cdb85e8..2896d401dbc4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21888,3 +21888,9 @@ S:	Buried alive in reporters
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>  F:	*
>  F:	*/
> +
> +UWB

Note, this is NOT generic UWB.  This is a single spi device driver,
right?

> +M:	manjunatha.venkatesh@nxp.com

No real name?

> +S:	Maintained
> +F:	drivers/misc/sr1xx.c
> +F:	include/uapi/misc/sr1xx.h

Please read the top of this file for how to correctly find where to
place your new entry.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..1ca97d168f26 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,21 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config NXP_UWB
> +        tristate "Nxp UCI(Uwb Command Interface) protocol driver support"
> +        depends on SPI
> +        help
> +        This option enables the UWB driver for Nxp sr1xx
> +        device. Such device supports UCI packet structure,
> +        FiRa complaint.
> +
> +
> +
> +        Say Y here to compile support for sr1xx into the kernel or
> +        say M to compile it as a module. The module will be called
> +        sr1xx.ko
> +
> +

Why all the extra blank lines?

And are you sure you indented the help properly?  Why no tabs like the
rest of this file?  Did you run checkpatch.pl on your patch first?


>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 70e800e9127f..bbd4dd17cabc 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> +obj-$(CONFIG_NXP_UWB) 		+= sr1xx.o
> diff --git a/drivers/misc/sr1xx.c b/drivers/misc/sr1xx.c
> new file mode 100644
> index 000000000000..100c36031fd2
> --- /dev/null
> +++ b/drivers/misc/sr1xx.c
> @@ -0,0 +1,784 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI driver for UWB SR1xx
> + * Copyright (C) 2018-2022 NXP.
> + *
> + * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> + */
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/jiffies.h>
> +#include <linux/list.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +#include <linux/poll.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/uaccess.h>
> +#include <uapi/misc/sr1xx.h>

Do you really need all of these?  If so, great, but I think that's way
too many for a simple driver like this.


> +
> +static int sr1xx_dev_open(struct inode *inode, struct file *filp)
> +{
> +	struct sr1xx_dev *sr1xx_dev = container_of(
> +		filp->private_data, struct sr1xx_dev, sr1xx_device);

Odd line break, please run checkpatch.pl.

I'm not going to review the driver contents based on my above comments
as this needs lots of reworking and most of the code here can go away.

One meta-comment though, your uapi .h file:

> --- /dev/null
> +++ b/include/uapi/misc/sr1xx.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Header file for UWB sr1xx device
> + * Copyright (C) 2018-2022 NXP.
> + *
> + * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> + */
> +
> +#include <linux/types.h>
> +
> +#define SR1XX_MAGIC 0xEA
> +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
> +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
> +
> +#define UCI_HEADER_LEN 4
> +#define HBCI_HEADER_LEN 4
> +#define UCI_PAYLOAD_LEN_OFFSET 3
> +
> +#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET 1
> +#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK 0x80
> +#define UCI_EXT_PAYLOAD_LEN_OFFSET 2
> +
> +#define SR1XX_TXBUF_SIZE 4200
> +#define SR1XX_RXBUF_SIZE 4200
> +#define SR1XX_MAX_TX_BUF_SIZE 4200
> +
> +#define MAX_RETRY_COUNT_FOR_IRQ_CHECK 100
> +#define MAX_RETRY_COUNT_FOR_HANDSHAKE 1000
> +
> +/* Macro to define SPI clock frequency */
> +#define SR1XX_SPI_CLOCK 16000000L
> +#define WAKEUP_SRC_TIMEOUT (2000)
> +
> +/* Maximum UCI packet size supported from the driver */
> +#define MAX_UCI_PKT_SIZE 4200
> +
> +struct sr1xx_spi_platform_data {
> +	unsigned int irq_gpio; /* SR1XX will interrupt host for any ntf */
> +	unsigned int ce_gpio; /* SW reset gpio */
> +	unsigned int spi_handshake_gpio; /* Host ready to read data */
> +};
> +
> +/* Device specific macro and structure */
> +struct sr1xx_dev {
> +	wait_queue_head_t read_wq; /* Wait queue for read interrupt */
> +	struct spi_device *spi; /* Spi device structure */
> +	struct miscdevice sr1xx_device; /* Char device as misc driver */
> +	unsigned int ce_gpio; /* SW reset gpio */
> +	unsigned int irq_gpio; /* SR1XX will interrupt host for any ntf */
> +	unsigned int spi_handshake_gpio; /* Host ready to read data */
> +	bool irq_enabled; /* Flag to indicate disable/enable irq sequence */
> +	bool irq_received; /* Flag to indicate that irq is received */
> +	spinlock_t irq_enabled_lock; /* Spin lock for read irq */
> +	unsigned char *tx_buffer; /* Transmit buffer */
> +	unsigned char *rx_buffer; /* Receive buffer */
> +	unsigned int write_count; /* Holds nubers of byte written */
> +	unsigned int read_count; /* Hold nubers of byte read */
> +	struct mutex
> +		sr1xx_access_lock; /* Lock used to synchronize read and write */
> +	size_t total_bytes_to_read; /* Total bytes read from the device */
> +	bool is_extended_len_bit_set; /* Variable to check ext payload Len */
> +	bool read_abort_requested; /* Used to indicate read abort request */
> +	bool is_fw_dwnld_enabled; /* Used to indicate fw download mode */
> +	int mode; /* Indicate write or read mode */
> +	long timeout_in_ms; /* Wait event interrupt timeout in ms */
> +};
> +
> +/* Power enable/disable and read abort ioctl arguments */
> +enum { PWR_DISABLE = 0, PWR_ENABLE, ABORT_READ_PENDING };
> +
> +enum spi_status_codes {
> +	TRANSCEIVE_SUCCESS,
> +	TRANSCEIVE_FAIL,
> +	IRQ_WAIT_REQUEST,
> +	IRQ_WAIT_TIMEOUT
> +};
> +
> +/* Spi write/read operation mode */
> +enum spi_operation_modes { SR1XX_WRITE_MODE, SR1XX_READ_MODE };


You have loads of things in here that should NOT be exposed to userspace
at all (your structure?)

Does this even build properly if you have the header check build option
enabled?  I would be amazed if it did.

Anyway, you do not need a uapi .h file from what I can tell, so it
shouldn't be needed for your next version.

thanks,

greg k-h
