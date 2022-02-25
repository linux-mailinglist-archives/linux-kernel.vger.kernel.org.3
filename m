Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0198F4C3C30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiBYDMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBYDMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:12:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74E4BBB2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:12:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j22so2376806wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tXA6AeT/n84QHis5S/egaFq21pdbXEw9XfX//TKVfM=;
        b=c7GYzBUZ9xR/BVJG5gvZgCEJWk3vhp6OQX6HWlS9iuFRLcxYPGbKRSEHM+64LlVY1g
         8xIbBZr9zBJEu7O0NERNKR5d52ZiltX0nnRUgH6OAgMUPcQivl9IpnKHLQGvN62wGriA
         kaUUenhCahjCZ9/EhzF+CSapnzjWiiPFc2iltfDulLHS1VY2pkUuHv8b5rInK+IusWXU
         SVhF1Gmh1MfaLf+S62E0LFzQGLSnTxV2EPxsWoTGrPcFP95/JgZ7mcxX/3PoPAFif7Ro
         qyu9JeOC94XiTIrVVFdNtmrBGN2vNFmJnpxfnWKUnxKVGmb9jS3EdJNWec8tPVaN4ArF
         Q8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tXA6AeT/n84QHis5S/egaFq21pdbXEw9XfX//TKVfM=;
        b=l5M4xWVL4DY30Poa9zAudbe+FlMweLDrU9S7NPGW8QlsRsH0uBHSL14vcBwSqO5i8B
         iTT9WgClmHEYJ+O+5TUMduA8mFVohImqlIyweGQNPw91aebD8cEMokhEBo4Tt3iV6mR2
         kbEHCtW5AnTyJFs50KS8kE8VK4bbJVbvvSt+iQHc0kcRBuvftLiDQlcu9G5WdGqAR/l5
         tvpJWbV3+NlRaedZHpVvY01K/8KBu6uyYIUPyrJH9HIyFSbciyLymCDuPKY8LUODl37W
         gHMT4zMbbt+c4/oN/OY2YL1B0gcBo06ymPWePQxQxhdh8ZFDvj9RSAlhpwx27pZRvIX8
         mV1w==
X-Gm-Message-State: AOAM532wrZppFD2mEkJsNjZf6Xcae1sjm0r3k9SPLNT79l82MsNMdqyw
        qw+dDQ6h8Db+yOQ7cs+3lsPrvz+E+73DPyqlwrbmaw==
X-Google-Smtp-Source: ABdhPJxpp13+Gj6zLNHG/fdOzoKqtaJB14AbGDQVpFLIsU1SU8SdTUT1E0oKQs51V54e00SfilVyzOkbf0DXzqyfito=
X-Received: by 2002:adf:ca08:0:b0:1ed:c0bc:c212 with SMTP id
 o8-20020adfca08000000b001edc0bcc212mr4359347wrh.577.1645758727122; Thu, 24
 Feb 2022 19:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20220222165212.2005066-7-kaleshsingh@google.com>
 <202202231727.L621fVgD-lkp@intel.com> <875yp63ptg.wl-maz@kernel.org>
 <YhYpvfZaSjrAtkZp@rli9-dbox> <cb750267af0636c49d2f8aa354f086a5@kernel.org>
 <CAMj1kXHsNsQXbeeS1zcy+xYA7kSE5apbLpChohfvkABS7Z6jKg@mail.gmail.com>
 <89c48bd2a9b32b4607d1515714fa3c1b@kernel.org> <16f47fa9-90b4-0b5c-33cb-cb004fc39266@intel.com>
