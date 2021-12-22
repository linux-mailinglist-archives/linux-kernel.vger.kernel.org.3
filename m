Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9C47D81D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345372AbhLVUE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbhLVUE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:04:26 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4AC061574;
        Wed, 22 Dec 2021 12:04:25 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id g15so3301630qvi.6;
        Wed, 22 Dec 2021 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6xplw3WqkRRdusCfDSWb1qyYJCc78WMxiskJHsnruc4=;
        b=JAXOnJLq3Y5WisspFa/qByt3JtsK3cQc7PiJTavr3LBJ65wCgzfGEyBbLQ6xgP83FV
         3uYesZn50eDzZnKIfMSpGLGB5x9Xbar6KeVaASdPI1hfv+/MYJ1QeYYhdhx6Ncx99rB+
         25GppgGSmGMAdu6wA5G8Iu6874gJdTwuXyDNF1kArKZfVMFUl5r2M/Ae2z+sBzt3t7sS
         3VMas6zT/UVKyn+xx9emARTzPGBTeyfP49LxU8EPIM4/sPjwPgKkU+sKXWmXByWE6Lpb
         g7Boz0BncK5VsXjxyIiT7YZOgZkLo8NuWHebzqysjjucTOiS/75xcpgHbIMRBMoZm/L9
         G+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xplw3WqkRRdusCfDSWb1qyYJCc78WMxiskJHsnruc4=;
        b=3W9lnt1YueuEsgi5zAdeY9baFwt4uzgurHS/391aq/tQ0f9OIicv6WpZXzXIcqwVDP
         HwUounm+hCrYfX2Y7MMNNvzJTuYkDTWAV/05osXFS7G7dWDql54H+j5mhKZeuhKCZeUI
         rBT0xesbuNxNPkd88NbEchDeFtParQrz4gdSEofXnNcpR7d+VTya1Xcf4b3+KDYMJl/I
         VhRkY1WS6sPZ+k+W3TabYqNmf+8MxhDhlX07nakDIse7oF3cpvgVxOP81CzJ+c/AS6g6
         DB8P2dl9lamPIxIU1TPOSPfakq5mxMnN1/s7RIbYS3SxSn8IeGuUxWQIt6dzSulCMHo2
         +lpQ==
X-Gm-Message-State: AOAM531Ra8yoQ+jqJ+T2tfjJo1QR47+lXs5XllbAs4XT8tPvicZRI4s3
        Cyj+RlI2+iCW8MJ3eTTm55jPmRnlt0nxxQ==
X-Google-Smtp-Source: ABdhPJwiYLO1aeEbElSk1DP3WB9hNuTq8I/gvCCe5eDbodXRVCDj/kCpeKvhkezW7Ip34oljkQ38pg==
X-Received: by 2002:ad4:5e8f:: with SMTP id jl15mr3923078qvb.84.1640203464931;
        Wed, 22 Dec 2021 12:04:24 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id de13sm2706609qkb.81.2021.12.22.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:04:24 -0800 (PST)
Date:   Wed, 22 Dec 2021 15:04:21 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v11 04/15] iio: afe: rescale: expose scale processing
 function
Message-ID: <YcOExYiT2zIBm8ie@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-5-liambeguin@gmail.com>
 <CAHp75Vc009o5EunYP3QAB8up8hMrRL7oNax7cjphCFVUgSKXRw@mail.gmail.com>
 <YcNscJ/fQhI7h6Uq@shaak>
 <CAHp75Vf6iN7yEdubKFkf+fXupVTco-toZN=a5+KNXG4Yv6oT3Q@mail.gmail.com>
 <YcN/kkazUGyyazNF@shaak>
 <CAHp75VfGJwfCiwt1mfnqnBWd0MPMmVk-oheh1===ero2ErbXJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfGJwfCiwt1mfnqnBWd0MPMmVk-oheh1===ero2ErbXJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:50:28PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 9:42 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > On Wed, Dec 22, 2021 at 08:52:30PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 22, 2021 at 8:20 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > > > On Wed, Dec 22, 2021 at 12:21:01PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Dec 22, 2021 at 5:46 AM Liam Beguin <liambeguin@gmail.com> wrote:
> 
> ...
> 
> > > > > Missed types.h and forward declarations like
> 
> ^^^^ (1)
> 
> > > > > struct device;
> > > >
> > > > Okay. will add linux/types.h
> 
> ^^^^ (2)
> 
> > > What about forward declaration?
> >
> > I'm not sure I understand what you mean here.
> 
> In (1) I have mentioned header and forward declaration. You agreed in
> (2) to add a header. What about forward declaration?

Oh, understood, sorry I misread your message.

I'll add `struct device;` above `struct rescale;`.

Cheers,
Liam

> -- 
> With Best Regards,
> Andy Shevchenko
