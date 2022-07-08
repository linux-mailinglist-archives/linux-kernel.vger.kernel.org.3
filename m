Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887356C3DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiGHSlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiGHSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:41:47 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C95F1A827;
        Fri,  8 Jul 2022 11:41:47 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2a4c51c45so30268794fac.9;
        Fri, 08 Jul 2022 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0+g3v6pC8RZHHJAWVXJd2G4KVUBkvrj09rmmxGrR+E=;
        b=kSYmvN1LCA3HQHM673GLcBGagoKwVuIV8NANpt2rxPMcLLWoBx+CfJY8ie9CG4TGzW
         ugF84N5L5QD3G75H5LrXyrM8YkCRQMnK+iZ1dI4DI2zTyth8s05//EGrQJvdGqb9yi4S
         B/tjHLAOt5UvECMIo6t8OqiACR6SiWt3V+3dF6sUQfeq7kyW6jlLw8j1l2035R9lcPch
         UcUr8O7CrHvwRQ5lzMep3rsle82S1UVvgN2dAsAoTVQ/xJgiAO/JI8phqK4EF8y6kmpS
         s0J76+Tjs1AkkNP5UpMf4RoGm4qheTfRTJS/0uObwUMh44154LXbdFg062bUyBbKKDhI
         FLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0+g3v6pC8RZHHJAWVXJd2G4KVUBkvrj09rmmxGrR+E=;
        b=atIxdAkwCQK2dtTUogb/H8IcAGoCR5yCOQeOL2c97cOK54rstCmv0GQXO22b1uRxrH
         cDnw7irOWvkEtoyghsqBgGgPtqe8rQ8be/kLNq+7dsZg02XMvjZfCPmM+mn2TtccZkQn
         EX/5zBpvdkqAjf1HRMjParC55s7hmC2RQXwr+HixpzWjMWMfP0srMlgnBG2PRoFxhNn+
         0MEWDRRHyYqJ19aaapyt4UNdqX9cvl43hNU+J248n1oF6l+TKbhDG+UQtpWtjAsBsXqV
         nDIBTWxsXrh5Z7UiUST0kD5mQESHH7cBxN/yXwFNnrFeL34HonczNuZlPs6uWPdWuMeH
         Zn0A==
X-Gm-Message-State: AJIora8ywGuPxXS3I1MV37Vz/GiYCpGbys4h72bbZgnJc4BdeNjUwNCj
        2JOM5Dp1Iwq8EbAxEV3btU2pA+NgRAwQH7KXBERWhW60zxX+5A==
X-Google-Smtp-Source: AGRyM1tJ/cjliLSb05PEgv9ikZiVR60MsFIKWxl5kdrWfbZDUl5sqhyFFPR61swqCmtESYW1a7F/DCBBVWpAqv0OAXU=
X-Received: by 2002:a05:6870:88a8:b0:101:6409:ae26 with SMTP id
 m40-20020a05687088a800b001016409ae26mr736747oam.160.1657305706145; Fri, 08
 Jul 2022 11:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220608161150.58919-1-linux@fw-web.de> <20220608161150.58919-2-linux@fw-web.de>
 <5611d1c5-44db-4144-3c46-256323d39fe3@arm.com>
In-Reply-To: <5611d1c5-44db-4144-3c46-256323d39fe3@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 8 Jul 2022 14:41:35 -0400
Message-ID: <CAMdYzYo=Wft93OEKapVFx-oxe8ocU7OuhU+MOdqUw8-QjqzDGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtc: hym8563: try multiple times to init device
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 12:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-06-08 17:11, Frank Wunderlich wrote:
> > From: Peter Geis <pgwipeout@gmail.com>
> >
> > RTC sometimes does not respond the first time in init.
> > Try multiple times to get a response.
>
> FWIW, given that HYM8563 is fairly common on RK3288 boards - I can't say
> I've ever noticed an issue with mine, for instance - it seems dubious
> that this would be a general issue of the chip itself. Are you sure it's
> not a SoC or board-level issue with the I2C bus being in a funny initial
> state, timings being marginal, or suchlike?

I don't think this is an SoC issue since this is the first instance
I've encountered it. Mind you we don't have the reset lines hooked up
at all for the Rockchip i2c driver, so it's possible that's the case,
but I'd imagine it would be observed more broadly if that was the
case. I've tried pushing the timings out pretty far as well as bumping
up the drive strength to no change. It seems to occur only with the
hym rtc used on this board. I suspect it's a new variant of the hym
that has slightly different behavior.

>
> Robin.
>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >   drivers/rtc/rtc-hym8563.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
> > index 90e602e99d03..9adcedaa4613 100644
> > --- a/drivers/rtc/rtc-hym8563.c
> > +++ b/drivers/rtc/rtc-hym8563.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/clk-provider.h>
> >   #include <linux/i2c.h>
> >   #include <linux/bcd.h>
> > +#include <linux/delay.h>
> >   #include <linux/rtc.h>
> >
> >   #define HYM8563_CTL1                0x00
> > @@ -438,10 +439,16 @@ static irqreturn_t hym8563_irq(int irq, void *dev_id)
> >
> >   static int hym8563_init_device(struct i2c_client *client)
> >   {
> > -     int ret;
> > +     int ret, i;
> >
> >       /* Clear stop flag if present */
> > -     ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
> > +     for (i = 0; i < 3; i++) {
> > +             ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
> > +             if (ret == 0)
> > +                     break;
> > +             msleep(20);
> > +     }
> > +
> >       if (ret < 0)
> >               return ret;
> >
