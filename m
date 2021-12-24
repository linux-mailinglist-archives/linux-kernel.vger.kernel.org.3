Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0547EC98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351778AbhLXHQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343520AbhLXHQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:16:50 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D478AC061401;
        Thu, 23 Dec 2021 23:16:50 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t19so7147657pfg.9;
        Thu, 23 Dec 2021 23:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zhwb/1rkoFIfNJihrhMcunuEn4WEc3y8o31ix4CFyjU=;
        b=b4Kvbs45Qr6PRMyWWn89aKY+AiKiW+YoZcb0F3AZiEdt62ZrHZLylLv88kjGTV10yp
         znp1cXYLG7oo6LIDK/2c/ZsgxPHsm4aIXjTfzd5hsD2V7FLyBevPw9joXwYwZxEKQPci
         AmMJDGQhmksGwjgxA2+SF5uBBuB9V0wBriorPaiBnlzySyeZOPpoEiHkSiFrJtRy/bMv
         eR6A9raPgATbNTXKRqSxnGKjTLx2BB2O1bMwAC2X9CBB+vv/VyfhfxdjX44jiw0pU2X9
         E1TFiOSYf5cADMFj9sNKXAmXSGklf2XNJ++YBRFAy/spCVKXd65Sh+wPW4yHuFopVzEv
         MPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zhwb/1rkoFIfNJihrhMcunuEn4WEc3y8o31ix4CFyjU=;
        b=kqXX42CMAH66hSHpz9/s5MZmTXff/JCG0+oEuyOPvzMOEltetx+J+SvuewPyZj/Y2F
         Ni0GBZJnnBmvPYEWrVJE0c5hgzLqQODsZvfUZ3MCqtp7DqKjLZte4RRpibTqX10mspc/
         VBUj6JdmlyQ0SUuWXyIlGdCZ85ODyI3tN5vgj6+dY1I8BrG5KkEaesp+k9PbWaIFDTgp
         uM51JcB2yAp3mf4L7I5odCTnlknYGdeq573rfkFaROR+BSvVJSZUQIQmVidprYsqzoSQ
         zA5TkUQ+3WRmxJLSqJP8MwmKPfe6IFunyD1qYR5t9y5Ckvd4RJgYUJW/26hSX+/gWxRK
         +24A==
X-Gm-Message-State: AOAM532FoB4lBEujKuyD7pR2+bCQTt+q3296aY3mc1Mws6juRnclx5oD
        icJ/7PB+mZk3OetKoQ8lxqV/xpy//cDGfifwZrvwWOx3p8o=
X-Google-Smtp-Source: ABdhPJzLVSYDsmClvfrI8LbillRgjj3U2qtgV463+mBt90V3xYlLMjXSdjEuWuXSMjT7xr/YGE/Qp/eFZo0LfA18S08=
X-Received: by 2002:a63:5725:: with SMTP id l37mr5062321pgb.476.1640330209857;
 Thu, 23 Dec 2021 23:16:49 -0800 (PST)
MIME-Version: 1.0
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
 <YcCmaJkeKy+R0mhF@kroah.com> <CAOX-t54j9=7eLMAx4n-ngiNdM=Ab=YcK-zdxRW88e41cPS=46Q@mail.gmail.com>
 <YcGOmzKSHOoycZNC@kroah.com>
In-Reply-To: <YcGOmzKSHOoycZNC@kroah.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Fri, 24 Dec 2021 15:16:55 +0800
Message-ID: <CAOX-t55fBM7u3qZm7ubLANDnWNFhCiBXB29v00racWd-gy3OgA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg KH :

In patch v1 coding quite mess, it is almost 2000 LOCs.
For down size code under 1000 LOCs, I decide to drop DMA function code
after patch v3.
I think that's the biggest difference compared with 8250.
Without DMA function, like you said it looks like 8250 variant.
I think I should put DMA function back in next submit.

Another question for why I need PORT_SLUNPLUS ?
I just check many other uart driver, almost all driver define their
own PORT number.
Actually, I didn't know about it.
Maybe some device like bluetooth(use uart port) need autoconfig.
Then it will call ioctl with TIOCSERCONFIG.
I don't have tool for calling type/config/request/release/verify.

Regards,
Hammer Hsieh

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, Dec 21, 2021 at 04:14:16PM +0800, hammer hsieh wrote:
> > Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=88=
20=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:51=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On Mon, Dec 13, 2021 at 03:10:07PM +0800, Hammer Hsieh wrote:
> > > > +/* Register offsets */
> > > > +#define SUP_UART_DATA                        0x00
> > > > +#define SUP_UART_LSR                 0x04
> > > > +#define SUP_UART_MSR                 0x08
> > > > +#define SUP_UART_LCR                 0x0C
> > > > +#define SUP_UART_MCR                 0x10
> > > > +#define SUP_UART_DIV_L                       0x14
> > > > +#define SUP_UART_DIV_H                       0x18
> > > > +#define SUP_UART_ISC                 0x1C
> > > > +#define SUP_UART_TX_RESIDUE          0x20
> > > > +#define SUP_UART_RX_RESIDUE          0x24
> > > > +
> > > > +/* Line Status Register bits */
> > > > +#define SUP_UART_LSR_TXE             BIT(6) /* tx empty */
> > > > +#define SUP_UART_LSR_BC                      BIT(5) /* break condi=
tion status */
> > > > +#define SUP_UART_LSR_FE                      BIT(4) /* frame error=
 status */
