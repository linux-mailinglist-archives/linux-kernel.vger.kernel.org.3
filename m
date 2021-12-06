Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4E46932F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhLFKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:11:44 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:35674 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhLFKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:11:42 -0500
Received: by mail-vk1-f170.google.com with SMTP id q21so6379969vkn.2;
        Mon, 06 Dec 2021 02:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMvGxeB+8V20yO6olIdLEiGj173u2V5AUcW9oi1cEig=;
        b=FmK/zLesbp8DJJeagSNwkz75wtIQGeO5CoZwngjHb+DBhYORBZ4nhpmtEiAGuUD/Tc
         T8WgQAP/7NJnGu8pmKYD9LCQ0KCVzYPyPUZkq79Y9ZqiPwVFag0rm2dQm1rnoHC6gBuc
         2VDN8oYn5y9sVPgHJlMwl2PJ7AKixWkEZ/MUQyyfLuSqDJn2BFnNjCJGQmXveMRDrgYh
         XRZeR0NawLW5k7yhfSKsMuVas6Dep5HBbPK8Ho+DlFIjdMX8ac+ZNRVHMLqzF54ZGh8X
         KgM7fdRR4CMZouA2KAXE7K7JW73x7PVptemv2MYqI6Ua4VLodaSrHD0KmA0Jft+sFbmT
         WOHw==
X-Gm-Message-State: AOAM532wXddieTuSy970lC8XCBPto2/s0EYc+vUDofdpbZRbcDRhmYJc
        4B382uvEkilYzqpa3By7eVzYI0ryhKG+2A==
X-Google-Smtp-Source: ABdhPJwCaTUMyQfnefxWoSCpzUPun+EkYLRUht2uDR2AThNoyDDxSRdZVxHe6fwMRlou8dqWLJzAAg==
X-Received: by 2002:a1f:3853:: with SMTP id f80mr39646300vka.0.1638785289389;
        Mon, 06 Dec 2021 02:08:09 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id u20sm3874746vke.0.2021.12.06.02.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 02:08:09 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id e27so6395220vkd.4;
        Mon, 06 Dec 2021 02:08:08 -0800 (PST)
X-Received: by 2002:a1f:4641:: with SMTP id t62mr39583149vka.0.1638785288439;
 Mon, 06 Dec 2021 02:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-4-gsomlo@gmail.com>
In-Reply-To: <20211204204121.2367127-4-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 11:07:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXh6YfRdGi8gYc4hJuTwogme6+Esn9Mf1vr9MFO=f8mAg@mail.gmail.com>
Message-ID: <CAMuHMdXh6YfRdGi8gYc4hJuTwogme6+Esn9Mf1vr9MFO=f8mAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
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

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/mmc/host/litex_mmc.c

> +struct litex_mmc_host {
> +       struct mmc_host *mmc;
> +       struct platform_device *dev;
> +
> +       void __iomem *sdphy;
> +       void __iomem *sdcore;
> +       void __iomem *sdreader;
> +       void __iomem *sdwriter;
> +       void __iomem *sdirq;
> +
> +       u32 resp[4];
> +       u16 rca;
> +
> +       void *buffer;
> +       size_t buf_size;
> +       dma_addr_t dma;
> +
> +       unsigned int freq;
> +       unsigned int clock;
> +       bool is_bus_width_set;
> +       bool app_cmd;
> +
> +       int irq;
> +       struct completion cmd_done;

You may want to reorder the members to avoid implicit gaps
(i.e. structs first, followed by integral types in decreasing size).

> +};
> +
> +static int
> +sdcard_wait_done(void __iomem *reg)
> +{
> +       u8 evt;
> +       int ret;
> +
> +       ret = read_poll_timeout(litex_read8, evt, (evt & 0x1),

Lots of magic numbers. Please use defines, like

    #define EVT_FOO   BIT(0)

> +                               SD_SLEEP_US, SD_TIMEOUT_US, false, reg);
> +       if (ret || (evt & 0x4))
> +               return SD_TIMEOUT;
> +       if (evt == 0x1)
> +               return SD_OK;
> +       if (evt & 0x2)
> +               return SD_WRITEERROR;
> +       if (evt & 0x8)
> +               return SD_CRCERROR;
> +       pr_err("%s: unknown error evt=%x\n", __func__, evt);
> +       return SD_ERR_OTHER;
> +}
> +
> +static int
> +send_cmd(struct litex_mmc_host *host,
> +        u8 cmd, u32 arg, u8 response_len, u8 transfer)
> +{
> +       void __iomem *reg;
> +       u8 i;

unsigned int

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
> +
> +       status = read_poll_timeout(litex_read8, i, (i & 0x1),
> +                                  SD_SLEEP_US, SD_TIMEOUT_US, false, reg);
> +       if (status)
> +               pr_err("DMA timeout (cmd %d)\n", cmd);
> +
> +       return status;
> +}
> +
> +static inline int

