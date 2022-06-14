Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31DB54BD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358400AbiFNWI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352180AbiFNWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:08:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166D4EDF9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:08:52 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e80so10880577iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dGwyqQWqKQhUVZXocdLXxbcz5iYcIebggOB8F+Krxg=;
        b=FMnyQsbBTpfaI982a6MQ8uP9ByA2o3U8F3mrkPUXG5pAZOzw98y0CapM11N8zUSG0t
         99K7QlRSow8lJ80bPLWSV5/BAgHq/LkEyuiWY8Z5wDHKVa42NKERpzSJzXuvOlA7ZgtE
         PxlpozmA+LusYvnX5clXnPKnxVgZ/njUZPiWCIrJkhuGEkvmeeNlfHMHPyoLZGI7ljXB
         5d/9uZc5/9VAjp90jGCddlIt3tzsIzRkKWeHDudrnFvSmA+kUcVneI4x7FaSLKVfHR+t
         Lgq9/jNX/HxyW+K50bQGutQLKTOcIxdU2M1Zx7BDWn2VLhxHEPBklp1eztS5pV776hHS
         x0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dGwyqQWqKQhUVZXocdLXxbcz5iYcIebggOB8F+Krxg=;
        b=3TmKo6nGsHimh0W1hZY0Nq6eg3qnLGPfsSI3F3Lu5khv54h/zAM8WDp+739KbCQYEZ
         BhdfK/p4Q+2BJt5R/7T5+bGnNisOzkEVi4mrsyoBWG48XkYDVjbzcbzIY4VEt9a7tH2o
         n67C7YRQ4bLsRvVtieFH+FE2bNX9jZe6h85IQ5ZrByHAEpWl70MR+JB3vwd9YwdHNUlV
         AThUR6gNP9u33pTwXc91mp6+5Kv5V2lnyOLOjiJhMgLP7fw4LrdUCxhDDFEUS1Y/nbiP
         5oVSSoWmLKZFiJ9Zo0y4p3jRgLYt745puhvWQbIu06oW6053eGfNz+AFfswu2XuTKvbz
         35RQ==
X-Gm-Message-State: AOAM531YZgVFcXgkMuHKdvTgXGW8360czOg9c55McM4h/VJWi3TWjmxj
        +aUg68FCPK8rcVtMZ2Br6fJdk7rxC0fbUkGynMxjnQ==
X-Google-Smtp-Source: ABdhPJxXo8qyCxQNbUKgcqR58bxEuX/+dZOP2labZ9vMu4YcVrmdVsOc+ZJkU8X5BYEfYIw3TbCfn9YQ3wJcMy9Tkfs=
X-Received: by 2002:a02:a98a:0:b0:332:b171:df78 with SMTP id
 q10-20020a02a98a000000b00332b171df78mr4035478jam.54.1655244531923; Tue, 14
 Jun 2022 15:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com>
 <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com>
 <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com> <20220614214039.GA25951@gate.crashing.org>
In-Reply-To: <20220614214039.GA25951@gate.crashing.org>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Tue, 14 Jun 2022 15:08:40 -0700
Message-ID: <CAFKCwrjBjHMquj-adTf0_1QLYq3Et=gJ0rq6HS-qrAEmVA7Ujw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 2:45 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> No such luck: the passing itself already causes UB.
>
> GCC does not warn, it has already optimised the code to what you expect
> by the time this warning is done.  If you use -fno-inline it does warn
> for both "c" and "size" (via -Wmaybe-uninitialized).
>
> But it is still UB!  All bets are off, no compiler can do any correct
> translation of your program, since there *is none*.

Clang also puts "noundef" attribute on most function arguments in the
frontend, and the optimizer can assume that the inputs are fully
initialized. The diagnostic for this is very imperfect.

What Alex is proposing (the KMSAN option) takes place *after*
inlining, so it will only enforce the "semantically meaningful" case
in Linus's words.
