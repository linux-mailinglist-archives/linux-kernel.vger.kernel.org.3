Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03D85A0D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiHYJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiHYJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:57:28 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A285C12D33;
        Thu, 25 Aug 2022 02:57:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g14so5224400qto.11;
        Thu, 25 Aug 2022 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ms4JRfp4bbqLAxumr6FHHMASRC9sUuDO9ip+t7Y80b4=;
        b=mQWGNEnRt44gWKCKTu/e1dqeZ2eg33XAX635iw8mSscZzw1ZOOPAfCuH0WQ29khJ3X
         07hEdzqMcrkPN1PFLuTDvUPGplDryxZvRmaeYHXUGORC75sAvi5InL5D5VfC6AFKlgGC
         Pjp3H6+0OGNI6mdAJHB10IwPJk+GurFUzjHbbFVRCpDA3hRtcHsZg6pBcPEik6zSKTZB
         Jk4yPJQl+NK2hb1+rLdH2AJ0Ww8p33HeHf+8MJF2I6tVCoMrYle70VPWEFmWBMGw2+0/
         BqMwLy9vs+wBXXRbNB07Wp3YkYuK9AC6dKUyfWSvtSgrTI5DYP/tsrcNX08yiKrbCQKP
         rAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ms4JRfp4bbqLAxumr6FHHMASRC9sUuDO9ip+t7Y80b4=;
        b=ty1MrL9qs87w3H7LPep4HNkKf9wTNMgita0CHemLHRoRK/kBeJ0M7ZdiBUgaThejUW
         Xarwiz3StdwnZ7B25o+K7/hLuJBOu+xBNFUzIMta1E/h0duaK5DafPc+F3hkmQsWiwEh
         oY21tjoVMzzXDHs7LtHbEJkNcrQnPzOD1GJHoeAZtQ13XSSsItNPYXipWoT2peTLEBqB
         KDPh76IbpUiivYy/MssQFLxhw2HOvHqP/GFOCiEHBpzFaukXgG/2zEANcpr3ac0dF65E
         7LY5lJSr2N+icHtexQOcU2tG/Kq6g832I2P3c6PNPlXMjqCzqUti53Z9mD1Ua0Heueh1
         mQCw==
X-Gm-Message-State: ACgBeo3kfIS2g4hIWcB5AhvFMlsqsPyiXgfXH90azL9Th+e/CXfzKOL8
        O6Vfcjcis8vSO+CzXsi1G0MTGHgJ+I3etYLEQswibIO/n6s=
X-Google-Smtp-Source: AA6agR51alYCj4efz+VyYGYy5PubYizLbdoNZA1k6++6vnrSNEIwwqAjq+B1jpZk3eJgyVLnXN0vhaVi/Nr9uQ0nu2w=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr2698470qte.195.1661421444713; Thu, 25
 Aug 2022 02:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220824140347.1842-1-henning.schild@siemens.com>
 <20220824140347.1842-2-henning.schild@siemens.com> <CAHp75Vf6agD-G1Ey1UgUvWnub4Q8-ysx3OMV14dR3ed5FRX=Vw@mail.gmail.com>
 <20220825113203.4e14f4d5@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220825113203.4e14f4d5@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 12:56:48 +0300
Message-ID: <CAHp75Vd3VOx=+hzCgo6Wpz8Uwu9trxRiF_N=QYDBfidFvECyAw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:32 PM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Wed, 24 Aug 2022 18:59:17 +0300
> schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> > On Wed, Aug 24, 2022 at 5:04 PM Henning Schild
> > <henning.schild@siemens.com> wrote:

...

> > > +#define gpio_dir_invert(type)  ((type) == nct6116d)
> > > +#define gpio_data_single(type) ((type) == nct6116d)
> >
> > What you are trying to do here is to put GPIO maintainers / heavy
> > contributors on a minefield (basically moving your job to their
> > shoulders). Please, provide a proper namespace and not gpio_ one. I'm
> > talking in my "GPIO heavy contributor" hat on.
>
> No i was trying to avoid having to touch those other 4 existing macros,
> touching lines that checkpatch.pl and you will pick on again. Adding
> the prefixes just to those new ones would be inconsistent and also not
> nice.

Do you have other prefixes in those files starting with gpio_?!
Now I see it. I'm not sure why this pops up only now.

> > With that fixed I can survive w/o pr_fmt() being in this patch. If you
> > are going to address this, you may add my tag in a new version.
>
> It is a bit unfortunate that you seem to be surprised where i said i
> was going to not address this.

Yes, because you are not a newbie and you know that the community
doesn't work on a "take it or leave" basis.

>  And once the new series comes insist on
> another round ... which involves testing and what not.

Which is your job as a developer.

> But hey, i will send a v6 with style refactoring patches and test it
> all over again.

Thanks!

> Thanks everyone for the review, i hope that next version will be
> acceptable and not open new discussion with the new patches coming.

-- 
With Best Regards,
Andy Shevchenko
