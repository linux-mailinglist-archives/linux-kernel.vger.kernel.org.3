Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E467E4D37E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiCIQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiCIQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:45:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CF3A70B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:38:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B709261A59
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D538C340F4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646843917;
        bh=iC169KEcmP4GOYp17Sss+BBLrHr5sbsqM2HTswZv53k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kbLZCVPrrNZFgg1zNOv+uj5thtx4j1RVK30FiaV8TGBwC/29iXSw/mVIp6NiQ8tZb
         CrSo/B/2Z71YWMe1vMEIfoQLEl7nTQWKHCDiLND5qM4OqfOV6Kkzv81DnLNyWOdqgx
         b2xKJ0Bxn51hFE5dTNqBptDqScyBIr42XAwzZpu4BWdnfgUqMpi4+T+gDsrV8Y8I+p
         fTDMntrIZnHYu0GgmVh0/NRFFGUsFHcpXzTEVgt7shOTUI37kiAVxt0S6fUvAvTmvi
         2Rd26xOdel9ocLGleuKBOVfk/WlomYSXTr+d74PFsQM+AfTFDBEiVQ5LWn+lHxmTPj
         m0RI76qyY4+RQ==
Received: by mail-wm1-f42.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3809120wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:38:37 -0800 (PST)
X-Gm-Message-State: AOAM5301HjaM7z0YTgWIzbM0LH/yqoICC3sapgKL8RC41c3XddzxCYjD
        9mGaPmHqa5SBNTq87lTsC4o0aF1/F6kA/5+TjoU=
X-Google-Smtp-Source: ABdhPJznNRJosN/CnJQ8YmwilKitvCCkO6cHt7K4Li/0F09s1DxZWjuBCBpxQQg+QX8GIS2PET9sY9GvZ1dgU5eRtoM=
X-Received: by 2002:a05:600c:384a:b0:37c:2d14:a2d3 with SMTP id
 s10-20020a05600c384a00b0037c2d14a2d3mr196737wmr.20.1646843915414; Wed, 09 Mar
 2022 08:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org> <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com> <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
 <08232117-7444-55d8-e13c-b49828c8f3e9@arm.com>
In-Reply-To: <08232117-7444-55d8-e13c-b49828c8f3e9@arm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Mar 2022 17:38:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3L2sfi-VQ=yjRhkGA6x6JTvCw5KyHQnBf2r348MX_avw@mail.gmail.com>
Message-ID: <CAK8P3a3L2sfi-VQ=yjRhkGA6x6JTvCw5KyHQnBf2r348MX_avw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Wed, Mar 9, 2022 at 5:21 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> On 3/9/22 4:17 PM, Arnd Bergmann wrote:
> > On Wed, Mar 9, 2022 at 4:48 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2022-03-09 14:40, Arnd Bergmann wrote:
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> It is possible to build MMU-less kernels for Cortex-M base
> >>> microcrontrollers as well as a couple of older platforms that
> >>> have not been converted to CONFIG_ARCH_MULTIPLATFORM,
> >>> specifically ep93xx, footbridge, dove, sa1100 and s3c24xx.
> >>>
> >>> It seems unlikely that anybody has tested those configurations
> >>> in recent years, as even building them is frequently broken.
> >>> A patch I submitted caused another build time regression
> >>> in this configuration. I sent a patch for that, but it seems
> >>> better to also remove the option entirely, leaving ARMv7-M
> >>> as the only supported Arm NOMMU target for simplicity.
> >>
> >> In that case, it would probably make sense to garbage-collect all the
> >> configs, setup code and other stuff relating to older MMU-less CPU cores
> >> like ARM1156, ARM940, etc. at the same time.
> >
> > Right, good idea. These are only selected by CONFIG_ARCH_INTEGRATOR,
> > but that in turn doesn't build for CONFIG_MMU=n because it depends on
> > ARCH_MULTIPLATFORM. I'll send a patch for these.
> >
> > I also went back and forth between removing the #ifdefs in
> > arch/arm/mm/proc-*.S for this patch, though I did not do that in the end.
> > We may still want them at least for proc-v7.S because that is a small
> > chance that someone will want to support Cortex-R.
> >
>
> I'd appreciate if you keep them since I run Cortex-R52...

Ok, no problem.

Any opinion on removing CPU_ARM{7TDMI,740T,940T,946E}?

       Arnd
