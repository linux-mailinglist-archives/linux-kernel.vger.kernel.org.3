Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF04469463
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbhLFK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbhLFK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:57:00 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C87C061746;
        Mon,  6 Dec 2021 02:53:31 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id p19so10296237qtw.12;
        Mon, 06 Dec 2021 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=da+CzZtWYewZSabCiAC83z8OxkPQqw8PMv0GOstx7e4=;
        b=Ad17HvalXfch60OThzlHdnuaQBkRcN3EdxaVJIYf3decexgqwRiBHS6eyKXnN5WeCX
         tS8AqfP+zAhOktl4+B964XqefYmzwIOL89f9aeWXn8XQW2aunAA9+SVbAZ40N0KPq3Ka
         hAvJksYkeXXtBZED7zI5abGyU5ARPQwvqKAvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=da+CzZtWYewZSabCiAC83z8OxkPQqw8PMv0GOstx7e4=;
        b=ETClxy01/clPvxCtdjd7OOuqCccMVB+A+mnXkTRJZQ2uDGqerR2FTlTOUJVMsMM+Mm
         nCjdofNAhwCX0vS4Ir416FF0CHvpNhmZG0Z0XRlycaNLsJQimA6pLlCx2YavM1oE99WK
         hHavRI6MREwaMLE5RDLwNGgj5hTZyDq9UqrD5zSom/f5gpKMNZ8ge/oszcHCoxWDt5FT
         K6lZgX+yxnyK9onJWt+/iwoSY4YzgZZjtBk7oP/w2gaqxLR+jUi1+QuP/jrmrCidL6NB
         5M3PdkzD0Ks73EZFWbAAmYyuuz3hBr2jsDXiIPvySkBhIWwHUEShaIsMOuUF4X+h34og
         V/qA==
X-Gm-Message-State: AOAM531JaNDd8pW/GNzbPvuXdaxrNhJWOdEGEjvExFKoKWKr2Vmb1PNU
        xN3OfZ6acQinn4UiQBlwz+vug0O9QiDpjWliLR4=
X-Google-Smtp-Source: ABdhPJwgdkqWf8z5WuWYGLpWMCANK3mA5bUc9GBlEZsE2xZCHAriZ5iH26bo/3FznFfVCKQp5yM6ZTvRe3l54h5Xr/8=
X-Received: by 2002:a05:622a:1350:: with SMTP id w16mr38833123qtk.394.1638788010477;
 Mon, 06 Dec 2021 02:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20211203234155.2319803-1-gsomlo@gmail.com> <20211203234155.2319803-4-gsomlo@gmail.com>
In-Reply-To: <20211203234155.2319803-4-gsomlo@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 6 Dec 2021 10:53:17 +0000
Message-ID: <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, 3 Dec 2021 at 23:42, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
>
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!
>
> Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> ---
>  drivers/mmc/host/Kconfig     |   6 +
>  drivers/mmc/host/Makefile    |   1 +
>  drivers/mmc/host/litex_mmc.c | 677 +++++++++++++++++++++++++++++++++++
>  3 files changed, 684 insertions(+)
>  create mode 100644 drivers/mmc/host/litex_mmc.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5af8494c31b5..84c64e72195d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1093,3 +1093,9 @@ config MMC_OWL
>
>  config MMC_SDHCI_EXTERNAL_DMA
>         bool
> +
> +config MMC_LITEX
> +       tristate "Support for the MMC Controller in LiteX SOCs"

Did you test using this as a module?

> +       depends on OF && LITEX

I don't like having litex drivers depend on the LITEX kconfig. The
symbol is not user visible, and to enable it we need to build in the
litex controller driver, which platforms may or may not have.

The microwatt platform is an example of a SoC that embeds some LITEX
IP, but may or may not be a litex SoC.

> +       help
> +         Generic MCC driver for LiteX
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ea36d379bd3c..4e4ceb32c4b4 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_MMC_CQHCI)                     += cqhci.o
>  cqhci-y                                        += cqhci-core.o
>  cqhci-$(CONFIG_MMC_CRYPTO)             += cqhci-crypto.o
>  obj-$(CONFIG_MMC_HSQ)                  += mmc_hsq.o
> +obj-$(CONFIG_MMC_LITEX)                        += litex_mmc.o
>
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>         CFLAGS-cb710-mmc        += -DDEBUG
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> new file mode 100644
> index 000000000000..3877379757cd
> --- /dev/null
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -0,0 +1,677 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LiteX LiteSDCard driver
> + *
> + * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>

