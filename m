Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A61648B13C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349678AbiAKPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349680AbiAKPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:47:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C23C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:47:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u13so57698135lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tyz0T3L5k7JVLSkVqRRc1uuQG+s11vxFwAGLpKTJ+E=;
        b=S05PZim50ADuyvdHy52t6o3qwwkc4mQ7t2wHME7HE4aOnu7oGxIbAi5pN4NgXn0iuM
         f9jPBkCwfOhdfJnfQ8+EiAC8uYjrlwcV8aipZ7hJS3yOGBtcjfEf722jnUzwGN8g78M7
         iQmInD2F/UNohSAgF9tz2+yVKL+AjYwbEKNt5xBmdfKAvLzs9ScYr+UxEc8nT6cfPZjC
         dmkWmjApy5VnGLk4FG7a1190odkdCHua0fbuCoz9Ij7V3ZkKIbSnXYes4Ye+RESMYkao
         OwCW3Do6GfjiNum97xF/n/emaloK0vo9mxFAhs3qID+5SJIZtdUXk38SJQ1/1dPD9LiV
         v61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tyz0T3L5k7JVLSkVqRRc1uuQG+s11vxFwAGLpKTJ+E=;
        b=btneZI0jRLW4lURPqLfm7c3QyS20o2svVQ4i418NhWuNHKLOV/fKUYQpE7fGe2IfQ5
         zhuo0MdjhWUhjk5e8JDqeA7QcEDZHxOe3ujQggXAUVsOL9uRfShLprwHdQ6IaZM09vil
         yuAdZuj6A5TKzBewoZg9Pew44LXkfQktvVL/J+mNjOy4+xlA/IK74C0DixqIap5ZulGS
         hkD2B3Me44+dtZc8ulHjADXi/R298y4GilYMyY98PLb4mh1r7dwPHY+atCPwKgQN4Flx
         V7KrQF33KMS2LCsYTGZf0M86cqwWcsUAidVtnttXbmH4sesN7b3Ep2Xca9KPuIu4CTQd
         GjiA==
X-Gm-Message-State: AOAM532KKWLxuuLypE2uuKoe15doDJI8Ecxz58orplmIL6KW7nb3moPR
        2f23b/KJfUHa/L8y1U2AUA36FysxXIET3T8jIXfaKCgjslBMhQlh
X-Google-Smtp-Source: ABdhPJzmUiJYqdME47hxLmr3pcO63yeqFS1DHOrmRgyouUBPr0oR2DgjwRC/2IrnqepvAc52lI4e1jwRzMgGUw/vHwk=
X-Received: by 2002:a2e:9659:: with SMTP id z25mr3410709ljh.16.1641916064333;
 Tue, 11 Jan 2022 07:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20211215130711.111186-1-gsomlo@gmail.com> <20211215130711.111186-4-gsomlo@gmail.com>
 <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com> <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu>
In-Reply-To: <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Jan 2022 16:47:07 +0100
Message-ID: <CAPDyKFohOHYu_bdXsAYvDmMLqnGUW=9pG+yJDwP5-db1B6F1Dw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
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

[...]

