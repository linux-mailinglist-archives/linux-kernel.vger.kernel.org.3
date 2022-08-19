Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD959A4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349681AbiHSR6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350559AbiHSR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:57:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0DAE9CE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:42:20 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so3327333lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5Ba40ee6mdV3GLMe4cToIGO5iaIyAuSfJaWNy2z3RjA=;
        b=b9TOPh+GL55mFPaCalx5Qcpbj1gHR2dCIb4yq1YkHkXNAtRboaXo4RCrWm5NmcC7Xi
         B+jOh6+l/W5y70P2g7As3UAoNYQa4y6LW6/QDWA4ERfJJw74xOjNpqLOEYS56sXS/O9D
         pM2gTo481VfmGSTscHu3QOEDkXyI6k9ArMW2kC9/thl3WF2SGCgieIdtudrc9Po9pkYy
         +mEy1EOeckIzqVgJm89jcjCStC5l+/PRRvMNBz8zSQtBdJ9vlMW9n1dgygPBfcTSAUSE
         IgP9PimYAbcYfA8abmfhblys7sFndp1s5ZsqNI02Ykmunr2xWkuT6Lf79dvBVGEiyGsV
         7xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5Ba40ee6mdV3GLMe4cToIGO5iaIyAuSfJaWNy2z3RjA=;
        b=AEIGfnQ61sZBcmCHtcHCMXx+28mkDgSVXlttd2IVbnLADXdbi2jk5oiClEnJWLKm1P
         BmM17XdhV4zHJx2/mRUIjuBlOsHWy4h5qbBlcypUpL44Al+q3tUmc2wzfkc15749Tflm
         9NT68gGKifV5jpfio9NZvq2exRZnNaazsG8XGF6eQvfQer5pFTww5UuXPe7/9cymLx+I
         CrtuLrjkbVxiiTXxSKOS6G9zmjY5jo3e4qf5dHh172LB1mkvHkIWISu/6vwI6GB9zdXs
         7ClDZP+ET3a+j8r+EZD6XSJ6h80lXCxmLJijvgMZxir7SKlLaNsGz5RoB1kXIYsp1Arb
         S/Xg==
X-Gm-Message-State: ACgBeo0ieWdUsGVmesbw/r4VCBbYxNiQ0BFuhem1WCZ7zOXJsElRpMf5
        SpsjlGk/X/ItZrlOtB3nZGsWJHDXd1IJ/zIK2vyCVXbt2QbB+w==
X-Google-Smtp-Source: AA6agR5VXnlG7SrkweUZy5qPdAOtIIbEbto9U1pm0R6Ryl+A7t6+fG/bVeM0no9MFluCVMD1XhhlA4AEz9k7WRJe7Lk=
X-Received: by 2002:a05:6512:b01:b0:48b:a065:2a8b with SMTP id
 w1-20020a0565120b0100b0048ba0652a8bmr2649945lfu.401.1660930938505; Fri, 19
 Aug 2022 10:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com>
In-Reply-To: <20220815013317.26121-1-dmitrii.bundin.a@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Aug 2022 10:42:06 -0700
Message-ID: <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     masahiroy@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, edumazet@google.com,
        isabbasso@riseup.net, jpoimboe@kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, maskray@google.com,
        michal.lkml@markovi.net, nathan@kernel.org, peterz@infradead.org,
        vbabka@suse.cz
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

On Sun, Aug 14, 2022 at 6:34 PM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> Adds config options to control debug info level and producing of macro
> definitions for GCC/Clang.
>
> Option DEBUG_INFO_LEVEL is responsible for controlling debug info level.
> Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2. To provide
> a way to override the setting with, e.g. -g1, DEBUG_INFO_LEVEL is set
> independently from DEBUG_INFO_SPLIT.
>
> Option DEBUG_MACRO_DEFINITIONS is responsible for controlling inclusion
> of macro definitions. Since Clang uses -fdebug-macro to control if macro
> definitions are produced which is different from GCC, provides a
> compiler-specific way of handling macro inclusion. The option is handled
> after DEBUG_INFO_LEVEL since -g3 -g2 implies -g2, but -g2 -g3 implies
> -g3 and GCC uses -g3 to produce macro definitions.
>
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
>
> Changes in v2: https://lore.kernel.org/all/20220804223504.4739-1-dmitrii.bundin.a@gmail.com/

Is any of this really necessary?  It seems like a great way to bloat
vmlinux artifacts built with CONFIG_DEBUG_INFO even further.  The
above link mentions "when debugging with GDB."  In that case, please
don't add new Kconfigs for these; just set -g3 when
CONFIG_GDB_SCRIPTS=y.

-- 
Thanks,
~Nick Desaulniers
