Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085344D4368
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiCJJYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiCJJYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:24:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1C41F9C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAAF561CE0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5D1C340F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646904225;
        bh=ghWIRBpDe2KEAVCmoHp7Q73RTvUTaZ4QY3GIe47sHG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r5h1dEGELer/PyJT2bmbIKs7FfKKt+fy6CgNWJMCCCUj79x7EJ3KDSAtpVQHEJlRJ
         fTF4WSTHSHU1pOHqnEObNcxR321dTuydV2aqSDVnNKfp6IHzBxBsFeEOkq1X0c902F
         PBYvhaBFv4QDsY4oe2IAXf17J+U/DBFq/3vd2rhtbIpCuS01u4+WvOtTH1IrvX2A45
         hxJTLjbxekhBErPYXXXXeGoOBsgkSk8+ALg0WBoj6qhZ0h92SwRQcZ+KLQW9c2rwkj
         l8URJKlFzGeHr5QRlfrR8AHtkI88QM81MCNYajvj09LPpDwAmVrWzFC0fRFsF8a+WK
         w69srkpzvjFNg==
Received: by mail-wm1-f49.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so2968249wmp.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:23:45 -0800 (PST)
X-Gm-Message-State: AOAM532N3vpgv7IcfQyfr7dH7Qg2BWXyilU+tp3zEc9h5x4PxM0jpH6X
        GWI4lvqrtuPFn0nZW2EwN6MvTFQVHQHQbW0lZ6E=
X-Google-Smtp-Source: ABdhPJy9fLy7k9/BDB1ORE6SEXrnrnjsiqkOQ++S0LDxTpeeZglK8bHJkNch3V5qLVb9KO3Iv15wwX5nmXcoq0mPksc=
X-Received: by 2002:a7b:c746:0:b0:385:506e:7c8b with SMTP id
 w6-20020a7bc746000000b00385506e7c8bmr2664089wmk.71.1646904223578; Thu, 10 Mar
 2022 01:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org> <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com> <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
 <CACRpkdbxico4SDottfB9Z8PHsXKG4fNA6G0XNyuaY+LObOovuw@mail.gmail.com>
In-Reply-To: <CACRpkdbxico4SDottfB9Z8PHsXKG4fNA6G0XNyuaY+LObOovuw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 10 Mar 2022 10:23:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a02a-+k=ChdT_Lg=xvHYZ4WTb-Efu7aQq-yBP1Gn37TgA@mail.gmail.com>
Message-ID: <CAK8P3a02a-+k=ChdT_Lg=xvHYZ4WTb-Efu7aQq-yBP1Gn37TgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 2:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Mar 9, 2022 at 5:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > Robin
> > > In that case, it would probably make sense to garbage-collect all the
> > > configs, setup code and other stuff relating to older MMU-less CPU cores
> > > like ARM1156, ARM940, etc. at the same time.
> >
> > Right, good idea. These are only selected by CONFIG_ARCH_INTEGRATOR,
> > but that in turn doesn't build for CONFIG_MMU=n because it depends on
> > ARCH_MULTIPLATFORM. I'll send a patch for these.
>
> Just delete these, I do have these CPU tiles around but they are so obscure
> and I never got around to even testing to boot them.

Right, of course you couldn't boot test them because it has been
impossible to even select them in Kconfig for years. I've added
a patch to completely remove the five v4/v5 NOMMU cores now,
will send that later.

There are five more cores that are only referenced by mach-integrator
that are supposed to work (922T, 1020, 1020E, 1022, 1026). Have you
ever tested those, or should we consider removing them as well?

At some point, there was a proposal to add an arm10 based SoC
to mainline, but that never happened and I'm fairly sure it won't
come back now.

        Arnd
