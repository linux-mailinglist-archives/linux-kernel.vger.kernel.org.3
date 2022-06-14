Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5892454AF61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiFNLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbiFNLi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:38:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF1841610;
        Tue, 14 Jun 2022 04:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3805A611E8;
        Tue, 14 Jun 2022 11:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE281C3411E;
        Tue, 14 Jun 2022 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655206705;
        bh=dt/7IRihakfa0z3FSC6b8H9fkTidVQtEjvRx/bxxSvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NBdiwjjoUG/a0z6QSAhuQ5VH2blwUuiBYDJ+/PBalF5wXzvY5CFYKt2DY0A/GesNa
         KKz0FfRDorBtNoLNLvyeFQ1i9JmUU3rh5NismpJLJ7peSIbQeZ3/cFxOyP43DGB2Iu
         qnavlnXX/y7ZrsWM4qgSWJgEplb1xn78yWHqVltC69a1CWNhREf5wVU5imBVLHAzId
         rFABMWlHhPVKndbMjHHdN1+rGLMwp8V9ZHSJnA8wPLtiHj+m6H8bJYIMarciFZODk1
         adhF5SBM7gX4QVBR/D3VYdKueJrSItwtMSIVEj+S/tkccVBYMZMlNIt/SlFdprZs7+
         h62aeEQm8RWVQ==
Date:   Tue, 14 Jun 2022 12:47:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220614124735.1d712a4a@jic23-huawei>
In-Reply-To: <37ac71be-78d6-a266-045b-18164d715e57@gmail.com>
References: <20220608091238.403897-1-cosmin.tanislav@analog.com>
        <20220608091238.403897-3-cosmin.tanislav@analog.com>
        <CAHp75Vdvng-fxt-p2bHJiF8i967eh1o_MUgDFN_odhW0sLu69A@mail.gmail.com>
        <37ac71be-78d6-a266-045b-18164d715e57@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 23:11:51 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 6/8/22 18:59, Andy Shevchenko wrote:
> > On Wed, Jun 8, 2022 at 12:19 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:  
> >>
> >> AD4130-8 is an ultra-low power, high precision, measurement solution for
> >> low bandwidth battery operated applications.
> >>
> >> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> >> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> >> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> >> selectable filter options, smart sequencer, sensor biasing and excitation
> >> options, diagnostics, and a FIFO buffer.  
> > 
> > I believe we may gain a few LoCs by slightly bending the rule of 80.
> > Also see below.
> >   
> 
> I'll only go over the 80 columns limit if Jonathan agrees to it.


Where it helps readability I fine with us going past 80.
I'm not convinced by every case Andy highlights, but many do
make things easier to read.


> 
> >> +       *size = ad4130_reg_size[reg];
> >> +       if (!*size)
> >> +               return -EINVAL;  
> > 
> > Is this check necessary?
> >   
> 
> Yes. I haven't described all registers in the table, and the registers
> can be accessed by the user via the debugfs_reg_access() method.

For that one, probably worth a comment as not immediately obvious.

> 

...

> 
> >> +       switch (ref_sel) {
> >> +       case AD4130_REF_REFIN1:
> >> +               ret = regulator_get_voltage(st->regulators[2].consumer);
> >> +               break;
> >> +       case AD4130_REF_REFIN2:
> >> +               ret = regulator_get_voltage(st->regulators[3].consumer);
> >> +               break;
> >> +       case AD4130_REF_AVDD_AVSS:
> >> +               ret = regulator_get_voltage(st->regulators[0].consumer);
> >> +               break;
> >> +       case AD4130_REF_REFOUT_AVSS:
> >> +               ret = st->int_ref_uv;
> >> +               break;
> >> +       default:
> >> +               ret = -EINVAL;
> >> +               break;
> >> +       }  
> >   
> >> +       if (ret < 0)
> >> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> >> +                                    ref_sel);  
> > 
> > Can it be moved to the caller where it would cleaner to use, I think?
> > As a good side effect the all above will be shortened to just return directly.
> >   
> 
> I'm pretty sure I remember Jonathan suggested moving it inside the
> function.

It's possible, though I don't know what my reasoning would have been...

