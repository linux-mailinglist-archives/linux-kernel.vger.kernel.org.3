Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112CA510ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357188AbiD0CgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiD0CgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:36:15 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21ED65D08
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:33:04 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j2so1042815ybu.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owwvrF0Oneu6nUpGuZVDT8wMo7nPqE+euFwnhOXKaw8=;
        b=HfxvJuxf78ynuF6zYsj4rtEl0rclWd7X5RCCD+zsPA1/1PJzakIR5VvTs30fkwpOOh
         O4cyuUGnqdX8o0/4KTpqtv+ywlaMAKi82vslso+ckq0OXY/l25y8dzlUdkfKIlwuzdBL
         EqRunxTv8Jn18PyN5D+GfRS7FLT+c3ZapFw7++jNq8jh22IUZuAHMsh+MW0rSj7yRbiT
         Fl1O1a07hS4ONFDyomh/T94KSbYIfmOmr6HdEdXKjfsquEwxfbLkD806cHeksZVqtAFh
         4kd4CRHlHGeKRMrodAiJurm8X7/mmG2X9Tq2Db+guEHtcFr0BmiCdqhOIBv+vsRqt8io
         bijA==
X-Gm-Message-State: AOAM530vTUSjq9o3Q4C4vZZUQHCuBaVPWCqywnHfbhq2UwN6DxV5upSg
        xiftCgmifcpJvSGlxI7AwiDnsKtLlvaN9kNJ31Y9C9kajEdT0u+R
X-Google-Smtp-Source: ABdhPJz6Uz9nbm/kG+yQUwAK7MLSvb7ZRCvecPAJ4ukWVnzARsCQiTN5oYWQ68PVWMn/ofWBfan074KzQQoFZEbDAHA=
X-Received: by 2002:a25:df0a:0:b0:648:6364:a150 with SMTP id
 w10-20020a25df0a000000b006486364a150mr13101447ybg.381.1651026784126; Tue, 26
 Apr 2022 19:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr> <CAK8P3a2ZUfpWiHh6yeAy3fFP8k5BcE8crkis7Savxhdym1e-FQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2ZUfpWiHh6yeAy3fFP8k5BcE8crkis7Savxhdym1e-FQ@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 27 Apr 2022 11:32:53 +0900
Message-ID: <CAMZ6RqKdSET45pXLu9pTY4Weqxdpqmio5ca5M8f33uYPe+NPHA@mail.gmail.com>
Subject: Re: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings
 by 34% tree-wide
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 27 Apr 2022 at 03:56, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Apr 26, 2022 at 6:16 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>
> > +__diag_push();
> > +__diag_ignore(GCC, 8, "-Wtype-limits",
> > +             "GENMASK(size - 1, 0) yields 'comparison of unsigned expression in < 0 is always false' which is OK");
> > +
>
> Are you sure gcc-8 is the correct version to check for?
> If older versions had this
> already, you may have to add the magic bits in the compiler-gcc.h header.

Right, I used GCC-8 because this is what is available off the
shelf in compiler-gcc.h (and I CC'd you on purpose because I
though you might have relevant comments).

-Wtype-limits was introduced in GCC 4.3. Need to check if this
specific check existed back then, but I strongly expect the older
version to also trigger the warning.  It might take me a bit of
time to set up an environment with an old GCC (nothing hard, just
need to get access to the good machine). So do not worry if I
stay silent on this subject for the next couple of days.

Yours sincerely,
Vincent Mailhol
