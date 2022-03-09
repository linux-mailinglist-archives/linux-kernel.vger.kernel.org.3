Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764DE4D3435
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 17:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiCIQYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiCIQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:21:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805C3E10
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 516DEB82221
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E277C340F7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646842659;
        bh=wcHvu5yCe5RwLv3/dGOPzc0JNrj+q5a53qp5+a2m21I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P4s8nVLyAwUaVuySt4MjswdVCrghJHdXHJWl11pfoO8oNuQowU/27mk//j2znrI15
         UcX2Je00Fe/yWxKR36XA4BnsbGm5126STh4cbCeThPI6pcewwFDovbVCUQxSuZFSeE
         a8RtKl26PRJwVSKhnFXti3dFCNR+KMcLAr5MlcdNZeRazqr2mz5wlHtfhTqYwG0hhV
         0mz9aI8sjFa4CvY17I2byucqi+P/AHz971xcGi9GiGmkdhw4FJs/kdiweashl0IunM
         BLAhn2BGxtOPYxNQCuoeoSxbDvtJWx1R7q0Qb0dLEa936LWi4IyCFjUskUwZP2T4IT
         dms7AHozZ9kDg==
Received: by mail-wr1-f52.google.com with SMTP id u1so3825250wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:17:39 -0800 (PST)
X-Gm-Message-State: AOAM531IqslL4RBccobkVyYvMAhj8tSsL1QZUuG5oRDPPza9BPa7WA8u
        NvDhdrBAk5rWITHQzlo45uBCxuKeGEhcI2tEF2Q=
X-Google-Smtp-Source: ABdhPJxGoyWxihc52YXH4rfuLZkMFEs/nxgBgrYnRqvXSt4UGzbMzOAuUKsccPsfh8OGvNhkES6t/rUrJkFkhtYrkP0=
X-Received: by 2002:a5d:6810:0:b0:203:7cbb:20be with SMTP id
 w16-20020a5d6810000000b002037cbb20bemr283536wru.219.1646842657281; Wed, 09
 Mar 2022 08:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org> <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com>
In-Reply-To: <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Mar 2022 17:17:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
Message-ID: <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Wed, Mar 9, 2022 at 4:48 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-09 14:40, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > It is possible to build MMU-less kernels for Cortex-M base
> > microcrontrollers as well as a couple of older platforms that
> > have not been converted to CONFIG_ARCH_MULTIPLATFORM,
> > specifically ep93xx, footbridge, dove, sa1100 and s3c24xx.
> >
> > It seems unlikely that anybody has tested those configurations
> > in recent years, as even building them is frequently broken.
> > A patch I submitted caused another build time regression
> > in this configuration. I sent a patch for that, but it seems
> > better to also remove the option entirely, leaving ARMv7-M
> > as the only supported Arm NOMMU target for simplicity.
>
> In that case, it would probably make sense to garbage-collect all the
> configs, setup code and other stuff relating to older MMU-less CPU cores
> like ARM1156, ARM940, etc. at the same time.

Right, good idea. These are only selected by CONFIG_ARCH_INTEGRATOR,
but that in turn doesn't build for CONFIG_MMU=n because it depends on
ARCH_MULTIPLATFORM. I'll send a patch for these.

I also went back and forth between removing the #ifdefs in
arch/arm/mm/proc-*.S for this patch, though I did not do that in the end.
We may still want them at least for proc-v7.S because that is a small
chance that someone will want to support Cortex-R.

        Arnd