You should list your co-authors here I think.

> +
> +static int
> +sdcard_wait_done(void __iomem *reg)
> +{
> +       u8 evt;
> +
> +       for (;;) {
> +               evt = litex_read8(reg);
> +               if (evt & 0x1)
> +                       break;
> +               udelay(5);

This is an infinite loop. Take a look at the commits here and grab the
fix to make it timeout:

https://github.com/shenki/linux/commits/microwatt-v5.16

Well behaving hardware should be ok, but a broken or missing IP block
will cause the kernel to lock up for ever.

> +       }
> +       if (evt == 0x1)
> +               return SD_OK;
> +       if (evt & 0x2)
> +               return SD_WRITEERROR;
> +       if (evt & 0x4)
> +               return SD_TIMEOUT;
> +       if (evt & 0x8)
> +               return SD_CRCERROR;
> +       pr_err("%s: unknown error evt=%x\n", __func__, evt);
> +       return SD_ERR_OTHER;

I would consider refactoring the driver to not have it's own error
codes that map to real ones. You can get rid of map_status too.

> +}
> +
> +static int
> +send_cmd(struct litex_mmc_host *host,
> +        u8 cmd, u32 arg, u8 response_len, u8 transfer)
> +{
> +       void __iomem *reg;
> +       ulong n;
> +       u8 i;
> +       int status;
> +
> +       litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
> +       litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
> +                     cmd << 8 | transfer << 5 | response_len);
> +       litex_write8(host->sdcore + LITEX_CORE_CMDSND, 1);
> +
> +       /* Wait for an interrupt if we have an interrupt and either there is
> +        * data to be transferred, or if the card can report busy via DAT0.
> +        */
> +       if (host->irq > 0 &&
> +           (transfer != SDCARD_CTRL_DATA_TRANSFER_NONE ||
> +            response_len == SDCARD_CTRL_RESPONSE_SHORT_BUSY)) {
> +               reinit_completion(&host->cmd_done);
> +               litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
> +                             SDIRQ_CMD_DONE | SDIRQ_CARD_DETECT);
> +               wait_for_completion(&host->cmd_done);
> +       }
> +
> +       status = sdcard_wait_done(host->sdcore + LITEX_CORE_CMDEVT);
> +
> +       if (status != SD_OK) {
> +               pr_err("Command (cmd %d) failed, status %d\n", cmd, status);

Take a look at the patch in my tree that fixes up the error messages
to have the driver prefix (dev_err/dev_info/etc).


> +               return status;
> +       }
> +
> +       if (response_len != SDCARD_CTRL_RESPONSE_NONE) {
> +               reg = host->sdcore + LITEX_CORE_CMDRSP;
> +               for (i = 0; i < 4; i++) {
> +                       host->resp[i] = litex_read32(reg);
> +                       reg += sizeof(u32);

> +               }
> +       }
> +
> +       if (!host->app_cmd && cmd == SD_SEND_RELATIVE_ADDR)
> +               host->rca = (host->resp[3] >> 16) & 0xffff;
> +
> +       host->app_cmd = (cmd == MMC_APP_CMD);
> +
> +       if (transfer == SDCARD_CTRL_DATA_TRANSFER_NONE)
> +               return status; /* SD_OK from prior sdcard_wait_done(cmd_evt) */
> +
> +       status = sdcard_wait_done(host->sdcore + LITEX_CORE_DATAEVT);
> +       if (status != SD_OK) {
> +               pr_err("Data xfer (cmd %d) failed, status %d\n", cmd, status);
> +               return status;
> +       }
> +
> +       /* wait for completion of (read or write) DMA transfer */
> +       reg = (transfer == SDCARD_CTRL_DATA_TRANSFER_READ) ?
> +               host->sdreader + LITEX_BLK2MEM_DONE :
> +               host->sdwriter + LITEX_MEM2BLK_DONE;
> +       n = jiffies + (HZ << 1);
> +       while ((litex_read8(reg) & 0x01) == 0)
> +               if (time_after(jiffies, n)) {

Use readx_poll_timeout.

> +                       pr_err("DMA timeout (cmd %d)\n", cmd);
> +                       return SD_TIMEOUT;
> +               }
> +
> +       return status;
> +}
> +
> +static inline int
> +send_app_cmd(struct litex_mmc_host *host)
> +{
> +       return send_cmd(host, MMC_APP_CMD, host->rca << 16,
> +                       SDCARD_CTRL_RESPONSE_SHORT,
> +                       SDCARD_CTRL_DATA_TRANSFER_NONE);
> +}
> +
> +static inline int
> +send_app_set_bus_width_cmd(struct litex_mmc_host *host, u32 width)
> +{
> +       return send_cmd(host, SD_APP_SET_BUS_WIDTH, width,
> +                       SDCARD_CTRL_RESPONSE_SHORT,
> +                       SDCARD_CTRL_DATA_TRANSFER_NONE);
> +}
> +
> +static int
> +litex_set_bus_width(struct litex_mmc_host *host)
> +{
> +       bool app_cmd_sent = host->app_cmd; /* was preceding command app_cmd? */
> +       int status;
> +
> +       /* ensure 'app_cmd' precedes 'app_set_bus_width_cmd' */
> +       if (!app_cmd_sent)
> +               send_app_cmd(host);
> +
> +       /* litesdcard only supports 4-bit bus width */
> +       status = send_app_set_bus_width_cmd(host, MMC_BUS_WIDTH_4);
> +
> +       /* re-send 'app_cmd' if necessary */
> +       if (app_cmd_sent)
> +               send_app_cmd(host);
> +
> +       return status;
> +}
> +
> +static int
> +litex_get_cd(struct mmc_host *mmc)
> +{
> +       struct litex_mmc_host *host = mmc_priv(mmc);
> +       int ret;
> +
> +       if (!mmc_card_is_removable(mmc))
> +               return 1;
> +
> +       ret = mmc_gpio_get_cd(mmc);

Bindings.

> +       if (ret >= 0)
> +               /* GPIO based card-detect explicitly specified in DTS */
> +               ret = !!ret;
> +       else
> +               /* use gateware card-detect bit by default */
> +               ret = !litex_read8(host->sdphy + LITEX_PHY_CARDDETECT);
> +
> +       /* ensure bus width will be set (again) upon card (re)insertion */
> +       if (ret == 0)
> +               host->is_bus_width_set = false;
> +
> +       return ret;
> +}
> +
> +static irqreturn_t
> +litex_mmc_interrupt(int irq, void *arg)
> +{
> +       struct mmc_host *mmc = arg;
> +       struct litex_mmc_host *host = mmc_priv(mmc);
> +       u32 pending = litex_read32(host->sdirq + LITEX_IRQ_PENDING);
> +
> +       /* Check for card change interrupt */
> +       if (pending & SDIRQ_CARD_DETECT) {
> +               litex_write32(host->sdirq + LITEX_IRQ_PENDING,
> +                             SDIRQ_CARD_DETECT);
> +               mmc_detect_change(mmc, msecs_to_jiffies(10));
> +       }
> +
> +       /* Check for command completed */
> +       if (pending & SDIRQ_CMD_DONE) {
> +               /* Disable it so it doesn't keep interrupting */
> +               litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
> +                             SDIRQ_CARD_DETECT);
> +               complete(&host->cmd_done);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static u32
> +litex_response_len(struct mmc_command *cmd)
> +{
> +       if (cmd->flags & MMC_RSP_136) {
> +               return SDCARD_CTRL_RESPONSE_LONG;
> +       } else if (cmd->flags & MMC_RSP_PRESENT) {
> +               if (cmd->flags & MMC_RSP_BUSY)
> +                       return SDCARD_CTRL_RESPONSE_SHORT_BUSY;
> +               else
> +                       return SDCARD_CTRL_RESPONSE_SHORT;
> +       }
> +       return SDCARD_CTRL_RESPONSE_NONE;
> +}
> +
> +static int
> +litex_map_status(int status)
> +{
> +       int error;
> +
> +       switch (status) {
> +       case SD_OK:
> +               error = 0;
> +               break;
> +       case SD_WRITEERROR:
> +               error = -EIO;
> +               break;
> +       case SD_TIMEOUT:
> +               error = -ETIMEDOUT;
> +               break;
> +       case SD_CRCERROR:
> +               error = -EILSEQ;
> +               break;
> +       default:
> +               error = -EINVAL;
> +               break;
> +       }
> +       return error;
> +}
> +
> +static void
> +litex_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct litex_mmc_host *host = mmc_priv(mmc);
> +       struct platform_device *pdev = to_platform_device(mmc->parent);
> +       struct device *dev = &pdev->dev;
> +       struct mmc_data *data = mrq->data;
> +       struct mmc_command *sbc = mrq->sbc;
> +       struct mmc_command *cmd = mrq->cmd;
> +       struct mmc_command *stop = mrq->stop;
> +       unsigned int retries = cmd->retries;
> +       int status;
> +       int sg_count;
> +       enum dma_data_direction dir = DMA_TO_DEVICE;
> +       bool direct = false;
> +       dma_addr_t dma;
> +       unsigned int len = 0;
> +
> +       u32 response_len = litex_response_len(cmd);
> +       u32 transfer = SDCARD_CTRL_DATA_TRANSFER_NONE;
> +
> +       /* First check that the card is still there */
> +       if (!litex_get_cd(mmc)) {
> +               cmd->error = -ENOMEDIUM;
> +               mmc_request_done(mmc, mrq);
> +               return;
> +       }
> +
> +       /* Send set-block-count command if needed */
> +       if (sbc) {
> +               status = send_cmd(host, sbc->opcode, sbc->arg,
> +                                 litex_response_len(sbc),
> +                                 SDCARD_CTRL_DATA_TRANSFER_NONE);
> +               sbc->error = litex_map_status(status);
> +               if (status != SD_OK) {
> +                       host->is_bus_width_set = false;
> +                       mmc_request_done(mmc, mrq);
> +                       return;
> +               }
> +       }
> +
> +       if (data) {

This is a big ol' if(). Consider splitting it (or some of it?) out
into some other functions to make it easier to read.

> +               /* LiteSDCard only supports 4-bit bus width; therefore, we MUST
> +                * inject a SET_BUS_WIDTH (acmd6) before the very first data
> +                * transfer, earlier than when the mmc subsystem would normally
> +                * get around to it!
> +                */
> +               if (!host->is_bus_width_set) {
> +                       ulong n = jiffies + 2 * HZ; // 500ms timeout
> +
> +                       while (litex_set_bus_width(host) != SD_OK) {
> +                               if (time_after(jiffies, n)) {
> +                                       dev_warn(dev, "Can't set bus width!\n");
> +                                       cmd->error = -ETIMEDOUT;
> +                                       mmc_request_done(mmc, mrq);
> +                                       return;
> +                               }
> +                       }
> +                       host->is_bus_width_set = true;
> +               }
> +
> +               /* Try to DMA directly to/from the data buffer.
> +                * We can do that if the buffer can be mapped for DMA
> +                * in one contiguous chunk.
> +                */
> +               dma = host->dma;
> +               len = data->blksz * data->blocks;
> +               if (data->flags & MMC_DATA_READ)
> +                       dir = DMA_FROM_DEVICE
> +               sg_count = dma_map_sg(&host->dev->dev,
> +                                     data->sg, data->sg_len, dir)

dma_map_sg(..., mmc_get_dma_dir(data))

> +               if (sg_count == 1) {
> +                       dma = sg_dma_address(data->sg);
> +                       len = sg_dma_len(data->sg);
> +                       direct = true;
> +               } else if (len > host->buf_size)
> +                       len = host->buf_size;
> +
> +               if (data->flags & MMC_DATA_READ) {
> +                       litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
> +                       litex_write64(host->sdreader + LITEX_BLK2MEM_BASE, dma);
> +                       litex_write32(host->sdreader + LITEX_BLK2MEM_LEN, len);
> +                       litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 1);
> +
> +                       transfer = SDCARD_CTRL_DATA_TRANSFER_READ;
> +               } else if (data->flags & MMC_DATA_WRITE) {
> +                       if (!direct)
> +                               sg_copy_to_buffer(data->sg, data->sg_len,
> +                                                 host->buffer, len);
> +
> +                       litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
> +                       litex_write64(host->sdwriter + LITEX_MEM2BLK_BASE, dma);
> +                       litex_write32(host->sdwriter + LITEX_MEM2BLK_LEN, len);
> +                       litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 1);
> +
> +                       transfer = SDCARD_CTRL_DATA_TRANSFER_WRITE;
> +               } else {
> +                       dev_warn(dev, "Data present w/o read or write flag.\n");
> +                       /* Continue: set cmd status, mark req done */
> +               }
> +
> +               litex_write16(host->sdcore + LITEX_CORE_BLKLEN, data->blksz);
> +               litex_write32(host->sdcore + LITEX_CORE_BLKCNT, data->blocks);
> +       }
> +
> +       do {
> +               status = send_cmd(host, cmd->opcode, cmd->arg,
> +                                 response_len, transfer);
> +       } while (status != SD_OK && retries-- > 0);
> +
> +       cmd->error = litex_map_status(status);
> +       if (status != SD_OK)
> +               /* card may be gone; don't assume bus width is still set */
> +               host->is_bus_width_set = false;
> +
> +       if (response_len == SDCARD_CTRL_RESPONSE_SHORT) {
> +               /* pull short response fields from appropriate host registers */
> +               cmd->resp[0] = host->resp[3];
> +               cmd->resp[1] = host->resp[2] & 0xFF;
> +       } else if (response_len == SDCARD_CTRL_RESPONSE_LONG) {
> +               cmd->resp[0] = host->resp[0];
> +               cmd->resp[1] = host->resp[1];
> +               cmd->resp[2] = host->resp[2];
> +               cmd->resp[3] = host->resp[3];
> +       }
> +
> +       /* Send stop-transmission command if required */
> +       if (stop && (cmd->error || !sbc)) {
> +               int stop_stat;
> +
> +               stop_stat = send_cmd(host, stop->opcode, stop->arg,
> +                                    litex_response_len(stop),
> +                                    SDCARD_CTRL_DATA_TRANSFER_NONE);
> +               stop->error = litex_map_status(stop_stat);
> +               if (stop_stat != SD_OK)
> +                       host->is_bus_width_set = false;
> +       }
> +
> +       if (data)
> +               dma_unmap_sg(&host->dev->dev, data->sg, data->sg_len, dir);
> +
> +       if (status == SD_OK && transfer != SDCARD_CTRL_DATA_TRANSFER_NONE) {
> +               data->bytes_xfered = min(len, mmc->max_req_size);
> +               if (transfer == SDCARD_CTRL_DATA_TRANSFER_READ && !direct) {
> +                       sg_copy_from_buffer(data->sg, sg_nents(data->sg),
> +                                           host->buffer, data->bytes_xfered);
> +               }
> +       }
> +
> +       mmc_request_done(mmc, mrq);
> +}
> +
> +static void
> +litex_set_clk(struct litex_mmc_host *host, unsigned int clk_freq)
> +{
> +       u32 div = clk_freq ? host->freq / clk_freq : 256;
> +
> +       div = roundup_pow_of_two(div);
> +       div = min_t(u32, max_t(u32, div, 2), 256);
> +       dev_info(&host->dev->dev, "clk_freq=%d: set to %d via div=%d\n",
> +                clk_freq, host->freq / div, div);

dev_dbg?

> +       litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
> +}
> +
> +static void
> +litex_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct litex_mmc_host *host = mmc_priv(mmc);
> +
> +       /* NOTE: Ignore any ios->bus_width updates; they occur right after
> +        * the mmc core sends its own acmd6 bus-width change notification,
> +        * which is redundant since we snoop on the command flow and inject
> +        * an early acmd6 before the first data transfer command is sent!
> +        */
> +
> +       /* update sdcard clock */
> +       if (ios->clock != host->clock) {
> +               litex_set_clk(host, ios->clock);
> +               host->clock = ios->clock;
> +       }
> +}
> +
> +static const struct mmc_host_ops litex_mmc_ops = {
> +       .get_cd = litex_get_cd,
> +       .request = litex_request,
> +       .set_ios = litex_set_ios,
> +};
> +
> +static int
> +litex_mmc_probe(struct platform_device *pdev)
> +{
> +       struct litex_mmc_host *host;
> +       struct mmc_host *mmc;
> +       struct device_node *cpu;
> +       int ret;
> +
> +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
> +       /* NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
> +        * and max_blk_count accordingly set to 8;
> +        * If for some reason we need to modify max_blk_count, we must also
> +        * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
> +        */
> +       if (!mmc)
> +               return -ENOMEM;
> +
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->dev = pdev;
> +
> +       host->clock = 0;
> +       cpu = of_get_next_cpu_node(NULL);
> +       ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);