In-Reply-To: <16f47fa9-90b4-0b5c-33cb-cb004fc39266@intel.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 24 Feb 2022 19:11:55 -0800
Message-ID: <CAC_TJvd2a4DJUgvFLAHyBJT-eZNWwwohuTG=NOfvaOpyTTd3oA@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v2 6/9] KVM: arm64: Detect and handle
 hypervisor stack overflows
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 6:12 PM Chen, Rong A <rong.a.chen@intel.com> wrote:
>
>
>
> On 2/24/2022 6:39 PM, Marc Zyngier wrote:
> > On 2022-02-23 12:56, Ard Biesheuvel wrote:
> >> On Wed, 23 Feb 2022 at 13:54, Marc Zyngier <maz@kernel.org> wrote:
> >>>
> >>> On 2022-02-23 12:34, Philip Li wrote:
> >>> > On Wed, Feb 23, 2022 at 09:16:59AM +0000, Marc Zyngier wrote:
> >>> >> On Wed, 23 Feb 2022 09:05:18 +0000,
> >>> >> kernel test robot <lkp@intel.com> wrote:
> >>> >> >
> >>> >> > Hi Kalesh,
> >>> >> >
> >>> >> > Thank you for the patch! Perhaps something to improve:
> >>> >> >
> >>> >> > [auto build test WARNING on
> >>> cfb92440ee71adcc2105b0890bb01ac3cddb8507]
> >>> >> >
> >>> >> > url:
> >>> https://github.com/0day-ci/linux/commits/Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
> >>>
> >>> >> > base:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
> >>> >> > config: arm64-randconfig-r011-20220221
> >>> (https://download.01.org/0day-ci/archive/20220223/202202231727.L621fVgD-lkp@intel.com/config)
> >>>
> >>> >> > compiler: clang version 15.0.0
> >>> (https://github.com/llvm/llvm-project
> >>> d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> >>> >> > reproduce (this is a W=1 build):
> >>> >> >         wget
> >>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> >>> -O ~/bin/make.cross
> >>> >> >         chmod +x ~/bin/make.cross
> >>> >> >         # install arm64 cross compiling tool for clang build
> >>> >> >         # apt-get install binutils-aarch64-linux-gnu
> >>> >> >         #
> >>> https://github.com/0day-ci/linux/commit/7fe99fd40f7c4b2973218045ca5b9c9160524db1
> >>>
> >>> >> >         git remote add linux-review
> >>> https://github.com/0day-ci/linux
> >>> >> >         git fetch --no-tags linux-review
> >>> Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
> >>> >> >         git checkout 7fe99fd40f7c4b2973218045ca5b9c9160524db1
> >>> >> >         # save the config file to linux build tree
> >>> >> >         mkdir build_dir
> >>> >> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> >>> make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/
> >>> >> >
> >>> >> > If you fix the issue, kindly add following tag as appropriate
> >>> >> > Reported-by: kernel test robot <lkp@intel.com>
> >>> >> >
> >>> >> > All warnings (new ones prefixed by >>):
> >>> >> >
> >>> >> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >>> >> >    #define NULL ((void *)0)
> >>> >> >                 ^~~~~~~~~~~
> >>> >> >    arch/arm64/kvm/hyp/nvhe/switch.c:200:27: warning: initializer
> >>> overrides prior initialization of this subobject
> >>> [-Winitializer-overrides]
> >>> >> >            [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
> >>> >> >                                              ^~~~~~~~~~~~~~~~~~~~~
> >>> >> >    arch/arm64/kvm/hyp/nvhe/switch.c:196:28: note: previous
> >>> initialization is here
> >>> >> >            [0 ... ESR_ELx_EC_MAX]          = NULL,
> >>> >> >                                              ^~~~
> >>> >> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >>> >> >    #define NULL ((void *)0)
> >>> >> >                 ^~~~~~~~~~~
> >>> >>
> >>> >> Kalesh, please ignore this nonsense. There may be things to improve,
> >>> >> but this is *NOT* one of them.
> >>> >>
> >>> >> These reports are pretty useless, and just lead people to ignore real
> >>> >> bug reports.
> >>> >
> >>> > Hi Kalesh, sorry there're some irrelevant issues mixed in the report,
> >>> > kindly ignore them. And the valuable ones are the new ones that
> >>> > prefixed by >>, as the below one in original report.
> >>> >
> >>> >>> arch/arm64/kvm/hyp/nvhe/switch.c:372:17: warning: no previous
> >>> >>> prototype for function 'hyp_panic_bad_stack' [-Wmissing-prototypes]
> >>> >    void __noreturn hyp_panic_bad_stack(void)
> >>> >                    ^
> >>>
> >>> This is only called from assembly code, so a prototype wouldn't bring
> >>> much.
> >>>
> >>
> >> Should probably be marked as 'asmlinkage' then. I've suggested many
> >> times already that this bogus diagnostic should either be disabled, or
> >> disregard 'asmlinkage' symbols.
> >
> > Yes, asmlinkage is definitely missing.
> >
> > But it is pretty obvious that the robot people aren't interested in
> > fixing this particular issue, given how long we have been suggesting
> > this...
> >
> >          M.
>
> Hi Marc, Ard,
>
> We have ignored the warning related to asmlinkage according to the below
> advice:
>
> https://lore.kernel.org/lkml/CAMj1kXHrRYagSVniSetHdG15rkQS+fm4zVOtN=Zda3W0QaEoJA@mail.gmail.com/
>
> do you want the bot ignore such warning if asmlinkage not specified?

Hi Rong,

I have added asmlinkage to the functions without a prototype in later
versions of the patch.

Perhaps the report should be updated to say "functions only called
from assembly code should be annotated with the asmlinkage attribute"
if the error is a missing prototype

Thanks,
Kalesh
>
> Best Regards,
> Rong Chen
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
