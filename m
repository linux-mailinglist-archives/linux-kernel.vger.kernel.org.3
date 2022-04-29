Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10F15148B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358831AbiD2MEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiD2MEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:04:11 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E313F54
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:00:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y76so14091618ybe.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sys1mXcuUo5inlRgrppSM5ckhVWyIVgcWrvJy246IoU=;
        b=a82BLgpcgQVaB4iv5+/oWXp4Zkq0/e/f0eS2hOInw/XGYO8yHFSVDaN24Fos1iFmii
         EjviGHi1+YZ013v+e6D3xxpLrWCjSNeAuLZUwKzv7CH04zYvxpkbJJtFN3NgnRqYUVKc
         S/5r+PN27MAuMMBlDAUIpufSD2kkDd6fZiH5CRMfFSVdG//9OdVhfGK07o7DT3UZ3+6O
         0mJmct3CgOvjGcPa+3k0rugY6vt3+7R7ukvCn4yI/5DMbv8amtv26FWqxkCRDFk4bRmh
         lOQaHC8yFwY3WM8IQjeqvqYgzhqFr+eCSh7Za29Hi+GFKuE8q/ROjRLM2RDvJySIjd9C
         FAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sys1mXcuUo5inlRgrppSM5ckhVWyIVgcWrvJy246IoU=;
        b=VMeYJuff0cVd9g9XeABGC+IL/YF8Lxd9R9ruNOO2sfdVf1/Iry0hdiRB9ff8Eiovtl
         W6bZRa/PuiuyCH/wfAE38+nEq+uRCYrFPdkeyCAW2DoX1Irus+MlQHfuo/OK2oTaGZOr
         VJSPN2Pc1XBS57Cxr4lJ2RR1JDsdI3Vu1dKWr4sbLoLlBAnc5vkTeUN08NH82IAfXESx
         g3s8PuT/rY38/RR5LV7+crWetrx8yWlni6oieSgU+H/sVa2ISdN//ay90IlQzbj4Pq8T
         xDUKBylfT84Zi9u4Ojp2itdzAG6LA7lgwBPJhVGJk010vsMq1WO3q+K48xr294pKRCln
         DlAQ==
X-Gm-Message-State: AOAM531DrmuPRayGKwtwy6s8pTtvW1U/9Nfs2ZgB9cwhLNO1V8QVCi60
        jOFltO/K0fYUo+I8eB6PwCimP98JPvTXVGi/xvs=
X-Google-Smtp-Source: ABdhPJwcP/Uh86o9nnEcGL8JOPixV3ERZhwfr38PefcY8ZLW+l2vZsrutpmgTqxZGPbDyyretWURiC87P4jrcgztCh0=
X-Received: by 2002:a25:830e:0:b0:648:3d73:e414 with SMTP id
 s14-20020a25830e000000b006483d73e414mr27756988ybk.552.1651233648242; Fri, 29
 Apr 2022 05:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220429091301.GR2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220429091301.GR2731@worktop.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 29 Apr 2022 20:00:37 +0800
Message-ID: <CAJhGHyBUzURTBBnkO5c5xRC+c9+KFvLXw06h5uQ7gODeiSR-QA@mail.gmail.com>
Subject: Re: [PATCH v3] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 5:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Since the upper regs don't exist for ia32 code, preserving them
> doesn't hurt and it simplifies the code.
>
> If there was any attack surface on this, that attack surface already
> exists for INT80 and needs to be otherwise dealt with.
>
> Notably:
>
>  - SYSENTER: didn't clear si, dx, cx.
>  - SYSCALL, INT80: *do* clear si since the C functions don't take a
>    second argument.
>

If CLEAR_REGS for SYSCALL, INT80 clears si, it is better, IMO, to
make CLEAR_REGS clear si unconditionally.

SYSCALL, INT80 will explicitly clear si via calling
syscall_enter_from_user_mode().

But some handlers called from the macro idtentry don't clear
si explicitly, although it is likely to be cleared.

So if %rsi is a concern for SYSCALL, INT80, please make CLEAR_REGS
clear %rsi unconditionally.

Thanks
Lai
