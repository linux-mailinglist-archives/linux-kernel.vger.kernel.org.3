Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA45AF11D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiIFQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIFQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:51:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0265C9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:37:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bz13so12901572wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WRgBEaIROkHsbqiLlLVtVzNIxvB4btETvriIqS02JBs=;
        b=c/WmjlCUYq1ys/R+jL2BkRWKajrLG75nP/QpHOGP/F4RUOE9Wro0OHtQGszgM9qRxe
         z7XZNr8bx59b/9CA4wyaEyOR2YINjDjJxNcB65KBmMKvBqXCPXTW2L9cx6bciaZuCJri
         7ZYUGedlXxcUD+9LCca5qPIwJS8eUr2Quor7dnjqsHIhngJkjIO9teu9XnGxAFjMNjbK
         /ZMzcEeE5ugVdU+JjJ28ESULuPjj22Xzb7YrNyZ9y9In2MQ8VXyv2RYAqZfIGCyu506W
         xz+B9vLCZP2DbatepAHSUKYw2j5Quxt4TcQP8xGb1BK6rwX7U1b6N+r2qMEnMQ9Ugjj3
         xfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WRgBEaIROkHsbqiLlLVtVzNIxvB4btETvriIqS02JBs=;
        b=ViSaIMi7kA3CM6KnAB1xecnJ0+JxHR0PPpLyIdRKKFfat6bVNaVL11pl4FW4zcG3Bu
         1saw5Y+kVLc0C824aFoj2SNJBCDMRq7XBe8vXdJwqVJr6l0WIFCoiByABKCqUBB8yJNI
         2tiBWBOP+CZmS0gGRN0sLA2PFFVllwIwynqIbPfxqpVbhqHZ3biQOus/OBHt16ajFXJ9
         fNu+XsZvfdibySOFolbgzNWcejvM0ZD5fMVpijsM9lgyiEArKR/crnP7VcFmUNgYMOkS
         Ng4oAlJvlrpMF4d+9V+VPyl7OiaiELr1t10cKc867rJ/oO24e72JPMgZkpKOH8T7yHy8
         +rYw==
X-Gm-Message-State: ACgBeo3NC67e6hen9PP2eofl8PokdfIUxhEdRZ62CYFMORAHxQx3y3YY
        gv8kDY7vfA/p/l8XETOHQX1KBbVSs+zGE9pwDYpjuA==
X-Google-Smtp-Source: AA6agR67CPRfwhYa2E4op20iW4ujRDkrian2fe9S1zq0GPYV1G/fFR7+F7OSOdLlRVeqDFPy8n8ljAbn8oGE6inT9C8=
X-Received: by 2002:a05:6000:10cf:b0:228:df93:a9b1 with SMTP id
 b15-20020a05600010cf00b00228df93a9b1mr18470wrx.4.1662482275344; Tue, 06 Sep
 2022 09:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220902204351.2521805-1-keescook@chromium.org>
In-Reply-To: <20220902204351.2521805-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Sep 2022 09:37:44 -0700
Message-ID: <CAKwvOdmMhTdkpA5pOrkDkyRB6O6Y8mw_s2JbqvBS3r12BCMQyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix FORTIFY=y UBSAN_LOCAL_BOUNDS=y
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Fri, Sep 2, 2022 at 1:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> With CONFIG_FORTIFY=y and CONFIG_UBSAN_LOCAL_BOUNDS=y enabled, we
> observe a runtime panic while running Android's Compatibility Test
> Suite's (CTS) android.hardware.input.cts.tests. This is stemming from a
> strlen() call in hidinput_allocate().
>
> __builtin_object_size(str, 0 or 1) has interesting behavior for C
> strings when str is runtime dependent, and all possible values are known
> at compile time; it evaluates to the maximum of those sizes. This causes
> UBSAN_LOCAL_BOUNDS to insert faults for the smaller values, which we
> trip at runtime.
>
> Patch 1 is the actual fix, using a 0-index __builtin_constant_p() check
> to short-circuit the runtime check.
> Patch 2 is a KUnit test to validate this behavior going forward.
> Patch 3 is is a cosmetic cleanup to use SIZE_MAX instead of (size_t)-1

Thanks,
Testing out patch 1/3 against Android's CTS:
https://android-review.googlesource.com/c/kernel/common/+/2206839,
will give formal signoffs/review after a completed test run.

>
> -Kees
>
> v2:
>  - different solution
>  - add KUnit test
>  - expand scope of cosmetic cleanup
> v1: https://lore.kernel.org/lkml/20220830205309.312864-1-ndesaulniers@google.com
>
> Kees Cook (3):
>   fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL
>   fortify: Add KUnit test for FORTIFY_SOURCE internals
>   fortify: Use SIZE_MAX instead of (size_t)-1
>
>  MAINTAINERS                    |  1 +
>  include/linux/fortify-string.h | 29 ++++++-------
>  lib/Kconfig.debug              |  9 ++++
>  lib/Makefile                   |  1 +
>  lib/fortify_kunit.c            | 77 ++++++++++++++++++++++++++++++++++
>  5 files changed, 103 insertions(+), 14 deletions(-)
>  create mode 100644 lib/fortify_kunit.c
>
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
