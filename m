Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCEA5A9DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiIARHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiIARHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:07:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86127F245
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:07:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n17so23206448wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fA4MAzocVYnZA2PNv0a79ePFGBimCCBV9TwhybPc+1g=;
        b=gaNyFVJIAWi6NladXb1I0D9sKA1wYJuqwzT3vMPSeWijxpfGD7ju8E/Y3qpCZH+5z5
         I5clrbyXneyIbY7yxT2NhXaPYKkI8zIbnuijIbHVkg1GygW6FAX3jkEs46hrEWyloeD6
         NH+rPwNIi+1P/9amACHfAZSkG+wBIYJpRqYb9fJbKc75Jk/B0VuiZgRH08uClKGcmEDK
         yiN/O23Z1sZqKpASU54QXDdZx8fOkg1GrSYPxx29wANWc/x1uDFbSOc/aaxSQ4fUb53m
         uB/IGAAF3ZJVI0EUsjQJV71kT+kkLX9QRBd1LlSPY44Ry6Ege4IDk4UMvIQeu5Vl9wPl
         LiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fA4MAzocVYnZA2PNv0a79ePFGBimCCBV9TwhybPc+1g=;
        b=MrW3cNWlwxqtXdLYprfg+ZoUVfOcwMPvpIVibXIDv104kWEXpso2XLOzamgBU5jOev
         xmw30bynla3xO/umdF+2jpJvl+KzOLNm5mPDIq717wn8YXwl5K+41aW5/bqMMSed8Ato
         pwTdiFWwiHzvvsO725fXkTxKXLQ0kmpTRObzbKOagQNyI5vKJGhXUWVmD8zrz4J9GGmY
         bKsVUAFQM2J9p5SGMzls4t/6cix6uJoAEs2mzcSm1kJyWFFcE1+NWTDyASjOLrGOeJMm
         fa5On+0VFSitMt+twVPZ5Yzi5xyj5etn6wg6t6zRburJ4hvjsuUddYIzLGbvRagsjUus
         WuSw==
X-Gm-Message-State: ACgBeo1pk0/7Khv+qH9mWQFTMhZn7ZxCyvjSld3hB7O2egVYOEGqmRyL
        z7aN5Dp0fqkj8pKV+XEiXQRU5MZJZBMODn/1G5/u4Q==
X-Google-Smtp-Source: AA6agR73Y35/orZRP6OW0fmTCoK9dzubdjVPKax1N9hX81ihv1EYXPfbC2vCtqRIuINb3pbTgiJ55+g4kDpcHcCpQb0=
X-Received: by 2002:a5d:47ac:0:b0:226:df12:412f with SMTP id
 12-20020a5d47ac000000b00226df12412fmr10609969wrb.675.1662052020147; Thu, 01
 Sep 2022 10:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr> <Yw8hJS9f6SofG4/6@yury-laptop>
 <YxArx4UGoSQXljQd@yury-laptop> <CAMZ6Rq+XVWGEEHr9t5dkXN0E36hkpMb5kNEZJmMFgtJxyQntsg@mail.gmail.com>
 <YxC+eShQLDor0B9D@yury-laptop>
In-Reply-To: <YxC+eShQLDor0B9D@yury-laptop>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 1 Sep 2022 10:06:48 -0700
Message-ID: <CAKwvOd=xWEc9T=RQcZDuHNMtng+pODa2SXs9iOmPWdJ5coPBaA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Borislav Petkov <bp@alien8.de>,
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

On Thu, Sep 1, 2022 at 7:19 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Thu, Sep 01, 2022 at 07:30:10PM +0900, Vincent MAILHOL wrote:
> > On Tue. 1 sept. 2022 at 12:49, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Wed, Aug 31, 2022 at 01:54:01AM -0700, Yury Norov wrote:
> > > > On Wed, Aug 31, 2022 at 04:57:40PM +0900, Vincent Mailhol wrote:
> > > > > The compilers provide some builtin expression equivalent to the ffs(),
> > > > > __ffs() and ffz() functions of the kernel. The kernel uses optimized
> > > > > assembly which produces better code than the builtin
> > > > > functions. However, such assembly code can not be folded when used
> > > > > with constant expressions.
> > > > >
> > > > > This series relies on __builtin_constant_p to select the optimal solution:
> > > > >
> > > > >   * use kernel assembly for non constant expressions
> > > > >
> > > > >   * use compiler's __builtin function for constant expressions.
> > > > >
> > > > >
> > > > > ** Statistics **
> > > > >
> > > > > Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> > > > > of __ffs() and ffz() calls (details of the calculation in each patch).
> > > >
> > > > Hi Vincent,
> > > >
> > > > Can you please add a test for this? We've recently added a very similar
> > > > test_bitmap_const_eval() in lib/test_bitmap.c.
> > > >
> > > > dc34d5036692c ("lib: test_bitmap: add compile-time optimization/evaluations
> > > > assertions")
> > > >
> > > > Would be nice to have something like this for ffs() and ffz() in
> > > > lib/test_bitops.c.
> > > >
> > > > Please keep me in loop in case of new versions.
> >
> > Hi Yury,
> >
> > My patch only takes care of the x86 architecture.
>
> OK, I just realized that you started submitting this at least back in May.
>
> For me, v6 is good enough and well-described. So, for the series:
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
>
> How are you going to merge it? If you haven't a specific tree in mind
> already, I can take it in my bitmap tree because  ffs and ffz are closely
> related to find_bit() functions.

Unless Boris feels strong enough to nack the series, I think Yury
accepting the series is the way to go.
-- 
Thanks,
~Nick Desaulniers
