Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240E746D54E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhLHOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhLHOPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:15:48 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F6C061746;
        Wed,  8 Dec 2021 06:12:16 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m6so4316587oim.2;
        Wed, 08 Dec 2021 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZ4a2Q2JGh9XlSO7M5O7EIwFUgTCzOJasXHkco99Bw4=;
        b=YuWPWAqeweg8HTH2XkmDa4rMIIEJdjBPBCFso+zEH0Om7eRZcAmJj+TDx+mPnt3HHO
         ipYQ9VL9Ey620DQ4xgJHasnrL6DTe0wncd3Zcv1rMvgME4JZWNSKbmv9OriEK8B33fXf
         y0c7W36DsJn9wYUv3rnnSH+uxs367RbSzOs6bLcpUK2AyryaVIIJRGqZYfzZyp84ioUD
         bv/aWB0O2JRO5GZHmFeoApovpTFbotaoAKtYlWD9MSjp1GpDcLCrcSFfI2iMFGdrcWPZ
         rBNHggLU9SpqDSjR79RXGvzfx9h/EFFJzUKtO4zDYXZrL+b9l6FA6QjCHVWN1aw33Scq
         yWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZ4a2Q2JGh9XlSO7M5O7EIwFUgTCzOJasXHkco99Bw4=;
        b=rpELA4g8lD0tdOYFWrJXc7RGkTbw4qK56qmoYBeoELxRJ30jSFgfL9LSrv5DjRWFqB
         plXMUk5KqRGXlfrUu9WrStDU1rsqY39yPAM6zbF6S4V+d8ggi3VS4RzmXy6XeHb+WHir
         U51fXaFJJSG0m7/f3veTz4rxeqMrn7vrnhJKEnMKNaLx53elvrD/GL+2ZZvkPcBaQtji
         TNjrH5z31tiPr+8WgW0DCvq3iuql/uQV02KUbTdGLtM0iw6pTJGkobgortDgUuyg4seM
         TYy9MZ9+ziJQftzrwzqFVw5xzdpHNK0mWn9IWtSe4/IvAV2896XB9K9RbLdJ0CCd13fx
         heHg==
X-Gm-Message-State: AOAM531oMZk1PNO69ncaXlbzr6gbzO2+SI9eajulYZRJig/iYsJFSVEX
        7iaA/kgGxseHF/dHFZnRDi9YemuyLj+u1RkqF+k=
X-Google-Smtp-Source: ABdhPJw7LPO7mfLxF4VV98Z4T/LGrfzmkd5il9GPK8oLAHj7mQpK5n6HFvXG2xLcIfVjF9EaUOC0R8VWwoFtkq9pq68=
X-Received: by 2002:a54:4486:: with SMTP id v6mr12060509oiv.90.1638972735722;
 Wed, 08 Dec 2021 06:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20211207221741.50422-1-makvihas@gmail.com> <YbBGWH0lPs3NBLQr@kroah.com>
In-Reply-To: <YbBGWH0lPs3NBLQr@kroah.com>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Wed, 8 Dec 2021 19:42:04 +0530
Message-ID: <CAH1kMwThQARAoxoxP__fv+f2ep5ndutnxUbQXPEyqn410oL1mA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: return appropriate error on failure
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please no, do not use ? : unless you have to.  Spell it out and use a
>> real if statement.

Okay. But I don't think it's required anymore, as Jiri pointed out in
https://bugzilla.kernel.org/show_bug.cgi?id=215205#c1

On Wed, Dec 8, 2021 at 11:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 08, 2021 at 03:47:41AM +0530, Vihas Mak wrote:
> > when a user with CAP_SYS_ADMIN disabled calls ioctl (TIOCSSERIAL),
> > uart_set_info() returns 0 instead of -EPERM and the user remains unware
> > about what went wrong. Fix this.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215205
> >
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 61e3dd022..c204bdecc 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -960,7 +960,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
> >               uport->fifosize = new_info->xmit_fifo_size;
> >
> >   check_and_exit:
> > -     retval = 0;
> > +     retval = retval < 0 ? retval : 0;
>
> Please no, do not use ? : unless you have to.  Spell it out and use a
> real if statement.
>
> thanks,
>
> greg k-h



-- 
Thanks,
Vihas
