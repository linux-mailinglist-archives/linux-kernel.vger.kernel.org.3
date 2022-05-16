Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C019528A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbiEPQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbiEPQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:29:01 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F53B012
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:29:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so28041226ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bOl+fIEQwkyHpsAzPSpEA4t7EJjG4W9SophqswqviQ=;
        b=bdD+55o79GwcDBvWafpfYRSlZ2cIsVtsEzWN8lNQZowpdfgforgqMt8qYsM397aVOm
         YiVGsBjyCQ4/nzJb8pjgE6jjFdcKLpF5wOOcJodQ1RZ4iNIvX0CENTxmrtn9+/UciHyW
         EKnHHqZErG9LECr8b32WdjMLnN2pXB4+B7zMmAvfkaPu7l6jzIfy0MhMILwvn73/9VQ/
         MkHv6wCf5C5mFtWTtxiMgZBPV2qCW1bp6lyYTE56bmlfFrfQylzrQZmpH8+PR5FUV1/R
         OxVBsmGQ396NviKrlt0o6WZ5PsTDAzdbxxcSej5Osw7CXNEecq4EKHR7E8NkFpIkBOAc
         v+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bOl+fIEQwkyHpsAzPSpEA4t7EJjG4W9SophqswqviQ=;
        b=Hw0ri4gzmk5OzZCqoNM3ZsRc2+KEHPdxMZ8XZf0y9aqXqZJhNWGGmUWkNtXzetv7yV
         UZT4UpOXcmX99uE0R97d3M2Pq3DC+gOSJrdOjhDT8RTcZdv9wU9cdIp7+Ewfjq20vKgB
         Xa+iTNWHV8avzQiT3I/MCJo7UjexucvV6ivsTBtRsIJ8+Txr7rF5F6v9XXvxkhlBVHdK
         4EHg0hq0c+XaKY/10DnW3nGAfDthF2qTs4qE3aSS1fvNc9ofPk/IexKEaiSkDLfT0nhE
         kh6XZSaYLLRg1BW/n/Va5eeDrpLYWLbdgeuAJxKTafp2ALz+6HihSC8mIG0aPYy3kOSJ
         iiLg==
X-Gm-Message-State: AOAM531/AUfl6IwjDZzPu6OSyOLApwNaPDS4LNqJ1NAlfyyCtiv15q5k
        cNiI6LNzZgzhYKXpRTmEKRQtoZJR8DAvdqRsi0H7pg==
X-Google-Smtp-Source: ABdhPJwCEGLuNBoujfx+BIv6GEik4LbJeGm6Fda7U5MlIv3LPv1HXUgO10cPIMseX62+HYUEsnBRjf+KqqvWact8dkE=
X-Received: by 2002:a05:6902:90b:b0:64b:233d:8e03 with SMTP id
 bu11-20020a056902090b00b0064b233d8e03mr18071522ybb.428.1652718539243; Mon, 16
 May 2022 09:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-12-samitolvanen@google.com> <202205141453.44171359E3@keescook>
In-Reply-To: <202205141453.44171359E3@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:28:23 -0700
Message-ID: <CABCJKudJZUsRjwAEzWszOGY6G5igwWVpEy1OsAWrhyKr3csUSA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/21] arm64: Drop unneeded __nocfi attributes
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

On Sat, May 14, 2022 at 2:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:49PM -0700, Sami Tolvanen wrote:
> > With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
> > with address space confusion in functions that switch to linear
> > mapping. Now that the indirectly called assembly functions have
> > type annotations, drop the __nocfi attributes.
> >
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> It looks like there are still other cases that continue to require
> __nocfi, yes? It looks like after this series, it's still BPF?

Yes, BPF is the only remaining user of __nocfi after this series.

Sami
