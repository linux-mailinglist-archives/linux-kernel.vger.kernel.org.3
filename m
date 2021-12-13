Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1F473455
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhLMStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhLMStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:49:15 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9892AC061574;
        Mon, 13 Dec 2021 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7KgDkATiU0RV/IfVLTSzsn/JOr6EcoRuymb7temF2c0=; b=duV+0Th6IUefxS61uwrRBfdARi
        vrDvGDfakFTlYNpd+A8TQsCt67+SvHZfnbW3XGO87RMAL0QOWxXc+lTBdYF3YZdqtG6aFUJxNrGLJ
        lEq+1JZ2cNMMAn9O+W9quGhpVgOPN4006Vws/aIVxB1YOGNxgVh92lQQG3y9HaaACPq8=;
Received: from p200300ccff0a64001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:6400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mwqNn-0003kg-TG; Mon, 13 Dec 2021 19:49:08 +0100
Date:   Mon, 13 Dec 2021 19:49:06 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alistair Francis <alistair23@gmail.com>,
        Alistair Francis <alistair@alistair23.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mylene Josserand <mylene.josserand@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <20211213194906.00fd028c@aktux>
In-Reply-To: <YbbeDFJERtP0mAIQ@google.com>
References: <20211103114830.62711-1-alistair@alistair23.me>
        <20211103114830.62711-2-alistair@alistair23.me>
        <YYYk/uisKqPNgRu0@google.com>
        <CAKmqyKOFZOLpjMY+kj2CLibFhYJ3-tL+9+cKEVzgSn9Mzq30gw@mail.gmail.com>
        <YbbeDFJERtP0mAIQ@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Dec 2021 21:45:48 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:


> > > > +     rc = devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
> > > > +                                    IRQF_TRIGGER_FALLING | IRQF_ONESHOT,  
> > >
> > > Please do not override platform setup with hardcoded triggers. Also, it
> > > is strongly recommended to use level interrupts for these peripherals.
> > >
> > > This is also likely unsafe if controller is not completely shut off and
> > > is capable of generating interrupts given input device is not yet
> > > allocated.  
> > 
> > I have dropped the `IRQF_TRIGGER_FALLING |`
> > 
> > I have tried to use level interrupts, but I can't get the device
> > working with them.  
> 
> That is weird, does the interrupt controller support level interrupts?
> 
hmm, it should, at least on the imx6 I am using them for some other
devices, I guess, on the imx7 they should work, too.
I hope I find time to give that a try the next days.

Regards,
Andreas
