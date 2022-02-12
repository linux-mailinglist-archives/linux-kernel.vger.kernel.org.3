Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24A4B3212
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354440AbiBLAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:37:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbiBLAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:37:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D8D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:37:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v4so9502835pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VKg0zjQwSALdbTIf5uSsnkD9DpXhrHD5gjop/xM2cY=;
        b=fVgW/+njctwyhjA00T4OTwKIyHC+ekd/gR2K1kuA66oeEQXIkPL1FXYiyWdAp1d0xn
         TbdfWzdca4NFtjxnNV2QMdmjjW4SM+aVVim50VDMFKC4dYF/vTsoAHkeValgFgcoC+S3
         UO2HQ51kQVncYNuzO0ANIFL2p5kuevmP5FdQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VKg0zjQwSALdbTIf5uSsnkD9DpXhrHD5gjop/xM2cY=;
        b=YqcNnh814BoDtfKbE5nmzjcvnYEpjOCWczlw50YejRtcUGVy3NefVB+cMX7YuijR4M
         szavYRxLnwkp5GKRZyS2UA2myowg5ozHYlNvZ+KrijztIYmd9si8LR5nE4bRwGO1qTRP
         2OkStEdvoGxRKj+op6/YMedCsl/fSh9uDi6ML0Ue+JUgpZI5bsltBL94OD6oab+deY8g
         BW5uo1/f+/ZJi/zU+aopxieMGbZxkpC+MJUSuYfLavHjNmxiVFQEUdH/X7X8qXKDRB7a
         B5tkTmJ0yv6lWWHVlvlEr0gRw717njnsI21KTA92yupCC9+h7FNJiV6EfPIbRtD1iBPh
         HQ8Q==
X-Gm-Message-State: AOAM531l9BEsDi4WjsTP9wsttvZ41Y5FztNIitmSAVIa/+TFmijw0a4s
        f8Cp89Mz55m3VwCFxVkjM5SFGQ==
X-Google-Smtp-Source: ABdhPJy8rQL9XeZ5gO2kkhHcKJasWBPGH4H6gAKxFR64fdrgNu/QVz2ARaO/PRaZzGTt8kr6AuxU0Q==
X-Received: by 2002:a17:90a:1a53:: with SMTP id 19mr2970043pjl.19.1644626270083;
        Fri, 11 Feb 2022 16:37:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h26sm20567050pgm.72.2022.02.11.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 16:37:49 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:37:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Victor Erminpour <victor.erminpour@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org
Subject: Re: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
Message-ID: <202202111623.A7881CC@keescook>
References: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
 <202202101415.43750CEE@keescook>
 <3740c93e-9fde-f89f-9752-26ffff3ea274@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3740c93e-9fde-f89f-9752-26ffff3ea274@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:34:09AM +0000, Robin Murphy wrote:
> Hi Kees,
> 
> On 2022-02-10 23:47, Kees Cook wrote:
> > On Thu, Feb 10, 2022 at 08:41:51PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 10 Feb 2022 at 19:48, Victor Erminpour
> > > <victor.erminpour@oracle.com> wrote:
> > > > 
> > > > When building with automatic stack variable initialization, GCC 12
> > > > complains about variables defined outside of switch case statements.
> > > > Move the variable into the case that uses it, which silences the warning:
> > > > 
> > > > ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
> > > >    1670 |                         struct acpi_iort_named_component *ncomp;
> > > >         |                                                           ^~~~~
> > > > 
> > > > Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> > > 
> > > Please cc people that commented on your v1 when you send a v2.
> > > 
> > > Still NAK, for the same reasons.
> > 
> > Let me see if I can talk you out of this. ;)
> > 
> > So, on the face of it, I agree with you: this is a compiler bug. However,
> > it's still worth fixing. Just because it's valid C isn't a good enough
> > reason to leave it as-is: we continue to minimize the subset of the
> > C language the kernel uses if it helps us get the most out of existing
> > compiler features. We've eliminated all kinds of other "valid C" from the
> > kernel because it improves robustness, security, etc. This is certainly
> > nothing like removing VLAs or implicit fallthrough, but given that this
> > is, I think, the only remaining case of it (I removed all the others a
> > while ago when I had the same issues with the GCC plugins), I'd like to
> > get it fixed.
> 
> It concerns me if minimising the subset of the C language that the kernel
> uses is achieved by converting more of the kernel to a not-quite-C language
> that is not formally specified anywhere, by prematurely adopting
> newly-invented compiler options that clearly don't work properly (the GCC
> warning message quoted above may as well be "error: giraffes are not purple"
> for all the sense it makes.)

Yeah, you're right. While it's a corner case, it's still important to
get it fixed because it risks eroding people's good will for future work.
What you (and Ard) bring up is just as important a roadblock as any of
the other (many *sob*) roadblocks that have been overcome for its
adoption.

> From your security standpoint (and believe me, I really do have faith in
> your expertise here), which of these sounds better:
> 
> 1: Being able to audit code based on well-defined language semantics
> 
> 2: Playing whack-a-mole as issues are discovered empirically.
> 
> 3: Neither of the above, but a warm fuzzy feeling because hey someone said
> "security" in a commit message.
> 
> AFAICS you're effectively voting against #1, and the examples you've given
> demonstrate that #2 is nowhere near reliable enough either, so where does
> that leave us WRT actual secure and robust code in Linux?

Well, I'm for #1, though perhaps with a more narrow view: some semantics
are just weird/surprising. ;) Until I first encountered this warning a
few years ago when working on GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, I didn't
even know putting declarations there was valid C. ;)

Whack-a-mole is part of the work to make these kinds of treewide
changes, but the hope is to find as much of it ahead of time as
possible. And, no, I have no interest in security theater. (Not
everything has equal levels of effectiveness, of course, but I don't
think that's what you're saying.)

> In fairness I'd have no objection to that patch if it came with a convincing
> justification, but that is so far very much lacking. My aim here is not to
> be a change-averse Luddite, but to try to find a compromise where I can
> actually have some confidence in such changes being made. Let's not start
> pretending that 3 100ml bottles of shampoo are somehow "safer" than a 300ml
> bottle of shampoo...

Sure. I think I am trying to take a pragmatic approach here, which is
that gaining auto-var-init is a big deal (killing entire classes of
vulnerabilities), but it comes with an annoying compiler bug (that we do
get a warning about) for an uncommon code pattern that is easy to fix.
So rather than delaying the defense until the sharp edge on the compiler
gets fixed, I'd like to get the rest rolling while the edge is filed.

-Kees

-- 
Kees Cook
