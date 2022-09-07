Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE35AF991
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiIGB7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGB72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:59:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EBC260E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:59:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq23so20175231lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 18:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EFy/QSO0F4j4Apu6RDsR6WCOc7oRq8bSTcHPqIPG7Ts=;
        b=CCb3YOlFRGWWKGrdlvaf62RkHUFHvgRy9Pl9Rd5dpb7MJ1mMzrDvjPIFfvyJGxq521
         HLL2gwDh9W9SZJY07tUIEXxkzko4IKHaUexEgGUbock7JFGJgk+c4+zs+ethDsttKJnY
         Cre2ZzqRNPSSsrPTR4DL8YcPz26qn7efBPg/zkVnaxZmdOhYBiVhTRpxr4GnqiCY3YGJ
         OMPGf2KDNvlMBdDnInQqa2lLDl+mU0OYpsPdblH6WJafSsaPhsF3OwuIuAVR9jzK6Hlo
         6lJ2qANjOJosL8cVbuKIBu87cnBuGSV/KdwBRcffz4+QXJVmy/yCLoPNO8vP3GbByP6H
         CxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EFy/QSO0F4j4Apu6RDsR6WCOc7oRq8bSTcHPqIPG7Ts=;
        b=4cFsDrFdQmAECeyWaDauoNCem1XrmNz8bgJGUSc13sFy9iw2CRqr0688imYjndwuwF
         rAoooHC4GWJRgHzYrBH1I/39WMe+nH1guSHMBE8Je/mZq+R8SqD4CR9lKo7GZXjqiJLT
         D0z69JORHEMx4XU9x8R60m3XbUQJoCFGo5xXazb66apLUIqGxdwu+/kz236Gl/OGWNbt
         OWOQgvMJ0HGEDK9n++0JyLCnBRzmAIsgDISkcibi/9LUddeDoBULm/83dDH1vNGlXixd
         KaYAD8Hnlc//uS2/16Mf6fAITMS/459Udcox3o3agPIBlY4bfi4Knj76Hc8XdORVdSSj
         qVbw==
X-Gm-Message-State: ACgBeo3nzYu69gfba3JHFMXCUIEXtShKEW1AGcqYJljcjgJSrF3NEumo
        QJZwljL/P0CbqL53KVdweczOKOjzWhuCmPCERCTa1A==
X-Google-Smtp-Source: AA6agR62TnWZqZ0eQ9BI+5r4ExFk6NfXVb5ER+iX5GutywvNPeAGme2Hie99tf6Po3ksGbjEiGX0TE6PEACqxBFgm5c=
X-Received: by 2002:a05:6512:3f05:b0:497:9e06:255b with SMTP id
 y5-20020a0565123f0500b004979e06255bmr355206lfa.175.1662515964784; Tue, 06 Sep
 2022 18:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220906101555.106033-1-mie@igel.co.jp> <Yxcn4CPN3BkC9xg7@kroah.com>
In-Reply-To: <Yxcn4CPN3BkC9xg7@kroah.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 7 Sep 2022 10:59:13 +0900
Message-ID: <CANXvt5ouQ72R3q=G3W-N77ecmu8k86c4FwpEq4eMaCG-pt=G_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] misc: pci_endpoint_test: Aggregate params
 checking for xfer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=E5=B9=B49=E6=9C=886=E6=97=A5(=E7=81=AB) 19:58 Greg Kroah-Hartman <greg=
kh@linuxfoundation.org>:
>
> On Tue, Sep 06, 2022 at 07:15:54PM +0900, Shunsuke Mie wrote:
> > Each transfer test functions have same parameter checking code. This pa=
tch
> > unites those to an introduced function.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> > Changes in v2:
> > * New patch
> > ---
> > ---
> >  drivers/misc/pci_endpoint_test.c | 35 ++++++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoi=
nt_test.c
> > index 8f786a225dcf..3bd9f135cdac 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -332,6 +332,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_e=
ndpoint_test *test,
> >       return false;
> >  }
> >
> > +static int pci_endpoint_test_validate_xfer_params(struct device *dev,
> > +             struct pci_endpoint_test_xfer_param *param, size_t alignm=
ent)
> > +{
> > +     if (param->size > SIZE_MAX - alignment) {
> > +             dev_err(dev, "Maximum transfer data size exceeded\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
> >                                  unsigned long arg)
> >  {
> > @@ -363,9 +374,13 @@ static bool pci_endpoint_test_copy(struct pci_endp=
oint_test *test,
> >               return false;
> >       }
> >
> > +     err =3D pci_endpoint_test_validate_xfer_params(dev, &param, align=
ment);
> > +     if (err) {
> > +             dev_err(dev, "Invalid parameter\n");
>
> Also, you just printed 2 errors for the same error.  Not needed.
I see. I'll also change to using the dev_dbg() in the next version.

Thanks,
Shunsuke
