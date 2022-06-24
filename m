Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3940155A141
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiFXSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiFXSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:30:02 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF777FD2;
        Fri, 24 Jun 2022 11:30:01 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-317741c86fdso32904987b3.2;
        Fri, 24 Jun 2022 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eoibeWra5s6gnCP+9Mmkq/WC/3r7V3AJCgLtaYuC/mE=;
        b=VJf+rCox2IpG7qcJ20g7NmG8hCN3uvuvWPZ+kUAOc/tYAlJLlLvgrjY3FYtqETkE31
         RKDQnNE67yTQMG/dZdsplZdT07dKmjsbrLlKIGUII/u3gfWz+FjSz1wsP3zUrlW763qq
         vIKUTwQJuR9Uec+BX0CYct97+wXVypeCyMeuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eoibeWra5s6gnCP+9Mmkq/WC/3r7V3AJCgLtaYuC/mE=;
        b=45tQR+RACLFLzG63+R5s5HZ+p6XEaY5VlgsGw1If+JnI+HT2qzfNgA6d4SdmifKkJT
         vmQ01M2RgSPvkpeqVG7QhTdxhp/hBz0vJ129Fs8T8CgT8mO6VCurv3aSBgtMaRp7NTuB
         NI0ObZm90Z4NhD1lETP1neYWmUMt0h5J6LUlEuLwOkJJNC9dDU/UZ8r8CgKkq/i+WjYe
         tFa2wqcW5HDwmvPrtH0AmFoTRpnYHJgVuWyobtLHV16D/fy90bP00GIP5nfKB+tnEUto
         6bcT6bndJ+DUhYUxj0ETADDjX26jFbzWi1T/r4U9/zCFHJQG3EA0PEjHeReyAl+xZ9OQ
         hz4A==
X-Gm-Message-State: AJIora+zYj0JXfFAHiaDEoycquO6A9jvMZ/S8qEZswznk9HGVtLlgByk
        VCC1VHeTrcA7Rlrtj4PhHBdHX8+1XHOb5z6jR64=
X-Google-Smtp-Source: AGRyM1uKmmRLJi1FF1ixJrF8xaXrDOETqtDM+N7saLf6pL9NzQbyKivl+aTQjocIyQqTkudGd/rAYY+QD6zYgiWawms=
X-Received: by 2002:a81:6c49:0:b0:317:8acd:b8d4 with SMTP id
 h70-20020a816c49000000b003178acdb8d4mr237828ywc.183.1656095400227; Fri, 24
 Jun 2022 11:30:00 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <linus@linux-foundation.org>
Date:   Fri, 24 Jun 2022 11:29:49 -0700
Message-ID: <CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
To:     arnd@arndb.de
Cc:     bigeasy@linutronix.de, chris@chrisdown.name,
        dmitry.torokhov@gmail.com, gustavoars@kernel.org,
        john.ogness@linutronix.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        mikoxyzzz@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        oleksandr@redhat.com, quic_eberman@quicinc.com, seanjc@google.com,
        tglx@linutronix.de, vbabka@suse.cz, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23 at 7:27:29 PM  Arnd Bergmann <arnd@arndb.de> wrote:
>
> This probably also needs a dependency on !COMPILE_TEST so we don't
> report compile-time problems that are specific to -O3.

Honestly, let's just remove -O3 entirely.

Enabling it, and then not even build-testing the result, is just about
the *worst* possible case. That's just horrible.

The argument that "but ARC uses it" is not an argument. It was always
a bad argument, and ARC needs to just fix whatever it is that made it
an issue (likely already fixed with a compiler upgrade).

And there is no way I would ever accept this as a "let people try it" when

 - as mentioned, just use KCFLAGS=-O3 if you want to

 - -O3 has a *loong* history of generating worse code than -O2

so I will *not* be taking these kinds of patches without some very
serious explanations of why -O3 has suddenly become acceptable again.

Those explanations had better be more than "let people try". They
should have in-depth actual performance numbers for a real load, not
some made-up "bigger is better" logic.

                 Linus
