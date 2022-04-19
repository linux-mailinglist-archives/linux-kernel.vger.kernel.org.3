Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF3507D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbiDSXoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354561AbiDSXmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:42:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC7EE9F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:39:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso2576525wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RHrbFYBi/qzFHB7B/mm3DnbADsP51ix+XKNZcvCBDdI=;
        b=Dx9tpGwffSyQwjHNSd6zVcAaAeE7zztKVijW4Ho4OfPOmsnL2LNx7U24GIcoMarJzR
         vCSNNTjPahvmsr6XdXQ/zmPc3KsmtcvXh2Q9pXY+Awuf/UntrxK1BYEinZkDZAkRMX9D
         80hqpsDd1anuJx/CXprXq6QO/3hyB6iFkiGnY1ZYo61TGaEwTZJnT0KxHYNH+k4aalNS
         8+CdEn9xwRRRzOMpaAsNDmWmeM59tROwLnD8mVEeeB4JnUVT6AwfY2sOOxiWp9BEdwV4
         2TPBqIoUcev6KbPGpXAwxVu+xjeHMME3Pbk7nXYoJbJWNkl0/q0qXxnKS4rur+qqVEMs
         CH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RHrbFYBi/qzFHB7B/mm3DnbADsP51ix+XKNZcvCBDdI=;
        b=ajmI5hU9968W8KWoHX1FWvREsJ1nOHhL2QmLjcVGSlt9uHvC72DgYhzhhpZPyqCNTo
         WeoaFmvQ0Qo2flLl1h+hzxZYr2eDccGJGWG598qDLATpAV2VxeyiVlIt7nQLsaAHmHso
         pmAjqE4rYsltdK2dnO0Vua+MjtigxOBm+86kPevwbCcuS45t0XXq374AZUrwK6iEFNrh
         0VTjTP6OOEnbh88dchUF7qCjdWagjCBLJI+uCSb53h2iqP2kIYRIhHWncacoRJF6OPPZ
         lFw7Jt57rBVPgXSm/trR9thNkby4b1WlrYHV4/Uau8PiBvdNqDq7TQAkcFvQfrbAa5tE
         t+zw==
X-Gm-Message-State: AOAM532uDnoBfHACCmeKjzLwCnspwfzHFGgt43uTBOGjfsgeSq15Jy6y
        HV0GSXASaYKtcmB+mPbAyY0sME83utjK//xC+TnFvg==
X-Google-Smtp-Source: ABdhPJx2XBKItBJuaY+YjvTn31qkSgPUV0xcIsWWIHq3FWyjiK9eCiTL7EMeKwibG5vapGjjkTL6jb3hhKFAGzJf/ng=
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id
 l1-20020a7bc341000000b0037bc619c9f4mr901984wmj.38.1650411586902; Tue, 19 Apr
 2022 16:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220405173741.4023216-1-jbk@chromium.org> <6528eec1-0ab1-a5ff-3e30-2e06256dfd04@molgen.mpg.de>
 <YlgOqpe85pe3P/JP@kernel.org> <068becdf-2d88-65a1-5977-1fedd34a8f0b@molgen.mpg.de>
 <047c3145c93a35ec3096aad44b221bda7d9e12c7.camel@kernel.org>
In-Reply-To: <047c3145c93a35ec3096aad44b221bda7d9e12c7.camel@kernel.org>
From:   Jes Klinke <jbk@google.com>
Date:   Tue, 19 Apr 2022 16:39:35 -0700
Message-ID: <CANMTAZS+UzqaoKybC6wy7JwDvtcrduvasvvC+hOrdmcsg2zMzQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: cr50: Add new device/vendor ID 0x504a6666
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Jes B. Klinke" <jbk@chromium.org>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your feedback, I have sent an updated patch to the list,
(as far as I could tell, the convention is to prefix with: [PATCH
v2]).

Regards
Jes

