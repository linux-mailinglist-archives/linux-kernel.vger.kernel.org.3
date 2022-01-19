Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0724942D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357507AbiASWKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiASWKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:10:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6AAC061574;
        Wed, 19 Jan 2022 14:09:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m4so19762820edb.10;
        Wed, 19 Jan 2022 14:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6or7b7oqi8XFp99LE1mG3pzyrTEJswEM16arcf7f0I=;
        b=UMqkxnBt6aLrXaSapBHlKgFN8aCbqQSs8tXggu1ZkYiojIXlwsHq4x0I4VQeg13Epo
         sev/AOy30SepvcfendfuDxb2wCEHrAFwgRgICSzkNJj02hkQm53jmIiwRZs+79T8VLwF
         vstt37/tEA9UG3bdV0DJQV1TsXsFTogX/d7ZvgzMpJ6DJFDG698JR5deYtXnTyjRzcgo
         CkkjBox+c6effH0Qg6AazCp/ogT8jRURwELF5t4UyXSNHPtKoC5y+STx1+6z+HsbUrDK
         GjSpwR66sML+U504Kf1WfHEGu5/nCIrxj5RNFM9MQhPazEVT1dxFLpSceJXNF0FPdqUG
         P8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6or7b7oqi8XFp99LE1mG3pzyrTEJswEM16arcf7f0I=;
        b=Z8E5lyDgf+RgGvy9s4HEtTO7lLUPEa1MQQ6rqE1ABYY0DznN8aHl24bLzCUlWj5MQK
         K4n9hcQWsm07nJUzl7qK+Rzj9SUJJWJcznOvQ4l7yeTMzOUVF6ZCApfV1p17N3bSd/dw
         jEzqXnoebXVaowwLpXYC1Zjd8nf++UwSbe9rrE8koDxa8NTZE5HaVkN0FDomMM7qSIG7
         tfzyqnR/K68UhzJgfUxg4dzM1iqScGL/Y447pWrRu1UAm0Ys5wGyHM4JWY9SiHWxR+oI
         sGCJe3BlnSERqiI1Zq50ajdsiMxHrnYkch9A1SI1TOrQj7qSIi+ofDua2mBqwgik3Qx7
         dmDw==
X-Gm-Message-State: AOAM532kboRMhw/zyQrrw2vFomiwtTY9Qtg588v+Sa7Y3lB3wTSWiXQf
        kQLyDYU3+aoq55zm7gXjeu1M9RwpA2MJKeIj72i065oA2MHiDQ==
X-Google-Smtp-Source: ABdhPJzCl4jeYWptkDzVUHUs+r7tiuZtgfCFGy1NCN0+ZAsvwzJAWJT6n9DUvkNQ/BDwZOQQVBNKD5l2zuiZHkQjTpY=
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr8284452ejo.636.1642630197897;
 Wed, 19 Jan 2022 14:09:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642494310.git.lhjeff911@gmail.com> <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
In-Reply-To: <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jan 2022 00:08:15 +0200
Message-ID: <CAHp75VdKc3UDzaqM2G5J5+G90U6Spqyhz_vuOYKhqJ4V-uf=wg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:42 AM Li-hao Kuo <lhjeff911@gmail.com> wrote:
>
> Add spi driver for Sunplus SP7021.

...

> Changes in v6:

Thanks for update, my comments below.

...

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>

...

> +       data_status = readl(pspim->s_base + SP7021_DATA_RDY_REG);
> +       writel(data_status | SP7021_SLAVE_CLR_INT, pspim->s_base + SP7021_DATA_RDY_REG);

Wouldn't be

       data_status = readl(pspim->s_base + SP7021_DATA_RDY_REG);
       data_status |= SP7021_SLAVE_CLR_INT;
       writel(data_status, pspim->s_base + SP7021_DATA_RDY_REG);

better to read? Same question to other places like this.

...

> +       writel(SP7021_SLAVE_DMA_EN | SP7021_SLAVE_DMA_RW | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
> +              pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);

Temporary variable?
var = ...

...

> +       writel(readl(pspim->s_base + SP7021_DATA_RDY_REG) | SP7021_SLAVE_DATA_RDY,
> +              pspim->s_base + SP7021_DATA_RDY_REG);

Ditto.

...

> +int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
> +{
> +       struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);

> +       int ret = 0;

Unused.

...

> +       writel(SP7021_SLAVE_DMA_EN | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
> +              pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);

Temporary variable?

...

> +static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
> +{
> +       struct sp7021_spi_ctlr *pspim = dev;
> +       unsigned int tx_cnt, total_len;
> +       unsigned int tx_len, rx_cnt;
> +       unsigned int fd_status;

> +       unsigned long flags;

Why do you need this?

> +       bool isrdone = false;
> +       u32 value;

> +       return IRQ_HANDLED;
> +}

...

> +       div = clk_rate / xfer->speed_hz;
> +       if (div < 2)
> +               div = 2;

div = max(2U, clk_rate / xfer->speed_hz); ?

...

