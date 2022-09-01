Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6357A5A99F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiIAOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiIAOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:19:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2A62A80
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:19:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j17so13471869qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sU5/spIoFFsSsjudnyeB7I5k2zVIg64jzdQC1Ln9LKI=;
        b=L3vwZZLviUfz2/Qv1uuocskyzZF3TjqFQXBHeWunVdszNZkWU/5mL6r0ecwdvIn71h
         QQvFH0ixCr7AuByn4N1CF2wwiAfPB/c7ge2uweWtQ/2RLAtRTaD8F/wLh/PSlE2/2xQk
         0mHjqfOpYTviHShaGwJjrf7QTtVYJKZJZSLCwIxizsIaCaAQcYwxRiVUZ8uUDa4of+F+
         C+4ZEc1vwuFRaFcjIxSWumpszXQNCTAGUkIERkRuob4qNrTTnvgMS/Z5Iu8/2AFdcoRu
         VGu5ZVNgZ1sdCMi1Q9IRJtIbCEmIPO/LoG41W8Psc/GZ00z3W9xdly9o/IoASJmmkeWK
         tHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sU5/spIoFFsSsjudnyeB7I5k2zVIg64jzdQC1Ln9LKI=;
        b=7Ecv/Pq2XvOGiJhrGD14+Cq6mG6Sp3QxbMSdN3CmfGs6j6Ke2SGVIuf+sFp1vrc/9T
         pvShFeQMh6z5kGlIgraThXf9jiTnLBbHn5s1JtfGf7MCUKulPNo9Os2oxSM8vmPeVsT7
         hRe8wKZlNFJAJ0dEuEn1Po4dH0rgdd3XQded/VtcSfB2esKcvJAR2/XdY+5/Tm7J3Pw8
         ZHKTG2NldBLQHyzVsFXNH0iIzvLVOUbaPNOT/7B9MrfLJhB10s64pv7FqyV8tU5G9V+O
         mnAD5ceTJwyqOmiLcU64qHHAZu4F6+jp/LDTPzr6Su3bVpE3FVmCj40oJOs/3Smnfobp
         R5jA==
X-Gm-Message-State: ACgBeo3zFC16lHIGY1FS33h6v/5HZ2wU845ETmU3iy367I/QtjY2qu1k
        Nc1dpgJ8Pbnsu7tDuwZMIW4=
X-Google-Smtp-Source: AA6agR5z1NM1EyyB2pG7Q4h+Y42w4H3zINPSAaCyxrK/1RCpCBh2d5EoXNAzzSHnRTNqBwhuwMlPew==
X-Received: by 2002:ac8:7dc1:0:b0:344:6104:eab6 with SMTP id c1-20020ac87dc1000000b003446104eab6mr23373266qte.455.1662041954828;
        Thu, 01 Sep 2022 07:19:14 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:f862:dbcc:aa84:4875])
        by smtp.gmail.com with ESMTPSA id 138-20020a370390000000b006a5d2eb58b2sm11419968qkd.33.2022.09.01.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:19:14 -0700 (PDT)
Date:   Thu, 1 Sep 2022 07:19:13 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v6 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
Message-ID: <YxC+eShQLDor0B9D@yury-laptop>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr>
 <Yw8hJS9f6SofG4/6@yury-laptop>
 <YxArx4UGoSQXljQd@yury-laptop>
 <CAMZ6Rq+XVWGEEHr9t5dkXN0E36hkpMb5kNEZJmMFgtJxyQntsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+XVWGEEHr9t5dkXN0E36hkpMb5kNEZJmMFgtJxyQntsg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 07:30:10PM +0900, Vincent MAILHOL wrote:
> On Tue. 1 sept. 2022 at 12:49, Yury Norov <yury.norov@gmail.com> wrote:
> > On Wed, Aug 31, 2022 at 01:54:01AM -0700, Yury Norov wrote:
> > > On Wed, Aug 31, 2022 at 04:57:40PM +0900, Vincent Mailhol wrote:
> > > > The compilers provide some builtin expression equivalent to the ffs(),
> > > > __ffs() and ffz() functions of the kernel. The kernel uses optimized
> > > > assembly which produces better code than the builtin
> > > > functions. However, such assembly code can not be folded when used
> > > > with constant expressions.
> > > >
> > > > This series relies on __builtin_constant_p to select the optimal solution:
> > > >
> > > >   * use kernel assembly for non constant expressions
> > > >
> > > >   * use compiler's __builtin function for constant expressions.
> > > >
> > > >
> > > > ** Statistics **
> > > >
> > > > Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> > > > of __ffs() and ffz() calls (details of the calculation in each patch).
> > >
> > > Hi Vincent,
> > >
> > > Can you please add a test for this? We've recently added a very similar
> > > test_bitmap_const_eval() in lib/test_bitmap.c.
> > >
> > > dc34d5036692c ("lib: test_bitmap: add compile-time optimization/evaluations
> > > assertions")
> > >
> > > Would be nice to have something like this for ffs() and ffz() in
> > > lib/test_bitops.c.
> > >
> > > Please keep me in loop in case of new versions.
> 
> Hi Yury,
> 
> My patch only takes care of the x86 architecture.

OK, I just realized that you started submitting this at least back in May. 

For me, v6 is good enough and well-described. So, for the series:
Reviewed-by: Yury Norov <yury.norov@gmail.com>

How are you going to merge it? If you haven't a specific tree in mind 
already, I can take it in my bitmap tree because  ffs and ffz are closely
related to find_bit() functions.

> Assuming some other
> architectures are not optimized yet, adding such a test might break
> some builds. I am fine with adding the test, however, I will not write
> patches for the other architecture because I do not have the
> environment to compile and test it.
> 
> Does it still make sense to add the test before fixing all the architectures?

All-arches fix should begin with changing the ffs design. Namely, there
should be a generic ffs() in include/linux/bitops.h, and arch-specific
arch__ffs() in arch/xxx/include/asm/bitops.h; like we do for the set_bit()
family. I have a feeling that it's far beyond the scope of your series.

The test is a different story. Good tests are always welcome, even if
they don't cover all the arches.

> > Also, what about fls? Is there any difference with ffs/ffz wrt compile
> > time optimizations? If not, would be great if the series will take
> > care of it too.
> 
> Agree. The fls() and fls64() can use __builtin_ctz() and
> __builtin_ctzll(). However, those two functions are a bit less
> trivial. I wanted to have this first series approved first before
> working on *fls*().

OK, the test and fls() can be a matter of a follow-up series, taking
into account how long are these 2 patches moving.

Thanks,
Yury
