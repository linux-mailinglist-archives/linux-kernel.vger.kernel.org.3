Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A13480B26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhL1QQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhL1QQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:16:04 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA8C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:16:03 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h15so18046167ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4k4njwm7hK6Z45dckiCYbmCzLy/kr0ugHzYUGxbiInU=;
        b=Ek1p4foThB+yuOnIzjsvfQr0fFSjQQbiQsGxSFJiUd5rHYVeapqJevPb/9EV2nu/sX
         OKfWCPftZmWx7EaXMwLeJy7Zyb8qp+0Hvfi5OVPkBuO7l1LPehb9xKumZsXCpNocn5DV
         8Ksiw5vFs4+EpTjsM0G+HaPQWiY3qGK6QQu1sgkluuLle+YYkZzYuympAB6sjyJjYe5R
         EuRwoi5Fi3knGB29CgLT7eeP5o3jhQloStL+/7j+LaveK7oV0fGpJNIDETtMWOJfPG7B
         NHgFuvCyU4lYGq7MTiUCxgW2h5/OZ64c6ArCfWQE/P0iOWw5Da8Zr02Rr2MTN4VVVas/
         cETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4k4njwm7hK6Z45dckiCYbmCzLy/kr0ugHzYUGxbiInU=;
        b=muN6khyO3PM4Tg14K2U23O1YIE/mzkeD/LNfO9Twy3VAYxcn4oEjN1KjdOEGanfkXT
         TtFnU8QVlm2NByAhhNwDhiXsm00cgyfRrOnzwNamk05pTmpQFPFAkOsr5byNbFYodWiI
         hC0V9MfTjOjoKwhG2woaH1/f6CcsYIGlkfdRgw/6fArKuaBIp7l9gLaV2hSq72PsLJZW
         AoQGjBnlYDxX6nnKDV9vP7rfakNGXI2hD1+uMhtKXywhgeQyW65GIztGC+Qn5Nscwes/
         H+DRnr/kxJCkt1LpfysxlkVxy8r13XNxEIRXjJmiu95wxDto48itDJDRedZquoBbfYQS
         hmYQ==
X-Gm-Message-State: AOAM5327RdTMKl52/2HNsw1z0ZxyaoFt/RH+64yVGT58j2M8OM8Rh2Ee
        FkG4cJ/Q9friUkgoVuMIFm3E9zIKuWovQ8knflaX9g==
X-Google-Smtp-Source: ABdhPJz2MeuKH/Nzw6lbMyBsvACOeWh7uQV47y66mmJQhZsIRESHcyGkt6EGEiX3GcFZ29eJLYbs9f2LPwsdlGEzjSY=
X-Received: by 2002:a2e:9659:: with SMTP id z25mr17154594ljh.16.1640708162009;
 Tue, 28 Dec 2021 08:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20211215130711.111186-1-gsomlo@gmail.com> <20211215130711.111186-4-gsomlo@gmail.com>
In-Reply-To: <20211215130711.111186-4-gsomlo@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:15:25 +0100
Message-ID: <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 14:09, Gabriel Somlo <gsomlo@gmail.com> wrote:
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
> Reviewed-by: Joel Stanley <joel@jms.id.au>

[...]

