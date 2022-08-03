Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA74588721
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiHCGJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:09:03 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863E1A3A5;
        Tue,  2 Aug 2022 23:09:02 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10edfa2d57dso9018517fac.0;
        Tue, 02 Aug 2022 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOHSIpOzFj2CQ4DoZoKBpGpskH5cJ9I2fZ25nCXTDds=;
        b=kwgb8ZiAAMjRcBeseTPJQYM1uwyX5cph1sxTseAwEya6BTNt/1ZBZ8Mn/ASyskeZM/
         48yFeV7hgNQfdGM7/xfpdRQ2+43liItiye9/B2e59sXuZwz0zRo3blfVuqqIj2PD5wIb
         04d5eNXbpattTfxFtUnJnWoa72lUxCQhj+7qs2aP/sD9UH0lyEOpV45BxZ+DOOihEFvB
         1ay0/p7hL6oEgAOAr32B8Vmduge/x1vZTpzoZLRfvZg7otMHEdONvvuypGlTi+lYYnWF
         oguNXdLizw4FNBwanFd8h5Ypt+YtTQ7vhq571LEApV6h5ZOhdPBpJ+ahW1Y71PUGH2Nq
         ssjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOHSIpOzFj2CQ4DoZoKBpGpskH5cJ9I2fZ25nCXTDds=;
        b=nVB7jQ7mcyA52yp6C1JPyEvHcyPvutX1p9AdOoNnx0q3sgp0xHKtWjeZ5rz+B5ZMp4
         txCi6G3mBzFaMJXHmQvyDOcwUpKynTSlc/1oMuPN06FCMvHq0q+Xd8tPfiuFJks2C/lX
         Xoirfd9dwHdDroooctr7ITzBdy1zvKtJynGtCI9BM4TqOeOXMmjn9ii/+f2+NO7mMfWU
         hhPObVB4Nu80s3VmyPnbniCSG7Fx990y5L6uvwwC4QwQv/wPuLEc5E//nhd5EFE0sYaz
         5gUOyiz7f67qIOI2K9JQD+dMBiEdoSOegntlJW6ZrtrDjuScqo+DpgOEgHKUqUNJW+qO
         nHEQ==
X-Gm-Message-State: ACgBeo0K5Kpi1IO0xzSSQ//KoMTWQjofx3BN2bDURo81/Yc78mNydj7W
        TXa5xKhKj1xGAIuEYMMS93qoz3/KM81ofzXuzO54QcS0
X-Google-Smtp-Source: AA6agR6EG3M12SD6Hj393d5YYQN3yN13JuFvJWw2BouLtXUhkmSN9c9lIvVVEZxANvUHUEwD6sqA9e/frTA+bMXh8ko=
X-Received: by 2002:a05:6870:2323:b0:10d:2b6:3519 with SMTP id
 w35-20020a056870232300b0010d02b63519mr1231397oao.215.1659506942070; Tue, 02
 Aug 2022 23:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-3-gene.chen.richtek@gmail.com> <YujZATquqh0srgHm@kuha.fi.intel.com>
In-Reply-To: <YujZATquqh0srgHm@kuha.fi.intel.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Wed, 3 Aug 2022 14:08:50 +0800
Message-ID: <CAE+NS37qqAUON=GZV1Q9HisgxpzJGQai6QFBJi8Ss_rhpTjzBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] usb: typec: tcpci_rt1711h: Fix vendor setting when
 set vconn
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2022=E5=B9=B48=
=E6=9C=882=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:57=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi Gene,
>
> On Mon, Aug 01, 2022 at 06:14:42PM +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > replace overwrite whole register with update bits
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec=
/tcpm/tcpci_rt1711h.c
> > index b56a0880a044..6197d9a05d36 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > @@ -5,13 +5,15 @@
> >   * Richtek RT1711H Type-C Chip Driver
> >   */
> >
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > +#include <linux/bits.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/gpio/consumer.h>
> > -#include <linux/usb/tcpm.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/regmap.h>
> > +#include <linux/usb/tcpm.h>
>
> That header reshuffling is not necessary for this change - at least you
> are not giving any reason for it in your commit message.
>
> If there is no real need for that in this patch, then please leave the
> headers as they are. You can propose changing the order of the headers
> in a separate patch. Though, I would not bother with it unless there
> is some real benefit in doing so, and I'm pretty sure there isn't any.
>

ACK, I will remove reshuffling.
It was suggested coding style by other reviewer in other driver.

> >  #include "tcpci.h"
> >
> >  #define RT1711H_VID          0x29CF
> > @@ -23,6 +25,7 @@
> >  #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
> >                           (((ck300) << 7) | ((ship_off) << 5) | \
> >                           ((auto_idle) << 3) | ((tout) & 0x07))
> > +#define RT1711H_AUTOIDLEEN   BIT(3)
> >
> >  #define RT1711H_RTCTRL11     0x9E
> >
> > @@ -109,8 +112,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, s=
truct tcpci_data *tdata,
> >  {
> >       struct rt1711h_chip *chip =3D tdata_to_rt1711h(tdata);
> >
> > -     return rt1711h_write8(chip, RT1711H_RTCTRL8,
> > -                           RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
> > +     return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
> > +                               RT1711H_AUTOIDLEEN, enable ? 0 : RT1711=
H_AUTOIDLEEN);
> >  }
> >
> >  static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
> > --
> > 2.25.1
>
> thanks,
>
> --
> heikki
