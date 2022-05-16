Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA04528D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiEPS55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiEPS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:57:55 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0F3EB82
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:57:53 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f863469afbso164639077b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0lDvgtygkUQt/MUd8knhUulQHn3vRN7wQxbpMX/7kc=;
        b=OtkZKug+pHgQ2UZ/72x5bHwTEdoqxCQfEkm1QUCKIEgRffjKW3KbMb3c/K0hbgw8Hh
         4snt1OZnOFAGl+LpQ4hpHFIJxYGrgyUHb3MpltCQAyohc4EBc2K3cVdSQIPXWZTMCpAo
         xvkF6YXXSdLtGnt7ynxNOqwGwVVTZspuksDC6xnRRp98ABNh0U+IV0ZaF0Dke8RLQ2hY
         0zwsUzPrYM4NS77Te/aQXLi3uZ8/Pe1REWifevXQA7rgTj6p6tmReRBxgn3R2O7hm2fZ
         OJ6CVb4R6Yse/fCzJP36XXgjWUGVUJLUzzJC39/+B4Yu2HI44XK9AEZhZ/l6VNqETlCG
         d/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0lDvgtygkUQt/MUd8knhUulQHn3vRN7wQxbpMX/7kc=;
        b=qhdMAOCK1yUot0sXtpmp5u81vjEAFI7NiTJ2yd0BzpHT6MY6K9fTxza5r53CxYqEX4
         0w7NjBshdbrc4lJiMlYDO2axQHKQKlPwaCw2PzcK7VHaEq5Xr+P4roSSJm11Le1f42r3
         JJMEXZfnqcyWZ02QkF7QhDl8qazGFgJsUa/UXnD/V20yLTd0xH2sv3PUJbqrjlDIWZw0
         a9EBh9vGIReGDcnOcbWGZ/W+pSA+UlXv6zv3kfla+LoTlXUGGZ4t43VCr9eR7+t9Sku7
         Jd7FeuYD+YEIsLuGUeCwAXIMNRf1lBFuAVoBd1i2i+F+z1bVFa2Y7VcVgrLhj9KcAk0M
         PbKg==
X-Gm-Message-State: AOAM530rLP+JQ6A4VezfqGoWDPYkrJXU3XbWHhuv3Vm90917GsHj7pG0
        bMh9qQSs9kvV5Okzz3JFteMcgum9V4VVlMIfZnyt3g==
X-Google-Smtp-Source: ABdhPJyxnegSHSL4esR4Y8T2LGVa+WGgTYoK2/N/07nmR8fbjF1kDUJlLs7zXniWb3x4daFZGwyj8JCag7XedUMNBVU=
X-Received: by 2002:a81:7953:0:b0:2fe:f8a9:7e45 with SMTP id
 u80-20020a817953000000b002fef8a97e45mr7139331ywc.23.1652727472248; Mon, 16
 May 2022 11:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <202205141501.92A22264B4@keescook>
In-Reply-To: <202205141501.92A22264B4@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 11:57:16 -0700
Message-ID: <CABCJKudiLBjsNHUTH6zqhYik0WQZwsM4OceYJadYKoDQYOFRXw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
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

On Sat, May 14, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> > +#ifdef CONFIG_CFI_CLANG
> > +static void decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
> > +                         unsigned long *type)
> > +{
> > +     char buffer[MAX_INSN_SIZE];
> > +     struct insn insn;
> > +     int offset;
> > +
> > +     *target = *type = 0;
>
> Should report_cfi_failure() have some additional hinting for the case
> where target/type are zero? Like, "hey, got an inexplicable CFI failure
> here, but preamble decode failed. Yikes!"

Good point, I'll add an error message here.

Sami
