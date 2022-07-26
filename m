Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0206B5812E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbiGZMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbiGZMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:12:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB992B1AD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:12:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y11so22187942lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRdMkVO45kt5SUq2iTSwOTuiugVw1ePTDCKNo3/Lr2Q=;
        b=PWpNy38u+kmxcyNOBTsonapbCAkL3cJaMR4mqtXCM6PBsg1pnSlLojXIouR2HEm4gc
         nQGRcdQhBEPSk7FemlfLMu2vuyGtyK9kGUQqImx3Jjqtd7THFBIPliuzj9VeIUclriS4
         pKb7YBTkwl30kCjGoqQ6zki5lcHDMdlsHMpwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRdMkVO45kt5SUq2iTSwOTuiugVw1ePTDCKNo3/Lr2Q=;
        b=uA/a58aRtzvnX7LD6Dkk1yldmZ3vNzqxJQ24zI+Qk5VRK1u39PezFYRJqti805KFpH
         0MGf4eq1+hrwjxScdizPdGs2lKEwaxxHLm8Uzc4WeIQCR6hJRtckIDhPxCF+yBY9Qlsw
         PV7v8bVx14rfxCMiolZ95934tTmKGEc3dfwNNpGkcnRiL0H+9IIp0JBbUhPn2/kOusXb
         6LD/+wvs3IDhmJW7a5jAVcVDsJmCZBB57fAQPzk+v6dTuxYL0wERM0vRaKV3RV9EuVEg
         cYqLp+/3GjJGgleGiq9MkUpDy3YmdJ5WA5lvexebbauvMfCpx7qp4dPhK4Ix0zASe+qb
         gWwg==
X-Gm-Message-State: AJIora/xcm8xhMHuUi7RguytWwP3yRCeS2QlBnLc8OOw1yZIVcjX9ZJT
        3a1nyZ0gwQH3fTWQ7fw3zhUVc3F5YozpZ8bWJy5XRg==
X-Google-Smtp-Source: AGRyM1tMgbLOF7GIEOIivn9Jp8KvbfU4Z7Vy7FS2Xgg2x+pv0vH3AwCgePCUcgeP86HEVM/iUvSYHNnU6CaDrCpYSvA=
X-Received: by 2002:a05:6512:32c2:b0:48a:9822:ca2c with SMTP id
 f2-20020a05651232c200b0048a9822ca2cmr2540199lfg.117.1658837519793; Tue, 26
 Jul 2022 05:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
 <20220725065419.3005015-3-dario.binacchi@amarulasolutions.com>
 <20220725123804.ofqpq4j467qkbtzn@pengutronix.de> <CABGWkvrBrTqWQPBWKuKzuwQzgvc-iuWJPXt2utb60MOfych09A@mail.gmail.com>
 <20220726115845.4ywgubfpqfbl7qa3@pengutronix.de>
In-Reply-To: <20220726115845.4ywgubfpqfbl7qa3@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Tue, 26 Jul 2022 14:11:48 +0200
Message-ID: <CABGWkvrknM0VS2V1TAjyjeoE0n2yXGLvv6ucvO-z23nL=EXvXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] can: slcan: remove legacy infrastructure
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Max Staudt <max@enpas.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 1:58 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 26.07.2022 12:11:33, Dario Binacchi wrote:
> > Hello Marc,
> >
> > On Mon, Jul 25, 2022 at 2:38 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > >
> > > On 25.07.2022 08:54:15, Dario Binacchi wrote:
> > > > Taking inspiration from the drivers/net/can/can327.c driver and at the
> > > > suggestion of its author Max Staudt, I removed legacy stuff like
> > > > `SLCAN_MAGIC' and `slcan_devs' resulting in simplification of the code
> > > > and its maintainability.
> > > >
> > > > The use of slcan_devs is derived from a very old kernel, since slip.c
> > > > is about 30 years old, so today's kernel allows us to remove it.
> > > >
> > > > The .hangup() ldisc function, which only called the ldisc .close(), has
> > > > been removed since the ldisc layer calls .close() in a good place
> > > > anyway.
> > > >
> > > > The old slcanX name has been dropped in order to use the standard canX
> > > > interface naming. It has been assumed that this change does not break
> > > > the user space as the slcan driver provides an ioctl to resolve from tty
> > > > fd to netdev name.
> > >
> > > Is there a man page that documents this iotcl? Please add it and/or the
> > > IOCTL name.
> >
> > I have not found documentation of the SIOCGIFNAME ioctl for the line discipline,
> > but only for netdev (i. e.
> > https://man7.org/linux/man-pages/man7/netdevice.7.html),
>
> Ok - What about:
>
> The old slcanX name has been dropped in order to use the standard canX
> interface naming. The ioctl SIOCGIFNAME can be used to query the name of
> the created interface. Further There are several ways to get stable
> interfaces names in user space, e.g. udev or systemd-networkd.

Good! I will update the commit message in the next version I will submit.
Thanks and regards,

Dario
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
