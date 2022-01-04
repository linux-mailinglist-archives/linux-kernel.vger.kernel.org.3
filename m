Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5C483975
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiADA1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiADA13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:27:29 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B2C061761;
        Mon,  3 Jan 2022 16:27:29 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b85so33354396qkc.1;
        Mon, 03 Jan 2022 16:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MgMhKljyM3NnbejnPvS6grQU9qjmnNC1uMJfZTG0tFA=;
        b=LxA0VboRixSlttUZ8mvYgNquT5fwWzr6Jg8BW7PduUSnqtvUasz1PvrHpymB3/Bm6d
         nv57N3Fhfo+D7uhQdFkF9Lsd9fYSPSxBHw67us6tjqwyWkM/o69i01w+K96avG1/FWlw
         z6oVWlNwGaAiDB9/mLmVO6m+1f1xw7PMJuSUv0mo8suMJOjMq+B2rkYHhAYhAXUbKMtA
         SH0/fm406VFV/dIGLDOvJ8RvtTt0jHjC5tSNLY7j42OK24T1EC+LxgugveA35smsrzV3
         w3tCKmrtnR4fDj9z3OXIBemYmcHXABwOYQAiHZLdEqAdyg1ueicWTfOxSunT2CuaF3i3
         yBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MgMhKljyM3NnbejnPvS6grQU9qjmnNC1uMJfZTG0tFA=;
        b=RVt7ZLo2UPoGXv3amz+U79SvynXo79ugg5AoAr988d/o7x0Fch61nDbN0KjCHSL4Rq
         rJ7lsU4kcnlZyPmGORbyv9HtDp1QT15+Pq271YNgogVOsZbSlmDkI2To/6uib+NgA7ur
         53QFgMYZiNPSTz70nw7kZK6C3Sv6n/JQrukXqRekS4x2iQDY8kgoR6r8hJmCrWrvBJGc
         3E+YpjsEp0EMzxO4wgSlvmUHisFmx9/dgjFs4z4LKdWWcSh2o9+WshGTT2ZwPBLrDo29
         zobgF4hBko0p/mGysPbzhF3KePWDVs0NrA6w+wom+JDHdp+ZPbCAmjUf9M1XS4rrP2Ll
         1wXw==
X-Gm-Message-State: AOAM533wqiVwOkNy8y74t9yCkl31OcaFQekEGW1dhMs/p0zpEZBKq65h
        elqSpx71z13ujEx7psiSruk=
X-Google-Smtp-Source: ABdhPJzatLHcyAhV0z3L73FpKuTfqeejt7k/VziOnEsqM1Fz0zrOr8Lc3nvgAl/Mj9S+cqBX++JR4A==
X-Received: by 2002:a05:620a:68a:: with SMTP id f10mr33649686qkh.651.1641256048340;
        Mon, 03 Jan 2022 16:27:28 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id d9sm30192004qkn.131.2022.01.03.16.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 16:27:27 -0800 (PST)
Date:   Mon, 3 Jan 2022 19:27:25 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu>
References: <20211215130711.111186-1-gsomlo@gmail.com>
 <20211215130711.111186-4-gsomlo@gmail.com>
 <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback! Some replies and follow-up comments below.