> +       of_node_put(cpu);
> +       if (ret) {
> +               dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
> +               goto err_free_host;
> +       }
> +
> +       init_completion(&host->cmd_done);
> +       host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq < 0)
> +               dev_err(&pdev->dev, "Failed to get IRQ, using polling\n");

Can you put all of the irq handling together? Move the hardware sanity
checking up higher and put it together too:

litex_write32(host->sdirq + LITEX_IRQ_PENDING, SDIRQ_CARD_DETECT);
  /* clears it */
/* ensure DMA bus masters are disabled */
litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);

if (host->irq < 0) {
                dev_err(&pdev->dev, "Failed to get IRQ, using polling\n");
                mmc->caps |= MMC_CAP_NEEDS_POLL;
} else {
              ret = request_irq(host->irq, litex_mmc_interrupt, 0,
"litex-mmc", mmc);
              if (ret < 0) {
                 goto err_free_host;
               /* enable card-change interrupts */
               litex_write32(host->sdirq + LITEX_IRQ_ENABLE, SDIRQ_CARD_DETECT);
 }

> +
> +       /* LiteSDCard only supports 4-bit bus width; therefore, we MUST inject
> +        * a SET_BUS_WIDTH (acmd6) before the very first data transfer, earlier
> +        * than when the mmc subsystem would normally get around to it!
> +        */
> +       host->is_bus_width_set = false;
> +       host->app_cmd = false;
> +
> +       ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));

