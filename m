Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0CE530E27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiEWJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiEWJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:23:10 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA621AF3F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:23:06 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id q135so24310655ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSdESsXQYczC4k5qR6EUhoG55XqgQrQ395OHEw3icQs=;
        b=Pi4LW90U1ShTzGmDT8SQ/xibhk2aC2q6v2wGZ975dtuViGwyrXikIW8b+JdJbC99mf
         mDcf2tHMSFEeUr7u6c8yBuEL+mXJ/x1lkPQbi3ElWtrxayU2jOaRxCjIYvBBigLpxBqe
         +ZNJabHY003bTYMx0kOceRcai2d9GfP1wtbnRo0d2YsEv5D2ciRURu/IT1zunA2YPkVQ
         IaNuekRLYDTCm55r2QVVQO0GBEcFxqj1CbT1yQvr7cT5W3xWBy5qqxkorTCbiyiznYO4
         BgotvFSYKq8MLuI6EGAJU/0C5oRTS5pHFdqsE4vEwJD+zPOcFXB7N2+7pC8sSAUCq964
         yLrQ==
X-Gm-Message-State: AOAM532n+s9B/dc1l2jov+ABJP+AkUpFAbNQQBno5Goma4ce5E1rupoM
        G0kOn0u0p3peEXvH/7fRE9zR32VFywuoYbRNVCY=
X-Google-Smtp-Source: ABdhPJyy8YU4QNP8+S3euZ1cip0Al7OTJHjUcN2ZpHTMyltrNjuzU9LvTTPZtV62bLbOXw9bFGPm+tKQq9FLJrOwEKI=
X-Received: by 2002:a5b:491:0:b0:64a:f42f:6973 with SMTP id
 n17-20020a5b0491000000b0064af42f6973mr19994401ybp.20.1653297785863; Mon, 23
 May 2022 02:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr> <20220512011855.1189653-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220512011855.1189653-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 23 May 2022 18:22:54 +0900
Message-ID: <CAMZ6RqL-GBDW1f4=eE_N+jaBjSnD7A8kG_XsNjyvcp94M2Ok3g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 12 May 2022 at 10:20, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> The compilers provide some builtin expression equivalent to the ffs(),
> __ffs() and ffz() function of the kernel. The kernel uses optimized
> assembly which produces better code than the builtin
> functions. However, such assembly code can not be optimized when used
> on constant expression.
>
> This series relies on __builtin_constant_p to select the optimal solution:
>
>   * use kernel assembly for non constant expressions
>
>   * use compiler's __builtin function for constant expressions.
>
> I also think that the fls() and fls64() can be optimized in a similar
> way, using __builtin_ctz() and __builtin_ctzll() but it is a bit less
> trivial so I want to focus on this series first. If it get accepted, I
> will then work on those two additionnal function.
>
>
> ** Statistics **
>
> Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> of __ffs() and ffz() calls (details of the calculation in each patch).
>
>
> ** Changelog **
>
> v3 -> v4:
>
>   * (no changes on code, only commit comment was modified)
>
>   * Remove note and link to Nick's message in patch 1/2, c.f.:
>   https://lore.kernel.org/all/CAKwvOdnnDaiJcV1gr9vV+ya-jWxx7+2KJNTDThyFctVDOgt9zQ@mail.gmail.com/
>
>   * Add Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> in tag in patch 2/2.
>
>
> v2 -> v3:
>
>   * Redacted out the instructions after ret and before next function
>     in the assembly output.
>
>   * Added a note and a link to Nick's message on the constant
>     propagation missed-optimization in clang:
>     https://lore.kernel.org/all/CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com/
>
>   * Fix copy/paste typo in statistics of patch 1/2. Number of
>     occurences before patches are 1081 and not 3607 (percentage
>     reduction of 26.7% remains correct)
>
>   * Rename the functions as follow:
>     - __varible_ffs() -> variable___ffs()
>     - __variable_ffz() -> variable_ffz()
>
>   * Add Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> in tag in patch 1/2.
>
> Vincent Mailhol (2):
>   x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant
>     expressions
>   x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant
>     expressions

Hi Thomas, Ingo and Borislav,

Are there any chances for you to pick those two patches during this
week's merge windows?
https://lore.kernel.org/all/20220512011855.1189653-2-mailhol.vincent@wanadoo.fr/
https://lore.kernel.org/all/20220512011855.1189653-3-mailhol.vincent@wanadoo.fr/

Thank you!


Yours sincerely,
Vincent Mailhol
