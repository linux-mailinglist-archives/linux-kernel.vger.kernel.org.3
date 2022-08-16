Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A1595C46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiHPMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiHPMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:49:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD075CCC;
        Tue, 16 Aug 2022 05:49:07 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i24so7958936qkg.13;
        Tue, 16 Aug 2022 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=zTE3vSGffjLJL9SJl1g+w5PaNK8MI9gWtgUj+ChkYjM=;
        b=Lrt3mzJVMzYaaaU3g9Xp2bqgK93uiGwOmDvf+T3AnSJEAmdDLFqMOdCO9aOJXiOXpE
         3xpfGVUmU5Xtw1IjFtmlOcikerBjDEsdnaRZPAy/UrfWLkLs3R9QMoiKLhQfnx0Xz3JV
         vVqtwHhsPjApuIIqFVO6IumY32S3eBbRpMzcohvPi2dyXsXMIlxyTucQrZvswA6ZNVjS
         6H11tmwUUlYLiiKyFLD2c/4SQo5gSREA1LU0mTcWv5/tvWMsOdBck5CA+nK2dllDzKXx
         A3e5edOK+9cC33+axh1zRO1B/7GXzpHANiPI5nXyh5CI1OWHjyOtf/cQ6Pmjr65tRM0b
         htzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=zTE3vSGffjLJL9SJl1g+w5PaNK8MI9gWtgUj+ChkYjM=;
        b=vacpoL9SxkZXg/DTXqgJZd2rchCV72vNrCv02BwWJl2hLOb05oGS76vhyT84Lao+FV
         ttZ/DbMXM0R7dFv/Eu1+N1Ttx9/VP6/KApTU4uli73j2hNJrMgRX3bqJg3U6yon9SOCb
         kaBMiNt82vn6jgHZPU+8zW61jTFgvsiIZ4KG+AyLc68aGlqIyWooUzstvV08cfluMYLf
         y7hdTDi+MacrGXxcfty8Jnr3VK+j4DTFTk/5/E2I0XI2J36+Qb6VRHQa6F0rkugiB14H
         JRyOqlNciyJSJYapyGNw/Gr2XBus3PQ/ek+VuSIkBdih65UiacY3xXca+adXY2xDXPzZ
         QEHw==
X-Gm-Message-State: ACgBeo1QaWUsUQe6WSDQCq/aI4WdO9m6Vb2C4WOCKIwxc1khvWwzVdPy
        7hFVnIftSClNFBxcYNPLDQJirLHU99FZXyK3WlM=
X-Google-Smtp-Source: AA6agR6BQXKA5uhaxl3xSfY3OeXKEI42340fyGfkVgFGIMtq4QLVrrmDZiAKeRaPxKvnSMokb9AktnFfq/9hd3v2AqA=
X-Received: by 2002:ae9:e30f:0:b0:6bb:868:c7d8 with SMTP id
 v15-20020ae9e30f000000b006bb0868c7d8mr8914857qkf.25.1660654146978; Tue, 16
 Aug 2022 05:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220714101451.198211-1-robimarko@gmail.com> <20220714101451.198211-2-robimarko@gmail.com>
 <0861a79e-f2b0-143e-b09e-9b088a4568a7@linaro.org>
In-Reply-To: <0861a79e-f2b0-143e-b09e-9b088a4568a7@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 16 Aug 2022 14:48:56 +0200
Message-ID: <CAOX2RU4-sanm0ABdPZmvVjqn=K7tdAu9vGijg4HreY6LCevJfA@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drivers: thermal: tsens: Add support for combined interrupt
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 at 12:28, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
>
> Hi,
>
> On 14/07/2022 12:14, Robert Marko wrote:
> > Despite using tsens v2.3 IP, IPQ8074 and IPQ6018 only have one IRQ for
> > signaling both up/low and critical trips.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Bjorn, are these changes ok for you ?

It would be great for these to get merged, I have been using them
for couple of months now.

