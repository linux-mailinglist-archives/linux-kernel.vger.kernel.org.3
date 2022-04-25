Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8A50D94D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiDYGUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiDYGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:20:44 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB528989
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:17:40 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id r189so25215270ybr.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCtKQYSTps0VrLDUq04agqNEXmphYahJ7hA7Tsk3PTM=;
        b=y87zLxXLd7YWRCsK5HoU9vnzAOjFhAz4Uu2o+I3q65DqAb6PYR97pM/VYKPZQdZH9m
         t6HqzuAVlEtKaDPX08wNGQRjc9aM+h+FIIFZL75IFD+R5u7ly6t0yTchtwIabrQtMi94
         MfLDqq8xC2lyjorgn8wF7yPfp4LXEXF6OvVCe4ZrZidf45eJ6m6d55OggzH6qpcRsWhD
         +GPSiY8OKR9YhmDFT2m44DTNVEYaTlHmgX5ZhSFRyri/JxJ4mAkBPbalTKdhDUxN2Z+f
         +gJC7CWEZmqrC1fx2gLpSqSgqPH7GrzGavmHQY0b9Ot2PmqSLuQ4d05wUQ9ANTUxGVVV
         yqVw==
X-Gm-Message-State: AOAM530UdEhESrDvRzTbsty/ZsPXmbgtnG0PugBKJdC3250qOJ83qOdA
        ZkBsL9HZ670IK7U3m93w5qcJjxeat+nS03LMyvs=
X-Google-Smtp-Source: ABdhPJwZwQAaQ5egYyYjlBDWprpUmMiY8C08pHkGK7L97GUxtWa3ijJqZPpDBUDSxZiWSdAjFcDdwIhK2lar/ppEDE0=
X-Received: by 2002:a25:76c6:0:b0:648:5616:ca50 with SMTP id
 r189-20020a2576c6000000b006485616ca50mr4091431ybc.423.1650867460065; Sun, 24
 Apr 2022 23:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr> <YmXMiTXEvFXZ/swU@dev-arch.thelio-3990X>
In-Reply-To: <YmXMiTXEvFXZ/swU@dev-arch.thelio-3990X>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 25 Apr 2022 15:17:29 +0900
Message-ID: <CAMZ6Rq+3XOze01dZZRTe+V44N2uo5J_=rtd9bKH7d7Fq9sNxVw@mail.gmail.com>
Subject: Re: [PATCH] checksyscalls: ignore -Wunused-macros
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
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

Hi Nathan,

Thanks for the comments!

On Mon. 25 Apr 2022 at 07:17, Nathan Chancellor <nathan@kernel.org> wrote:
> Hi Vincent,
>
> On Sat, Apr 23, 2022 at 12:17:25AM +0900, Vincent Mailhol wrote:
> > The macros defined in this file are for testing only and are purposely
> > not used. When compiled with W=2, both gcc and clang yield some
> > -Wunused-macros warnings. Ignore them.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> The change itself looks fine but a couple of comments:
>
> 1. Nick and I do not pick up patches, we rely on others to do so.
>    Additionally, this is not really something within our domain, despite
>    what get_maintainer.pl might say. This change should be sent to
>    either
>
>    Masahiro Yamada <masahiroy@kernel.org>
>    linux-kbuild@vger.kernel.org
>
>    or
>
>    Andrew Morton <akpm@linux-foundation.org>
>
>    so that it can be applied by one of them.

Ack. As you pointed out, I indeed just followed get_maintainer.pl.
I will resend a v2 to the people you pointed out (and exclude you).

> 2. I am not sure that silencing warnings from W=2 is that useful, as
>    they are unlikely to be real issues. Not to discourage you by any
>    means but it might be more useful to focus on cleaning up warnings
>    from W=1 and getting those promoted to regular build warnings.

Normally I agree, but there is one reason to fix this W=2: this
warning appears when building other files.

Example:
| $ make W=2 drivers/net/dummy.o
|   CALL    scripts/checksyscalls.sh
| <stdin>:21: warning: macro "__IGNORE_stat64" is not used [-Wunused-macros]
| <stdin>:22: warning: macro "__IGNORE_lstat64" is not used [-Wunused-macros]
| <stdin>:75: warning: macro "__IGNORE_llseek" is not used [-Wunused-macros]
| <stdin>:159: warning: macro "__IGNORE_madvise1" is not used [-Wunused-macros]
(rest of the output redacted).

When I run W=2, I want to only see the warnings of the file I am
working on. So I find it useful to fix the W=2 warnings which
show up when building other files to not get spammed by
irrelevant issues and to simplify the triage.

My initial message lacked the rationale. I will add additional
explanations in the v2 of this patch.


Yours sincerely,
Vincent Mailhol