> > > > +#define SUP_UART_LSR_OE                      BIT(3) /* overrun err=
or status */
> > > > +#define SUP_UART_LSR_PE                      BIT(2) /* parity erro=
r status */
> > > > +#define SUP_UART_LSR_RX                      BIT(1) /* 1: receive =
fifo not empty */
> > > > +#define SUP_UART_LSR_TX                      BIT(0) /* 1: transmit=
 fifo is not full */
> > > > +#define SUP_UART_LSR_TX_NOT_FULL     1
> > > > +#define SUP_UART_LSR_BRK_ERROR_BITS  GENMASK(5, 2)
> > > > +
> > > > +/* Line Control Register bits */
> > > > +#define SUP_UART_LCR_BC                      BIT(5) /* break condi=
tion select */
> > > > +#define SUP_UART_LCR_PR                      BIT(4) /* parity bit =
polarity select */
> > > > +#define SUP_UART_LCR_PE                      BIT(3) /* parity bit =
enable */
> > > > +#define SUP_UART_LCR_ST                      BIT(2) /* stop bits s=
elect */
> > > > +#define SUP_UART_LCR_WL5             0x00 /*  word length 5 */
> > > > +#define SUP_UART_LCR_WL6             0x01 /*  word length 6 */
> > > > +#define SUP_UART_LCR_WL7             0x02 /*  word length 7 */
> > > > +#define SUP_UART_LCR_WL8             0x03 /*  word length 8 (defau=
lt) */
> > > > +
> > > > +/* Modem Control Register bits */
> > > > +#define SUP_UART_MCR_LB                      BIT(4) /* Loopback mo=
de */
> > > > +#define SUP_UART_MCR_RI                      BIT(3) /* ring indica=
tor */
> > > > +#define SUP_UART_MCR_DCD             BIT(2) /* data carrier detect=
 */
> > > > +#define SUP_UART_MCR_RTS             BIT(1) /* request to send */
> > > > +#define SUP_UART_MCR_DTS             BIT(0) /* data terminal ready=
 */
> > > > +
> > > > +/* Interrupt Status/Control Register bits */
> > > > +#define SUP_UART_ISC_RXM             BIT(5) /* RX interrupt enable=
 */
> > > > +#define SUP_UART_ISC_TXM             BIT(4) /* TX interrupt enable=
 */
> > > > +#define SUP_UART_ISC_RX                      BIT(1) /* RX interrup=
t status */
> > > > +#define SUP_UART_ISC_TX                      BIT(0) /* TX interrup=
t status */
> > > > +
> > > > +#define SUP_DUMMY_READ                       BIT(16) /* drop bytes=
 received on a !CREAD port */
> > > > +#define SUP_UART_NR                  5
> > >
> > > Aren't most of these defines already in the kernel header files?  Why
> > > create them again?
> > >
> >
> > If for reduce code.
> > I can add #include<linux/serial_reg.h>
> > And remove some overlap define name.
> >
> > #define SUP_UART_LCR_PR -> UART_LCR_EPAR
> > #define SUP_UART_LCR_PE -> UART_LCR_PARITY
> > #define SUP_UART_LCR_ST -> UART_LCR_STOP
> > #define SUP_UART_LCR_WL5 -> UART_LCR_WLEN5
> > #define SUP_UART_LCR_WL6 -> UART_LCR_WLEN6
> > #define SUP_UART_LCR_WL7 -> UART_LCR_WLEN7
> > #define SUP_UART_LCR_WL8 -> UART_LCR_WLEN8
> >
> > #define SUP_UART_MCR_LB -> UART_MCR_LOOP
> > #define SUP_UART_MCR_RI -> UART_MCR_OUT2 ?
> > #define SUP_UART_MCR_DCD -> UART_MCR_OUT1 ?
> > #define SUP_UART_MCR_RTS -> UART_MCR_RTS
> > #define SUP_UART_MCR_DTS -> UART_MCR_DTR
> >
> > But the rest define didn't match internal #include<linux/serial_reg.h>
> > , those define still need to keep.
> > Some use SUP_xxxx specific define.
> > Some use internal #include<linux/serial_reg.h>, it is strange.
>
> Do not duplicate defines that we already have for the same hardware
> type.
>
> And again, why is this not a normal serial driver for the existing UART
> types as this hardware is obviously an 8250 variant?
>
> thanks,
>
> greg k-h
