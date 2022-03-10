Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F604D3E44
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiCJAho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiCJAhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:37:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB711EF1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:36:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 3so6687963lfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tU+Fe+vcmWYII8bcpQckbuUOYQxVwc8Ms6FjnpeZUXo=;
        b=L/mvPUr5+ed9/8F1xYBeOkHEQX/N5BqBnxQcWBYwpz8RAerWYK3vG+jQ8UcnJ76O8n
         Z6F8qP7cE8tNgjablMkD4TSjih/QPIMEsvNLTgmbdeWBRVediWkgAMhZdVVhEgcgGEdK
         lMZ1J3pO3p0Ql46BLe9TS7msF+0WkJiXc3GEYEhfXxvSABXRpmnJrXBNidzsucgWij7W
         h71P/xxdG4gMnr+gam3ehpQ7R8zTNQQGhJ/hYPRcyYsfLb7u+8rs0B5WjYUfbEvSpW08
         3VtCaxMUJjZ5zrZuYEdWuLeNzUmAVqnhioFkV1FhQj3OlGZ8RQb3TRq3538igabd/3yR
         jrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tU+Fe+vcmWYII8bcpQckbuUOYQxVwc8Ms6FjnpeZUXo=;
        b=ZpLnb2XTfCP7tFZJVjIKZu7QQ1CxY7QscRdgMthI6vBdOJQFnabgYGbJ+vvu+j4Q2i
         lnxgmHTJgEiAinBIoI/bvQzJ6utKVgtRopPqECOEcMH+jhfw80yVMvVmBtrBR6Y9t9Y+
         5hW4eTYjTKJHCXuifN2n0kCf58KY8naYK+eapWZd2S9o0LaD876h+bC2Mn6PYZ0g4sVj
         E3h1XUkJwKs9Fj+hZ6eSIhq+fxoII6NDoyGGYHJFaLdp1EqIwWCXwlpyfINrQgf4J4zm
         4jeRPcuBhAiaFoR2rA32yr5ARSZfsDl2w0zV6ZfPJG10n9purWuI/XsvdL2AwEblg5lP
         u3vg==
X-Gm-Message-State: AOAM530ETj5i6o8TBDFnQQLZvGOvU+QOJoiydKZBsSL3FX+VOvlIi0aF
        scjT6SQHJP7DmzgqWBg5m+aWhL1OBf7Cv7zNV1K86A==
X-Google-Smtp-Source: ABdhPJytXKwI98E3nQqK0BdQ0dFxt9GnezH6c63KyMKM/BPYYzDCKWIjWSo338Qxmgo/66zO3+BC+IAEhGNy/BYPIF4=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr1387380lfl.87.1646872591569; Wed, 09 Mar
 2022 16:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20220304170813.1689186-1-nathan@kernel.org> <CAKwvOd=Q-7vPaRPj1wQagFsY3txcAKzrqU_D2UAX3h4ym91uUA@mail.gmail.com>
 <Yid6eS7YV4Oxj+hx@dev-arch.thelio-3990X>
In-Reply-To: <Yid6eS7YV4Oxj+hx@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Mar 2022 16:36:20 -0800
Message-ID: <CAKwvOd=0tn3DeqDkKxxk61EvHY9Vb+SnHkXugUmHCMFF_0VVoQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
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

On Tue, Mar 8, 2022 at 7:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Mar 07, 2022 at 11:08:29AM -0800, Nick Desaulniers wrote:
> > On Fri, Mar 4, 2022 at 9:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > +If your LLVM tools are not available in your PATH, you can supply their
> > > +location using the LLVM variable with a trailing slash: ::
> > > +
> > > +       make LLVM=/path/to/llvm/
> > > +
> > > +which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
> >
> > I don't think we should do this; `PATH=/path/to/llvm/ make LLVM=1`
> > works and (my interpretation of what) Masahiro said "if anyone asks
> > for this, here's how we could do that."  I don't think I've seen an
> > explicit ask for that. I'd rather LLVM= have 2 behaviors than 3, but I
> > won't hold this patch up over that.  Either way:
>
> Right, there has not been an explicit ask for the prefix support yet,
> although I know I personally would use it,

Then let that be reason enough. :)
-- 
Thanks,
~Nick Desaulniers
