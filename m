Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB29500F73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbiDNN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244183AbiDNNXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:23:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E47F939ED;
        Thu, 14 Apr 2022 06:18:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2eafabbc80aso54530987b3.11;
        Thu, 14 Apr 2022 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VSPSHGLNryKTOTOge0ylfTJKLHsA725QG3K5z7xv3vQ=;
        b=mzWrWwMEQ3pI8mP8YATBmRidCAoh3CfJ3ZEoKRvU/hHhk+epGF0cWiBIe+gMTfRG7M
         JLofzUCSt7FOvDvWoAd0Cz4EJjHM+vtgdfOyvRV1Df6lpRDHn+ycrgprZg3GPWuVWXw/
         zDqLZHVkl55JdcERRPvuilaE0ghuLJhV3jYRHp7aQEazFf0h+AZb/OY0BNm7FFikyUh8
         2OFyH+OSRjSojLe4FzHaaEfUxSsSGF/T8sQZ+6AjO1r5Tk6/4ba7mnJt19a5ITEXX7ms
         Ig8C1xutmBlhR42x9LIgohdBjS8wRUNKcPCywc2WDCV893IRcfLphbHWbvkYOZtem/KC
         UJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VSPSHGLNryKTOTOge0ylfTJKLHsA725QG3K5z7xv3vQ=;
        b=hzWdlTmEd4mD9a+12mm17fULW07cK/ocaZ5HT0C1WXqkwnEbIFCnuAitnyUvUZw7H4
         n8yJxurUfntrDMV6XpHTpf1fKRM3ne3otu8CWupdxlYzBqtHcqjXKz2I3iCzoZV8SNFF
         ZQHglEnBkPIEOFwwHK4m8SNyWpEE4kPht5Fjl8uGdS/tcHnqaMPuG67OPJrLNgvfjzHO
         zW1Ux3cIpcjSaUU7APaZedK5J2bjXZ0fMElpzJeO8GyHpenrdtz3af5Gv1aSIGbPeRoM
         ZhktCPP3aPS48YlbmxMKNAo3fHs8iKQWtTAC4urdjA0bFy1+OK68NY1m+WvfRas7L2Ed
         Cj0Q==
X-Gm-Message-State: AOAM531YT/l3FjiBMCQGt8urDFAm9ZIZMO8wcNZJhPzHzIqJCjZ/710+
        7h8F7HWmLhhitqPRiE26GjNzu/r1RGHaz2RTH6mhr9USvyM=
X-Google-Smtp-Source: ABdhPJw7JUk3PaMO3ZTIH6MHWMnYDMymlZdf02YIpUqHKqDgK9Ke78x/au9ULwW+2UgR4ORl9VvEyHq2/PIbd6B/AXk=
X-Received: by 2002:a0d:d702:0:b0:2ef:32f7:b800 with SMTP id
 z2-20020a0dd702000000b002ef32f7b800mr1937878ywd.482.1649942312435; Thu, 14
 Apr 2022 06:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
 <fdb1e0a6-62f9-c0a3-c1db-8857087701a1@redhat.com>
In-Reply-To: <fdb1e0a6-62f9-c0a3-c1db-8857087701a1@redhat.com>
From:   =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Date:   Thu, 14 Apr 2022 21:16:15 +0800
Message-ID: <CAGcXWkzZex-XTEoq8H5mc+3Y2BH=cphdpH-815Y+TAq812K=8g@mail.gmail.com>
Subject: Re: [PATCH] spi: remove spin_lock_irq in the irq procress
To:     Tom Rix <trix@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>,
        "lh.kuo" <lh.kuo@sunplus.com>, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom :

    This SPI driver only handles one transfer at a time.
That's why locks are not needed.


Li-hao Kuo

Tom Rix <trix@redhat.com> =E6=96=BC 2022=E5=B9=B44=E6=9C=8813=E6=97=A5 =E9=
=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> On 4/12/22 6:38 PM, Li-hao Kuo wrote:
> > - remove spin_lock_irq and spin_unlock_irq in the irq funciton
>
> function
>
> I was expecting a statement on why is the lock is not needed.
>
> Could you add one ?
>
> Tom
>
> >
> > Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> > ---
> >   drivers/spi/spi-sunplus-sp7021.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus=
-sp7021.c
> > index f989f7b..120623c 100644
> > --- a/drivers/spi/spi-sunplus-sp7021.c
> > +++ b/drivers/spi/spi-sunplus-sp7021.c
> > @@ -199,8 +199,6 @@ static irqreturn_t sp7021_spi_master_irq(int irq, v=
oid *dev)
> >       if (tx_len =3D=3D 0 && total_len =3D=3D 0)
> >               return IRQ_NONE;
> >
> > -     spin_lock_irq(&pspim->lock);
> > -
> >       rx_cnt =3D FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
> >       if (fd_status & SP7021_RX_FULL_FLAG)
> >               rx_cnt =3D pspim->data_unit;
> > @@ -239,7 +237,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, v=
oid *dev)
> >
> >       if (isrdone)
> >               complete(&pspim->isr_done);
> > -     spin_unlock_irq(&pspim->lock);
> > +
> >       return IRQ_HANDLED;
> >   }
> >
>
