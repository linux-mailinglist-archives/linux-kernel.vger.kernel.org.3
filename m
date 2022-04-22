Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769B50ADE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443465AbiDVCnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390541AbiDVCng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:43:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF66D46B09;
        Thu, 21 Apr 2022 19:40:44 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r12so7316253iod.6;
        Thu, 21 Apr 2022 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tA/GN7+c67o1NyF+466DMI+EMeC8sv83fFoRqBT9mgE=;
        b=iWDj5KrTRCIAze4iAjXfwBmxw+2GGryED8OtbsZfik3uu6ApHgr2YAlKYwx/Oag+LB
         kYsciKiRfATmgZnuTURK5py1o4FbOj1BtuahGF0Z3fVc52CWP+VGSolM/AufEquSwCJe
         dTe20Iym4u5BNlgFUL0tb1CiFHYHiWyO13cwwQJZa/pU8V45ZxUZQdkfU2A7mRCDrLiy
         PV4cCqDWtTdnggsu5N9rM0hBXtKgtAcdviFfGHOdxUn/+pY+Gbi5MIjn/ZTMRIvfGh5A
         4vmUUgC5P0K0pF4rSerRDbEa0yWMCEPkeFPWoWUChrl8Rh/HLGbJnVT/SJ+GXDn047n4
         LkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tA/GN7+c67o1NyF+466DMI+EMeC8sv83fFoRqBT9mgE=;
        b=jX1dtviR2vXECx6ghMI4D4xfm7U7KUCL4HMAm+bgnSIFBYpd4rEosiifZTrM4rC8F2
         5Ki0TLtCSAmeawA30Fi9/U0e04ZzMGeBJLmTfSgXQ/cViArdySjt0TjH1k7wTdEqG5do
         SqIOHom4UbiNRAmVFo0C7ABegAWfVOOVZvXTlTkJ7gWEV19PAAF1dBqOudae6sYonISj
         XOGVcc0HpU6ER7DsZC3wnVHxCbc+x1XYLXdnvZUzOlB3cn5XwdvQs0PsC0/jRaeuTUeP
         WXlGexQ30YifRA84szndr7GhGBhNQQoF7BYegShgeDA/AkdXpFCKmX9/lXxF2Vefi/cm
         L7Ag==
X-Gm-Message-State: AOAM530TMPoS6kdUeqV/xhu4OxDwf140fGXv3lZG+HDPesze+pkCQxNt
        mHaFhOfxQIrEVofQptgVnErFjTrZEr2H4iZLLUJEyDRETCt3Cg==
X-Google-Smtp-Source: ABdhPJxzeptQM9ahlnz6s9Cc/eazWxRkvi16dcAHXk+T4ARzeWuwv1h0OnxsNqswC/tER+iSCbDcFGquCMU4cre58wE=
X-Received: by 2002:a05:6638:213:b0:326:5c30:494b with SMTP id
 e19-20020a056638021300b003265c30494bmr1251627jaq.42.1650595244330; Thu, 21
 Apr 2022 19:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220412025952.21062-1-surong.pang@gmail.com> <YmGJOYDdn1T9+lPy@kroah.com>
In-Reply-To: <YmGJOYDdn1T9+lPy@kroah.com>
From:   surong pang <surong.pang@gmail.com>
Date:   Fri, 22 Apr 2022 10:40:33 +0800
Message-ID: <CAEDbmAQw0t1dXwvBMudBtA8iT_iaXAouv9_q=j0PFhWWRduPug@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] usb/host: To get "usb3-slow-suspend" property,
 then to set xhci quirks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson.Zhai@unisoc.com,
        yunguo.wu@unisoc.com
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

We need to abandon this patch.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=94 00:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 12, 2022 at 10:59:52AM +0800, Surong Pang wrote:
> > From: Surong Pang <surong.pang@unisoc.com>
> >
> > To set xhci->quirks value according to "usb3-slow-suspend" property
> >
> > Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> > ---
> >  drivers/usb/host/xhci-plat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.=
c
> > index 649ffd861b44..6bc456bc6468 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -302,6 +302,9 @@ static int xhci_plat_probe(struct platform_device *=
pdev)
> >               if (device_property_read_bool(tmpdev, "usb3-lpm-capable")=
)
> >                       xhci->quirks |=3D XHCI_LPM_SUPPORT;
> >
> > +             if (device_property_read_bool(tmpdev, "usb3-slow-suspend"=
))
> > +                     xhci->quirks |=3D XHCI_SLOW_SUSPEND;
>
> Device properties need to be documented somewhere.
>
