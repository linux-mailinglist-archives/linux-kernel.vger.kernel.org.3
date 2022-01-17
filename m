Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4184909FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiAQOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiAQOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:08:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:08:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b14so39577953lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/F5VAIUnuZoKvZjwxrhtVdlFx14UE2p7e9E4YI4S8Q=;
        b=dtThkQCBCm+J6vmjue/Tmyk3oTBjYJ9zd+y8nd9e44YNb18prJSoUUJYV5sVSBLmqQ
         8PrQZai4p64TkxCs6UPRZcfIoD8uxIaWjFlf210TGtMVPQPxZf+84xJGO0+Qgv14dNQ3
         enuoVdwgz/Q0+8Hu9w1nS8foUn7Np+LrDcPQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/F5VAIUnuZoKvZjwxrhtVdlFx14UE2p7e9E4YI4S8Q=;
        b=wh9FDQM8/PsRtvp6pPPuxR40UR4RhQjZuE3Ah0zbTtRc6MNmkM0x1mWw3dG2gt+t/+
         lt4ThHra0aB31NMYtqi3XBBAzeOfogxt/XsFNqaqcYW+Kf0MPOVMj+wVQxj5q7CKNDxk
         DQGy5FmkBdQZyYzPXhVsTZ8L+DQa+eXxMFqyPfyrwyr1vjVX+xE4PZHiCdJlODXuI6gl
         V3PjsIj0X8VWIlUfd5CXtVzcoFe0Aet7WREc6MqAQ8Aj+rNIn0v/RCNQRq7SFB+5SjRa
         XtJsM0DDAsRyBnGOJvZ1GX0LjUhmPz7IWHXjhyAMjDC72BdNViI2FOyu5JrHbBSYvKAJ
         s9OQ==
X-Gm-Message-State: AOAM531xNk8O3L5gcQlX6WgU87TsdvZkMGHCoNb0f9Yt6qmn5Dmo4iQl
        oyz5unyzDaqpa5BpC6CrmS8jz4i3zsCnSM50rdfstA==
X-Google-Smtp-Source: ABdhPJwktiCc+IH1AlXibibrqA2zKQHxTNYida7J2+3yuEWDDJptN/B2nyIsF7B2Px06Sa49MDFZV59swqfh4sZebUA=
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr14765814ljh.132.1642428521589;
 Mon, 17 Jan 2022 06:08:41 -0800 (PST)
MIME-Version: 1.0
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
 <20220117111829.1811997-4-dario.binacchi@amarulasolutions.com> <YeVsnQpOkyXaBk0+@pengutronix.de>
In-Reply-To: <YeVsnQpOkyXaBk0+@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Mon, 17 Jan 2022 15:08:30 +0100
Message-ID: <CABGWkvruAWcOxX99U0jcK1sz+AoGKKJwHWbtn_kSO=SJsCO5Wg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] mtd: rawnand: gpmi: use a table to get EDO
 mode setup
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

On Mon, Jan 17, 2022 at 2:18 PM Sascha Hauer <sha@pengutronix.de> wrote:
>
> Hi Dario,
>
> On Mon, Jan 17, 2022 at 12:18:27PM +0100, Dario Binacchi wrote:
> > +struct edo_mode {
> > +     u32 tRC_min;
> > +     long clk_rate;
> > +     u8 wrn_dly_sel;
> > +};
> > +
> > +static const struct edo_mode edo_modes[] = {
> > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > +     {.tRC_min = 25000, .clk_rate = 80000000,
> > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
> > +     {.tRC_min = 20000, .clk_rate = 100000000,
> > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
> > +};
> > +
> >  /*
> >   * <1> Firstly, we should know what's the GPMI-clock means.
> >   *     The GPMI-clock is the internal clock in the gpmi nand controller.
> > @@ -657,22 +678,18 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
> >       int sample_delay_ps, sample_delay_factor;
> >       u16 busy_timeout_cycles;
> >       u8 wrn_dly_sel;
> > +     int i, emode = ARRAY_SIZE(edo_modes) - 1;
> >
> > -     if (sdr->tRC_min >= 30000) {
> > -             /* ONFI non-EDO modes [0-3] */
> > -             hw->clk_rate = 22000000;
> > -             wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
> > -     } else if (sdr->tRC_min >= 25000) {
> > -             /* ONFI EDO mode 4 */
> > -             hw->clk_rate = 80000000;
> > -             wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
> > -     } else {
> > -             /* ONFI EDO mode 5 */
> > -             hw->clk_rate = 100000000;
> > -             wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
> > +     /* Search the required EDO mode */
> > +     for (i = 0; i < ARRAY_SIZE(edo_modes); i++) {
> > +             if (sdr->tRC_min >= edo_modes[i].tRC_min) {
> > +                     emode = i;
> > +                     break;
> > +             }
>
> The first four entries of edo_modes[] all have the same value, so this loop
> will never end on the second, third or fourth element. These elements are just
> there to match 'emode' with the existing ONFI mode numbers, but then 'emode' is
> never used as an ONFI mode number, instead it's only used as an index to the
> array. You could equally well remove the second till fourth array entries.
>
> Then with only three entries left in the array I wonder if you're not better
> off with the original code and change it to something like:

This implementation is justified by the next patch in the series ([RFC
PATCH v2 4/5] mtd: rawnand: gpmi: validate controller clock rate).
I thought that clock rate validation could be better implemented by
indexing a table. The replication of the second, third and fourth
elements
makes the index also the edo mode (used in the debug printout). Using
a less redundant table (three elements) requires the edo mode
to be stored in it if you want to keep the debug printing or remove
the debug message.

>
>         if (sdr->tRC_min >= 30000) {
>                 /* ONFI non-EDO modes [0-3] */
>                 hw->clk_rate = 22000000;
>                 min_rate = 0;
>                 wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
>         } else if (sdr->tRC_min >= 25000) {
>                 /* ONFI EDO mode 4 */
>                 hw->clk_rate = 80000000;
>                 min_rate = 22000000;
>                 wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
>         } else {
>                 /* ONFI EDO mode 5 */
>                 hw->clk_rate = 100000000;
>                 min_rate = 80000000;
>                 wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
>         }
>
>         hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
>         if (hw->clk_rate < min_rate)
>                 return -EINVAL;
>
> I think this would be easier to follow.

I think the key point is to decide if the patch "[RFC PATCH v2 4/5]
mtd: rawnand: gpmi: validate controller clock rate" makes sense.
I thought of this patch to facilitate that implementation, since it
compares the real GPMI clock rate to that of the previous edo mode.
I thought it wasn't elegant to implement another switch case.

Thanks and regards,
Dario

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



--

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
