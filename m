Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D748F6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiAOL6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAOL6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:58:44 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 03:58:44 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so13357139otc.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 03:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZjvbSke9BdPxETtfaTJHHd+rn3AYix7YT8wSQwzCDY=;
        b=LxuqRmd1cSLdGPA9Ep9s63jgimB0LeesVi6ofrWZUxvrjqYmBBIMoaGYY/sQ+/Je3e
         HEimKjgFOrdYGYSoxo6zcRtYl/uhS0KsKZIFR+v7YfDv0YtGtIHWcVDmrI3qrhiNlWXK
         9PXYmUgVt1DNOQcOyA3H63jrSasPVgRf+QPpxxfsAcFyEhmXVUYk4A5n5KGM6kEKiPG/
         rvEfKmk0HHll9rgFwk6/RXiS+7FnpuK9ZWYeekpyxbwKU3jPTuUfxyvfPOg/S7bKSyX/
         EB0EB5g8tWkYiXc5UDphrzvqtHNNEVaMTey4dJ0miIocGkzj8r1o/vJJ1Cd49CdK0sJN
         o7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZjvbSke9BdPxETtfaTJHHd+rn3AYix7YT8wSQwzCDY=;
        b=dv6FNN8WFBv/uS432nWAUZQ84GYU1jCUL+yC0JraYz1moXGRFXmXNOAXlETymS3EEq
         rsG6+lTMSvIOz/Rah71uhuipD0Kot0dtIyu3jTxQJsFGizigJkiKmTQ7e0RJsAceoTLR
         CwomdRsjInoi/5C6kWnp0Br/LKZiLuzJ3JI67HYLccPVF/skJ25qGL4M9ZFZKVFDOfQy
         SemnJtelfuSf+CQeslvJP/r/sajenOjAHN3MEaIxOiO55gQCeh2gM1WZRsTEyEgx6q8a
         e4Dg7cpW3/qeZs+KE3bH3Hy7OkRWURHFOW1QT9pa81sutGh8jW4REyQMdNpeNHwYoI42
         Byrg==
X-Gm-Message-State: AOAM533x/fIAE5V8ciTWwCv4hATZsSU/BL6UoGStADWOX7lQ47PWETVy
        H5mEG2KNcsLRQr2KwPmrs/mPbPFg6i9Twg6PisnUtQJTnrs=
X-Google-Smtp-Source: ABdhPJx2y4aaPtxvV9O72RQF0nxah2k1PdVDycg/7mNOfXYfU2PltFuJaiaOaprnEpu5tXPRxA2St85VS8U2vC4WVmM=
X-Received: by 2002:a9d:6f13:: with SMTP id n19mr9814209otq.317.1642247922761;
 Sat, 15 Jan 2022 03:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20220113074016.15163-1-christian.gmeiner@gmail.com> <c88a1dc4-afbd-bc52-1320-8f3d0e951121@denx.de>
In-Reply-To: <c88a1dc4-afbd-bc52-1320-8f3d0e951121@denx.de>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Sat, 15 Jan 2022 13:58:31 +0200
Message-ID: <CAGi-RU+U21coW01Z+_1SbrsjA=9jmuGf19MgVywhzm3BT_KU1w@mail.gmail.com>
Subject: Re: [PATCH] net: fastboot: make UDP port net: configurable
To:     Heiko Schocher <hs@denx.de>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>,
        Michal Simek <michal.simek@xilinx.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 2:02 PM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Christian,
>
> On 13.01.22 08:40, Christian Gmeiner wrote:
> > The fastboot protocol uses per default the UDP port 5554. In some cases
> > it might be needed to change the used port. The fastboot utility provides
> > a way to specifiy an other port number to use already.
> >
> >   fastboot -s udp:192.168.1.76:1234 boot fastboot.img
> >
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/fastboot/Kconfig | 7 +++++++
> >  net/fastboot.c           | 5 +----
> >  2 files changed, 8 insertions(+), 4 deletions(-)
>
> Reviewed-by: Heiko Schocher <hs@denx.de>
>
> bye,
> Heiko
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
