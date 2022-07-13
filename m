Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A505736A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiGMMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiGMMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:52:04 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899343190D;
        Wed, 13 Jul 2022 05:52:03 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h62so16450431ybb.11;
        Wed, 13 Jul 2022 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyF65RB+8ufLsUOwv6H7Jw838CrnaTJC1Ttm5pW+P+I=;
        b=Vps9sLVokrir+gToIIG3HnyfI3A9gdS/d1Cxzo0WtN7NBV4t62NimAT3boSnOtoVdT
         WnIz0HP2cz3oDYg01F0Sat2mg6qkWTtEbLIvTqYdKhwG/eDv5Ffgw6lrLM3N4do1hJit
         RP3J2+irrBKx5anjifc84xsYXpKTeUbfnQHQrWUPVnibtDk/Gd7neJ06fOPqp3gc0twr
         efKe/Ppq/fnC84IsAimX7ZmPYhFyChCjKp/G2sMwF7QxCeLv2pAV7n/+SXrEMwTJtVHe
         ZlHQoe9kNCVRGM9cu9rCkjmbOWz9U9YbEq2Dhlgk96f6I3uX3hJkaK5WR3BYavmV5Hq3
         JqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyF65RB+8ufLsUOwv6H7Jw838CrnaTJC1Ttm5pW+P+I=;
        b=KL4C0Py1RwjLz8VFr8bTf2gdrC0jGawXpbDZ2iNcPNIcVKeT/9g25kllN1z/uZ8Dvj
         3WQQVPIwEizkDczlXQZMTO5JPNnSeDMwcEnQsEsZ6z3HvgadDfGmrFn9nRohcwJjHGrg
         xcpHhlk5Arch8YL5MaiPFG83obwHfd7bO9lKIsdMyMG4JLsAH+kDLI5N+BRJiDQuRY1H
         VAHHk0ffG6JkTV1X+cFgKNExkqptJ+CvPM563aPT7j8Sl54YgHYG14BzW7mVe5MJ8M8v
         v4tboA0nNJ06NQibDHBhscJNz0b+/IeZiPvJMJx83OAM2LjmkLCv5wDof6Js0ctD4VEf
         NfFQ==
X-Gm-Message-State: AJIora+BpDtwRorBcnCf0kkPX+PhUP0becdc8BZUNhKlXxvDynQHvxD1
        z+39Iw/BEGMWW0yhgGrZ09nht+qHUSR/oHb0WA0=
X-Google-Smtp-Source: AGRyM1tIXmvkspDZ+KnGadtTKiM3ZSi/5BnlTQViEXL5fewqO5V+jsPgxI6YrR3TggVxV1IylDc97/CZRahyg417wjE=
X-Received: by 2002:a05:6902:1143:b0:66e:eb08:4c23 with SMTP id
 p3-20020a056902114300b0066eeb084c23mr3672259ybu.570.1657716722756; Wed, 13
 Jul 2022 05:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220713123922.2284522-1-vamshigajjela@google.com>
In-Reply-To: <20220713123922.2284522-1-vamshigajjela@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 14:51:25 +0200
Message-ID: <CAHp75Vf8fOpyp0R+D5w0gYeVTAUOa+Qnb=16bT9LnpjyUk-JSg@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250_dw: Avoid pslverr on reading empty
 receiver fifo
To:     Vamshi Gajjela <vamshigajjela@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manu Gautam <manugautam@google.com>
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

On Wed, Jul 13, 2022 at 2:43 PM Vamshi Gajjela <vamshigajjela@google.com> wrote:
>
> From: VAMSHI GAJJELA <vamshigajjela@google.com>
>
> With PSLVERR_RESP_EN parameter set to 1, the device generates an error
> response when an attempt to read an empty RBR with FIFO enabled.
>
> This happens when LCR writes are ignored when UART is busy.
> dw8250_check_lcr() in retries to update LCR, invokes dw8250_force_idle()
> to clear and reset FIFO and eventually reads UART_RX causing the error.
>
> Avoid this by not reading RBR/UART_RX when no data is available.

Thanks for an update!
My comments below.

...

> +       /*
> +        * With PSLVERR_RESP_EN parameter set to 1, the device generates an
> +        * error response when an attempt to read empty RBR with FIFO enabled.

an empty

> +        */
> +       lsr = p->serial_in(p, UART_LSR);

I have just noticed that you do it independently on FIFO enablement.

> +       if ((up->fcr & UART_FCR_ENABLE_FIFO) && !(lsr & UART_LSR_DR))
> +               return;

I would recommend to move it inside the conditional

  if (fcr & FIFO) {
    lsr = ...
    if (!(lsr &))
      return;
  }

-- 
With Best Regards,
Andy Shevchenko
