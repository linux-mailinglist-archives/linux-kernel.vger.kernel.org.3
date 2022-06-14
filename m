Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7D54AD49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356092AbiFNJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355989AbiFNJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:21:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB32943AF7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:21:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v19so10724257edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9+sBB4az8PfG+oqMLFfqvzPWPE5Mvh0+Xpdi5P3RSU=;
        b=VfJB3BZcteWdCfL0c3cN7yC152WlTrVmpyCDgUTuU2vLFvUrCp2os2P/tYJ7iRsJ/N
         sdIMMsB1imy+v5XY3EKLZZRJnvPkYaBkdtWnT+EtM+jahFrzR6xiVOgy1rpwCPY8R6j6
         ez29wttJXxUJRq5AC8K9Gqt3BHxqwtghz8wWrcH8fhdaCA8Y59EgmM8jK+iHqnm9GVw0
         A2mnOhYZkUjlQJK5fj1iGBOcNfCCDhrWntBQvSrxKUz0OtoeSgAB6VFaywoe9Nj7ZuEg
         nblvof50FLse+WTB6kwc8WKwRfuTlx9W5li+vxKPX7H8ix/QkzzY7xN165Rs2F43MNrY
         72eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9+sBB4az8PfG+oqMLFfqvzPWPE5Mvh0+Xpdi5P3RSU=;
        b=TjU24SLewHQveIBDAv7E3VqKBuBHD2ar7aI0Cmf95ggTLti7AFL5UHmbScFNRNd0DQ
         aLDgvAgNQN1Q0U5E0vsogcjTyeTlhG3lAXWolgExZh0U2xrSj1yCghha6PFzA7l04ZT9
         PrYvM9xDWVBYHRRqqf/33hLvCSQt04dRdpBRuqRwdVgIT5NbuhJzfQu34WRs+HlnpL0Y
         Kindu7dys3lgg4ca4wBaVDFCUtXAWjx61hlHWiLOFiKekSkco8ejkMDOQSvFroIbbjV+
         yc9+PajKvSA8412iSpf7dXAoinJJmksEK+MuImyAAuQ+5YdfrZpHZAywuEaSkkOo4uZ4
         865g==
X-Gm-Message-State: AOAM533S4JdF8232Dk9YykkwNqVvxO5TVGYatW5V5GMCJaFbEv2sIqND
        NISjJErv3+UKFQM2EeorUsD+Nv4IiAgyreEWJyo=
X-Google-Smtp-Source: ABdhPJyM3jgouLOMO/tDjE10nh/quVO83hQwpb9AxR+1pb4d1TKYuAK2pd+SndevH09DDQqKU9vRb/LEsCKOPYjhFkI=
X-Received: by 2002:a05:6402:3325:b0:42d:e1d8:99e9 with SMTP id
 e37-20020a056402332500b0042de1d899e9mr4578210eda.87.1655198505246; Tue, 14
 Jun 2022 02:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220614090340.123714-1-dzm91@hust.edu.cn> <YqhSYtfLJ3h/zFEr@kroah.com>
In-Reply-To: <YqhSYtfLJ3h/zFEr@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 14 Jun 2022 17:21:10 +0800
Message-ID: <CAD-N9QUpBHgtu8kssuf-22n94RnLDshioDaJTcFWNipvAuh08g@mail.gmail.com>
Subject: Re: [PATCH] driver: r8188eu: remove NULL check before vfree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 5:18 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 14, 2022 at 05:03:30PM +0800, Dongliang Mu wrote:
> > From: mudongliang <mudongliangabcd@gmail.com>
> >
> > vfree can handle NULL pointer as its argument.
> > According to coccinelle isnullfree check, remove NULL check
> > before vfree operation.
> >
> > Signed-off-by: mudongliang <mudongliangabcd@gmail.com>
> > ---
> >  drivers/staging/r8188eu/os_dep/usb_intf.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > index 68869c5daeff..bd1c8b4b5c4b 100644
> > --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> > +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > @@ -372,8 +372,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
> >  free_adapter:
> >       if (pnetdev)
> >               rtw_free_netdev(pnetdev);
> > -     else if (padapter)
> > -             vfree(padapter);
> > +     vfree(padapter);
>
> You changed the logic of this code here, please be more careful in the
> future.

Oh yes, I will move vfree into the else branch. Sorry for the mistake.

>
> Also, you need to use your real name for the signed-off-by and From:
> line.

Sure.

>
> thanks,
>
> greg k-h
