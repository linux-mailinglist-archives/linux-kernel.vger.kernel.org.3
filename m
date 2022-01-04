Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA84849F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiADVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiADVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:34:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522CC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:34:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u25so32303763edf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sZ4yuZGqCPqkUDnmCAq5OUkSffiqPtJLP/mxilEStc=;
        b=WTQCJWiv/F+zhihRmn78BQddeC/Aw0oCQZBElMoXRJVG0+X7CNlVU8TYFOV20Oh5WE
         z0rV8GBZbj47SX8qHPJu6ELaRQdWsC+bROMLvqOZa9L0wZzl3Gw+Gl8cp6ri6RK+G5iT
         Vk+4igFuBi1wjYknZjhz8qCMITn8347p12Mhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sZ4yuZGqCPqkUDnmCAq5OUkSffiqPtJLP/mxilEStc=;
        b=ZdSkCcfxCr2TKIkD19SmUXx9TDrA+o8gxd0kxnI5s7SqQhe5IL/VRBpCda9RfHMnLR
         qwLK9xXezO+NgjqzbJR9zzXKNGHy5a4P/7TlNE5+vhJAThL/KgYqH/87XjzSWghlrJ0U
         JVjfVtV+fNE6pIAN6LvrE+Re4/9FiDE7bJK5jSHk6tAJ6Bwreby0WAKU+9Pzn5sMi+wX
         e3OhFp3mNK1r2yvMvnyPTqm7Jr9V4GyKNkCLUvfl6A2eC6iLa3Z9Yy5xudbIyRfuHOm1
         KxZhp337alCiH62q0M3DoHL5ls4jWE8Hg7X9eXkEiTOu6KWwbc6hHt9Xcpopd14pFfSt
         u/5A==
X-Gm-Message-State: AOAM531Yf3UG35WleKJmEEXJ3OZV8JwLIngatUTk9AW75ORoN7du04td
        hbHpwievCzp2DKmCLfC25XCORu45DcU3LK4q80g=
X-Google-Smtp-Source: ABdhPJwASiG7no0z52RI0zVjUFPwLSAJkMjDKbKHnaMW6P5jD4Ir+tPQDGtyOtRx9A5FL3KxpBKmgQ==
X-Received: by 2002:a05:6402:2746:: with SMTP id z6mr50075971edd.294.1641332085458;
        Tue, 04 Jan 2022 13:34:45 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id a18sm15409215eds.42.2022.01.04.13.34.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 13:34:45 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso537335wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:34:45 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr224179wmj.144.1641332074339;
 Tue, 04 Jan 2022 13:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <20220104202227.2903605-5-yuzhao@google.com>
In-Reply-To: <20220104202227.2903605-5-yuzhao@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jan 2022 13:34:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wib5-tUrf2=zYL9hjCqqFykZmTr_-vMAvSo48boCA+-Wg@mail.gmail.com>
Message-ID: <CAHk-=wib5-tUrf2=zYL9hjCqqFykZmTr_-vMAvSo48boCA+-Wg@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] mm: multigenerational lru: groundwork
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 12:23 PM Yu Zhao <yuzhao@google.com> wrote:
>

> index a7e4a9e7d807..fadbf8e6abcd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
>
> +#ifdef CONFIG_LRU_GEN
> +static inline void task_enter_lru_fault(void)
> +{
> +       WARN_ON_ONCE(current->in_lru_fault);
...

Why are these in this very core header file?

They are used in one single file - mm/memory.c.

They should be just static functions there.

I'm also not sure why the calling convention is

        if (lru_fault)
                task_enter_lru_fault();

instead of doing just

        task_enter_lru_fault(vma);

and having that function do

        /* Don't do LRU fault accounting for SEQ/RAND files */
        if (unlikely(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ)))
                return;

which would seem to be a lot more legible and straightforward.

In fact, you could do it without any conditionals at all, if you just
remove the WARN_ON_ONCE() from the exit path, turning it into just

        current->in_lru_fault = !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ));

for 'enter' and just

        current->in_lru_fault = 0;

for exit.

It seems pointless to have that extra variable, and the extra
conditionals, for a case that is probably very unusual indeed.

                  Linus
