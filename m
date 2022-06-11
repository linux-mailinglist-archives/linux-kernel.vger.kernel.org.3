Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651BE547644
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiFKPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiFKPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156DE48;
        Sat, 11 Jun 2022 08:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3EDD60FDD;
        Sat, 11 Jun 2022 15:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42226C3411C;
        Sat, 11 Jun 2022 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654962870;
        bh=EL9IwdgyDy64ek56Qd2NVbsxL0qUb5pIGgLzQaLc9Kg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ou0jiymYgg+fZZCEjI0RELxurgnnciNTdmsgGI9Nbm3jMAjTPMqmvXYjImW0akMaZ
         oG98JR/PuLApH1pZVkPuLB8MVoKU3MtBMn8EsrLDCggfIugtwLgpn7UBPaNmUyNy5p
         ru47W/L8FX5SXfuUdU0GrjQz5IUeBQz34pIRa5FXKtnQyXDxlLOXPrrmRDrqLIRY2n
         m7rnzMMwibIwi6BkxPaAjgAAEQCVaFOIheuvJL7RmRpriMV15USCc0CqiowABajQsC
         oYLdPYuRslM+N3dr0FdqIYTcbvzYITfajRaq8E+E3o0XcwFBlMa583W3Jy9vgKjFxm
         EKA89FPZFhquA==
Date:   Sat, 11 Jun 2022 17:03:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jongpil Jung <jongpil19.jung@samsung.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio:proximity:sx9360: Fix hardware gain read/write
Message-ID: <20220611170340.1538ce98@jic23-huawei>
In-Reply-To: <CAHp75Vd6y7RJcwi_Egyb5guJ3i+FJHD-_pdeOmq4LC7xBmhnPg@mail.gmail.com>
References: <20220610053012.27279-1-xiaohuizhang@ruc.edu.cn>
        <CAHp75Vd6y7RJcwi_Egyb5guJ3i+FJHD-_pdeOmq4LC7xBmhnPg@mail.gmail.com>
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

On Fri, 10 Jun 2022 16:37:05 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 10, 2022 at 7:53 AM Xiaohui Zhang <xiaohuizhang@ruc.edu.cn> wrote:
> >
> > Similar to the handling of read/write in commit 108e4d4de2b5
> > ("iio:proximity:sx9324: Fix hardware gain read/write"), we thought
> > a patch might be needed here as well.
> >
> > There are four possible gain values according to 'sx9360_gain_vals[]':
> >
> >         1, 2, 4, and 8
> >
> > The values are off by one when writing and reading the register. The
> > bits should be set according to this equation:
> >
> >         ilog2(<gain>) + 1
> >
> > so that a gain of 8 is 0x4 in the register field and a gain of 4 is 0x3
> > in the register field, etc. Note that a gain of 0 is reserved per the
> > datasheet. The default gain (SX9360_REG_PROX_CTRL0_GAIN_1) is also
> > wrong. It should be 0x1 << 3, i.e. 0x8, not 0x80 which is setting the
> > reserved bit 7.
> >
> > Fix this all up to properly handle the hardware gain and return errors
> > for invalid settings.  
> 
> ...
> 
> > +       regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
> > +       if (regval)
> > +               regval--;
> > +       else if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
> > +                regval > SX9360_REG_PROX_CTRL0_GAIN_8)  
> 
> else?! Isn't it a dead code? How has it been tested?

Gah. Missed this in review of sx9324 change.  First check is
fine because GAIN_RSVD is 0 though not a lot of point in the if.

Second one is intended as hardening against malicious / broken
hardware only so you would never see that value except via emulation
or a unit test.  So test wouldn't have spotted this as far as I
can see.
Needs good old eyeballs. :)


> 
> > +               return -EINVAL;  
> 
> > +       *val = 1 << regval;  
> 
> Even in the original code this is wrong in accordance with C standard.
> It might have potentially UB. BIT(), for example, solves this issue.
> You may do what it does under the hood.
> 
