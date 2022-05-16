Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB4528A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244393AbiEPQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbiEPQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:33:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F13BA4D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:33:04 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d137so8814491ybc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVOWBi2MNBuehei9huBnd/8loFbnwhqAiuOC/hCYUtE=;
        b=UMpVvjAskWnfR6g3ci4cMkPkNEchbPVQCDFZURqGgdGBGtyEU0+pfkHuIEsLxzzdxa
         B18bBKbFeo2JcX6Nz0IkEdagX64XxF2YEDcGnalbPkbzsdXHnZZGaCAZvltIUt8sXuPo
         zc+e8B4SuenU8MISBWZpTrjTRFvYcwbYxq6tk/fA+vLgbNtNdpbpv9n/FFbrhrGyS4/A
         hl891Clm6zzMg1ByvOjCgkYC1CBLqqCMd5UMKl7fYoxLVwfMTVOj3WL8d9fGHLWJxHp1
         HFHt9MPjqwqb5TyctUJdvK/tYMZpC5GtaKZHEttGWXNLnXoDb1+0WTqUO3MYlQIJ76Hw
         42MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVOWBi2MNBuehei9huBnd/8loFbnwhqAiuOC/hCYUtE=;
        b=8KuJ6c5OMMymIDrSZSZtEERdi6CdxG5OkCdfuZABGbljy7C/UCV2Sj16GvGmCdpKit
         GRjs6PtRkL4PmiDDaxp+/P+8xzUQD3sp1+BGTkn7zYY4eQK7hyuuYR7L730dNBEuqYW3
         /BBe0Wra1UAQ/xZQRLiaog83BD3yFN+eVXgMjrdTCXH0sNacYe6yIegExIqkcJ4UF5Tg
         9nEFAy3vveDaQPsDNjDpqlwIp3wJcHQlaadzx/dfez61n9ibFGJBOfeLVxQEvrTMNrzd
         skrmYEPW83jWs90df4J9gMioKlqsPqrcvQChJ+xV7iYN+Wlkte6OZKx0jqaRARviUBix
         Ufbw==
X-Gm-Message-State: AOAM532Xplv79Q4eHBgNCFPwpPca2uBju2bDt11EFQJkMNzqveJmDoxl
        yEV00kI4eIjbOkrpBUZxKNeOvb3in/BZl54WVJ0vUQ==
X-Google-Smtp-Source: ABdhPJxnm0eijYHOVmrixfo245yISpWoVL7JodzT9EqGHwvEuWoWte/Watn8vMd89vUvUVL2y2IhRQzqqpGLJpOURZA=
X-Received: by 2002:a05:6902:90b:b0:64b:233d:8e03 with SMTP id
 bu11-20020a056902090b00b0064b233d8e03mr18090305ybb.428.1652718783727; Mon, 16
 May 2022 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-15-samitolvanen@google.com> <202205141455.0A6F409@keescook>
In-Reply-To: <202205141455.0A6F409@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:32:27 -0700
Message-ID: <CABCJKudyuB3doGwcRpYNm-LrdEzjgwR3MTys3MmSs+vMkxhsPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/21] treewide: Drop __cficanonical
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

On Sat, May 14, 2022 at 2:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:52PM -0700, Sami Tolvanen wrote:
> > CONFIG_CFI_CLANG doesn't use a jump table anymore and therefore,
> > won't change function references to point elsewhere. Remove the
> > __cficanonical attribute and all uses of it.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  include/linux/compiler_types.h | 4 ----
> >  include/linux/init.h           | 4 ++--
> >  include/linux/pci.h            | 4 ++--
> >  3 files changed, 4 insertions(+), 8 deletions(-)
>
> I think this is missing removing it from include/linux/compiler-clang.h ?

That was removed in the earlier patch that switched the CFI implementation.

> With that done (or explained why not):

I'll add a note about it to the commit message.

Sami