> > > +
> > > +static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > > +{
> > > +       struct litex_mmc_host *host = mmc_priv(mmc);
> > > +       struct device *dev = mmc_dev(mmc);
> > > +       struct mmc_command *cmd = mrq->cmd;
> > > +       struct mmc_command *sbc = mrq->sbc;
> > > +       struct mmc_data *data = mrq->data;
> > > +       struct mmc_command *stop = mrq->stop;
> > > +       unsigned int retries = cmd->retries;
> > > +       unsigned int len = 0;
> > > +       bool direct = false;
> > > +       u32 response_len = litex_mmc_response_len(cmd);
> > > +       u8 transfer = SD_CTL_DATA_XFER_NONE;
> > > +
> > > +       /* First check that the card is still there */
> > > +       if (!litex_mmc_get_cd(mmc)) {
> > > +               cmd->error = -ENOMEDIUM;
> > > +               mmc_request_done(mmc, mrq);
> > > +               return;
> > > +       }
> > > +
> > > +       /* Send set-block-count command if needed */
> > > +       if (sbc) {
> > > +               sbc->error = litex_mmc_send_cmd(host, sbc->opcode, sbc->arg,
> > > +                                               litex_mmc_response_len(sbc),
> > > +                                               SD_CTL_DATA_XFER_NONE);
> > > +               if (sbc->error) {
> > > +                       host->is_bus_width_set = false;
> > > +                       mmc_request_done(mmc, mrq);
> > > +                       return;
> > > +               }
> > > +       }
> > > +
> > > +       if (data) {
> > > +               /* LiteSDCard only supports 4-bit bus width; therefore, we MUST
> > > +                * inject a SET_BUS_WIDTH (acmd6) before the very first data
> > > +                * transfer, earlier than when the mmc subsystem would normally
> > > +                * get around to it!
> >
> > This means that you may end up trying to switch bus-width, to a width
> > that isn't supported by the card, for example.
> >
> > As also stated above, I wonder how this conforms to the SD spec from
> > the initialization sequence point of view. Have you verified that this
> > isn't a problem?
>
> During litex_mmc_probe(), I have:
>
>         ...
>         ret = mmc_of_parse(mmc);
>         if (ret)
>                 goto err;
>
>         /* force 4-bit bus_width (only width supported by hardware) */
>         mmc->caps &= ~MMC_CAP_8_BIT_DATA;
>         mmc->caps |= MMC_CAP_4_BIT_DATA;
>         ...
>
> This ensures no bus-width switches to anything other than 4-bit data
> should ever occur. As far as I understand the SDcard spec, it's legal
> to both send multiple redundant bus-width-set commands, and to start
> doing so before the very first data transfer request is processed
> (regardless of the fact that linux typically does a few 1-bit-wide
> data transfers during card initialization before switching to a wider
> mode, if available).
>
> This driver simply ensures that any time we ever have a data transfer,
> the bus width is set to 4 *before* said transfer is acted upon.
>
> As I mentioned earlier, if we get a "weird" SDcard that can't support
> 4-bit data transfers, its initialization should fail shortly after
> detection, and that's all there is to it, as far as I can tell.

Alright, I get the point. I guess it should work. I will have another
closer look at the corresponding code from your last submitted
version.

>
> > > +                */
> > > +               cmd->error = litex_mmc_set_bus_width(host);
> > > +               if (cmd->error) {
> > > +                       dev_err(dev, "Can't set bus width!\n");
> > > +                       mmc_request_done(mmc, mrq);
> > > +                       return;
> > > +               }
> > > +
> > > +               litex_mmc_do_dma(host, data, &len, &direct, &transfer);
> > > +       }
> > > +
> > > +       do {
> > > +               cmd->error = litex_mmc_send_cmd(host, cmd->opcode, cmd->arg,
> > > +                                               response_len, transfer);
> > > +       } while (cmd->error && retries-- > 0);
> > > +
> > > +       if (cmd->error) {
> > > +               /* card may be gone; don't assume bus width is still set */
> > > +               host->is_bus_width_set = false;
> > > +       }
> > > +
> > > +       if (response_len == SD_CTL_RESP_SHORT) {
> > > +               /* pull short response fields from appropriate host registers */
> > > +               cmd->resp[0] = host->resp[3];
> > > +               cmd->resp[1] = host->resp[2] & 0xFF;
> > > +       } else if (response_len == SD_CTL_RESP_LONG) {
> > > +               cmd->resp[0] = host->resp[0];
> > > +               cmd->resp[1] = host->resp[1];
> > > +               cmd->resp[2] = host->resp[2];
> > > +               cmd->resp[3] = host->resp[3];
> > > +       }
> > > +
> > > +       /* Send stop-transmission command if required */
> > > +       if (stop && (cmd->error || !sbc)) {
> > > +               stop->error = litex_mmc_send_cmd(host, stop->opcode, stop->arg,
> > > +                                                litex_mmc_response_len(stop),
> > > +                                                SD_CTL_DATA_XFER_NONE);
> > > +               if (stop->error)
> > > +                       host->is_bus_width_set = false;
> > > +       }
> > > +
> > > +       if (data) {
> > > +               dma_unmap_sg(dev, data->sg, data->sg_len,
> > > +                            mmc_get_dma_dir(data));
> > > +       }
> > > +
> > > +       if (!cmd->error && transfer != SD_CTL_DATA_XFER_NONE) {
> > > +               data->bytes_xfered = min(len, mmc->max_req_size);
> > > +               if (transfer == SD_CTL_DATA_XFER_READ && !direct) {
> > > +                       sg_copy_from_buffer(data->sg, sg_nents(data->sg),
> > > +                                           host->buffer, data->bytes_xfered);
> > > +               }
> > > +       }
> > > +
> > > +       mmc_request_done(mmc, mrq);
> > > +}
> > > +
> >
> > [...]
> >
> > > +
> > > +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> >
> > I noticed that you use these hard coded values and don't really care
> > to manage voltage changes via ->set_ios().
> >
> > Rather than doing it like this, I would prefer if you can hook up a
> > fixed vmmc regulator in the DTS. Then call mmc_regulator_get_supply()
> > to fetch it from here, which will let the mmc core create the
> > mmc->ocr_avail mask, based upon the voltage level the regulator
> > supports.
> >
> > This becomes more generic and allows more flexibility for the platform
> > configuration.
>
> The LiteSDCard "hardware" (i.e., *gateware*) does not allow modification
> or selection of voltage from the software side. When a CMD8 is issued,
> the "voltage supplied" bit pattern is expected to be '0001b', which per
> the spec means "2.7-3.6V".

