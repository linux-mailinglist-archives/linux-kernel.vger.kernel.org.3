Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC63451C569
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382071AbiEEQyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiEEQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:54:09 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A48921E11;
        Thu,  5 May 2022 09:50:25 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 245Go94j025108;
        Fri, 6 May 2022 01:50:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 245Go94j025108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651769409;
        bh=ygzkm43GrcDzhqnHIxLfBnu2vDnA92BUs+zoxtrNQp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rHlaH4vwxLfb6tf78FehbMA1mQ3g8XT18MOjx/BJwxbFFxQ1YA9zYdtWsfDchs3Ih
         CahvCWRRVGYUbjywaxHySSdky4cSBGE8SCjVlC6NKC0ytB84sGI+4F0/MvmGEg0j7P
         YRHRTM3JRNsgchINBv4VRhAbX8IE5L4F3v1/8Onkf7/5jet3veyQNovYi8deOW/cck
         RYzG5jNHNvAKotdWOSSgIRno8+HGyvEBY3FstpdKlOO/lESOG5gLeDU6kn0hRFhgDx
         xJUvl8jSXKth7RL2k9/i4vp52l8QIZxgXvEkZXiE9uvN5TFV9YodefmG8QUqhEXWho
         pnD19iFso237Q==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id x18so4932728plg.6;
        Thu, 05 May 2022 09:50:09 -0700 (PDT)
X-Gm-Message-State: AOAM532b8AVI/U8ntLfgbHjBml/LGdAz6ZUudHsNTvwC6R7LDzyVe35M
        t0LFyhOjJy5C10vORdhkAhZPVPvjcy1CTlJeKJY=
X-Google-Smtp-Source: ABdhPJxFVg1PsB/pcXjIvUrAmLyyIQeQ5R29SzsliD7Nd4EgMkoKbYvt+QAlfLIfjHz1WUxVGwqiQnWQOB1ShcOtmY0=
X-Received: by 2002:a17:902:7891:b0:15e:cae9:7620 with SMTP id
 q17-20020a170902789100b0015ecae97620mr8573800pll.136.1651769408445; Thu, 05
 May 2022 09:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 6 May 2022 01:49:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnCOKcbFXDY2Qik=6AJ31fQLKO+NW6fD-xY-muV5UQ-A@mail.gmail.com>
Message-ID: <CAK7LNATnCOKcbFXDY2Qik=6AJ31fQLKO+NW6fD-xY-muV5UQ-A@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS)
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-um@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 4:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This is the third batch of cleanups in this development cycle.


This series is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
lto-cleanup-v3








-- 
Best Regards
Masahiro Yamada
