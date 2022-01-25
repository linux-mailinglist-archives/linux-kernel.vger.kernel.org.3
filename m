Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E515149B7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiAYPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:32:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54922 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348141AbiAYP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:28:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F82B81878
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76523C36AEB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643124505;
        bh=gy68J/WtNh4xtDiQTkwlHfgqhTp+SaYHlKVlJM6Ezgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1r/GvIMCuo1+PWyPRlTqCySiZSkyU2Qh86hukt+ZBuuc7ifM4FnGRreMq/grHZj8
         16TljCOtBl26LW63xBd3v5fn29SlGl9lLKtXr/2TnUjUAo01HpuofJ+lb+Rn8jXa4v
         3zKp7t0FRUcQziyd4i0Fk13eXiZ6TenNSHrGqDawWHDzasAz8RQ5p3jdkHs8ZianjZ
         jB9NO3N3svjTlGEWdXM+Mjos1YhsLJEw9X8j6VGO1ju9S8h2J6fPa/UqxlLKkNg6y6
         8WV4LaMWQA0ORuBBhp81dxXQXwaTkd1xjrBJx7uBZep7AXuxpu+XT39+334qe90pYE
         1VH6PdAJRn6nw==
Received: by mail-wr1-f49.google.com with SMTP id a13so20583059wrh.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:28:25 -0800 (PST)
X-Gm-Message-State: AOAM530hxm5i1edmBNadmwMLFchFHbxYvuiQrAVzqV1FMcEEvKBFFxYd
        G5yehZOx1vVMAoH40cC2dtOZ6PDLCLWVRvAhH0w=
X-Google-Smtp-Source: ABdhPJyPGDxExzZZHc857QOlZPHirDqnFWgDAwtsVNbMO9KJEWC4Nnz8nj7D2qBBP0+Z4tlZmp5hUOaUwwqY9O29V0M=
X-Received: by 2002:a5d:4944:: with SMTP id r4mr18962020wrs.550.1643124503651;
 Tue, 25 Jan 2022 07:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20220125113200.3829108-1-mark.rutland@arm.com>
In-Reply-To: <20220125113200.3829108-1-mark.rutland@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Jan 2022 16:28:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGCFFHzZAqhfmJthGCe6uhFsrHwzK0QyOfrGw7_kNbjWQ@mail.gmail.com>
Message-ID: <CAMj1kXGCFFHzZAqhfmJthGCe6uhFsrHwzK0QyOfrGw7_kNbjWQ@mail.gmail.com>
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

On Tue, 25 Jan 2022 at 12:32, Mark Rutland <mark.rutland@arm.com> wrote:
>
> This series aims to make symbol aliasing simpler and more consistent.
> The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> that e.g.
>
>     SYM_FUNC_START(func)
>     SYM_FUNC_START_ALIAS(alias1)
>     SYM_FUNC_START_ALIAS(alias2)
>         ... asm insns ...
>     SYM_FUNC_END(func)
>     SYM_FUNC_END_ALIAS(alias1)
>     SYM_FUNC_END_ALIAS(alias2)
>     EXPORT_SYMBOL(alias1)
>     EXPORT_SYMBOL(alias2)
>
> ... can become:
>
>     SYM_FUNC_START(name)
>         ... asm insns ...
>     SYM_FUNC_END(name)
>
>     SYM_FUNC_ALIAS(alias1, func)
>     EXPORT_SYMBOL(alias1)
>
>     SYM_FUNC_ALIAS(alias2, func)
>     EXPORT_SYMBOL(alias2)
>
> This avoids repetition and hopefully make it easier to ensure
> consistency (e.g. so each function has a single canonical name and
> associated metadata).
>

I take it this affects the sizes of the alias ELF symbols? Does that matter?