If you provide a range (2.7-3.6V), that means that your hardware
supports the entire range, not just one single part of it.

>
> I tried adding this to the overall DTS:
>
>         vreg_mmc: vreg_mmc_3v {
>                 compatible = "regulator-fixed";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>         };
>
> and then added a reference to it to the LiteSDCard "mmc0" node in DTS,
> like so:
>
>         mmc0: mmc@12005000 {
>                 compatible = "litex,mmc";
>                 reg = <0x12005000 0x100>,
>                         <0x12003800 0x100>,
>                         <0x12003000 0x100>,
>                         <0x12004800 0x100>,
>                         <0x12004000 0x100>;
>                 reg-names = "phy", "core", "reader", "writer", "irq";
>                 clocks = <&sys_clk>;
>                 vmmc-supply = <&vreg_mmc>; /* <-------- HERE !!! */
>                 interrupt-parent = <&L1>;
>                 interrupts = <4>;
>         };
>
> Finally, I replaced the hardcoded setting of `mmc->ocr_avail` with a
> call to `mmc_regulator_get_supply(mmc)`. Now, I get a bunch of timeouts
> during attempts to send e.g., CMD8 and CMD55.
> (going for 3200000 and 3400000 for min- and max-microvolt, respectively,
>  -- or anything else in the allowed 2.7-3.6 range -- doesn't help either).
>
> I might be doing something subtly wrong in the way I set things up
> above, but it feels a bit overengineered, and IMHO fragile.

At a quick glance, the above looks correct to me. Maybe there is
something wrong with the code in the driver instead?

>
> OTOH, going all out and setting:
>
>         /* allow for generic 2.7-3.6V range, no software tuning available */
>         mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
>                          MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
>                          MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;
>
> seems to work just fine... :) Please do let me know what you think!

No, this isn't the way we want it to work. That's because it means
that we would lie to the card about what voltage range the HW actually
supports.

It's better to let the DTS file give that information about the HW.

[...]

Kind regards
Uffe
