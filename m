Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5450C57C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiDWAAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDWAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:00:31 -0400
X-Greylist: delayed 35292 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 16:57:35 PDT
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445A1CFF86;
        Fri, 22 Apr 2022 16:57:35 -0700 (PDT)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id D25C3267CE;
        Fri, 22 Apr 2022 23:57:33 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 9D1EE3F1C5;
        Fri, 22 Apr 2022 23:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 931D12A374;
        Fri, 22 Apr 2022 23:57:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EKhdRskM061T; Fri, 22 Apr 2022 23:57:30 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 23:57:30 +0000 (UTC)
Received: from [172.16.34.145] (unknown [121.33.114.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5C0094006D;
        Fri, 22 Apr 2022 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650671849; bh=DD5aCHKicT3d4y+emq1GaFjzfF9oVaAmnNBTesrDm4E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AAdZy/P1OZJE0KnFzKZXRyz4HGgP3iW4LOq47Oo9dE4RItltGMTETGfkTtY3cXV3U
         GSSmovmGonmtmxzwWmhXREIdJa35VGKks5wnN5uJ5+98BMZQnhHaAS1/R+mnlFrAlk
         DMBd+QtgX2TLVenoRav27X36NtFs4RXDYf+zxDn8=
Message-ID: <2fb5b3f35d8b971839694e94d4965f1d8968f708.camel@aosc.io>
Subject: Re: [PATCH 3/4] spi: sun6i: add quirk for in-controller clock
 divider
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sat, 23 Apr 2022 07:57:20 +0800
In-Reply-To: <d1c09ca7-dc25-843c-2f64-fbf5111a9118@sholland.org>
References: <20220422155639.1071645-1-icenowy@outlook.com>
         <BYAPR20MB24728A99C2F7505873A091B5BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
         <d1c09ca7-dc25-843c-2f64-fbf5111a9118@sholland.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-04-22星期五的 18:54 -0500，Samuel Holland写道：
> On 4/22/22 10:56 AM, icenowy@outlook.com wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Previously SPI controllers in Allwinner SoCs has a clock divider
> > inside.
> > However now the clock divider is removed and to set the transfer
> > clock
> > rate it's only needed to set the SPI module clock to the target
> > value.
> > 
> > Add a quirk for this kind of SPI controllers.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  drivers/spi/spi-sun6i.c | 68 +++++++++++++++++++++++--------------
> > ----
> >  1 file changed, 38 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> > index 84c525b08ad0..fc81afc3a963 100644
> > --- a/drivers/spi/spi-sun6i.c
> > +++ b/drivers/spi/spi-sun6i.c
> > @@ -87,6 +87,7 @@
> >  
> >  struct sun6i_spi_cfg {
> >         unsigned long           fifo_depth;
> > +       bool                    has_clk_ctl;
> >  };
> >  
> >  struct sun6i_spi {
> > @@ -260,7 +261,7 @@ static int sun6i_spi_transfer_one(struct
> > spi_master *master,
> >                                   struct spi_transfer *tfr)
> >  {
> >         struct sun6i_spi *sspi = spi_master_get_devdata(master);
> > -       unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
> > +       unsigned int div, div_cdr1, div_cdr2, timeout;
> >         unsigned int start, end, tx_time;
> >         unsigned int trig_level;
> >         unsigned int tx_len = 0, rx_len = 0;
> > @@ -350,39 +351,44 @@ static int sun6i_spi_transfer_one(struct
> > spi_master *master,
> >  
> >         sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
> >  
> > -       /* Ensure that we have a parent clock fast enough */
> > -       mclk_rate = clk_get_rate(sspi->mclk);
> > -       if (mclk_rate < (2 * tfr->speed_hz)) {
> > -               clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> > -               mclk_rate = clk_get_rate(sspi->mclk);
> > -       }
> > +       if (sspi->cfg->has_clk_ctl) {
> > +               unsigned int mclk_rate = clk_get_rate(sspi->mclk);
> > +               /* Ensure that we have a parent clock fast enough
> > */
> > +               if (mclk_rate < (2 * tfr->speed_hz)) {
> > +                       clk_set_rate(sspi->mclk, 2 * tfr-
> > >speed_hz);
> > +                       mclk_rate = clk_get_rate(sspi->mclk);
> > +               }
> >  
> > -       /*
> > -        * Setup clock divider.
> > -        *
> > -        * We have two choices there. Either we can use the clock
> > -        * divide rate 1, which is calculated thanks to this
> > formula:
> > -        * SPI_CLK = MOD_CLK / (2 ^ cdr)
> > -        * Or we can use CDR2, which is calculated with the
> > formula:
> > -        * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
> > -        * Wether we use the former or the latter is set through
> > the
> > -        * DRS bit.
> > -        *
> > -        * First try CDR2, and if we can't reach the expected
> > -        * frequency, fall back to CDR1.
> > -        */
> > -       div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
> > -       div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
> > -       if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
> > -               reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) |
> > SUN6I_CLK_CTL_DRS;
> > -               tfr->effective_speed_hz = mclk_rate / (2 *
> > div_cdr2);
> > +               /*
> > +                * Setup clock divider.
> > +                *
> > +                * We have two choices there. Either we can use the
> > clock
> > +                * divide rate 1, which is calculated thanks to
> > this formula:
> > +                * SPI_CLK = MOD_CLK / (2 ^ cdr)
> > +                * Or we can use CDR2, which is calculated with the
> > formula:
> > +                * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
> > +                * Wether we use the former or the latter is set
> > through the
> > +                * DRS bit.
> > +                *
> > +                * First try CDR2, and if we can't reach the
> > expected
> > +                * frequency, fall back to CDR1.
> > +                */
> > +               div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
> > +               div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
> > +               if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
> > +                       reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) |
> > SUN6I_CLK_CTL_DRS;
> > +                       tfr->effective_speed_hz = mclk_rate / (2 *
> > div_cdr2);
> > +               } else {
> > +                       div = min(SUN6I_CLK_CTL_CDR1_MASK,
> > order_base_2(div_cdr1));
> > +                       reg = SUN6I_CLK_CTL_CDR1(div);
> > +                       tfr->effective_speed_hz = mclk_rate / (1 <<
> > div);
> > +               }
> > +
> > +               sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
> >         } else {
> > -               div = min(SUN6I_CLK_CTL_CDR1_MASK,
> > order_base_2(div_cdr1));
> > -               reg = SUN6I_CLK_CTL_CDR1(div);
> > -               tfr->effective_speed_hz = mclk_rate / (1 << div);
> > +               clk_set_rate(sspi->mclk, tfr->speed_hz);
> 
> clk_set_rate() may not set the exact requested rate. Should we set
> tfr->effective_speed_hz based on clk_get_rate() afterward?

Sounds right. I should add this in the next revision.

> 
> Regards,
> Samuel
> 
> >         }
> >  
> > -       sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
> >         /* Finally enable the bus - doing so before might raise SCK
> > to HIGH */
> >         reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
> >         reg |= SUN6I_GBL_CTL_BUS_ENABLE;
> > @@ -702,10 +708,12 @@ static int sun6i_spi_remove(struct
> > platform_device *pdev)
> >  
> >  static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
> >         .fifo_depth     = SUN6I_FIFO_DEPTH,
> > +       .has_clk_ctl    = true,
> >  };
> >  
> >  static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
> >         .fifo_depth     = SUN8I_FIFO_DEPTH,
> > +       .has_clk_ctl    = true,
> >  };
> >  
> >  static const struct of_device_id sun6i_spi_match[] = {
> > 
> 