On Thu, Apr 14, 2022 at 9:53 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, 2022-04-14 at 17:06 +0200, Paul Menzel wrote:
> > Dear Jarkko,
> >
> >
> > Am 14.04.22 um 14:08 schrieb Jarkko Sakkinen:
> > > On Thu, Apr 07, 2022 at 12:21:44PM +0200, Paul Menzel wrote:
> >
> > > > Thank you for your patch.
> > > >
> > > > Am 05.04.22 um 19:37 schrieb Jes B. Klinke:
> > > > > Accept one additional numerical value of DID:VID for next generat=
ion
> > > > > Google TPM, to be used in future Chromebooks.
> > > >
> > > > Maybe extend:
> > > >
> > > > =E2=80=A6 Google TPM with new firmware =E2=80=A6
> > > >
> > > > The TPM with the new firmware has the code name TI50, and going to =
use the
> > > > same interfaces.
> > > >
> > > > > This patch touches more lines than may seem necessary, as a resul=
t of
> > > > > the need to move the error case to sit after the two recognized c=
ases.
> > > > >
> > > > > Signed-off-by: Jes B. Klinke <jbk@chromium.org>
> > > > > ---
> > > > >
> > > > >    drivers/char/tpm/tpm_tis_i2c_cr50.c | 21 +++++++++++++--------
> > > > >    1 file changed, 13 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/t=
pm/tpm_tis_i2c_cr50.c
> > > > > index f6c0affbb4567..bf54ebd6724b0 100644
> > > > > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > > > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > > > @@ -31,6 +31,7 @@
> > > > >    #define TPM_CR50_TIMEOUT_SHORT_MS    2               /* Short =
timeout during transactions */
> > > > >    #define TPM_CR50_TIMEOUT_NOIRQ_MS    20              /* Timeou=
t for TPM ready without IRQ */
> > > > >    #define TPM_CR50_I2C_DID_VID         0x00281ae0L     /* Device=
 and vendor ID reg value */
> > > > > +#define TPM_TI50_I2C_DID_VID           0x504a6666L     /* Device=
 and vendor ID reg value */
> > > > >    #define TPM_CR50_I2C_MAX_RETRIES     3               /* Max re=
tries due to I2C errors */
> > > > >    #define TPM_CR50_I2C_RETRY_DELAY_LO  55              /* Min us=
ecs between retries on I2C */
> > > > >    #define TPM_CR50_I2C_RETRY_DELAY_HI  65              /* Max us=
ecs between retries on I2C */
> > > > > @@ -742,16 +743,20 @@ static int tpm_cr50_i2c_probe(struct i2c_cl=
ient *client)
> > > > >         }
> > > > >         vendor =3D le32_to_cpup((__le32 *)buf);
> > > > > -       if (vendor !=3D TPM_CR50_I2C_DID_VID) {
> > > > > -               dev_err(dev, "Vendor ID did not match! ID was %08=
x\n", vendor);
> > > > > -               tpm_cr50_release_locality(chip, true);
> > > > > -               return -ENODEV;
> > > > > +       if (vendor =3D=3D TPM_CR50_I2C_DID_VID) {
> > > > > +               dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id=
 0x%x)\n",
> > > > > +                        client->addr, client->irq, vendor >> 16)=
;
> > > > > +               return tpm_chip_register(chip);
> > > > > +       }
> > > > > +       if (vendor =3D=3D TPM_TI50_I2C_DID_VID) {
> > > > > +               dev_info(dev, "ti50 TPM 2.0 (i2c 0x%02x irq %d id=
 0x%x)\n",
> > > > > +                        client->addr, client->irq, vendor >> 16)=
;
> > > > > +               return tpm_chip_register(chip);
> > > > >         }
> > > >
> > > > Both branches are quite similar. Can a ternary operator be used?
> > > >
> > > >      dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > > >          (vendor =3D=3D TPM_CR50_I2C_DID_VID) ? "cr50" : "ti50", cl=
ient->addr,
> > > > client->irq, vendor >> 16);
> > > >      return tpm_chip_register(chip);
> > > >
> > > > and the original flow be left? (A separate variable can also be add=
ed.)
> > > >
> > > > > -       dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n=
",
> > > > > -                client->addr, client->irq, vendor >> 16);
> > > > > -
> > > > > -       return tpm_chip_register(chip);
> > > > > +       dev_err(dev, "Vendor ID did not match! ID was %08x\n", ve=
ndor);
> > > > > +       tpm_cr50_release_locality(chip, true);
> > > > > +       return -ENODEV;
> > > > >    }
> > > > >    /**
> >
> > > OK, these are legit suggestions. Paul, can you do these changes and a=
dd my
> > > reviewed-by for the +1 version?
> >
> > I guess you mean Jes?
> >
> >
> > Kind regards,
>
> Yeah, I meant Jes :-)
>
> /Jarkko