Is this going to be true on all platforms? How do we handle those
where it's not true?

> +       if (ret)
> +               goto err_free_host;
> +
> +       host->buf_size = mmc->max_req_size * 2;
> +       host->buffer = dma_alloc_coherent(&pdev->dev, host->buf_size,
> +                                         &host->dma, GFP_DMA);

dmam_alloc_coherent?

> +       if (host->buffer == NULL) {
> +               ret = -ENOMEM;
> +               goto err_free_host;
> +       }
> +
> +
> +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +       mmc->ops = &litex_mmc_ops;
> +
> +       mmc->f_min = 12.5e6;
> +       mmc->f_max = 50e6;

How did you pick these?

Are these always absolute? (wouldn't they depend on the system they
are in? host clocks?)

> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               goto err_free_dma;
> +
> +       /* force 4-bit bus_width (only width supported by hardware) */
> +       mmc->caps &= ~MMC_CAP_8_BIT_DATA;
> +       mmc->caps |= MMC_CAP_4_BIT_DATA;
> +
> +       /* set default capabilities */
> +       mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
> +                    MMC_CAP_DRIVER_TYPE_D |
> +                    MMC_CAP_CMD23;
> +       mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT |
> +                     MMC_CAP2_FULL_PWR_CYCLE |
> +                     MMC_CAP2_NO_SDIO;
> +
> +       platform_set_drvdata(pdev, host);
> +
> +       ret = mmc_add_host(mmc);
> +       if (ret < 0)
> +               goto err_free_dma;
> +

> +
> +       return 0;
> +
> +err_free_dma:
> +       dma_free_coherent(&pdev->dev, host->buf_size, host->buffer, host->dma);
> +err_free_host:
> +       mmc_free_host(mmc);
> +       return ret;
> +}
> +
> +static int
> +litex_mmc_remove(struct platform_device *pdev)
> +{
> +       struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
> +
> +       if (host->irq > 0)
> +               free_irq(host->irq, host->mmc);
> +       mmc_remove_host(host->mmc);
> +       dma_free_coherent(&pdev->dev, host->buf_size, host->buffer, host->dma);
> +       mmc_free_host(host->mmc);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id litex_match[] = {
> +       { .compatible = "litex,mmc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, litex_match);
> +
> +static struct platform_driver litex_mmc_driver = {
> +       .probe = litex_mmc_probe,
> +       .remove = litex_mmc_remove,
> +       .driver = {
> +               .name = "litex-mmc",
> +               .of_match_table = of_match_ptr(litex_match),
> +       },
> +};
> +module_platform_driver(litex_mmc_driver);
> +
> +MODULE_DESCRIPTION("LiteX SDCard driver");
> +MODULE_AUTHOR("Antmicro <www.antmicro.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.31.1
>
