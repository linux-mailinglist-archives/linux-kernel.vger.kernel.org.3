Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C214849D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiADVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiADVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:24:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF7C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:24:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f5so153616278edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqCKiYf+A5/18Td7yUtraHJy9LcjRCLCoUvNRD43+aU=;
        b=MfmNtueDVHnsYYwF7606zl1wvwmIUnMkrmZ7STTEI1WpjAcevanPdDcs4OmFi2IheI
         ZX6k3fGcbSo2/VuqQrrJ1JSFADXNPImGsiq3jIBXGy2+DjBDR2VH5ooOrmw0Bi5LsIxT
         Rf15u9d3j01bbR65HG8J945P6mls16I7jrX9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqCKiYf+A5/18Td7yUtraHJy9LcjRCLCoUvNRD43+aU=;
        b=u+WT71dHyfIlDQDFRqM8EPNfER7khlxw1k7XhaNl06FdxFgpFeEgn9qfyX8C/AWrTk
         N0s+hEAFfE6Crvn6qKzDOnyaNhTyAwijYus2RRpFdNa5hQ4RQxOpv7CbLvKTN348LrnH
         Ufp/uAuLGlQ9QeLFZpK9+BJ4K4awfjinnlFhmWzxVO9eTsPJYm9N7DuZQ7/V16Ft1yE1
         n1JatVrNz/B2XKJ9VVqE3794z+dQXrqIPjRAOCS4Dc/VRFQR0fU67I73B3EqFaWrW/tT
         qaSTloMzqCw0AUM4ELauC8fjeSwBwU1pLuOp7NerK9VZeIduNjMl5Ruu9NFJobd5Da+Z
         itCg==
X-Gm-Message-State: AOAM533Qi+dndxqgDnjy95L2hJQANpM2OXBPboFEFhUTIjdfVCVfpV7h
        z6mUrXRR/iX52XLgFYcMzCV/MlOlj41WDNPRKMU=
X-Google-Smtp-Source: ABdhPJwU2xDW7UiQEZrnaywNSe/pMyO/GvZ6XikhJR8tYNNhq48jZVtAHdBIVMLalixGW7tpX2O62g==
X-Received: by 2002:a17:906:89a:: with SMTP id n26mr12206422eje.263.1641331484386;
        Tue, 04 Jan 2022 13:24:44 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id ot19sm11707621ejb.63.2022.01.04.13.24.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 13:24:44 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id f5so153616164edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:24:44 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr43639104wrx.193.1641331473028;
 Tue, 04 Jan 2022 13:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <20220104202227.2903605-3-yuzhao@google.com>
In-Reply-To: <20220104202227.2903605-3-yuzhao@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jan 2022 13:24:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvOqj6LUhNp8V5ddT8eZyYdFDzMZE73KgPggOnc28VWg@mail.gmail.com>
Message-ID: <CAHk-=wgvOqj6LUhNp8V5ddT8eZyYdFDzMZE73KgPggOnc28VWg@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
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
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5c2ccb85f2ef..5a4843242f09 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,6 +85,7 @@ config X86
> +       select ARCH_HAS_NONLEAF_PMD_YOUNG       if X86_64

Why is this limited to 64-bit?

I'm ok with that - maybe it's a simple case of "this is not worth
doing on 32-bit", but I'd like the explanation to be written out.

Right now the commit message literally points the architecture manual
that sio relevant for both 32-bit and 64-bit - and then the patch
itself makes it 64-bit only.

              Linus
