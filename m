Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E352417F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349650AbiELA2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349641AbiELA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:28:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A4F18C06D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:28:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p10so6271356lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2ws23UBcUn/cg2bNLq1AZlNJZpHLdEd3cBqMWxwPHE=;
        b=ImISWlaf/fsowhzZ+LUJhuc8wWq73oxuQdC8Jg+B/b6IgYMhQ+3HwaaCLhndMaU1x7
         EuPSVxwcUYtxvoBKntk8Y2fvl4eouOdlxJiJMNqn8wY4VRZQ6OUOYpvY+t0N9xeqONMh
         KNJ+Tlr63HkniBbjUvrauMRJxeLp/M/HN/hyFZCgFxYcwFWXO7/GPoCvm166Eqg/xygR
         3o7vQxh9/hgWog03zMK4N+VacdMrpJ8oqnjmQS3Y+b5uuxIl806in1JBQRCIBenaKuV6
         lp7MArZYE5UiHGzCLgLeUxhVrq8O7wFXBKuvFuhER5KXbI1LYd5DY/gh+zzz3O7hVges
         0gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2ws23UBcUn/cg2bNLq1AZlNJZpHLdEd3cBqMWxwPHE=;
        b=WddMhxVad7XRHQO1XOZeUj7rnw1GHiTsRiW2qSV9P57z+M/zsk5gzMzW8tQCEm4WvJ
         P6dJR1Km8f/VbGRHBmhQ+Hfm8xZQgaEAmy8nRLb1b7OkaV3Ui68948C295EYNDaHBfP1
         RaVS7+LnqFh3DwUdpr7kTtun57/E+I4RbzXzh4hhOZawQSgZE+gyTDmum8ABwdj97s14
         7kx5/uc2f8zn+7sBWs2CD7r3zwBlLNITw9lYA3wUfDg2Kf5PynnvAU5k/5OOphxpsBpy
         xQxPci8nWP8M4qazte+IMVLa6j/ncqUoVXajnmyWc9zCuf9rh6EaO/AUspevKmeoZ0oR
         fjew==
X-Gm-Message-State: AOAM530Ucv1gr4Iu9olt2OnwqFJZx6UTZ27/69yTvTmv39fNYQ1tYVqo
        OCS/7U6sFWJtHac4ah8t4qhLlhCEFHvaeeJRogptJg==
X-Google-Smtp-Source: ABdhPJxZTVXxFfY2MEayuNV9TOxNJm0RpADQb0nB7hh1xfftZ6O9193T3hSRc29a+ayd2kJhGIgVP9PfwL4JI+Y+GFI=
X-Received: by 2002:ac2:5e86:0:b0:473:d044:60f5 with SMTP id
 b6-20020ac25e86000000b00473d04460f5mr22047290lfq.87.1652315298341; Wed, 11
 May 2022 17:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220512000340.1171988-1-mailhol.vincent@wanadoo.fr> <20220512000340.1171988-2-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220512000340.1171988-2-mailhol.vincent@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 17:28:06 -0700
Message-ID: <CAKwvOdnnDaiJcV1gr9vV+ya-jWxx7+2KJNTDThyFctVDOgt9zQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate
 constant expressions
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>
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

On Wed, May 11, 2022 at 5:04 PM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> And finally, Nick Desaulniers pointed out in [2] that this also fixes
> a constant propagation missed-optimization in clang.
>
> [2] https://lore.kernel.org/all/CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com/

Regarding
https://github.com/llvm/llvm-project/issues/55394
it seems that functions with static linkage cannot be considered
library functions, so libcall optimization will not run on calls to
them. So the compiler might be able to do a better job for constants
if ffs() and friends indeed were not defined in a header as static
inline.  But that relies on the compiler knowing these tricks; I think
the kernel's approach is just fine (better in fact, because we should
inline these tiny functions, regardless of LTO), but like this series
shows, there may be room for improvement for other functions within
the kernel that are defined as static inline in headers that are
normally found in a libc.

So I no longer think there's a missed optimization here, but at this
point, it's not worth a respin of the series IMO to just let sleeping
dogs lie.

Unless the x86 maintainers wouldn't mind dropping that line and link
when applying?
-- 
Thanks,
~Nick Desaulniers
