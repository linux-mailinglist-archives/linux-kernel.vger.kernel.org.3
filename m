Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C858874A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiHCGVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiHCGU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:20:58 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F799FDD;
        Tue,  2 Aug 2022 23:20:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10ee900cce0so7796089fac.5;
        Tue, 02 Aug 2022 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UoDUfn07lj1EPRhh8vCnMbEYPXX0njhlmTS1Lk0TL0Y=;
        b=iKd5MJRD5krxJ02QPiD8/KyWNZXIi0VhEBGz4zMktR9OIztE5FDw15/s4OGEaM6JH3
         gF0MJRylprbfxt+WpYHCS0ghHUJk5YY3i5q5OYUPLROOOJVwrMCpdcvABuJWy9OXBHBk
         ajZ1e8j/FrvtO0CnrByKkfy9kq9ffcXEY9tDS/yYpaphXNSNHzdaG6BJ2Nu/7FG/+VfT
         9mgeuAhmtp6dNFRAlnROvF6/+eS0EUFxsLF4ufP7SzSQ/EC5iHHbn8wj5prOoxZoD+lH
         NljnX1XGR3TRdYJ4Ri9VXwyojDgkuNvbBtPROHmQKENJCikTQgsMLRwPNjguMuGs1Jyc
         WvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UoDUfn07lj1EPRhh8vCnMbEYPXX0njhlmTS1Lk0TL0Y=;
        b=jCr5B+YLs2VHlqwrqJA/mhMLM5hB8Vah47m8iKinPuyJPkYCMcvCNDXJx3dPBvV6jm
         1RnE2fl2xqcASTeV/C3aXOyWCLFWJlMqmLGoEgN5UTW0HAvi39APcASOXaXRJoJj8p4V
         MCUXrAxn9M59YDEqeAygzuUkv7UmjgUNRg7FdTbbBE78QcvK2IUUdfV+kwy3JXc7bLk/
         vadhjGeMCv6kv2k2OcBp9fXy7nj8w8xK5QdLbM51XOBYDGeqJ0vyAZH2TxHjmb+jagBD
         Z6M5oCsvhQ/iTk7GJp9Pxv38F1j/ZOIGzqlUVtk6uFCbzT0j9k7Hql/srXNIRdkHAK3i
         aGpg==
X-Gm-Message-State: ACgBeo2Dia7+IiEMY+izCYwq0X26+BDdYbV0cjbE/PsxhUG4VQwdRrdP
        d+iho/0qA027oIrlv/FgU/sQWfEcQ+eISKf2Vx4=
X-Google-Smtp-Source: AA6agR4v+Pr3+eXvow3XkcW2aCP5SX91uTNwvrEK7H5iLUE1rBO/FUR3hi5ms6WJJmS3Ym3cAJfxA92U2UTAz6vWyy0=
X-Received: by 2002:a05:6870:ea8e:b0:fe:251a:3c3d with SMTP id
 s14-20020a056870ea8e00b000fe251a3c3dmr1288561oap.62.1659507656067; Tue, 02
 Aug 2022 23:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-5-gene.chen.richtek@gmail.com> <YujeA2pHG2WnZjaF@kuha.fi.intel.com>
 <20220802085848.GA3096405@roeck-us.net>
In-Reply-To: <20220802085848.GA3096405@roeck-us.net>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Wed, 3 Aug 2022 14:20:44 +0800
Message-ID: <CAE+NS34JmppcAXdYSynuX7wdNKgByogKDn=AmW_PgR13nZ48=g@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] usb: typec: tcpci_rt1711h: Add initial phy setting
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

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2022=E5=B9=B48=E6=9C=882=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Aug 02, 2022 at 11:19:15AM +0300, Heikki Krogerus wrote:
> > Hi Gene,
> >
> > On Mon, Aug 01, 2022 at 06:14:44PM +0800, Gene Chen wrote:
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Add initial phy setting about phy dicard retry,
> > > rx filter deglitech time and BMC-encoded wait time
> >
> > I'm sorry, but what does "deglitech" mean? Is it just a typo?
> >
>
> deglitch ?
>

Yes, typo, I will fix it.

> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typ=
ec/tcpm/tcpci_rt1711h.c
> > > index df7bfe299987..33d8ea95b7c1 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > > @@ -20,6 +20,9 @@
> > >  #define RT1711H_VID                0x29CF
> > >  #define RT1711H_PID                0x1711
> > >
> > > +#define RT1711H_PHYCTRL1   0x80
> > > +#define RT1711H_PHYCTRL2   0x81
> > > +
> > >  #define RT1711H_RTCTRL8            0x9B
> > >
> > >  /* Autoidle timeout =3D (tout * 2 + 1) * 6.4ms */
> > > @@ -107,8 +110,18 @@ static int rt1711h_init(struct tcpci *tcpci, str=
uct tcpci_data *tdata)
> > >             return ret;
> > >
> > >     /* dcSRC.DRP : 33% */
> > > -   return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> > > +   ret =3D rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   /* Enable phy discard retry, retry count 7, rx filter deglitech 1=
00 us */
> > > +   ret =3D rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
> > > +   if (ret < 0)
> > > +           return ret;
> > >
> > > +   /* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us =
*/
> > > +   /* wait time : (val * .4167) us */
> > > +   return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
> > >  }
> > >
> > >  static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *=
tdata,
> > > --
> > > 2.25.1
> >
> > thanks,
> >
> > --
> > heikki
