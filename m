Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1668F4DE1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiCRTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiCRTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:53:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B4A2EA0C7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:52:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w12so15673301lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQ3E8sCDZrEL2wZ8doD+CiI98BAdcflnpsvxxLxIuMs=;
        b=ENTvmxmfC4BBPkAvhD10+g2ipgazNCa4PAo9eVHZtO0K7t4pwlwqgomak+5pu8YwRJ
         05IbDBoO0ky49EF0YZ16JJCVFeR7Z9tKixBgevg/2393ptzAGOCK+UyXWJAsR8TlWx9R
         ZEjN0bsBQp4zVFejhCCUNvPjaId2PNhRRnnsQbJDR1bxrWukR/2LCBs8ftpwE68iS1ch
         vRxY210N95DMzLNpJH2jRAEQW25g4EtYLjiYQy532pwdPCzQnkGUZ/Hz2KLzgQo+MgQA
         djHW421qAfRshCbzSw2FzrnMQE3fucFLq7CGZfxVWOCAGxNIUiD/04HWve0DpOEztz0o
         4zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQ3E8sCDZrEL2wZ8doD+CiI98BAdcflnpsvxxLxIuMs=;
        b=54c3Jme3vJYZE8+eOQXwAHu/AojPM0FjmBUTFFwf99Ks6OlZpfxqfDkvy4TQ2enMEZ
         fTGtrc5pdp/Q8l2qkJVUhYw8EoyzLEIqnkYHu6MCICpPFhrmAUSen49zFD4oIDbSWzDC
         EBvcHoBjq3KVTXJgx5PXZfgItWYAJp7knhRYX8PQJ4GAz3gkqe+jXjpEI/XFl/VWEUgc
         ZoKKZ4BEf85FZSMWezCPDyc9plvMBSLmf3H7x6Jd5PQlaKAghCg5YAc/M5ZiGvgBZJJ/
         bdUPdx7cnymogpew1ilHktWlQpbtkXFAYbvc+k5XA1VyeauBPjOJcachk/kVqr1Y2Dxd
         xQBg==
X-Gm-Message-State: AOAM530PruaiJKh7HKv48uLqURLjyJk1bCLj6cv1dQTuT3lZZ/GEzCaR
        Fcq0MCmMzQcpr1XXi6jLCz9pBRdpYMn6HndPmX6jOA==
X-Google-Smtp-Source: ABdhPJyRQNH0WtelZOLCxhPX/+XCdJCX7NUeT+ryQRKooQ4D3nMrEUPMm3JbVI2fIOqCYAy82TIIaA+3n9az4eMg7Ys=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr6639558lfd.184.1647633149856; Fri, 18
 Mar 2022 12:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220316183833.1563139-1-arnd@kernel.org> <3b9cedd6-a084-5d87-2fdd-0da10146827b@arm.com>
In-Reply-To: <3b9cedd6-a084-5d87-2fdd-0da10146827b@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Mar 2022 12:52:18 -0700
Message-ID: <CAKwvOdnut8db1Z1FdZkkSXCvmggrzfKv9Y9GO3uz4ND=K5sB3g@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix clang warning about TRAMP_VALIAS
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Fri, Mar 18, 2022 at 12:11 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-16 18:38, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The newly introduced TRAMP_VALIAS definition causes a build warning
> > with clang-14:
> >
> > arch/arm64/include/asm/vectors.h:66:31: error: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Werror,-Wnull-pointer-arithmetic]
>
> Tangentially, all the other GNU extensions we depend on throughout Linux
> are also GNU extensions. Do we know what's special about this one?

My first thought is that -Wnull-pointer-arithmetic should be in the
-Wgnu flag group, such that -Wno-gnu (as set by Kbuild) implies
-Wno-null-pointer-arithmetic.

One issue seems to be that -Wnull-pointer-arithmetic seems to control
at least 2 different checks in clang.

https://godbolt.org/z/hdYYejj3d

So it's likely these two checks should have 2 distinct flags, such
that the warning we're observing can be grouped under -Wgnu.

Filed: https://github.com/llvm/llvm-project/issues/54444

>
> Robin.
>
> >                  return (char *)TRAMP_VALIAS + SZ_2K * slot;
> >
> > Change the addition to something clang does not complain about.
> >
> > Fixes: bd09128d16fa ("arm64: Add percpu vectors for EL1")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   arch/arm64/include/asm/vectors.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > I see this warning on 5.17-rc8, but did not test it on linux-next,
> > which may already have a fix.
> >
> > diff --git a/arch/arm64/include/asm/vectors.h b/arch/arm64/include/asm/vectors.h
> > index f64613a96d53..bc9a2145f419 100644
> > --- a/arch/arm64/include/asm/vectors.h
> > +++ b/arch/arm64/include/asm/vectors.h
> > @@ -56,14 +56,14 @@ enum arm64_bp_harden_el1_vectors {
> >   DECLARE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector);
> >
> >   #ifndef CONFIG_UNMAP_KERNEL_AT_EL0
> > -#define TRAMP_VALIAS 0
> > +#define TRAMP_VALIAS 0ul
> >   #endif
> >
> >   static inline const char *
> >   arm64_get_bp_hardening_vector(enum arm64_bp_harden_el1_vectors slot)
> >   {
> >       if (arm64_kernel_unmapped_at_el0())
> > -             return (char *)TRAMP_VALIAS + SZ_2K * slot;
> > +             return (char *)(TRAMP_VALIAS + SZ_2K * slot);
> >
> >       WARN_ON_ONCE(slot == EL1_VECTOR_KPTI);
> >



-- 
Thanks,
~Nick Desaulniers
