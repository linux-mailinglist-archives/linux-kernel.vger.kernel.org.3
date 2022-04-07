Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904CA4F7C62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiDGKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiDGKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F372E19;
        Thu,  7 Apr 2022 03:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B0561CCE;
        Thu,  7 Apr 2022 10:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E3C385AB;
        Thu,  7 Apr 2022 10:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649326126;
        bh=QtPSjuN1gj7rdOkimjbPZkc/Aldl/EZom3gZ7Sd17MM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pShqcGFc+XX+casrLsS9Pc5fcSX4XMOIkk4P4pLkhyM8jTRxeJZfiasrMXWAwImnf
         Bqbz/asxHXItGos7jFADu2czBEM8tUYmL2cAcNpMk/jXqy397YC1B5qkX92K0++lyN
         rLra2pZokwakZsU50KbRvVxSjpG0wQFnRX5n/Oa1K73HbQyUz99P46rhVzIuR5wmyI
         JHehnb3eiVO/3VclE+WBwm1wjn6xErleg6+xYLJOMLDAgTiYwn7RBF+9vt7NmqIdo8
         wXgIb91p3YzOoRYaZfMTbsYlE2sNeDbGHKT/CvM/dIvDgtj0cDO5vtzGLryQJb9WyW
         7L6PR4O++JYuQ==
Received: by mail-wr1-f54.google.com with SMTP id b19so7058516wrh.11;
        Thu, 07 Apr 2022 03:08:46 -0700 (PDT)
X-Gm-Message-State: AOAM530SVnbW3tLLMt/uarSlB0kzoQ/PYzrY+dS4KmBALUhgFBJpW7IJ
        YBAO2ldxSSLoMrKnxdc62DCItM5wXznY90B0nzs=
X-Google-Smtp-Source: ABdhPJzSiM0ws1XTQm0G+eX4lsdVE4jGZb8+YbyMPsKOEjJCLJ6qychiaP8KpFPTHWHrqGypGZ4tXi8XkZuFYEjHU4I=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr9491841wru.317.1649326124617; Thu, 07
 Apr 2022 03:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220405091750.3076973-1-arnd@kernel.org> <39e8b64cefd8e2b4e4d91a5e6cfc98db88be7449.camel@gmail.com>
In-Reply-To: <39e8b64cefd8e2b4e4d91a5e6cfc98db88be7449.camel@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Apr 2022 12:08:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a22dR276SRVh5WRZWDEGQaf9KUUz61tQaCySHZrrgnh9g@mail.gmail.com>
Message-ID: <CAK8P3a22dR276SRVh5WRZWDEGQaf9KUUz61tQaCySHZrrgnh9g@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: ARMv5 multiplatform conversions
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 11:23 AM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> Hello Arnd,
>
> On Tue, 2022-04-05 at 11:17 +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > I revisited some patches from a few years back, to see what
> > is needed forsome of the remaining platforms to become part of
> > CONFIG_ARCH_MULTIPLATFORM.
> >
> > A few things happened since I last looked at this, which helps to make
> > this easier:
> >
> >  - The ixp4xx platform saw a large scale cleanup
> >
> >  - The ep93xx platform lost support for MaverickCrunch FPUs and
> >    gained support for the common clock subsystem
>
> would you like to consider a couple of fixups from the common clock
> rework of ep93xx?
>
> https://lore.kernel.org/linux-arm-kernel/20220120133739.4170298-2-alexander.sverdlin@gmail.com/
> https://lore.kernel.org/lkml/20220130152502.236531-1-alexander.sverdlin@gmail.com/t/

Sure, both look like obvious bugfixes. Shall I apply them to the
fixes branch for 5.18, or as part of the multiplatform series?

Either way, if you have any obvious bugfixes for code you maintain,
and you'd like
to get merged through the soc tree, please send them to soc@kernel.org, which
puts them into the patchwork tracker.

       Arnd
