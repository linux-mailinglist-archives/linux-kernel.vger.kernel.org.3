Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245357F475
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiGXJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiGXJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:35:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9277CBC8A;
        Sun, 24 Jul 2022 02:35:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so13888192lfs.6;
        Sun, 24 Jul 2022 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY/2lDsjH8rvyR9vI13gtj+VtHAX6pqqtYSZIT34gMQ=;
        b=ANtyF2mKb++gC6/Y0D4BWpKx7diw7+EEqMUgh3n2P/HJ6uj8iZMx80qEQv5EMBVQOe
         8LiZubbCg+DNm8jTrkbkv3ySYcxjjVH2DwZOdLZv1VDnYbSk6eg7BSmJF0hBg4ARvKec
         l2cC7rPy8IhAbQStVEDF4iUsJLYL/tOcxyrL2j0u3WrMHj6P+8NlnDSjnz7vK6nNRlIA
         wk8tRQ/ezcoNCcl3YdNwTV86qIPIPcP2MzQcIOa0nHa+Qqije50JNR2Hw39vLJUZr6rO
         LdnlgPn94kxJrvqpIfCUGnwNtjHKyH0wgph1/du6/kjONK1CtPra9Zd1eQppoNy4ps5c
         +HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY/2lDsjH8rvyR9vI13gtj+VtHAX6pqqtYSZIT34gMQ=;
        b=AnlvetoAhugBCIXg3MZEfxo0+cmcZO6CFm+7x9xNI1gHdylSwRbKtBf8MAj2CmC2F5
         M1aObcfJXw0cxsM1cWlkxY3FtmJWmAXxG9/ZidZGVipnmv8OIQ2dz7kLFtczr9yXZWu+
         WkMDeI7o/9JHl7Px11vj4+u1casbAvN8LPg6SPBkckxbdwDgtWK5iOiKH7c31XK/LGll
         HZj3jBbZMTdoGwBRL+Q5YqrwF5CCoMxNwMYXSUDNa28+TZiR9xHsfIuymVUnB3vrpziS
         LboCQX3ZQcHoWShnDrOS2XwwL+Ykdg4YkEov9ZJGINHJDJ2JSxsqJ8bIPfjfxKvuvRH0
         BiIA==
X-Gm-Message-State: AJIora8A3YR0DwFCXKNFCXnTlEelxae784CJ3qJqIqI+gTr1g37jsNmb
        Hi7CQ1kznssdKNMX75VDmhe7TTj1SXKsrHPUZ/4=
X-Google-Smtp-Source: AGRyM1ttd4MQTqOMMfzH0Y37+KPEPMu8Aswiq+gjP4iO8JKTk6mNJSA0L8DCpp4Ma/G/aSrXXw+S1m4GvlnoYIE2Jy0=
X-Received: by 2002:a05:6512:1190:b0:48a:19d5:ef23 with SMTP id
 g16-20020a056512119000b0048a19d5ef23mr2732227lfr.401.1658655348919; Sun, 24
 Jul 2022 02:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220721101556.118568-1-tmaimon77@gmail.com> <20220721101556.118568-2-tmaimon77@gmail.com>
 <YtlYt/5VKIblUHBP@sirena.org.uk>
In-Reply-To: <YtlYt/5VKIblUHBP@sirena.org.uk>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 24 Jul 2022 12:35:37 +0300
Message-ID: <CAP6Zq1hu4GtFrLa5O_7gyszXwpfijJF=XU0hdw8FBbvj3Bk8Hg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] spi: npcm-pspi: add full duplex support
To:     Mark Brown <broonie@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for your detailed explanation!

On Thu, 21 Jul 2022 at 16:46, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 01:15:55PM +0300, Tomer Maimon wrote:
>
> > The NPCM PSPI handler, on TX-buffer not null, would perform a dummy read
> > but did not save the rx-data, this was valid only for half duplex.
>
> > This patch adds full duplex support for NPCM PSPI driver by storing all
> > rx-data when the Rx-buffer is defined also for TX-buffer handling.
>
> This doesn't seem to entirely correspond to what the patch does, nor to
> what the driver currently does?  I can't see any dummy read code in the
> current driver.
>
In the current handler file, in the handler function.
static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
....
-       if (priv->tx_buf) {
-               if (stat & NPCM_PSPI_STAT_RBF) {
-                       ioread8(NPCM_PSPI_DATA + priv->base);
the read above doing a dummy read
-                       if (priv->tx_bytes == 0) {
-                               npcm_pspi_disable(priv);
-                               complete(&priv->xfer_done);
-                               return IRQ_HANDLED;
-                       }
-               }


> >  static void npcm_pspi_send(struct npcm_pspi *priv)
> >  {
> >       int wsize;
> > -     u16 val;
> > +     u16 val = 0;
> >
> >       wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
> >       priv->tx_bytes -= wsize;
> >
> > -     if (!priv->tx_buf)
> > -             return;
> > -
> >       switch (wsize) {
> >       case 1:
> > -             val = *priv->tx_buf++;
> > +             if (priv->tx_buf)
> > +                     val = *priv->tx_buf++;
> >               iowrite8(val, NPCM_PSPI_DATA + priv->base);
> >               break;
>
> These changes appaear to be trying to ensure that when _send() is called
> we now always write something out, even if there was no transmit buffer.
> Since the device has been supporting half duplex transfers it is not
> clear why we'd want to do that, it's adding overhead to the PIO which
> isn't great.  This also isn't what the changelog said, the changelog
> said we were adding reading of data when there's a transmit buffer.
> Similar issues apply on the read side.
>
> AFAICT the bulk of what the change is doing is trying make the driver
> unconditionally do both read and writes to the hardware when it would
> previously have only read or written data if there was a buffer
> provided.  That's basically open coding SPI_CONTROLLER_MUST_TX and
> SPI_CONTROLLER_MUST_RX, if that's what the hardware needs then you
> should just set those flags and let the core fix things up.
We will try to use SPI_CONTROLLER_MUST_TX and SPI_CONTROLLER_MUST_RX
>
> > +       /*
> > +        * first we do the read since if we do the write we previous read might
> > +        * be lost (indeed low chances)
> > +        */
>
> This reordering sounds like it might be needed but should have been
> mentioned in the changelog and is a separate patch.

Best regards,

Tomer