No need for inline, the compiler can decide.

> +send_app_cmd(struct litex_mmc_host *host)
> +{
> +       return send_cmd(host, MMC_APP_CMD, host->rca << 16,
> +                       SDCARD_CTRL_RESPONSE_SHORT,
> +                       SDCARD_CTRL_DATA_TRANSFER_NONE);
> +}
> +
> +static inline int

Likewise.

> +send_app_set_bus_width_cmd(struct litex_mmc_host *host, u32 width)
> +{
> +       return send_cmd(host, SD_APP_SET_BUS_WIDTH, width,
> +                       SDCARD_CTRL_RESPONSE_SHORT,
> +                       SDCARD_CTRL_DATA_TRANSFER_NONE);
> +}

> +static int
> +litex_get_cd(struct mmc_host *mmc)

litex_mmc_get_cd()? (i.e. "litex_mmc_"-prefix everywhere)

> +{
> +       struct litex_mmc_host *host = mmc_priv(mmc);
> +       int ret;
> +
> +       if (!mmc_card_is_removable(mmc))
> +               return 1;
> +
> +       ret = mmc_gpio_get_cd(mmc);
> +       if (ret >= 0)
> +               /* GPIO based card-detect explicitly specified in DTS */
> +               ret = !!ret;
> +       else
> +               /* use gateware card-detect bit by default */
> +               ret = !litex_read8(host->sdphy + LITEX_PHY_CARDDETECT);

Please use curly braces to delimit blocks larger than a single line.

> +
> +       /* ensure bus width will be set (again) upon card (re)insertion */
> +       if (ret == 0)
> +               host->is_bus_width_set = false;
> +
> +       return ret;
> +}

> +static u32
> +litex_response_len(struct mmc_command *cmd)
> +{
> +       if (cmd->flags & MMC_RSP_136) {
> +               return SDCARD_CTRL_RESPONSE_LONG;
> +       } else if (cmd->flags & MMC_RSP_PRESENT) {

No need for else after return.

> +               if (cmd->flags & MMC_RSP_BUSY)
> +                       return SDCARD_CTRL_RESPONSE_SHORT_BUSY;
> +               else
> +                       return SDCARD_CTRL_RESPONSE_SHORT;
> +       }
> +       return SDCARD_CTRL_RESPONSE_NONE;

Perhaps it's worthwhile to invert the logic of the last check, to
reduce indentation?

        if (cmd->flags & MMC_RSP_136)
                return SDCARD_CTRL_RESPONSE_LONG;

        if (!(cmd->flags & MMC_RSP_PRESENT))
                return SDCARD_CTRL_RESPONSE_NONE;

        if (cmd->flags & MMC_RSP_BUSY)
                return SDCARD_CTRL_RESPONSE_SHORT_BUSY;

        return SDCARD_CTRL_RESPONSE_SHORT;

> +}

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

The above might look nicer when using "reverse Xmas tree" order
of declarations.

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
> +                       dir = DMA_FROM_DEVICE;
> +               sg_count = dma_map_sg(&host->dev->dev,
> +                                     data->sg, data->sg_len, dir);
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