On Tue, Dec 28, 2021 at 05:15:25PM +0100, Ulf Hansson wrote:
> On Wed, 15 Dec 2021 at 14:09, Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> >
> > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Cc: Karol Gugala <kgugala@antmicro.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: David Abdurachmanov <david.abdurachmanov@sifive.com>
> > Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> [...]
> 
> > +
> > +static int litex_mmc_set_bus_width(struct litex_mmc_host *host)
> > +{
> > +       bool app_cmd_sent;
> > +       int ret;
> > +
> > +       if (host->is_bus_width_set)
> > +               return 0;
> > +
> > +       /* ensure 'app_cmd' precedes 'app_set_bus_width_cmd' */
> > +       app_cmd_sent = host->app_cmd; /* was preceding command app_cmd? */
> > +       if (!app_cmd_sent) {
> > +               ret = litex_mmc_send_app_cmd(host);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       /* litesdcard only supports 4-bit bus width */
> > +       ret = litex_mmc_send_set_bus_w_cmd(host, MMC_BUS_WIDTH_4);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* re-send 'app_cmd' if necessary */
> > +       if (app_cmd_sent) {
> > +               ret = litex_mmc_send_app_cmd(host);
> > +               if (ret)
> > +                       return ret;
> > +       }
> 
> I understand that you are trying to address the limitation that the
> controller supports 4-bit width only. In principle it looks like we
> may need to violate the SD spec to be able to initialise an SD card,
> right? Isn't that a concern for you?

This would only be a concern for SDcard media that do not support
4-bit wide data transfer (if any such models even/still exist!). This
driver simply forces 4-bit wide data mode as soon as the very first
data transfer is "snooped", which is AFAICT legal w.r.t. the spec.

If the card does not support 4-bit wide data transfers, then
litex_mmc_set_bus_width() will fail, and the card will fail to
initialize, but I don't foresee much of anything else going wrong.
 
> > +
> > +       host->is_bus_width_set = true;
> > +
> > +       return 0;
> > +}
> 
> [...]
> 
> > +
> > +static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > +{
> > +       struct litex_mmc_host *host = mmc_priv(mmc);
> > +       struct device *dev = mmc_dev(mmc);
> > +       struct mmc_command *cmd = mrq->cmd;
> > +       struct mmc_command *sbc = mrq->sbc;
> > +       struct mmc_data *data = mrq->data;
> > +       struct mmc_command *stop = mrq->stop;
> > +       unsigned int retries = cmd->retries;
> > +       unsigned int len = 0;
> > +       bool direct = false;
> > +       u32 response_len = litex_mmc_response_len(cmd);
> > +       u8 transfer = SD_CTL_DATA_XFER_NONE;
> > +
> > +       /* First check that the card is still there */
> > +       if (!litex_mmc_get_cd(mmc)) {
> > +               cmd->error = -ENOMEDIUM;
> > +               mmc_request_done(mmc, mrq);
> > +               return;
> > +       }
> > +
> > +       /* Send set-block-count command if needed */
> > +       if (sbc) {
> > +               sbc->error = litex_mmc_send_cmd(host, sbc->opcode, sbc->arg,
> > +                                               litex_mmc_response_len(sbc),
> > +                                               SD_CTL_DATA_XFER_NONE);
> > +               if (sbc->error) {
> > +                       host->is_bus_width_set = false;
> > +                       mmc_request_done(mmc, mrq);
> > +                       return;
> > +               }
> > +       }
> > +
> > +       if (data) {
> > +               /* LiteSDCard only supports 4-bit bus width; therefore, we MUST
> > +                * inject a SET_BUS_WIDTH (acmd6) before the very first data
> > +                * transfer, earlier than when the mmc subsystem would normally
> > +                * get around to it!
> 
> This means that you may end up trying to switch bus-width, to a width
> that isn't supported by the card, for example.
> 
> As also stated above, I wonder how this conforms to the SD spec from
> the initialization sequence point of view. Have you verified that this
> isn't a problem?

During litex_mmc_probe(), I have:

	...
        ret = mmc_of_parse(mmc);
        if (ret)
                goto err;

        /* force 4-bit bus_width (only width supported by hardware) */
        mmc->caps &= ~MMC_CAP_8_BIT_DATA;
        mmc->caps |= MMC_CAP_4_BIT_DATA;
	...

This ensures no bus-width switches to anything other than 4-bit data
should ever occur. As far as I understand the SDcard spec, it's legal
to both send multiple redundant bus-width-set commands, and to start
doing so before the very first data transfer request is processed
(regardless of the fact that linux typically does a few 1-bit-wide
data transfers during card initialization before switching to a wider
mode, if available).

This driver simply ensures that any time we ever have a data transfer,
the bus width is set to 4 *before* said transfer is acted upon.

As I mentioned earlier, if we get a "weird" SDcard that can't support
4-bit data transfers, its initialization should fail shortly after
detection, and that's all there is to it, as far as I can tell.

> > +                */
> > +               cmd->error = litex_mmc_set_bus_width(host);
> > +               if (cmd->error) {
> > +                       dev_err(dev, "Can't set bus width!\n");
> > +                       mmc_request_done(mmc, mrq);
> > +                       return;
> > +               }
> > +
> > +               litex_mmc_do_dma(host, data, &len, &direct, &transfer);
> > +       }
> > +
> > +       do {
> > +               cmd->error = litex_mmc_send_cmd(host, cmd->opcode, cmd->arg,
> > +                                               response_len, transfer);
> > +       } while (cmd->error && retries-- > 0);
> > +
> > +       if (cmd->error) {
> > +               /* card may be gone; don't assume bus width is still set */
> > +               host->is_bus_width_set = false;
> > +       }
> > +
> > +       if (response_len == SD_CTL_RESP_SHORT) {
> > +               /* pull short response fields from appropriate host registers */
> > +               cmd->resp[0] = host->resp[3];
> > +               cmd->resp[1] = host->resp[2] & 0xFF;
> > +       } else if (response_len == SD_CTL_RESP_LONG) {
> > +               cmd->resp[0] = host->resp[0];
> > +               cmd->resp[1] = host->resp[1];
> > +               cmd->resp[2] = host->resp[2];
> > +               cmd->resp[3] = host->resp[3];
> > +       }
> > +
> > +       /* Send stop-transmission command if required */
> > +       if (stop && (cmd->error || !sbc)) {
> > +               stop->error = litex_mmc_send_cmd(host, stop->opcode, stop->arg,
> > +                                                litex_mmc_response_len(stop),
> > +                                                SD_CTL_DATA_XFER_NONE);
> > +               if (stop->error)
> > +                       host->is_bus_width_set = false;
> > +       }
> > +
> > +       if (data) {
> > +               dma_unmap_sg(dev, data->sg, data->sg_len,
> > +                            mmc_get_dma_dir(data));
> > +       }
> > +
> > +       if (!cmd->error && transfer != SD_CTL_DATA_XFER_NONE) {
> > +               data->bytes_xfered = min(len, mmc->max_req_size);
> > +               if (transfer == SD_CTL_DATA_XFER_READ && !direct) {
> > +                       sg_copy_from_buffer(data->sg, sg_nents(data->sg),
> > +                                           host->buffer, data->bytes_xfered);
> > +               }
> > +       }
> > +
> > +       mmc_request_done(mmc, mrq);
> > +}
> > +
> 
> [...]
> 
> > +
> > +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> 
> I noticed that you use these hard coded values and don't really care
> to manage voltage changes via ->set_ios().
> 
> Rather than doing it like this, I would prefer if you can hook up a
> fixed vmmc regulator in the DTS. Then call mmc_regulator_get_supply()
> to fetch it from here, which will let the mmc core create the
> mmc->ocr_avail mask, based upon the voltage level the regulator
> supports.
> 
> This becomes more generic and allows more flexibility for the platform
> configuration.

The LiteSDCard "hardware" (i.e., *gateware*) does not allow modification
or selection of voltage from the software side. When a CMD8 is issued,
the "voltage supplied" bit pattern is expected to be '0001b', which per
the spec means "2.7-3.6V". 

I tried adding this to the overall DTS:

	vreg_mmc: vreg_mmc_3v {
		compatible = "regulator-fixed";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
	};

and then added a reference to it to the LiteSDCard "mmc0" node in DTS,
like so:

	mmc0: mmc@12005000 {
		compatible = "litex,mmc";
		reg = <0x12005000 0x100>,
			<0x12003800 0x100>,
			<0x12003000 0x100>,
			<0x12004800 0x100>,
			<0x12004000 0x100>;
		reg-names = "phy", "core", "reader", "writer", "irq";
		clocks = <&sys_clk>;
		vmmc-supply = <&vreg_mmc>; /* <-------- HERE !!! */
		interrupt-parent = <&L1>;
		interrupts = <4>;
	};

Finally, I replaced the hardcoded setting of `mmc->ocr_avail` with a
call to `mmc_regulator_get_supply(mmc)`. Now, I get a bunch of timeouts
during attempts to send e.g., CMD8 and CMD55.
(going for 3200000 and 3400000 for min- and max-microvolt, respectively,
 -- or anything else in the allowed 2.7-3.6 range -- doesn't help either).

I might be doing something subtly wrong in the way I set things up
above, but it feels a bit overengineered, and IMHO fragile.

OTOH, going all out and setting:

        /* allow for generic 2.7-3.6V range, no software tuning available */
        mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
                         MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
                         MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;

seems to work just fine... :) Please do let me know what you think!
 
> > +       mmc->ops = &litex_mmc_ops;
> > +
> > +       /* set default sd_clk frequency range based on empirical observations
> > +        * of LiteSDCard gateware behavior on typical SDCard media
> > +        */
> > +       mmc->f_min = 12.5e6;
> > +       mmc->f_max = 50e6;
> > +
> > +       ret = mmc_of_parse(mmc);
> > +       if (ret)
> > +               goto err;
> > +
> > +       /* force 4-bit bus_width (only width supported by hardware) */
> > +       mmc->caps &= ~MMC_CAP_8_BIT_DATA;
> > +       mmc->caps |= MMC_CAP_4_BIT_DATA;
> > +
> > +       /* set default capabilities */
> > +       mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
> > +                    MMC_CAP_DRIVER_TYPE_D |
> > +                    MMC_CAP_CMD23;
> > +       mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT |
> > +                     MMC_CAP2_FULL_PWR_CYCLE |
> 
> A full power cycle requires you to be able to power on/off the vmmc
> regulator (unless this is internally managed by the controller). Can
> you really do that?

Nope, I cannot -- so I removed MMC_CAP2_FULL_PWR_CYCLE from the list,
should be there in v6 of the series. Thanks for pointing that out!

> > +                     MMC_CAP2_NO_SDIO;
> 
> We should add MMC_CAP2_NO_MMC here as well, as it looks like it can't
> be supported. Right?

Right, and done -- lined up for v6.

> > +
> > +       platform_set_drvdata(pdev, host);
> > +
> > +       ret = mmc_add_host(mmc);
> > +       if (ret < 0)
> > +               goto err;
> > +
> > +       return 0;
> > +
> > +err:
> > +       mmc_free_host(mmc);
> > +       return ret;
> > +}
> > +
> > +static int litex_mmc_remove(struct platform_device *pdev)
> > +{
> > +       struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
> > +
> > +       if (host->irq > 0)
> > +               free_irq(host->irq, host->mmc);
> > +       mmc_remove_host(host->mmc);
> > +       mmc_free_host(host->mmc);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id litex_match[] = {
> > +       { .compatible = "litex,mmc" },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, litex_match);
> > +
> > +static struct platform_driver litex_mmc_driver = {
> > +       .probe = litex_mmc_probe,
> > +       .remove = litex_mmc_remove,
> > +       .driver = {
> > +               .name = "litex-mmc",
> > +               .of_match_table = of_match_ptr(litex_match),
> > +       },
> > +};
> > +module_platform_driver(litex_mmc_driver);
> > +
> > +MODULE_DESCRIPTION("LiteX SDCard driver");
> > +MODULE_AUTHOR("Antmicro <contact@antmicro.com>");
> > +MODULE_AUTHOR("Kamil Rakoczy <krakoczy@antmicro.com>");
> > +MODULE_AUTHOR("Maciej Dudek <mdudek@internships.antmicro.com>");
> > +MODULE_AUTHOR("Paul Mackerras <paulus@ozlabs.org>");
> > +MODULE_AUTHOR("Gabriel Somlo <gsomlo@gmail.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> 
> Other than the comments above, the code looks nice and was easy to
> review, thanks!

Thanks again for the review, and please LMK about the voltage regulator
question.

Happy New Year,
--Gabriel
