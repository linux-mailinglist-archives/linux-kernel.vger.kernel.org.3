Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC024C1360
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbiBWM5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiBWM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:57:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7280646B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20A03CE1AFF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63124C340E7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645621031;
        bh=T3RPLphnpfjwjFji7iWJDHhlKcmc/lW8LSE7GNk2LKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oRYCnN+JtWTk+ZS+CT7d6jaqcSPRpUuFonbOK9xP0xB7QUUTpeIRYil0Z6yC0IrpP
         +STyaafk7/Yc//R5yR3Na6Wq8JTsYEQhJulAeoMOY2cxmshWudggYn9SYfYhvPbjqz
         S1XqLyRVOh1UX3uZwyDM/14Yi7HSPfG4EpA2kazhE8+xmwWUoOWTd1WMI99ANMWTg5
         oUulsYyUXWW2XP5os7plGfrs4dIepLnvkI1ZUGsK82KQIbU31vVFcj+qNNgPrdztYc
         n9a+b11/5Pe1Vquy+iQtBZEfvkVQqFxTCFvave+ELkO89WpT/CSxx1FVOJ2uZ5FkkF
         B3pJD/7n4mIIQ==
Received: by mail-yb1-f170.google.com with SMTP id w63so26496619ybe.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:57:11 -0800 (PST)
X-Gm-Message-State: AOAM533jjBOE66cnNeKeADrhz3+99nQbefKwwt9tgmjR5asQQ+ZohRcG
        vVCaOkG3HbemklQSTHP8yjIf0DZIoxNsY5xyceg=
X-Google-Smtp-Source: ABdhPJwEL3v2n7dXLiGGSxBUDiI1buHwdZ4ctEc1Ksn2/qthjXJ6pwsBtWyB0/G9MaH4qLrswEBFghsg5dkZhl8K2zI=
X-Received: by 2002:a25:e014:0:b0:619:a368:c3b5 with SMTP id
 x20-20020a25e014000000b00619a368c3b5mr27062454ybg.383.1645621030432; Wed, 23
 Feb 2022 04:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20220222165212.2005066-7-kaleshsingh@google.com>
 <202202231727.L621fVgD-lkp@intel.com> <875yp63ptg.wl-maz@kernel.org>
 <YhYpvfZaSjrAtkZp@rli9-dbox> <cb750267af0636c49d2f8aa354f086a5@kernel.org>
In-Reply-To: <cb750267af0636c49d2f8aa354f086a5@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Feb 2022 13:56:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHsNsQXbeeS1zcy+xYA7kSE5apbLpChohfvkABS7Z6jKg@mail.gmail.com>
Message-ID: <CAMj1kXHsNsQXbeeS1zcy+xYA7kSE5apbLpChohfvkABS7Z6jKg@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v2 6/9] KVM: arm64: Detect and handle
 hypervisor stack overflows
To:     Marc Zyngier <maz@kernel.org>
Cc:     Philip Li <philip.li@intel.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>, surenb@google.com,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
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

On Wed, 23 Feb 2022 at 13:54, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-02-23 12:34, Philip Li wrote:
> > On Wed, Feb 23, 2022 at 09:16:59AM +0000, Marc Zyngier wrote:
> >> On Wed, 23 Feb 2022 09:05:18 +0000,
> >> kernel test robot <lkp@intel.com> wrote:
> >> >
> >> > Hi Kalesh,
> >> >
> >> > Thank you for the patch! Perhaps something to improve:
> >> >
> >> > [auto build test WARNING on cfb92440ee71adcc2105b0890bb01ac3cddb8507]
> >> >
> >> > url:    https://github.com/0day-ci/linux/commits/Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
> >> > base:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
> >> > config: arm64-randconfig-r011-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231727.L621fVgD-lkp@intel.com/config)
> >> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> >> > reproduce (this is a W=1 build):
> >> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >> >         chmod +x ~/bin/make.cross
> >> >         # install arm64 cross compiling tool for clang build
> >> >         # apt-get install binutils-aarch64-linux-gnu
> >> >         # https://github.com/0day-ci/linux/commit/7fe99fd40f7c4b2973218045ca5b9c9160524db1
> >> >         git remote add linux-review https://github.com/0day-ci/linux
> >> >         git fetch --no-tags linux-review Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
> >> >         git checkout 7fe99fd40f7c4b2973218045ca5b9c9160524db1
> >> >         # save the config file to linux build tree
> >> >         mkdir build_dir
> >> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/
> >> >
> >> > If you fix the issue, kindly add following tag as appropriate
> >> > Reported-by: kernel test robot <lkp@intel.com>
> >> >
> >> > All warnings (new ones prefixed by >>):
> >> >
> >> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >> >    #define NULL ((void *)0)
> >> >                 ^~~~~~~~~~~
> >> >    arch/arm64/kvm/hyp/nvhe/switch.c:200:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
> >> >            [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
> >> >                                              ^~~~~~~~~~~~~~~~~~~~~
> >> >    arch/arm64/kvm/hyp/nvhe/switch.c:196:28: note: previous initialization is here
> >> >            [0 ... ESR_ELx_EC_MAX]          = NULL,
> >> >                                              ^~~~
> >> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >> >    #define NULL ((void *)0)
> >> >                 ^~~~~~~~~~~
> >>
> >> Kalesh, please ignore this nonsense. There may be things to improve,
> >> but this is *NOT* one of them.
> >>
> >> These reports are pretty useless, and just lead people to ignore real
> >> bug reports.
> >
> > Hi Kalesh, sorry there're some irrelevant issues mixed in the report,
> > kindly ignore them. And the valuable ones are the new ones that
> > prefixed by >>, as the below one in original report.
> >
> >>> arch/arm64/kvm/hyp/nvhe/switch.c:372:17: warning: no previous
> >>> prototype for function 'hyp_panic_bad_stack' [-Wmissing-prototypes]
> >    void __noreturn hyp_panic_bad_stack(void)
> >                    ^
>
> This is only called from assembly code, so a prototype wouldn't bring
> much.
>

Should probably be marked as 'asmlinkage' then. I've suggested many
times already that this bogus diagnostic should either be disabled, or
disregard 'asmlinkage' symbols.
