Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398057DAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGVHNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiGVHNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:13:09 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7CE8E6D9;
        Fri, 22 Jul 2022 00:13:08 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10dc1b16c12so229085fac.6;
        Fri, 22 Jul 2022 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/5eFAcvX/CKlTrR9jX/d2mPTDiNp5/R1cusUbd4zITc=;
        b=IAE445tfsoJF+oNXdF/zD/o+xl+j5zuke/2oHbLDrDDG1eK7oMFwzquA9owKIC0akd
         2wtRxONNq8jxitQ3T9C67se9Vr1rSoQvwlaTscjFzLW1c2a/5F4E5KboDfICs93jZTil
         0E0IoLVKrsMnxnyYFFQKW2lpHILH6KLPtlg5fey8OufecN3TWNT5SnjkNDpHr+rHZ429
         3eFW2gX7jaRz0bAt5mhSlzF7pJIgABlYhgd/Y8SaNIi4idYTIuB1mcImAJXFeFE0BWNd
         CWsx4ux7HI+RoXokQX7/HR+dhEWUyNFu3OZbjpPvIxHLJnUXvkBc4tE4d62xfHQgP7ck
         4zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/5eFAcvX/CKlTrR9jX/d2mPTDiNp5/R1cusUbd4zITc=;
        b=Y/3lGgvkKxgsDRBc4EIHfo+tkFuJRKGvuZqYIINfBRo7D4bh6RvdwngogX2EUvjPgv
         jsIRq1JH9h3lqu1Zem14HXOgBPJC1+riJJmDMLLUzwqWTWKg+ox6o+Zk1O5QW7oE2NoJ
         tQtZin4ENd8cu1+A0LWXZEMuVF3ebuSt2mAPrXiWhIq3+O2yzTaxcJuIhl5/L1HK1+9y
         XSw5QVJ2U8g6kEKdARF11DomjWIk1lbShDz7SNVudLWJme6XtsQmFDXkaeRLsDlLqpBv
         Q2zPDcYgfZ+zZ5nXEA6pkuGf626Mz4uJtX+Ml8cjISESFq/jUtxuS+SSuCXSVVo87DP+
         iufg==
X-Gm-Message-State: AJIora9zhecv0+loBcKD2kyuG1FJ8qb4AeVMxtZiSDPDqtEAZz3WKs7w
        F/yMT57OVl6qOnp1XGAQERzfcfrwMQB9UETHVXeQU3aF
X-Google-Smtp-Source: AGRyM1sZbAQqRFGT4zktXxYOhlpCSHAdyV2KhO65mrh0zep3NPJ8L+wFTa+SoqqdeFP8ZeriFFgE8FEPylj7lDy66+k=
X-Received: by 2002:a05:6870:2323:b0:10d:2b6:3519 with SMTP id
 w35-20020a056870232300b0010d02b63519mr6962462oao.215.1658473987695; Fri, 22
 Jul 2022 00:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
 <20220721061144.35139-4-gene.chen.richtek@gmail.com> <0675b483-9d51-30bc-a51d-9b9f2a0acb51@roeck-us.net>
In-Reply-To: <0675b483-9d51-30bc-a51d-9b9f2a0acb51@roeck-us.net>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 22 Jul 2022 15:12:55 +0800
Message-ID: <CAE+NS340V5+-QqnO8WAFT3Z2U77P+-hejFUbpCbxieORaPJ2Dw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] usb: typec: tcpci_rt1711h: Add regulator support
 when source vbus
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2022=E5=B9=B47=E6=9C=8821=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A10:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 7/20/22 23:11, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add regulator support when source vbus
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 28 +++++++++++++++++++++++++=
+
> >   1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec=
/tcpm/tcpci_rt1711h.c
> > index 3309ceace2b2..52c9594e531d 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > @@ -10,6 +10,7 @@
> >   #include <linux/i2c.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> >   #include <linux/usb/tcpm.h>
> >   #include <linux/regmap.h>
> >   #include "tcpci.h"
> > @@ -40,6 +41,8 @@ struct rt1711h_chip {
> >       struct tcpci_data data;
> >       struct tcpci *tcpci;
> >       struct device *dev;
> > +     struct regulator *vbus;
> > +     bool src_en;
> >   };
> >
> >   static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg=
, u16 *val)
> > @@ -103,6 +106,26 @@ static int rt1711h_init(struct tcpci *tcpci, struc=
t tcpci_data *tdata)
> >
> >       /* dcSRC.DRP : 33% */
> >       return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> > +
> > +}
> > +
> > +static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *td=
ata,
> > +                         bool src, bool snk)
> > +{
> > +     struct rt1711h_chip *chip =3D tdata_to_rt1711h(tdata);
> > +     int ret;
> > +
> > +     if (chip->src_en =3D=3D src)
> > +             return 1;
> > +
> > +     if (src)
> > +             ret =3D regulator_enable(chip->vbus);
> > +     else
> > +             ret =3D regulator_disable(chip->vbus);
> > +
> > +     if (!ret)
> > +             chip->src_en =3D src;
> > +     return ret ? ret : 1;
>
> Are you sure this is what you want ? Returning 1 bypasses the code settin=
g
> the vbus registers in tcpci.c. If that is on purpose it might make sense
> to explain it.
>

ACK, return 0 is more compatible with next generation chip,
and writing tcpci vbus command won't affect to ic if not supported.

> >   }
> >
> >   static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *=
tdata,
> > @@ -246,7 +269,12 @@ static int rt1711h_probe(struct i2c_client *client=
,
> >       if (ret < 0)
> >               return ret;
> >
> > +     chip->vbus =3D devm_regulator_get(&client->dev, "vbus");
> > +     if (IS_ERR(chip->vbus))
> > +             return PTR_ERR(chip->vbus);
> > +
>
> This makes regulator support mandatory, which so far was not the case.
> That warrants an explanation why it is not a problem for existing users.
>

We verified ic behavior as SNK only, because we couldn't add tcpci set
vbus callback and external boost otg vbus.
And we use our own type-c state machine and pd policy engine for mass
production to user.

> Thanks,
> Guenter
>
> >       chip->data.init =3D rt1711h_init;
> > +     chip->data.set_vbus =3D rt1711h_set_vbus;
> >       chip->data.set_vconn =3D rt1711h_set_vconn;
> >       chip->data.start_drp_toggling =3D rt1711h_start_drp_toggling;
> >       chip->tcpci =3D tcpci_register_port(chip->dev, &chip->data);
>