Regards,
Robert
>
> > ---
> > Changes in v6:
> > * Check critical IRQ handler return, simplify up/low return
> > ---
> >   drivers/thermal/qcom/tsens-8960.c |  1 +
> >   drivers/thermal/qcom/tsens-v0_1.c |  1 +
> >   drivers/thermal/qcom/tsens-v1.c   |  1 +
> >   drivers/thermal/qcom/tsens-v2.c   |  1 +
> >   drivers/thermal/qcom/tsens.c      | 38 ++++++++++++++++++++++++++----=
-
> >   drivers/thermal/qcom/tsens.h      |  2 ++
> >   6 files changed, 38 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/t=
sens-8960.c
> > index 67c1748cdf73..ee584e5b07e5 100644
> > --- a/drivers/thermal/qcom/tsens-8960.c
> > +++ b/drivers/thermal/qcom/tsens-8960.c
> > @@ -269,6 +269,7 @@ static const struct tsens_ops ops_8960 =3D {
> >   static struct tsens_features tsens_8960_feat =3D {
> >       .ver_major      =3D VER_0,
> >       .crit_int       =3D 0,
> > +     .combo_int      =3D 0,
> >       .adc            =3D 1,
> >       .srot_split     =3D 0,
> >       .max_sensors    =3D 11,
> > diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/t=
sens-v0_1.c
> > index f136cb350238..6effb822bf3c 100644
> > --- a/drivers/thermal/qcom/tsens-v0_1.c
> > +++ b/drivers/thermal/qcom/tsens-v0_1.c
> > @@ -539,6 +539,7 @@ static int calibrate_9607(struct tsens_priv *priv)
> >   static struct tsens_features tsens_v0_1_feat =3D {
> >       .ver_major      =3D VER_0_1,
> >       .crit_int       =3D 0,
> > +     .combo_int      =3D 0,
> >       .adc            =3D 1,
> >       .srot_split     =3D 1,
> >       .max_sensors    =3D 11,
> > diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tse=
ns-v1.c
> > index 573e261ccca7..a4f561a6e582 100644
> > --- a/drivers/thermal/qcom/tsens-v1.c
> > +++ b/drivers/thermal/qcom/tsens-v1.c
> > @@ -302,6 +302,7 @@ static int calibrate_8976(struct tsens_priv *priv)
> >   static struct tsens_features tsens_v1_feat =3D {
> >       .ver_major      =3D VER_1_X,
> >       .crit_int       =3D 0,
> > +     .combo_int      =3D 0,
> >       .adc            =3D 1,
> >       .srot_split     =3D 1,
> >       .max_sensors    =3D 11,
> > diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tse=
ns-v2.c
> > index b293ed32174b..129cdb247381 100644
> > --- a/drivers/thermal/qcom/tsens-v2.c
> > +++ b/drivers/thermal/qcom/tsens-v2.c
> > @@ -31,6 +31,7 @@
> >   static struct tsens_features tsens_v2_feat =3D {
> >       .ver_major      =3D VER_2_X,
> >       .crit_int       =3D 1,
> > +     .combo_int      =3D 0,
> >       .adc            =3D 0,
> >       .srot_split     =3D 1,
> >       .max_sensors    =3D 16,
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.=
c
> > index 7963ee33bf75..5c7f9ec6ab1c 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -532,6 +532,27 @@ static irqreturn_t tsens_irq_thread(int irq, void =
*data)
> >       return IRQ_HANDLED;
> >   }
> >
> > +/**
> > + * tsens_combined_irq_thread - Threaded interrupt handler for combined=
 interrupts
> > + * @irq: irq number
> > + * @data: tsens controller private data
> > + *
> > + * Handle the combined interrupt as if it were 2 separate interrupts, =
so call the
> > + * critical handler first and then the up/low one.
> > + *
> > + * Return: IRQ_HANDLED
> > + */
> > +static irqreturn_t tsens_combined_irq_thread(int irq, void *data)
> > +{
> > +     irqreturn_t ret;
> > +
> > +     ret =3D tsens_critical_irq_thread(irq, data);
> > +     if (ret !=3D IRQ_HANDLED)
> > +             return ret;
> > +
> > +     return tsens_irq_thread(irq, data);
> > +}
> > +
> >   static int tsens_set_trips(void *_sensor, int low, int high)
> >   {
> >       struct tsens_sensor *s =3D _sensor;
> > @@ -1083,13 +1104,18 @@ static int tsens_register(struct tsens_priv *pr=
iv)
> >                                  tsens_mC_to_hw(priv->sensor, 0));
> >       }
> >
> > -     ret =3D tsens_register_irq(priv, "uplow", tsens_irq_thread);
> > -     if (ret < 0)
> > -             return ret;
> > +     if (priv->feat->combo_int) {
> > +             ret =3D tsens_register_irq(priv, "combined",
> > +                                      tsens_combined_irq_thread);
> > +     } else {
> > +             ret =3D tsens_register_irq(priv, "uplow", tsens_irq_threa=
d);
> > +             if (ret < 0)
> > +                     return ret;
> >
> > -     if (priv->feat->crit_int)
> > -             ret =3D tsens_register_irq(priv, "critical",
> > -                                      tsens_critical_irq_thread);
> > +             if (priv->feat->crit_int)
> > +                     ret =3D tsens_register_irq(priv, "critical",
> > +                                              tsens_critical_irq_threa=
d);
> > +     }
> >
> >       return ret;
> >   }
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.=
h
> > index 1471a2c00f15..4614177944d6 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -495,6 +495,7 @@ enum regfield_ids {
> >    * struct tsens_features - Features supported by the IP
> >    * @ver_major: Major number of IP version
> >    * @crit_int: does the IP support critical interrupts?
> > + * @combo_int: does the IP use one IRQ for up, low and critical thresh=
olds?
> >    * @adc:      do the sensors only output adc code (instead of tempera=
ture)?
> >    * @srot_split: does the IP neatly splits the register space into SRO=
T and TM,
> >    *              with SROT only being available to secure boot firmwar=
e?
> > @@ -504,6 +505,7 @@ enum regfield_ids {
> >   struct tsens_features {
> >       unsigned int ver_major;
> >       unsigned int crit_int:1;
> > +     unsigned int combo_int:1;
> >       unsigned int adc:1;
> >       unsigned int srot_split:1;
> >       unsigned int has_watchdog:1;
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
