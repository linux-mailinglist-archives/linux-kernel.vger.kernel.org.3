Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8898476FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhLPLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:16:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:32838 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLPLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:16:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B51061D56
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3453C36AE2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639653392;
        bh=IWV7hsyb6SBFv5On8cyQp6L9YQ24eIyxVkSvcDqGHvs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LGZ65u6YEKyqpxFVt9GGEdNJ9rqRSCFFr3PFNsjMATcB0rdqasrTdZbDNOAuRhPw5
         hDn5P6ruy0O/u5knk0A/39pc8SvswgdiSOzhqznecCqpB6c3OIvQuhLnNWPxsTWgLo
         LziUQg/bb7s83umipuGsEhVVP5kPvo0wOSLa4Wr0Dg9DGS0SDTuDwXIh+jEOoR41MG
         f0XF4f6eprs1ZfwQ1ezriu8ztCmTjQPlrdSI8RLGA0HZOPj4081sSGEDgl0PuZOzz7
         Uw9i62QoymKSH9GsBSnu6cfSabB+dIr+e3HV+QiYlEYEmAm5Bk/TFUQx88MiUraSPI
         Oz59x68ngpYtw==
Received: by mail-wr1-f41.google.com with SMTP id v11so43487417wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:16:32 -0800 (PST)
X-Gm-Message-State: AOAM533TmuuKzKP8xId0iqRcq/oylGwZR4Ll75Z3dsSVBa1nkfpyzS+z
        LaPQHhuZfBEolVYWanq1eIGlCkcrti6ZbJ8hFRI=
X-Google-Smtp-Source: ABdhPJySC4rrUprHTTVoFxvhpszmF5AHf25xGzu2OsaJeR0G5ofCWlb87mmZSAWddJFPLfUBSlwhqXLtka8ssiG0eyI=
X-Received: by 2002:adf:c450:: with SMTP id a16mr2387150wrg.454.1639653391120;
 Thu, 16 Dec 2021 03:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20211007081235.382697-1-ardb@kernel.org> <163362596339.2313433.1892710945535449841.b4-ty@chromium.org>
In-Reply-To: <163362596339.2313433.1892710945535449841.b4-ty@chromium.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Dec 2021 12:16:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFWE68Pozk4Kwqk_vYW96mrvz+XkbjXm-rTo=7ZA_BwTQ@mail.gmail.com>
Message-ID: <CAMj1kXFWE68Pozk4Kwqk_vYW96mrvz+XkbjXm-rTo=7ZA_BwTQ@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: avoid printk() in recursive_loop()
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 at 18:59, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, 7 Oct 2021 10:12:35 +0200, Ard Biesheuvel wrote:
> > The recursive_loop() function is intended as a diagnostic to ensure that
> > exhausting the stack is caught and mitigated. Currently, it uses
> > pr_info() to ensure that the function has side effects that the compiler
> > cannot simply optimize away, so that the stack footprint does not get
> > reduced inadvertently.
> >
> > The typical mitigation for stack overflow is to kill the task, and this
> > overflow may occur inside the call to pr_info(), which means it could be
> > holding the console lock when this happens. This means that the console
> > lock is never going to be released again, preventing the diagnostic
> > prints related to the stack overflow handling from being visible on the
> > console.
> >
> > [...]
>
> Applied to for-next/lkdtm, thanks!
>
> [1/1] lkdtm: avoid printk() in recursive_loop()
>       https://git.kernel.org/kees/c/700fa7d22233
>

Ping?
