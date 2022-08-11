Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216575908B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiHKW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiHKW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:28:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1E59AFDF
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:28:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y13so35824348ejp.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PAb2yvZK0Azo5fYoLsSkJfhNFnrLBlWmRLOEh1fEo6U=;
        b=Esms5UFKrq+sy3bMqEsnXEBAzrb1Z4PlxF4f1306MBOPocD9GZhkWOMGTMMWtP1ZKl
         yW5NJw9YfyBE/2nA7zZSAx3T6C/+J7LJdx+oGUQhIKFZXTIWU5yVxfIVwy01zjl2HbLM
         8urB3rWUKKGEL7AHHfqV/YUUOm3BcXCVKghgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PAb2yvZK0Azo5fYoLsSkJfhNFnrLBlWmRLOEh1fEo6U=;
        b=tpNntH3Ya6R7qptBFr5UO8J7plbbtkh9B2GlAFLwVQgsJTu2w/r8mxwS0N/Sg3fJbg
         Pv8nmb504GrpndxFUhgoe38X5Z+xBozA6kaJIZucPZ4pPH2M3MmY/QLUEEO6HpvR3YQy
         SD8iacqVugJfuYXsm/HXMyZw8/9c10FrAd4j0mM5Iphxe3qjOWho7Bgyj0Qzu7zuwDwz
         581TsGN+r7Yw3LzwskMSFmXXTJMcH8jDx89VpKy9Cbi+xtj71zOEpD6DES/t+Iy83lmR
         Iq4chEFf8a9s2anmQIWW2AmMHSqGQyh0GMa2BIi+XnozAmVPybcgriVlsXpAGjXQ5VFf
         L4wQ==
X-Gm-Message-State: ACgBeo1fF4YLmo7a9MSiD8eUi283fFmw6aWPAoy1FB0WR65jvbfDQ+FL
        EWL0CMXqC8K8mMBFoA36JVwUyqnOVjat0HuH
X-Google-Smtp-Source: AA6agR7AKKJvpaw3eYBLwaLzNzz6ZEXC/zOXtAQ1uevqYzEwMYyZW3CSsOf0/DRlnv2bFZrdqGZK8A==
X-Received: by 2002:a17:907:a046:b0:730:9c7a:eab3 with SMTP id gz6-20020a170907a04600b007309c7aeab3mr780607ejc.285.1660256909851;
        Thu, 11 Aug 2022 15:28:29 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0073100dfa7b0sm150757eja.8.2022.08.11.15.28.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 15:28:28 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id l4so22774196wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:28:28 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr500346wrv.97.1660256907686; Thu, 11 Aug
 2022 15:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <YvSxeDkmwxcJL+Z0@debian> <YvUZ+9kJ/AvUMxzO@dev-arch.thelio-3990X>
 <CAHk-=wivP4zipYnwNWCLF5cd24GLs3m8=Sp7M-CmmPva_UC+3Q@mail.gmail.com>
 <CAKwvOdnQjgtwqFXLv+QtWPfpHosM5fxE5oqbX0VUD53F8L6bRg@mail.gmail.com>
 <CAHk-=wgJA=e-CLcvU5LRKu0bMLeAewXtOM6as1hFVeQAVkMPbg@mail.gmail.com> <CAKwvOdkUc=8DD938in5PMeGYAn3PEWp4E_W8qEHq_y7Smy8+mQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkUc=8DD938in5PMeGYAn3PEWp4E_W8qEHq_y7Smy8+mQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Aug 2022 15:28:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW_LjFRE9wFMj-j2gp9=u8jqrMVZtT3n4-oJWtQ6E0iQ@mail.gmail.com>
Message-ID: <CAHk-=wiW_LjFRE9wFMj-j2gp9=u8jqrMVZtT3n4-oJWtQ6E0iQ@mail.gmail.com>
Subject: Re: mainline build failure for arm64 allmodconfig with clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 3:04 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Yeah, I guess adding a truncate to the caller is kind of unnecessary
> if you're still going to use %hhd anyways.  What are your thoughts on
> this bug I've filed?
> https://github.com/llvm/llvm-project/issues/57102

I really wish that bug report was about how *wrong* it is to warn
about that thing.

Sure, a cast adds pointless code to the caller, and is overhead, but
that isn't really the argument here.

The argument really is that "if you force the value to always be a
char, then %hhd is pointless"

Basically, %hhu and %hhd simply do not make sense if you always
require the value to be cast to the right range, because for those
cases the much simpler and more straightforward %d and %u already
work.

So a warning that says "you didn't cast it to the rigth range" is
truly fundamentally broken.

So it's not about "a cast generates worse code". It's really about
"that warning is WRONG".

          Linus
