Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC7528921
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245409AbiEPPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiEPPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:45:21 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD59027CC7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:45:20 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ff1ed64f82so6952957b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnKHIkN0TU++izapmIFi8Ty+LNPCPzgGOdIpl087eMA=;
        b=iTcoOlahc6mNkkH9KN1UbL8/FqrKWmwWC3yXua2GycFg92x6rtngNdWTVZd0vbWmvo
         IS31fC3vbQgVufrjL9knZDTJqUptFr2aaqDFIneUmpWLvFJa+Wu+UxrjhyP7Rgj7bYw6
         zGYLwfOJbeMXxZZo4hcNGWPwaUtzNrt3Su/koMOjF0/lJfcxtgYk49vf4uomzBQ/y5my
         1yNpaUl8mO2poMKwfULV989QV1N1BB5iZDEFJA+CXZ4MAPWqN9ygMf71IFgVuS2VYweH
         bgcJ++RWpGXf45WXPIGOJztqFDbRlw5pqIk7yfMCXeIH15TdPWKecQfiVFMacIT+G95P
         EkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnKHIkN0TU++izapmIFi8Ty+LNPCPzgGOdIpl087eMA=;
        b=kg49zjaMcG+FquvoEDAE36Ne3GM6qXzM+v4rHuCb5IALYH5by2cUn28vdHAOroJoyh
         ZBg9pZqkU2/814XdfSvZE+fkNLruVUF4e/oPX4U3rbo2FcbkddnTJe/qzx2+Ig4EmXYr
         N3ooitNaG96mMu7F2UXf+k9BjdgypvPO1v3pvXLZRnMIS0Njcpay6orDbLLGTKgkZb24
         J0tiUGHaIGokQd2YMbNk3lTwctGjx/8KlJNeC2KUtdl+vtvo2PTyTRkOZI11hykkIk0/
         6tRnijklj7HJklfNYIySLPZ9h0rQXjxQZ9q3q9dDoYDSuUODLuhrRl+fY2Jc1i3Srmj3
         0xcw==
X-Gm-Message-State: AOAM532ydBW3wu5xy+1a4zIcFbaiv7ikASroz3apuC+feh7IaFUTGX0K
        V+N9skfSQMSD5aKTWUyC7C8fxO1RT0UdMYz1bjTKvw==
X-Google-Smtp-Source: ABdhPJwi/PDSBCPu8w13weeGP3GKG4Kc/dHnqpDwTulTE1xr8903vsYGeGb18xGWe7Di7/TDqqAZCDtrmcivBggYEX4=
X-Received: by 2002:a81:4ecf:0:b0:2fe:d9f2:15b3 with SMTP id
 c198-20020a814ecf000000b002fed9f215b3mr10749397ywb.305.1652715919792; Mon, 16
 May 2022 08:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-9-samitolvanen@google.com> <202205141449.87738FDF@keescook>
In-Reply-To: <202205141449.87738FDF@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 08:44:44 -0700
Message-ID: <CABCJKuc82+92BEjPU+5_7Y45cBAZ_J0Nyjvn_FtFroqsJjs_Gg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/21] psci: Fix the function type for psci_initcall_t
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

On Sat, May 14, 2022 at 2:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:46PM -0700, Sami Tolvanen wrote:
> > Functions called through a psci_initcall_t pointer all have
> > non-const arguments. Fix the type definition to avoid tripping
> > indirect call checks with CFI_CLANG.
> >
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> This could land separately from this series, too, yes?

Correct.

Sami
