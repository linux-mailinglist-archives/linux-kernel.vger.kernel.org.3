Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF47528A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiEPQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiEPQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:25:28 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A1B39163
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:25:27 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2fb9a85a124so156020347b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFls9zXfp5eTyiIQ+m2636iSt9xdwj1AtOgJeBph0LY=;
        b=YhXgB7NNVPD0yB1cDQg/SXVjUhX8SLXmuhEnMy8wBpqtJx2W1ubPNizgIU8zF85A9O
         4NabimscaxUtttPG7Gr13TcfobOte2BzOayOW/nlwMPCItIILzLtfLGgrw0uPqLvr1vN
         XhCPSDdmLiEtsD6yxSIRy5iwnZW/KIs5ZQCvm+r8msHjrgEmUHxjk2lQ6TIaPDXKbnYz
         sZhpeFcc2mDSmxSZpJ7TQKJHp4vjLedto83hHVkTNkoOpl6hYpxqNRN2G2PQWhl4aJCW
         EgK5oKNTRRk7HwbzJy09mdNldhGb4JoY04hsQgAJjG7sZFNeQ1kpT4ixGA+HzY9SOCsG
         1lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFls9zXfp5eTyiIQ+m2636iSt9xdwj1AtOgJeBph0LY=;
        b=NNyg8FCSbjassiQ+NOrAqNZQzDWlV5T+ujGuTvQXGqr+4kz2pUhWyUU3ieerXxnZoh
         nbBus7+Y7zyGf4ceCtXEfOtsiADphg1h0zcbw6rvTrVb/Wgp5NhGIeN//PBjjbJzEjIW
         dJ5MNZPtdZugvYGHRUek+ZItNPYTXD7OOf31lW5YY2lW0qgM34bn0P2EpS0WWHmAW4VA
         YT28ZvPhE4icCRUHswp4xC67qUBQdpH1HHc1K7m27th/3CPJRA9o57O/dNYmZ7gxWx5O
         4KzrqccWM1g2l+J40wiH5R2hU/+E+JBgMTiXSyZWjEMA5gt0cozA+atJhWqUxIp8aKKS
         OqYQ==
X-Gm-Message-State: AOAM533aje+K+S17gTDIran/QacPEpg1cp3Ojzw0QZofcbcsf4h7i9t/
        NZA5NntRgwecWIiaVgjkExN0Rwo6oYWJalPb4oIypg==
X-Google-Smtp-Source: ABdhPJze0FlbTm24mJB4UEHbsfYPEzROSnDu0xvZSbQCYGCBpmmty4Y0jTVl7jr510LqdmFqqvrpYIOVuhdO38wQmIQ=
X-Received: by 2002:a81:4ecf:0:b0:2fe:d9f2:15b3 with SMTP id
 c198-20020a814ecf000000b002fed9f215b3mr10961808ywb.305.1652718326620; Mon, 16
 May 2022 09:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-11-samitolvanen@google.com> <202205141451.AABEE8B@keescook>
In-Reply-To: <202205141451.AABEE8B@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:24:50 -0700
Message-ID: <CABCJKufbTGxjYg=vLwDUtxb06yues+yH9wV3J2hVa8uM+u1bvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/21] arm64: Add CFI error handling
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:48PM -0700, Sami Tolvanen wrote:
> > With -fsanitize=kcfi, CFI always traps. Add arm64 support for handling
> > CFI failures. The registers containing the target address and the
> > expected type are encoded in the first ten bits of the ESR as follows:
> >
> >  - 0-4: n, where the register Xn contains the target address
> >  - 5-9: m, where the register Wm contains the type hash
> >
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> It might be nice just to include an example exception Oops in this
> commit log.

Agreed, I'll add an example.

Sami
