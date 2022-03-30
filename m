Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6020E4EC37E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346907AbiC3MFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbiC3Ly6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:54:58 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793626241B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:51:39 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id m21so2125426qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bec0iphyAFTcaBtQxwlj+Sc/83TcuopoiWiMOgp6Yzk=;
        b=7XUMAnbZckAAX2BxySD0R95ZbxUg5nhV3LmLDKZBEnblno/0rcQWceqdr+IjMBxyec
         OIuZo0Szzv3N2OSnip2EJjZ3rqKDYlw7prQ9/+i0RHDAHEcB+sbs1PSs2YFA654qWYun
         D9daSw5gc3j7XWlLzgawGrZkgCPZC9AXxWLqfds3prB3GxkO4OhbjqRJE+EATO6sZqOZ
         pgo/g2GplFetjq7CzJYpMKhNmT1ZQg2cHIWTUE7p6ctS46GcJhS6Ug/VCMta7njcuJT6
         qbkrh/M3eXmMK9pmCBhmjmbfWa3TllVzCVjSTbQWfRkN3647/CsIzL2sd1CmkAL/WvL7
         JfQQ==
X-Gm-Message-State: AOAM532UOZe/SfQZyuw7w1DKSj09/we4mUAyoaL+LMcjs7C1OjnIS48R
        ae/8JR9v4+gSEMVRS7Ssw2adc0B4vgNGvA==
X-Google-Smtp-Source: ABdhPJzGUQUxHSt+J0gElbK5YLUeDiZnTMGorUR1mgys/F7EypE/akYCeec92So3HFRQdwfwkWGonw==
X-Received: by 2002:ac8:5e4c:0:b0:2e2:2bbf:57fa with SMTP id i12-20020ac85e4c000000b002e22bbf57famr31512345qtx.278.1648641086254;
        Wed, 30 Mar 2022 04:51:26 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm17681912qta.76.2022.03.30.04.51.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 04:51:25 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id v35so36334404ybi.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:51:25 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr16955433ybq.342.1648641085421; Wed, 30
 Mar 2022 04:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <f7ea35c723da72a89028da5b976ad417fbd7bf52.1648545587.git.geert@linux-m68k.org>
 <YkLgapMN2JqM+Lte@kroah.com> <YkM9CPbeARpWHMPw@heinlein> <342ae21e4bba6b0eccb39113fafa411aa8e93f96.camel@intel.com>
In-Reply-To: <342ae21e4bba6b0eccb39113fafa411aa8e93f96.camel@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 13:51:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2AixR0kKxT5j3uSGDs5ntf4NuzRN7PjF=-vpo1bUi_Q@mail.gmail.com>
Message-ID: <CAMuHMdU2AixR0kKxT5j3uSGDs5ntf4NuzRN7PjF=-vpo1bUi_Q@mail.gmail.com>
Subject: Re: [PATCH] peci: PECI should depend on ARCH_ASPEED
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "jason.m.bills@linux.intel.com" <jason.m.bills@linux.intel.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "joel@jms.id.au" <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iwona,

On Wed, Mar 30, 2022 at 12:37 PM Winiarska, Iwona
<iwona.winiarska@intel.com> wrote:
> On Tue, 2022-03-29 at 12:08 -0500, Patrick Williams wrote:
> > On Tue, Mar 29, 2022 at 12:33:14PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 29, 2022 at 11:21:37AM +0200, Geert Uytterhoeven wrote:
> > > > The Platform Environment Control Interface (PECI) is only available on
> > > > Baseboard Management Controllers (BMC) for Intel processors.  Currently
> > > > the only supported BMCs are ASpeed BMC SoCs.  Hence add a dependency on
> > > > ARCH_ASPEED, to prevent asking the user about the PECI subsystem when
> > > > configuring a kernel without ASpeed SoC support.
> > > >
> > > > Fixes: 6523d3b2ffa238ac ("peci: Add core infrastructure")
> > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > ---
> > > >  drivers/peci/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
> > > > index 89872ad833201510..0d3ef8ba0998d649 100644
> > > > --- a/drivers/peci/Kconfig
> > > > +++ b/drivers/peci/Kconfig
> > > > @@ -2,6 +2,7 @@
> > > >
> > > >  menuconfig PECI
> > > >         tristate "PECI support"
> > > > +       depends on ARCH_ASPEED || COMPILE_TEST
> > >
> > > I hate ARCH_ dependencies as there is nothing specific with that one
> > > platform that means that this driver subsystem will only work on that
> > > one.
> >
> > The motivation in the commit message isn't even accurate because the chips
> > under ARCH_NPCM are usually used as a BMC as well and PECI is just as important
> > for them.  HPE also has a custom chip they use as BMC and they've started the
> > process for upstreaming that support.
>
> "Currently the only supported BMCs are ASpeed BMC SoCs."
> From PECI subsystem perspective (not BMC support in general), it is technically
> true for now - but I agree with Greg and Patrick, this is just artificially
> introducing build-time dependencies where in fact there are none. And yes - we
> would then have to add the "depends on ARCH_YET_ANOTHER_ARCH" to generic
> subsystem anytime we add a new PECI controller. This belongs in the controller
> (and the ASPEED one depends on ARCH_ASPEED).

OK, let's keep it as-is.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
