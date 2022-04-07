Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D7B4F7784
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbiDGHd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiDGHdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A356745AE8;
        Thu,  7 Apr 2022 00:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AC3361E09;
        Thu,  7 Apr 2022 07:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C62C385AD;
        Thu,  7 Apr 2022 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649316684;
        bh=ivR8k8w9kZFOITTBTeYpwlLHjNVj0hGTLW0NW/yZSVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iYpJqdwj20zoDmfLo9h28pBJ++sP0GCoavfG6fhyWeqsGbQf4nfwF4r7hkHA+4YN9
         g4Ix4oiSQzkJKRqUV8gWDLWLc1LMjnb2oODf7RQMMMPmGVtJrTlwFJbwiSnNgRk3o6
         fZ+MuFynNBX6w+z5DHixR9TmCG7ONXCaarj6iJ3NCjpMmi5pIz4ENSosVXO1xTDBv9
         RMn9TGHcfExjQ7/mMk3MnUnTF9sD6BvyZC5TewP/KWUf67QQcqMs7q21W2qxncArWX
         7G8UJDW3ujeaHzgVMyi4h4Rd9eYFXQfGbKBTHZpqxUMsARGYWCCa7YnecHl/CeZIO0
         SeetcY+ic4s2w==
Received: by mail-wm1-f49.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so3105700wme.0;
        Thu, 07 Apr 2022 00:31:24 -0700 (PDT)
X-Gm-Message-State: AOAM533PFN3L8JKchO4peF7eqianFBmygT/reNPwoiNhVlBlj5dA99Yk
        SGKcUqdd8dGeIm/vPuPtu4P5cEJpfi6g+0Vdq1o=
X-Google-Smtp-Source: ABdhPJwjAHv/Ka95Vf9n+iGHaRSlH25AJIPsPhtwH0Gh++m1tNbjpZbBagwdF9/ezrXtsZ8x/PvfIi5tLJBz7CdJ0tU=
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id
 g12-20020a05600c4ecc00b0038e354d0909mr11230435wmq.33.1649316682523; Thu, 07
 Apr 2022 00:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220405091750.3076973-1-arnd@kernel.org> <e39d4d71-6ef3-b2b4-3697-1babbadab2ab@linaro.org>
In-Reply-To: <e39d4d71-6ef3-b2b4-3697-1babbadab2ab@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Apr 2022 09:31:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ZYbNKyN7gjoQE4pu_ePE+0Y=tSwvdOHo6GraVokEJmw@mail.gmail.com>
Message-ID: <CAK8P3a0ZYbNKyN7gjoQE4pu_ePE+0Y=tSwvdOHo6GraVokEJmw@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: ARMv5 multiplatform conversions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
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

On Thu, Apr 7, 2022 at 9:07 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/04/2022 11:17, Arnd Bergmann wrote:
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
> >
> >  - The OMAP1 platform has a proposed patch for the common
> >    clock subsystem.
> >
> >  - The generic IRQ entry code is now used everywhere, including
> >    on IOP32x.
> >
> >  - The s3c24xx platform is scheduled for removal next year
>
> Discussion [1] actually did not end with conclusion, but through all the
> time there were no other votes for the platform to stay.

Ok, thanks for the clarification, I misremembered the outcome
of the discussion. I've updated the reference in the mach/io.h
to no longer refer to that, but I still think it's safe to break
readw/writew on BAST ISA devices.

If we finish the multiplatform conversion for all ARMv5, I care
less about dropping s3c24xx entirely as an intermediate step,
but I definitely still like to see any board files and SoCs dropped
that have no users and are just a maintenance burden.

> I will resend my above [1] patch to mention the coming removal.

Ok, thanks!

          Arnd
