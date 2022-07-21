Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5501C57C47B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiGUGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiGUGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:30:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440C3FA25
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:30:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t1so1234180lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYoQxNSTNPsHjHHdnVSJTy6XvsIdkgtZZ+m+9kxdaVU=;
        b=cZTmE+yyZgkjRauw/z93i+eKr30+XFGJf4rOsbFIOkshDTO7DtT6DgMU1FfySEgVZ4
         8tcRWKJXfXdsE8ND0zp0iQcQSqDDQBRnGm3IUm/+0CTLKKxFRjAGEEMDftVCqoLiHDKz
         JbQCZRl2mvkzBVXQZYKO+7jcUFAfzihTz/sz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYoQxNSTNPsHjHHdnVSJTy6XvsIdkgtZZ+m+9kxdaVU=;
        b=2bsDNVy8kSU2kHdjfMVsVAolmq4sR1lhXxVn+z1oOyeMXTz5UbSWcAs3IpjowWzWVN
         LkalKltGlmNpF+N4QDC/+sJZNOB53z6TdLGLjm5i3WH+BQ9LGlTFEDON3PBeOwBVQDX2
         ef1TlByO7+Ll/exn+srEauDgvTbCNZI1nkvCzPLS3ndAqhO41o/StrW8Mfg9pj4CT2vE
         aqw/GJFplV10ryOU1K2HltShaweLG1a68wMZOEPTP3gWAQbmW7r73BKUGt4dOdQsxyYW
         QMz5JQDbViI4fufNQsJbxnApvUTuPC0wWVlgkVnWeJLVRzAhbdn4oUWDYc//x0HdTvCa
         aMcw==
X-Gm-Message-State: AJIora+SK/GD4AF+zRaX7J85HOaqabA5R21uA0K+PEi0UR0VvMikQuti
        jxZU21Glfl9iNe1+TQ3ziqqkkqLxdSiI8aKe4Y29J6iXjqtdjA==
X-Google-Smtp-Source: AGRyM1usdgJl116CRWoUjAKiyWdkZRovdyYrhs9Y/nxMXs1ETjBLO8msMh63pAMXzRER3QO83WcRywU7CnVHOdkIVMk=
X-Received: by 2002:a05:6512:1389:b0:489:d0bb:241e with SMTP id
 p9-20020a056512138900b00489d0bb241emr22781346lfa.536.1658385053417; Wed, 20
 Jul 2022 23:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220715072951.859586-1-dario.binacchi@amarulasolutions.com> <CAFqt6zaMnfGhwxnnJrbW1eoiGy46-WNUe8H-iqztRmZW5Z8jfQ@mail.gmail.com>
In-Reply-To: <CAFqt6zaMnfGhwxnnJrbW1eoiGy46-WNUe8H-iqztRmZW5Z8jfQ@mail.gmail.com>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Thu, 21 Jul 2022 08:30:41 +0200
Message-ID: <CABGWkvqonbDuSXk_iaxV4a-uBtHqeSUqAufj+LZULAVqb+u07Q@mail.gmail.com>
Subject: Re: [PATCH v3] can: slcan: do not sleep with a spin lock held
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        kbuild test robot <lkp@intel.com>,
        Richard Palethorpe <rpalethorpe@suse.de>,
        kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
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

Hello Souptick,

On Thu, Jul 21, 2022 at 3:58 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jul 15, 2022 at 1:00 PM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > We can't call close_candev() with a spin lock held, so release the lock
> > before calling it. After calling close_candev(), we can update the
> > fields of the private `struct can_priv' without having to acquire the
> > lock.
>
> But here we are updating private 'struct can_priv' before close_candev() while
> taking the lock.  If we go by change logs, then spin_unlock_bh() need to called
> before close_candev() and we can update the private 'struct can_priv'
> in existing place.

sl-> rcount and sl-> xleft are not part of 'struct can_priv' and can
be reset after
calling netif_stop_queu() because it inhibits any serial reception/transmission.

Thanks and regards,
Dario

>
> >
> > Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > Changes in v3:
> > - Update the commit message.
> > - Reset sl->rcount and sl->xleft before releasing the spin lock.
> >
> > Changes in v2:
> > - Release the lock just before calling the close_candev().
> >
> >  drivers/net/can/slcan/slcan-core.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> > index 54d29a410ad5..d40ddc596596 100644
> > --- a/drivers/net/can/slcan/slcan-core.c
> > +++ b/drivers/net/can/slcan/slcan-core.c
> > @@ -689,15 +689,14 @@ static int slc_close(struct net_device *dev)
> >                 clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
> >         }
> >         netif_stop_queue(dev);
> > +       sl->rcount   = 0;
> > +       sl->xleft    = 0;
> > +       spin_unlock_bh(&sl->lock);
> >         close_candev(dev);
> >         sl->can.state = CAN_STATE_STOPPED;
> >         if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
> >                 sl->can.bittiming.bitrate = CAN_BITRATE_UNSET;
> >
> > -       sl->rcount   = 0;
> > -       sl->xleft    = 0;
> > -       spin_unlock_bh(&sl->lock);
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.32.0
> >
> >



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
