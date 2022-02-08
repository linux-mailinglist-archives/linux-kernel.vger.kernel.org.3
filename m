Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5C4AE590
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiBHXmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiBHXmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:42:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02ABC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:42:34 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x3so700370pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6+sTXDYmgUQsDsJLKYnziAyPf1hDavDmQY5J7q52kzU=;
        b=bxG+vq9e3SrwYf4/FxA1grj/gUOyczUGU1bFcT8v36LdowcfF2hAgXMQPHKEzV9/pB
         qXQRxGgd+B1VbFvyV2nq0D9IW3lLsBBAWiT8It3alVq/ceJ6kUx35g1PnKdOKBG0ssv+
         R3aiUo/pBVqYnCHUtdp1fR3OKs0RsLlgkId68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6+sTXDYmgUQsDsJLKYnziAyPf1hDavDmQY5J7q52kzU=;
        b=1jqI8QjWu2CiGcSrqdAfG4laWOK4UkS/Kr7FRTmjzZWTbL6LWNogRZYe9Pv1nowyN4
         bcAJZj2GXGbBNa1UGHtZe2onOS62HifyvSOIEGYimLlE30DUfNdrX3S6ZVfdILDMT0TW
         eFCZ3szB8YqXAP/L+PLBRplhKQd3dqWlfqSzF9Ue8/66Z9c8KtVv3ORl/1C+B9T6+Azc
         ETu6m8oD5Fbo4FvsD7KulLlcfx3fS/fUPCtInbIN9IdpjyY9BYHCKcTbm5MyH+5OWUqd
         xtbBq7CRJuKmf98Sc1s6xISNPKnJ8LDtWLtFrI9Est/b5E8EwWfiwBWVK4mpwT6bpF8h
         hWJg==
X-Gm-Message-State: AOAM530QqErmar48aQos7d7Cqwf+0uGF7OB67do6Po0SgXZf95gh5Scg
        Iip1BBmTrbDsoRUnG2WVNDm14Q==
X-Google-Smtp-Source: ABdhPJwTLtJC/y2Hfm5dxqRTIRR0DSoV4UErP93LtFhCa3/CUZLVU+T2+AgQOZF+ju/qlCZhIZYMzA==
X-Received: by 2002:a17:903:1207:: with SMTP id l7mr7035725plh.19.1644363754281;
        Tue, 08 Feb 2022 15:42:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14sm17294592pfk.65.2022.02.08.15.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:42:34 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:42:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     joao@overdrivepizza.com
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <202202081541.900F9E1B@keescook>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 06:05:50PM -0800, joao@overdrivepizza.com wrote:
> On 2021-11-22 09:03, Peter Zijlstra wrote:
> > Objtool based IBT validation in 3 passes:
> > 
> >  --ibt-fix-direct:
> > 
> >     Detect and rewrite any code/reloc from a JMP/CALL instruction
> >     to an ENDBR instruction. This is basically a compiler bug since
> >     neither needs the ENDBR and decoding it is a pure waste of time.
> > 
> >  --ibt:
> > 
> >     Report code relocs that are not JMP/CALL and don't point to ENDBR
> > 
> >     There's a bunch of false positives, for eg. static_call_update()
> >     and copy_thread() and kprobes. But most of them were due to
> >     _THIS_IP_ which has been taken care of with the prior annotation.
> > 
> >  --ibt-seal:
> > 
> >     Find and NOP superfluous ENDBR instructions. Any function that
> >     doesn't have it's address taken should not have an ENDBR
> >     instruction. This removes about 1-in-4 ENDBR instructions.
> > 
> 
> I did some experimentation with compiler-based implementation for two of the
> features described here (plus an additional one). Before going into details,
> just a quick highlight that the compiler has limited visibility over
> handwritten assembly sources thus, depending on the feature, a
> compiler-based approach will not cover as much as objtool. All the
> observations below were made when compiling the kernel with defconfig, +
> CLANG-related options, + LTO sometimes. Here I used kernel revision
> 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1 with PeterZ's IBT Beginning patches
> applied on top (plus changes to Kbuild), thus, IBT was not really enforced.
> Tests consisted mostly of Clang's synthetics tests + booting a compiled
> kernel.
> 
> Prototypes of the features are available in:
> https://github.com/lvwr/llvm/tree/joao/ibt -- I fixed as many corner cases I
> could find while trying it out, but I believe some might still be haunting.
> Also, I'm not very keen to Kbuild internals nor to however the kernel
> patches itself during runtime, so I may have missed some details.
> 
> Finally, I'm interested in general feedback about this... better ways of
> implementing, alternative approaches, new possible optimizations and
> everything. I should be AFK for a few days in the next weeks, but I'll be
> glad to discuss this in January and then. Happy Holidays :)
> 
> The features:
> 
> -mibt-seal:
> 
> Add ENDBRs exclusively to address-taken functions regardless of its linkage
> visibility. Only make sense together with LTO.
> 
> Observations: Reduced drastically the number of ENDBRs placed in the kernel
> binary (From 44383 to 33192), but still missed some that were later fixed by
> objtool (Number of fixes by objtool reduced from 11730 to 540). I did not
> investigate further why these superfluous ENDBRs were still left in the
> binary, but at this point my hypotheses spin around (i) false-positive
> address-taken conclusions by the compiler, possibly due to things like
> exported symbols and such; (ii) assembly sources which are invisible to the
> compiler (although this would more likely hide address taken functions);
> (iii) other binary level transformations done by objtool.
> 
> Runtime testing: The kernel was verified to properly boot after being
> compiled with -mibt-seal (+ LTO).
> 
> Note: This feature was already submitted for upstreaming with the
> llvm-project: https://reviews.llvm.org/D116070

Ah nice; I see this has been committed now.

Given that IBT will need to work with both Clang and gcc, I suspect the
objtool approach will still end up needing to do all the verification.

(And as you say, it has limited visibility into assembly.)

-Kees

-- 
Kees Cook