> +static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
> +                                      struct spi_transfer *xfer)
> +{
> +       struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
> +       unsigned long timeout = msecs_to_jiffies(1000);
> +       unsigned int xfer_cnt, xfer_len, last_len;
> +       unsigned int i, len_temp;
> +       u32 reg_temp;

> +       int ret;

Seems redundant.

> +       xfer_cnt = xfer->len / SP7021_SPI_DATA_SIZE;
> +       last_len = xfer->len % SP7021_SPI_DATA_SIZE;
> +
> +       for (i = 0; i <= xfer_cnt; i++) {
> +               mutex_lock(&pspim->buf_lock);
> +               sp7021_prep_transfer(ctlr, spi);
> +               sp7021_spi_setup_clk(ctlr, xfer);
> +               reinit_completion(&pspim->isr_done);

> +               if (i == xfer_cnt)
> +                       xfer_len = last_len;
> +               else
> +                       xfer_len = SP7021_SPI_DATA_SIZE;
> +
> +               pspim->tx_buf = xfer->tx_buf + i * SP7021_SPI_DATA_SIZE;
> +               pspim->rx_buf = xfer->rx_buf + i * SP7021_SPI_DATA_SIZE;
> +
> +               if (pspim->tx_cur_len < xfer_len) {
> +                       len_temp = min(pspim->data_unit, xfer_len);
> +                       sp7021_spi_master_wb(pspim, len_temp);
> +               }
> +               reg_temp = readl(pspim->m_base + SP7021_SPI_CONFIG_REG);
> +               reg_temp &= ~SP7021_CLEAN_RW_BYTE;
> +               reg_temp &= ~SP7021_CLEAN_FLUG_MASK;
> +               reg_temp |= SP7021_FD_SEL | SP7021_FINISH_FLAG_MASK |
> +                           SP7021_TX_EMP_FLAG_MASK | SP7021_RX_FULL_FLAG_MASK |
> +                           FIELD_PREP(SP7021_TX_UNIT, 0) | FIELD_PREP(SP7021_RX_UNIT, 0);
> +               writel(reg_temp, pspim->m_base + SP7021_SPI_CONFIG_REG);
> +
> +               reg_temp = FIELD_PREP(SP7021_SET_TX_LEN, xfer_len) |
> +                                     FIELD_PREP(SP7021_SET_XFER_LEN, xfer_len) |
> +                                     SP7021_SPI_START_FD;
> +               writel(reg_temp, pspim->m_base + SP7021_SPI_STATUS_REG);
> +
> +               if (!wait_for_completion_interruptible_timeout(&pspim->isr_done, timeout)) {
> +                       dev_err(&spi->dev, "wait_for_completion err\n");
> +                       return -ETIMEDOUT;
> +               }
> +
> +               reg_temp = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
> +               if (reg_temp & SP7021_FINISH_FLAG) {
> +                       writel(SP7021_FINISH_FLAG, pspim->m_base + SP7021_SPI_STATUS_REG);
> +                       writel(readl(pspim->m_base + SP7021_SPI_CONFIG_REG) &
> +                               SP7021_CLEAN_FLUG_MASK, pspim->m_base + SP7021_SPI_CONFIG_REG);
> +               }
> +
> +               if (pspim->xfer_conf & SP7021_CPOL_FD)
> +                       writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
> +
> +               mutex_unlock(&pspim->buf_lock);
> +               ret = 0;
> +       }
> +       return ret;
> +}

...

> +static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
> +                                      struct spi_transfer *xfer)
> +{
> +       struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
> +       struct device *dev = pspim->dev;

> +       int mode, ret = 0;

ret assignment can be moved to the default case below, where it will
naturally fit.

> +       mode = SP7021_SPI_IDLE;

> +       if (xfer->tx_buf && xfer->rx_buf) {
> +               dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
> +               ret = -EINVAL;

Do you need this check if you properly set the capabilities of the controller?
If still needed, why not return here?

> +       } else if (xfer->tx_buf) {
> +               xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
> +                                             xfer->len, DMA_TO_DEVICE);
> +               if (dma_mapping_error(dev, xfer->tx_dma))
> +                       return -ENOMEM;
> +               mode = SP7021_SLAVE_WRITE;
> +       } else if (xfer->rx_buf) {
> +               xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
> +                                             DMA_FROM_DEVICE);
> +               if (dma_mapping_error(dev, xfer->rx_dma))
> +                       return -ENOMEM;
> +               mode = SP7021_SLAVE_READ;
> +       }
> +
> +       switch (mode) {
> +       case SP7021_SLAVE_WRITE:
> +               ret = sp7021_spi_slave_tx(spi, xfer);
> +               break;
> +       case SP7021_SLAVE_READ:
> +               ret = sp7021_spi_slave_rx(spi, xfer);
> +               break;
> +       default:
> +               break;
> +       }
> +       if (xfer->tx_buf)
> +               dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
> +       if (xfer->rx_buf)
> +               dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);

Why can't you use SPI core DMA mapping code?

> +       spi_finalize_current_transfer(ctlr);
> +       return ret;
> +}

...

> +       device_set_node(&ctlr->dev, pdev->dev.fwnode);

Use dev_fwnode() in the second argument.

-- 
With Best Regards,
Andy Shevchenko
