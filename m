Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304B592626
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 21:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiHNTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiHNTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 15:17:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433B1EAF1;
        Sun, 14 Aug 2022 12:17:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a9so8026707lfm.12;
        Sun, 14 Aug 2022 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oukTcdqzxgCAnjn2sDzCBwJuwmACAodKDpY3pQUuT0U=;
        b=J7bIEbuVudtPdI/hR4Xn1rdk3oa67ILRAFG+q/ZGHEw3mMFmf3WNOwTZW7a2tEh5wh
         wRV7d/+MpE2cZtevWn5ESDf1EklvMksCsiGNYlU5rqXrW13wy7554Lwsq+T5L+QNUgNA
         nCD7OohbUdZ6+PNZOzDRHh5fEWzSg+k7ZXX20r/e1o7y4IlZvTG8gfuMuEQ9hh7mTlf3
         FLUbTGlpUBpUKsISBXv88YiloEy4x9WzPyE4utdC3rlBbgbhsuPS8ID6B7BvTEKrv1Vk
         /bzWGT8K25PV5gfSIauc175T0AAAVsHRkIr/p+vTR5+ALEAa/SiRfC2Eb6TCaFSIYU8r
         FsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oukTcdqzxgCAnjn2sDzCBwJuwmACAodKDpY3pQUuT0U=;
        b=FdeCnQ2jWvg0bA46DCdUa/AixP7Rn+9KDY6A8qIxxfXoT2iBICZigXMlBVEa3QOCQH
         m49DFKnsJkGjASAj5pQB+WlyAaRQnEWt/EQc0+K0MppqNQHUF3AEFeIQsbL63iGjgKdg
         iEhsnJFB5gYoKY0Skpjxzn15vf7unsZC/QGaY/z5c3TP6PphglWsOX185sx10BALqiZ1
         Ci4hUAJu9FyAblocR0WGgVJJ1/0BmZ7F6kDEtFhYE5jnJ3jcZ9Rd/ihFdy4jh05KMNlj
         T6sp8Pr/D0ja9tXnH4oC9uD63iaWxz8EmK1L80QzvoXsiVcRQGPo6iqPUZjTWBcs+QEs
         yG6A==
X-Gm-Message-State: ACgBeo2RQ+daDyKIrebvfPMZ3ANnFV6bu9RqgqBc+2LjVzGrJysI00TK
        e1lUjapGP9GyFGpYNAK0RfcLdwqUP+XAZyzQw7Y=
X-Google-Smtp-Source: AA6agR5lEs957kyDbgOIqG1MIpncRpQ3CkOC5UtQ2qH+LWabYyVdspMDAs3Of/uQp4aVzTL6Y6FDkR9PudBWM/q/vqc=
X-Received: by 2002:a05:6512:4016:b0:48b:1e96:af0f with SMTP id
 br22-20020a056512401600b0048b1e96af0fmr4706968lfb.359.1660504671280; Sun, 14
 Aug 2022 12:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220814002021.16990-1-dmitrii.bundin.a@gmail.com>
 <CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com> <20220814053124.fsj3bqamrqyfoiey@google.com>
In-Reply-To: <20220814053124.fsj3bqamrqyfoiey@google.com>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Sun, 14 Aug 2022 22:17:39 +0300
Message-ID: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add configurable debug info level
To:     Fangrui Song <maskray@google.com>, masahiroy@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We already have CONFIG_DEBUG_INFO_NONE to
> disable the debug info.

Thanks for pointing this out. Indeed providing another way of
disabling debug info does not look reasonable to me.
So only it makes sense to set only 1, 2 or 3 debug levels.

> Using 'int' does not look sensible to me.

Could you please give a hint why?
My intention to choose int was to provide a boundary with range on the
DEBUG_INFO_LEVEL option to choose only acceptable ones.

On Sun, Aug 14, 2022 at 8:31 AM Fangrui Song <maskray@google.com> wrote:
> In Clang, -g = -g2 = -g3. To generate macro information,
> specify -fdebug-macro.
Thanks.
I would propose to add another config option like
DEBUG_MACRO_DEFINITIONS to turn on macro information for GCC/Clang.
For GCC it would be -g3, for Clang -fdebug-macro.

> Before GCC 11 and Clang 12, -gsplit-dwarf implied -g2 (older
> -gsplit-dwarf is like today's `-gsplit-dwarf -g2`).
>
> GCC 11 and Clang 12 (https://reviews.llvm.org/D80391) have changed
> -gsplit-dwarf to not imply -g2.
>
> For a group of -g0 -g1 -g2, the last option wins.  Therefore,
>
> -g0 -gsplit-dwarf => debug info in GCC<11 and Clang<12
> -g0 -gsplit-dwarf => no debug info in GCC>=11 and Clang>=12

I would add a note that when selecting -gdwarf-<level> gcc also
implicitly sets -g2 (at least in older versions).
It seems reasonable to me to put the DEBUG_LEVEL_INFO setting at the
very bottom to prevent it from overriding implicitly.

What do you think?
