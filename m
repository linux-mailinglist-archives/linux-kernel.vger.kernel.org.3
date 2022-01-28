Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98CD49F5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347437AbiA1JIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiA1JII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:08:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8E5C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:08:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE3561DD4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E483C340E6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643360887;
        bh=MBPptDMDLXtaR5MsyxmkNUko6KgF89JBb4LWE/5IspQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mvd473QlfFn4YG9t+8AZ1ZOY9dYFmVntTj4atlc8TjJZyIaiwnC10Eee6mXQW2Iyt
         agYKYWHhG6dcy/xQrGjtQnE3fDVWHFB2GWHi786hVoiqSnto1pjvtIziSabz4gS09w
         Mhw7SkFUkNm4PYoPDR3HFDq6ei0VtDlG8XJsCiqbACAW4Qj1T7itBgYP6WnxlzClPq
         +opLhRlbFrfDCrgJjyD0XZWEVXCg6plz5tAG1NV7qcPaNac2uo/dVCtOizLTNeCV6c
         PBnTTYpK5qpuRY1jHhmUg8noE+Gw9SUYWBygQcLhl0qO5iDBufTtYu+4YE8km5/kZV
         +ZIVacsWUVpaw==
Received: by mail-wm1-f50.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso3594758wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:08:07 -0800 (PST)
X-Gm-Message-State: AOAM5303bXNWyGE3rg/1SNYON36tRWU8tpjkdRmRVbEkOtfTjWxpjvxq
        lQK7TgR8+wmFoUqqT1EvrqUXXkbE86/MEKFfTO8=
X-Google-Smtp-Source: ABdhPJxjT5/5vck5qJabBN55fX7BJ0vvbma1AuCDsJeN+RrvQ2LQEWctCgqI5L+HxoJd55ca5kY53enpOFJeSAdY2ZY=
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr6538271wmq.25.1643360885904;
 Fri, 28 Jan 2022 01:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20220124170555.1054480-1-ardb@kernel.org> <YfG/Wi5OBHeDRPdg@kernel.org>
In-Reply-To: <YfG/Wi5OBHeDRPdg@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Jan 2022 10:07:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrS-=5Lc7rFz9Jaq8Nshss+VDgoP6n95D+w+1WB3OZEQ@mail.gmail.com>
Message-ID: <CAMj1kXHrS-=5Lc7rFz9Jaq8Nshss+VDgoP6n95D+w+1WB3OZEQ@mail.gmail.com>
Subject: Re: [PATCH] mm: make 'highmem' symbol ro_after_init
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 06:05:55PM +0100, Ard Biesheuvel wrote:
> > The 'highmem' variable is only set at boot, so we can make it
> > ro_after_init and prevent it from being corrupted inadvertently, or from
> > ending up in a contended cacheline.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>
> > ---
> >  mm/memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c125c4969913..50e82cb94ccc 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -106,7 +106,7 @@ EXPORT_SYMBOL(mem_map);
> >   * highstart_pfn must be the same; there must be no gap between ZONE_NORMAL
> >   * and ZONE_HIGHMEM.
> >   */
> > -void *high_memory;
> > +void *high_memory __ro_after_init;
> >  EXPORT_SYMBOL(high_memory);
> >
> >  /*
> > --
> > 2.30.2
> >
> >
>


This turns out to break CONFIG_MEMORY_HOTPLUG on x86, as it updates
max_pfn, max_low_pfn and high_memory after init.

So probably best to make all of those __read_mostly instead.
