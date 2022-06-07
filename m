Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B2653F843
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiFGIfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbiFGIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:35:27 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B601E3FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:35:25 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2578ZA7P009344
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jun 2022 17:35:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2578ZA7P009344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654590910;
        bh=XqJJ4gKzmON5UIGCBtOiM/fZFwpcJiC1fS3jys6RKvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jCf2OS0YBc+ammF3V9tquBfI7+MHWTPzFlX/sugHAwcNKGAJM4dnWPUIFaJ8nTyqd
         DlhRCVundLFFZGa2VC2wwVyoej0ZoP283Hk/pO9OVvjqojr0r0Jd5/N62FsWqxKx6U
         WiYYlkN+GlOX5wUMhy9Bw6fmupGrjffZHzGKbn+Da5BYP84efDS3UsTzgl6Immaj9V
         MlU/8FGpYbDlT77+TgzWXTiim3KJ2UH7NgJm8hfLmIFov3qSaDluWniYc/Cd/CBovc
         9bH8bEJTAaSNb+NkoeTRzVZ/k5E8gnCZNEFUJ68Fn0pqYSchP26qSIrquRAi8p4M2u
         7hNCSSHYvuHmg==
X-Nifty-SrcIP: [209.85.214.170]
Received: by mail-pl1-f170.google.com with SMTP id d22so14229427plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:35:10 -0700 (PDT)
X-Gm-Message-State: AOAM530aJlK1wNRfk5zt9JmDcgdBKBYVj1jNUZHLNqugIqjMKX+Cmc2O
        +3lN2PZQNT0dNZvWUj+LbvZKgvv8Y4p0Kmp9gu0=
X-Google-Smtp-Source: ABdhPJxXVlr3lifCLv5qwQFA6JmC4S3X5zhsXAj8emMXGj5UdxPjeWAiIrbYok/A/ki0b1j/Vdxbgs/z4RQysaweLL4=
X-Received: by 2002:a17:90a:9b08:b0:1e2:837f:bcce with SMTP id
 f8-20020a17090a9b0800b001e2837fbccemr30986349pjp.144.1654590909598; Tue, 07
 Jun 2022 01:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <62ba96a2-0a0c-ab8e-351d-398f31a880ae@I-love.SAKURA.ne.jp>
 <ce0b0a88-f8cb-ba9c-8a0e-1a818f8c50e0@I-love.SAKURA.ne.jp> <8af7aebf-61ae-f126-57fa-8ff358c1841e@I-love.SAKURA.ne.jp>
In-Reply-To: <8af7aebf-61ae-f126-57fa-8ff358c1841e@I-love.SAKURA.ne.jp>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Jun 2022 17:34:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREqTb=Y08R-jX8mNZoTmEYt_6WrUrP+U2oZQk2tT9kBg@mail.gmail.com>
Message-ID: <CAK7LNAREqTb=Y08R-jX8mNZoTmEYt_6WrUrP+U2oZQk2tT9kBg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: fix build failure by scripts/check-local-export
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 7:13 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> scripts/check-local-export fails with some versions of bash.
>
>     CC      scripts/mod/empty.o
>   ./scripts/check-local-export: line 54: wait: pid 17328 is not a child of this shell
>   make[2]: *** [scripts/mod/empty.o] Error 127
>   make[2]: *** Deleting file `scripts/mod/empty.o'
>   make[1]: *** [prepare0] Error 2
>   make: *** [__sub-make] Error 2
>
> Avoid use of bash's built-in wait command, by saving the output from
> nm command into a temporary variable.


This patch does not work because you did not avoid
running the while-loop in a subshell.

It is well described in  this page:
https://riptutorial.com/bash/example/26955/to-avoid-usage-of-a-sub-shell



I will send a working patch with a proper commit log.

The part "Saving such line into symbol_types is fine because export_symbols
will remain empty." seems OK with me.
(I was searching for an elegant solution for this, but
I could not come up with a better one.)






> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 31cb50b5590fe911 ("kbuild: check static EXPORT_SYMBOL* by script instead of modpost")
> ---









--
Best Regards

Masahiro Yamada
