Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319CB523D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346991AbiEKTe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiEKTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:34:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB50177898
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:34:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j4so5310167lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZeBueAo7XbLNHzSFdohWNSwZfJDZuFuvcSJwY8CQhE=;
        b=sY5PApnBJsxPzMuys/jslbcKeJaxlN768xHRp85uJ2JjMBKylsLasOTE1xiOYz9DrE
         +zHxayQfilge3sTH7mwsQGW9Fsx+J6W14+kAJtTARMuKl/NRqPANRL7sCv9C/vd34gF4
         7pG39luF8/3brbm0o+w+UujmNj+v6Vhc3a00xXefZdKGF6wagpdJQ0qAKP+/pLw/q53J
         lmv05KW000ufZQS3kM/ED5l1ic9V1Z1R3xEUPIVGfkGolOoj6d67VM0rQ9RXgMO+Eivw
         KdR+E4pEu3A6zI0AhoYnU00bMG7f88OBlnnsfUJPV0JYjQPZzOoMMf8SahEhFktu27wh
         zfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZeBueAo7XbLNHzSFdohWNSwZfJDZuFuvcSJwY8CQhE=;
        b=eerlRVig98b/tGO/uwvVAlOEiJBOXfF/qT+JHv2dxicsEZ3Dst9Fael8DFt0qlUpQ1
         /9L6S4+Iqho3grJqqfISPvBbvx1SjTvlxoo3zaBEjKLYafjYhT4SX3msnwHNi4WyqP8F
         HayHP3A84tuAgNUJITrlBYMg+2ja3EM3WjnwfAo3YiUPcd6FeqkLkHAcq2b/mkxHn7Nh
         vQmyWrFdC8rcdo6aB/cvFDMVOfzsSbizABEqfwMdEsQ3501vFTB+wO4HBcK+WcqoIojn
         rELfCur7jCdWFivqtBABi/tGBs4nvkpCysdNdVEzEFa7hb+tNjDOAfEvBZQZ5YP1nykI
         YDPw==
X-Gm-Message-State: AOAM530wy4/jtNpK9otYOpz/vy1SOgzI5AZdWqZ9lp1RZIQ5cU+tlZMv
        EaMUUem6HbXWCwF20idX6FAeaqJg6Y/F8DCbZgNT7g==
X-Google-Smtp-Source: ABdhPJx0nq21d57bjSMLc9tnNiGLxntA/KgJYcxML0H/xX2fFJiktsvqHKmc9w082aQb5KnRyqZul6G+7fuSOGjN+qg=
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id
 u17-20020a056512129100b00473b522ef58mr20873024lfs.190.1652297688470; Wed, 11
 May 2022 12:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220511072747.3960-1-jiangshanlai@gmail.com> <20220511072747.3960-2-jiangshanlai@gmail.com>
 <CAKwvOdmF_5KudQbC8j5hJT1CqxvYtMneZxb1Si3A2uNxopk3yQ@mail.gmail.com> <CANiq72kc02DbgVdKusDUeCkxVoQoOGMLnEJnzf-Gn=BiQUggLw@mail.gmail.com>
In-Reply-To: <CANiq72kc02DbgVdKusDUeCkxVoQoOGMLnEJnzf-Gn=BiQUggLw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:34:36 -0700
Message-ID: <CAKwvOdmVj006evgychajuUV4DqL4QXohHmYiE6To9traPKcr5w@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/entry: Introduce __entry_text for entry code
 written in C
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Wed, May 11, 2022 at 12:27 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 8:01 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > I haven't looked at the rest of the series, but isn't `noinstr` used
> > in a bunch of places? Wont this commit break all those uses or at
>
> Except the order, it expands to the same, no? Or what is the issue?

Yeah, nvm, I missed the bottom #define for some reason.
-- 
Thanks,
~Nick Desaulniers
