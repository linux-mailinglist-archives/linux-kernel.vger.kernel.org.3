Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD804573A50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiGMPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiGMPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:36:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86D4D830
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:36:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o12so11293450ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frSkO8LINr4fIYviWk98zCOOmU6Ew1V0tF2nZHNwdSA=;
        b=M/KSRgcUcJQvDr7kv37lS/FPE1C7EbhTDrVDDTHUGdFcWeTMm1zdyz7dfRaZjKSNeJ
         R26kPb8JFoIXs7POF8i38ksSux8OlP8OXdhXJlM/MIglrSReWnjFtEs2LDnRVN23UF8S
         pHVJVBM1yWymWPM/QFPzJ6kd2xvPT6e9/dJs07TmM/omaRNAtgFb1WYxL3pOsmO3Hr6b
         mx32ykTgWBKQu+5zdxVRH9Xn1wM+ivrsi75SfnhLUP3/wB7WVI3Br2cdwOBciYXtZUZB
         Y+SGKQxXcAAUdavWfKJeKi30cyXlCNdzpZ4myP8VydIPvoGrdmxVEaj0z23T6CV4UVaf
         948w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frSkO8LINr4fIYviWk98zCOOmU6Ew1V0tF2nZHNwdSA=;
        b=rRNPhxH4ZvSW3FNFtqiw1t1pnQx2sXE4qNQZiDkc3FRjxI1tzD6Z4RUgWI2b+Rv/Ab
         8r5Pf6QcOXC4o1/oiMaDfiOEvtkmqBE80oV9A+Kb+PAlDpgNKVUkv3nuwOMQJ95I1giP
         m3PscvNHkkNmDskHL89K5+hrXifzlv4watNTa/8sIUvpFAomni/iSAr+DpQtmxz3v6qf
         qJ4GknpuJzzWpg88x/tmvAdsymRST8jLJjkJ6/C9anx1UCWRp1RORM2JT2pZr8Gw6KJe
         ftIrP6ZadgwNPy/2xlPk7GJ694rWMLmKMYuPOWrvb+0NEcyV4LKwRhMQNxi+9yZPrUA+
         5+vw==
X-Gm-Message-State: AJIora8QZuCT300qQ4g6zgVn8XZUifnapu3bckEtZbv7ee0pSaGV0M3l
        xQwNK7uvVRu8VXTADuDlNuj0tSFBKrL67lYJhQQDzkfDjD4=
X-Google-Smtp-Source: AGRyM1t+27L+bFm9l7VHdmsBQUhxdg6zV9GyjGmpFKagRo+a2ORoV22JAC3XRC1j3aZr33+QHwqiqju1MiSuDlA2XKc=
X-Received: by 2002:a2e:8609:0:b0:25d:6af0:63b5 with SMTP id
 a9-20020a2e8609000000b0025d6af063b5mr2153523lji.360.1657726588005; Wed, 13
 Jul 2022 08:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220713152436.2294819-1-nathan@kernel.org>
In-Reply-To: <20220713152436.2294819-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jul 2022 08:36:16 -0700
Message-ID: <CAKwvOdkXdAXBTLipv5A3vaTe_dRPvtCDJobi=tHR9oSJab9oBw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 8:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
>   arch/x86/kernel/cpu/bugs.c:58:21: error: section attribute is specified on redeclared variable [-Werror,-Wsection]
>   DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
>                       ^
>   arch/x86/include/asm/nospec-branch.h:283:12: note: previous declaration is here
>   extern u64 x86_spec_ctrl_current;
>              ^
>   1 error generated.
>
> The declaration should be using DECLARE_PER_CPU instead so all
> attributes stay in sync.
>
> Cc: stable@vger.kernel.org
> Fixes: fc02735b14ff ("KVM: VMX: Prevent guest RSB poisoning attacks with eIBRS")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2: https://lore.kernel.org/20220713152222.1697913-1-nathan@kernel.org/
>
> * Use asm/percpu.h instead of linux/percpu.h to avoid static call
>   include errors.
>
>  arch/x86/include/asm/nospec-branch.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index bb05ed4f46bd..10a3bfc1eb23 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -11,6 +11,7 @@
>  #include <asm/cpufeatures.h>
>  #include <asm/msr-index.h>
>  #include <asm/unwind_hints.h>
> +#include <asm/percpu.h>
>
>  #define RETPOLINE_THUNK_SIZE   32
>
> @@ -280,7 +281,7 @@ static inline void indirect_branch_prediction_barrier(void)
>
>  /* The Intel SPEC CTRL MSR base value cache */
>  extern u64 x86_spec_ctrl_base;
> -extern u64 x86_spec_ctrl_current;
> +DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
>  extern void write_spec_ctrl_current(u64 val, bool force);
>  extern u64 spec_ctrl_current(void);
>
>
> base-commit: 72a8e05d4f66b5af7854df4490e3135168694b6b
> --
> 2.37.1
>
>


-- 
Thanks,
~Nick Desaulniers
