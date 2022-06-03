Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909AA53CC84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245645AbiFCPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbiFCPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:47:22 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD07201A2;
        Fri,  3 Jun 2022 08:47:21 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-30ec2aa3b6cso86223427b3.11;
        Fri, 03 Jun 2022 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rpR+ysTG3r/oi1euOdZz8SzpGxkF/hmbsauLKYdP7M=;
        b=j8ZnU74uAZ6D4PTcz0R6xcRPZMVDV8xfs5gVpnCQ6CesHfOkQDe66XxCuvKfSh4iEX
         N6mLXP92d2JjbWn9UdwWXdA50w0AI1WOCDG64KjH8GMVwGGLPoCPbXJgyxLz/XMJi/Uu
         HNBD3fiXZV1JvbRNjOaY1JwGSYVf6MhvvExqfxuwDWPV6qInk4kuOsAAAgRRkR9Toklm
         MNfg3sHEVHYby5WuSoDGfjMKh2/bWBoBr5LR3SqMOCmmdmXIenMCpiQ/TY4xDK7f4vfq
         i/vU1rDsXyLxIUx6fvfgKgb0thIDs3LP8uCwAv1WChdgH2h9PwmjYor0+0pxHND1JY6t
         vObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rpR+ysTG3r/oi1euOdZz8SzpGxkF/hmbsauLKYdP7M=;
        b=IqGK73z0NcnEYx1hG20tmAtH6FnNCPsh48dfT16Bv9RhfjfqUi6dIIGgQJ/KeblbCZ
         rTgF8L2zPAPnBb/1RlUzq5UHe4mlAJV4TMckhhZ6n0gZchE7irb0VrD20yZKhpdDK82z
         mN3RwvMyQijaA1cUr6ir/y5Pyn3Tzz7cFL26TuaDT+WFPsmVUBpIE5rxDnJ65Xwvm6pB
         5naRzTGpvKAzOuf76yHEi2KPh9Puu4UyR/pAboILJJlMQ9U9rOutbc9uVnOve0vrAb0/
         u/ygdEH6xRUwEfnyOMeGqSdlVJVvHofPLTGCE1eVocGTgitRXdz40iIReTQWG0nDDEug
         /Qvw==
X-Gm-Message-State: AOAM53179q1k6LYbltLArOd5uxbK+q09qQYblg8iyN5WP2k9NImBD6lw
        OMZcYV8t5TQ3vuBJ2Tt3rJBYFI53rNLXNE1+p5uRl+8M8ga1rA==
X-Google-Smtp-Source: ABdhPJxxXAx4EKwCBga0uvTSPyC88Uc7cl+nSZjuc/BNL4mNAvKEvMHLlipFiizZqMB9qbAPEsZogJnu9cIWgunuEsw=
X-Received: by 2002:a81:60c6:0:b0:30f:ea59:10c7 with SMTP id
 u189-20020a8160c6000000b0030fea5910c7mr9504447ywb.78.1654271241188; Fri, 03
 Jun 2022 08:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220602213544.68273-1-max@enpas.org> <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 4 Jun 2022 00:47:10 +0900
Message-ID: <CAMZ6RqKM7Z3GzO6vKyWf7D1z=HvJBN2QaZz1==LBsEJKjz=Qag@mail.gmail.com>
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
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

On Sat. 4 June 2022 at 00:12, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
> Hi Max,
>
> I gave a final deep look into your driver. I found a few things which
> went through the cracks of my previous reviews. But overall, it start
> to look good. Well done and looking forward for the v8.
>
> On Fri. 3 June 2022 at 06:36, Max Staudt <max@enpas.org> wrote:
> > This is the can327 driver. It does a surprisingly good job at turning
> > ELM327 based OBD-II interfaces into cheap CAN interfaces for simple
> > homebrew projects.
> >
> > Please see the included documentation for details and limitations:
> > Documentation/networking/device_drivers/can/can327.rst
> >
> > Cc: linux-can <linux-can@vger.kernel.org>
> > Signed-off-by: Max Staudt <max@enpas.org>
> > ---
[...]
> > diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> > new file mode 100644
> > index 000000000000..e29031ad825d
> > --- /dev/null
> > +++ b/drivers/net/can/can327.c
> > @@ -0,0 +1,1158 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* ELM327 based CAN interface driver (tty line discipline)
> > + *
> > + * This driver started as a derivative of linux/drivers/net/can/slcan.c
> > + * and my thanks go to the original authors for their inspiration.
> > + *
> > + * can327.c Author : Max Staudt <max-linux@enpas.org>
> > + * slcan.c Author  : Oliver Hartkopp <socketcan@hartkopp.net>
> > + * slip.c Authors  : Laurence Culhane <loz@holmes.demon.co.uk>
> > + *                   Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
> > + */
> > +
> > +#define pr_fmt(fmt) "can327: " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
>
> linux/moduleparam.h is not needed, right? Please make sure to clean up
> unused headers.
>
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/bitops.h>
> > +#include <linux/ctype.h>
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/if_ether.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/string.h>
> > +#include <linux/tty.h>
> > +#include <linux/tty_ldisc.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include <uapi/linux/tty.h>
> > +
> > +#include <linux/can.h>
> > +#include <linux/can/dev.h>
> > +#include <linux/can/error.h>
> > +#include <linux/can/led.h>
>
> Rebase on net-next (or can-next) and remove CAN LED. c.f.:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=6c1e423a3c84953edcf91ff03ab97829b287184a
>
> > +#include <linux/can/rx-offload.h>
> > +
> > +#define ELM327_NAPI_WEIGHT 4
> > +
> > +#define ELM327_SIZE_RXBUF 224
> > +#define ELM327_SIZE_TXBUF 32
> > +
> > +#define ELM327_CAN_CONFIG_SEND_SFF           0x8000
> > +#define ELM327_CAN_CONFIG_VARIABLE_DLC       0x4000
> > +#define ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF  0x2000
> > +#define ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7  0x1000

This ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7 macro is not used.

> > +#define ELM327_DUMMY_CHAR 'y'
> > +#define ELM327_DUMMY_STRING "y"
> > +#define ELM327_READY_CHAR '>'


Yours sincerely,
Vincent Mailhol
