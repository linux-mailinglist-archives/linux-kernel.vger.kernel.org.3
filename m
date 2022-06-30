Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39593562551
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiF3VeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiF3VeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:34:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87904475B;
        Thu, 30 Jun 2022 14:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61404CE302F;
        Thu, 30 Jun 2022 21:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACABC341CF;
        Thu, 30 Jun 2022 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656624853;
        bh=D2s+ZcxWc13QZ3Howbe3kBarPMoDIzINRNcSNPpkJnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=luvEGDjZt8Ljt1cdrdLPSRkHfxx4EcJ0DCb5X96dXECsc+SPP8VdOnUMUlkRzhtOm
         oEB4VgSo7oj+LwMlSwPaHW0gZLDlxcSsSpEQEpIt4WAAGwJZUiW+GTRcTIZJ1bVUTG
         6A2HDoexXAbjcFYoPCRW74rXbsosaoAUIJPTfUB2LFdrSyuJIL02/sLnFnWg1p3eTU
         pfVApwETFAEGOGudLj/8JHXIlP0JKxcpU1mUU/z6K5E++cOIPlxBkw7i9++4TPMO47
         WrYs5lN7Z19C2sAHcK3hk2QyKipmqahLoqjTKEvtP7zvm4vgEpeJ9cav8xZyJlY9z3
         ehtRYriJ2+cTA==
Received: by mail-vs1-f44.google.com with SMTP id o190so524314vsc.5;
        Thu, 30 Jun 2022 14:34:13 -0700 (PDT)
X-Gm-Message-State: AJIora8t2ZjczctwmXCTremqbgTxtzyXb8AMvfGbLCsIw9STOslDqEii
        qzk8BTBYu2sXhLPHCBISxvUrxHN6YUQOTdFF0A==
X-Google-Smtp-Source: AGRyM1vErMln+ylh4+9+m8Kp0tMQS4jT0ujsjpMLCpwWWuQCoV797B9eVWfZ18zgb3ZtvLJ0PbNFxgv7qH/qgP4i+ts=
X-Received: by 2002:a67:1787:0:b0:354:6490:437f with SMTP id
 129-20020a671787000000b003546490437fmr10423267vsx.26.1656624852529; Thu, 30
 Jun 2022 14:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
 <20220630162716.GA2842206-robh@kernel.org> <CAHp75VdARCTnpEMyVRAWv7jVSj_+m8_xYiNTwmX6LCzpZT8Tuw@mail.gmail.com>
In-Reply-To: <CAHp75VdARCTnpEMyVRAWv7jVSj_+m8_xYiNTwmX6LCzpZT8Tuw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 30 Jun 2022 15:34:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJH0tngWDCdLdxbbKx2VYG4u26fFJKgq2JC9a+jif50aA@mail.gmail.com>
Message-ID: <CAL_JsqJH0tngWDCdLdxbbKx2VYG4u26fFJKgq2JC9a+jif50aA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] of: unittest: Switch to use fwnode instead of of_node
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 1:03 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 6:29 PM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Jun 29, 2022 at 02:50:09PM +0300, Andy Shevchenko wrote:
> > > GPIO library now accepts fwnode as a firmware node, so
> > > switch the module to use it.
>
> ...
>
> > > -     devptr->chip.of_node = pdev->dev.of_node;
> > > +     devptr->chip.fwnode = dev_fwnode(&pdev->dev);
> >
> > Perhaps I want the DT test code to test using the of_node pointer. We do
> > want that to work, right?
>
> Nope. We want to get rid of of_node in GPIO.

I would think there's old PPC users preventing that, but if not, good job.

> > I'm really not a fan of fwnode'ifying things that are DT only. It's
> > really pointless churn.
>
> Other way around, keeping an of_node for just 3 drivers (and counting
> down) + one test case is pointless churn.
>
> But I got that commit message that is unclear about the intentions
> behind. I will update that if you agree on the rest.

If it is going away, then what choice do I have. :)

Rob