> +
> +static int litex_mmc_set_bus_width(struct litex_mmc_host *host)
> +{
> +       bool app_cmd_sent;
> +       int ret;
> +
> +       if (host->is_bus_width_set)
> +               return 0;
> +
> +       /* ensure 'app_cmd' precedes 'app_set_bus_width_cmd' */
> +       app_cmd_sent = host->app_cmd; /* was preceding command app_cmd? */
> +       if (!app_cmd_sent) {
> +               ret = litex_mmc_send_app_cmd(host);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* litesdcard only supports 4-bit bus width */
> +       ret = litex_mmc_send_set_bus_w_cmd(host, MMC_BUS_WIDTH_4);
> +       if (ret)
> +               return ret;
> +
> +       /* re-send 'app_cmd' if necessary */
> +       if (app_cmd_sent) {
> +               ret = litex_mmc_send_app_cmd(host);
> +               if (ret)
> +                       return ret;
> +       }

I understand that you are trying to address the limitation that the
controller supports 4-bit width only. In principle it looks like we
may need to violate the SD spec to be able to initialise an SD card,
right? Isn't that a concern for you?

> +
> +       host->is_bus_width_set = true;
> +
> +       return 0;
> +}

[...]

> +
> +static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct litex_mmc_host *host = mmc_priv(mmc);
> +       struct device *dev = mmc_dev(mmc);
> +       struct mmc_command *cmd = mrq->cmd;
> +       struct mmc_command *sbc = mrq->sbc;
> +       struct mmc_data *data = mrq->data;
> +       struct mmc_command *stop = mrq->stop;
> +       unsigned int retries = cmd->retries;
> +       unsigned int len = 0;
> +       bool direct = false;
> +       u32 response_len = litex_mmc_response_len(cmd);
> +       u8 transfer = SD_CTL_DATA_XFER_NONE;
> +
> +       /* First check that the card is still there */
> +       if (!litex_mmc_get_cd(mmc)) {
> +               cmd->error = -ENOMEDIUM;
> +               mmc_request_done(mmc, mrq);
> +               return;
> +       }
> +
> +       /* Send set-block-count command if needed */
> +       if (sbc) {
> +               sbc->error = litex_mmc_send_cmd(host, sbc->opcode, sbc->arg,
> +                                               litex_mmc_response_len(sbc),
> +                                               SD_CTL_DATA_XFER_NONE);
> +               if (sbc->error) {
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

This means that you may end up trying to switch bus-width, to a width
that isn't supported by the card, for example.

As also stated above, I wonder how this conforms to the SD spec from
the initialization sequence point of view. Have you verified that this
isn't a problem?

> +                */
> +               cmd->error = litex_mmc_set_bus_width(host);
> +               if (cmd->error) {
> +                       dev_err(dev, "Can't set bus width!\n");
> +                       mmc_request_done(mmc, mrq);
> +                       return;
> +               }
> +
> +               litex_mmc_do_dma(host, data, &len, &direct, &transfer);
> +       }
> +
> +       do {
> +               cmd->error = litex_mmc_send_cmd(host, cmd->opcode, cmd->arg,
> +                                               response_len, transfer);
> +       } while (cmd->error && retries-- > 0);
> +
> +       if (cmd->error) {
> +               /* card may be gone; don't assume bus width is still set */
> +               host->is_bus_width_set = false;
> +       }
> +
> +       if (response_len == SD_CTL_RESP_SHORT) {
> +               /* pull short response fields from appropriate host registers */
> +               cmd->resp[0] = host->resp[3];
> +               cmd->resp[1] = host->resp[2] & 0xFF;
> +       } else if (response_len == SD_CTL_RESP_LONG) {
> +               cmd->resp[0] = host->resp[0];
> +               cmd->resp[1] = host->resp[1];
> +               cmd->resp[2] = host->resp[2];
> +               cmd->resp[3] = host->resp[3];
> +       }
> +
> +       /* Send stop-transmission command if required */
> +       if (stop && (cmd->error || !sbc)) {
> +               stop->error = litex_mmc_send_cmd(host, stop->opcode, stop->arg,
> +                                                litex_mmc_response_len(stop),
> +                                                SD_CTL_DATA_XFER_NONE);
> +               if (stop->error)
> +                       host->is_bus_width_set = false;
> +       }
> +
> +       if (data) {
> +               dma_unmap_sg(dev, data->sg, data->sg_len,
> +                            mmc_get_dma_dir(data));
> +       }
> +
> +       if (!cmd->error && transfer != SD_CTL_DATA_XFER_NONE) {
> +               data->bytes_xfered = min(len, mmc->max_req_size);
> +               if (transfer == SD_CTL_DATA_XFER_READ && !direct) {
> +                       sg_copy_from_buffer(data->sg, sg_nents(data->sg),
> +                                           host->buffer, data->bytes_xfered);
> +               }
> +       }
> +
> +       mmc_request_done(mmc, mrq);
> +}
> +

[...]

> +
> +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;

I noticed that you use these hard coded values and don't really care
to manage voltage changes via ->set_ios().

Rather than doing it like this, I would prefer if you can hook up a
fixed vmmc regulator in the DTS. Then call mmc_regulator_get_supply()
to fetch it from here, which will let the mmc core create the
mmc->ocr_avail mask, based upon the voltage level the regulator
supports.

This becomes more generic and allows more flexibility for the platform
configuration.

> +       mmc->ops = &litex_mmc_ops;
> +
> +       /* set default sd_clk frequency range based on empirical observations
> +        * of LiteSDCard gateware behavior on typical SDCard media
> +        */
> +       mmc->f_min = 12.5e6;
> +       mmc->f_max = 50e6;
> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               goto err;
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

A full power cycle requires you to be able to power on/off the vmmc
regulator (unless this is internally managed by the controller). Can
you really do that?

> +                     MMC_CAP2_NO_SDIO;

We should add MMC_CAP2_NO_MMC here as well, as it looks like it can't
be supported. Right?

> +
> +       platform_set_drvdata(pdev, host);
> +
> +       ret = mmc_add_host(mmc);
> +       if (ret < 0)
> +               goto err;
> +
> +       return 0;
> +
> +err:
> +       mmc_free_host(mmc);
> +       return ret;
> +}
> +
> +static int litex_mmc_remove(struct platform_device *pdev)
> +{
> +       struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
> +
> +       if (host->irq > 0)
> +               free_irq(host->irq, host->mmc);
> +       mmc_remove_host(host->mmc);
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
> +MODULE_AUTHOR("Antmicro <contact@antmicro.com>");
> +MODULE_AUTHOR("Kamil Rakoczy <krakoczy@antmicro.com>");
> +MODULE_AUTHOR("Maciej Dudek <mdudek@internships.antmicro.com>");
> +MODULE_AUTHOR("Paul Mackerras <paulus@ozlabs.org>");
> +MODULE_AUTHOR("Gabriel Somlo <gsomlo@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> --

Other than the comments above, the code looks nice and was easy to
review, thanks!

Kind regards
Uffe