Please add curly braces.

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

No need for the _t-variants if you make the constants unsigned (e.g. 2U).

> +       dev_info(&host->dev->dev, "sdclk_freq=%d: set to %d via div=%d\n",
> +                clk_freq, host->freq / div, div);
> +       litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
> +}

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

platform_get_irq_optional()

So interrupts should not be required in the DT bindings.

> +       if (host->irq < 0)
> +               dev_err(&pdev->dev, "Failed to get IRQ, using polling\n");

This is not an error condition: dev_info() or dev_warn().

> +
> +       /* LiteSDCard only supports 4-bit bus width; therefore, we MUST inject
> +        * a SET_BUS_WIDTH (acmd6) before the very first data transfer, earlier
> +        * than when the mmc subsystem would normally get around to it!
> +        */
> +       host->is_bus_width_set = false;
> +       host->app_cmd = false;
> +
> +       ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> +       if (ret)
> +               goto err_free_host;
> +
> +       host->buf_size = mmc->max_req_size * 2;
> +       host->buffer = dma_alloc_coherent(&pdev->dev, host->buf_size,
> +                                         &host->dma, GFP_DMA);
> +       if (host->buffer == NULL) {
> +               ret = -ENOMEM;
> +               goto err_free_host;
> +       }
> +
> +       host->sdphy = devm_platform_ioremap_resource_byname(pdev, "phy");

So reg-names is required ;-)

> +       if (IS_ERR(host->sdphy)) {
> +               ret = PTR_ERR(host->sdphy);
> +               goto err_free_dma;
> +       }
> +
> +       host->sdcore = devm_platform_ioremap_resource_byname(pdev, "core");
> +       if (IS_ERR(host->sdcore)) {
> +               ret = PTR_ERR(host->sdcore);
> +               goto err_free_dma;
> +       }
> +
> +       host->sdreader = devm_platform_ioremap_resource_byname(pdev, "reader");
> +       if (IS_ERR(host->sdreader)) {
> +               ret = PTR_ERR(host->sdreader);
> +               goto err_free_dma;
> +       }
> +
> +       host->sdwriter = devm_platform_ioremap_resource_byname(pdev, "writer");
> +       if (IS_ERR(host->sdwriter)) {
> +               ret = PTR_ERR(host->sdwriter);
> +               goto err_free_dma;
> +       }
> +
> +       if (host->irq > 0) {
> +               host->sdirq = devm_platform_ioremap_resource_byname(pdev, "irq");

So you need a "minItems: 4" for reg{,-names} in the DT bindings.

> +               if (IS_ERR(host->sdirq)) {
> +                       ret = PTR_ERR(host->sdirq);
> +                       goto err_free_dma;
> +               }
> +       }
> +
> +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +       mmc->ops = &litex_mmc_ops;
> +
> +       mmc->f_min = 12.5e6;
> +       mmc->f_max = 50e6;
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
> +       /* ensure DMA bus masters are disabled */
> +       litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
> +       litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
> +
> +       /* set up interrupt handler */
> +       if (host->irq > 0) {
> +               ret = request_irq(host->irq, litex_mmc_interrupt, 0,
> +                                 "litex-mmc", mmc);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev,
> +                               "irq setup error %d, using polling\n", ret);
> +                       host->irq = 0;
> +               }
> +       }
> +
> +       /* enable card-change interrupts, or else ask for polling */
> +       if (host->irq > 0) {
> +               litex_write32(host->sdirq + LITEX_IRQ_PENDING,
> +                             SDIRQ_CARD_DETECT);       /* clears it */
> +               litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
> +                             SDIRQ_CARD_DETECT);
> +       } else {
> +               mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       }
> +
> +       return 0;
> +
> +err_free_dma:
> +       dma_free_coherent(&pdev->dev, host->buf_size, host->buffer, host->dma);
> +err_free_host:
> +       mmc_free_host(mmc);
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
