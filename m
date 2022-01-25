Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1749B808
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351264AbiAYPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582506AbiAYPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:49:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E80C061762
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D8DEB818B5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42891C340E5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643125758;
        bh=L1QYqyaORrLlX00Z4Deiwi7zX9ymNIf7ploH0m39Kq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=baRNDh751XAmB4Q8J0rWatkHqIrXWdw+eJTjVvVrLmsqwc+y95g6w8SYKPEj/HlC6
         zgGr8n6jBvydEkEqtmsfiZiRUKwTfI3RJwjzxgeyNs8kdDaIEnbtLsZcgAwglzUabr
         LdWdGrB72yWhK5DBZU0izK7FxpBQBlNriBbENPinP19EW6cy0nQmdHuG5J4YiTyEyz
         viCYvwJu/YMSbpWmAFL8v4yGGLiRDvzc/rWifL7WV1s1uRujIb0hjIjJNoUxiuN3JB
         OYCU9rD07gH4u1Bi/FPAUIYKYmmDPJKfh5ViI+PCloxw9DzQ/EPy+8tUtTiNnTzpxM
         bqgkI+fh0WkNg==
Received: by mail-wr1-f54.google.com with SMTP id v13so20670347wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:49:18 -0800 (PST)
X-Gm-Message-State: AOAM530iMk08OMFn66yWKrJtDBAW2dsdtvHTDuxXTQgSRqWC2QPALwrU
        hejdCyXmY0LcUdDRqyoA2voPsl6UKINvrBM4XPY=
X-Google-Smtp-Source: ABdhPJxULFKWIaH5W/JWDZGAReMwgfwspFkabyCqOvVGj9INKQ7bokWPB4JYAZxoWyp55QvLz7hfgHU+0yaEOULtMxk=
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr19373385wrs.447.1643125756606;
 Tue, 25 Jan 2022 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20220125113200.3829108-1-mark.rutland@arm.com>
 <CAMj1kXGCFFHzZAqhfmJthGCe6uhFsrHwzK0QyOfrGw7_kNbjWQ@mail.gmail.com> <YfAbMY6U4UpyrerB@FVFF77S0Q05N>
In-Reply-To: <YfAbMY6U4UpyrerB@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Jan 2022 16:49:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEyzNMWiQFiZW1_QTApmuHfot82USC=Q8nP27sVm+WMMw@mail.gmail.com>
Message-ID: <CAMj1kXEyzNMWiQFiZW1_QTApmuHfot82USC=Q8nP27sVm+WMMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] linkage: better symbol aliasing
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acme@redhat.com, Borislav Petkov <bp@alien8.de>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 16:46, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Jan 25, 2022 at 04:28:11PM +0100, Ard Biesheuvel wrote:
> > On Tue, 25 Jan 2022 at 12:32, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > This series aims to make symbol aliasing simpler and more consistent.
> > > The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> > > SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> > > that e.g.
> > >
> > >     SYM_FUNC_START(func)
> > >     SYM_FUNC_START_ALIAS(alias1)
> > >     SYM_FUNC_START_ALIAS(alias2)
> > >         ... asm insns ...
> > >     SYM_FUNC_END(func)
> > >     SYM_FUNC_END_ALIAS(alias1)
> > >     SYM_FUNC_END_ALIAS(alias2)
> > >     EXPORT_SYMBOL(alias1)
> > >     EXPORT_SYMBOL(alias2)
> > >
> > > ... can become:
> > >
> > >     SYM_FUNC_START(name)
> > >         ... asm insns ...
> > >     SYM_FUNC_END(name)
> > >
> > >     SYM_FUNC_ALIAS(alias1, func)
> > >     EXPORT_SYMBOL(alias1)
> > >
> > >     SYM_FUNC_ALIAS(alias2, func)
> > >     EXPORT_SYMBOL(alias2)
> > >
> > > This avoids repetition and hopefully make it easier to ensure
> > > consistency (e.g. so each function has a single canonical name and
> > > associated metadata).
> > >
> >
> > I take it this affects the sizes of the alias ELF symbols? Does that matter?
>
> The alias should be given the same size as the original symbol, unless I've
> made an error. If you look at patch 3:
>
> * In SYM_FUNC_START(name), via SYM_ENTRY_AT(name, ...), we create a local label
>   for the start of the function: .L____sym_entry__##name
>
> * In SYM_FUNC_END(name), via SYM_END_AT(name, ...), we create a local label for
>   the end of the function: .L____sym_end__##name
>
> * In SYM_FUNC_ALIAS*(alias,name), we define the start and end of the alias as
>   the start and end of the original symbol using those local labels, e.g.
>
>   | #define SYM_FUNC_ALIAS(alias, name)                                     \
>   |         SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_GLOBAL)      \
>   |         SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
>
> Note that:
>
> * SYM_FUNC_START() uses SYM_START(), which uses SYM_ENTRY_AT()
> * SYM_FUNC_END() uses SYM_END(), which uses SYM_END_AT()
>
> ... so the definition of tha alias is ultimately structurally identical to the
> definition of the canoncial name, at least for now.
>

Ah right, apologies for not looking more carefully - I assumed the
changed placement implied that the aliases had zero size.

And ultimately, I don't think there is an obviously correct answer
anyway, it's just the [apparently non-existent] change in behavior I
was curious about.
