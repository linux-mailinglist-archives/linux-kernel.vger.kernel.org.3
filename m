Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA52D46A925
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350053AbhLFVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhLFVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:12:40 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF349C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:09:10 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c3so14586683iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOK4K4S7Jgnn22bwENxP9eeLDVw5lq+Zz6heR9P+gtQ=;
        b=CD1fMPDEKBCxndODtqRsbXTz3vws2TAkx518ckSyqOK0qinOz2lWs7dwdfPUR2Q96f
         8D0zmV+ENSpmSX3DTg6oqAeda2v9twolMxe/Cc2OnzpxnrfuLzpWNEsx5zRTHX3Ul6kO
         XN/1bRJbmXQDRL0+XwX3i+aHPRHaM2ecnkGkOr7tYnf9cyoVDuN4/sZHeP7UCa2duFwK
         TKb41SQNNXZyr5CyMsFrngHhx7foY6Kxd2AHOmX1LExIXBLyP3eAxgH3gIsjI7cdFKON
         H563Iu6PgFxTct20MCfMEKONwoYLAZ3k+hPvEP0GG2gbSAvB3HnzLRLs8nJdtk9xiJC3
         mY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOK4K4S7Jgnn22bwENxP9eeLDVw5lq+Zz6heR9P+gtQ=;
        b=CGW/ir7gcRNb24bNon4JiT6ObsdskGgff4uGE61CbjDao7gik6EyooQG2ReAXbcUyp
         MtfA+pnIoOrYmmN/q87pFG3tRRIpkR3ZXE4D124G5PvMbJC+IqMzBc9/BRM9ZSMDidza
         8Bx38Ddl/aXTfaOsu/8OyJr4aY3EYrN/3Om8m52qEpS10r2ND5s3LyUiJLTrV/fXAI76
         fLDyFo7AG/djU6kRIE9ex8eBsnhkUH+9RmS4ygO4TL/9xMPyTe51TLKDihGojUxrjBQQ
         UdWHRC3H1BidgbD8SMZcZJDf6rWpcZhXqGRm5qaPOv8mwF6ky2YJfOymf5DfG/HbZaSZ
         1nQw==
X-Gm-Message-State: AOAM5313riMiR8o2lXZQTw2oyo9AvRmOJHzHOuhl3360TdAPOLZ/qNh3
        VsmdOjV1VnU6lv6899Z1eF1OLbgwGrwynzsMH/c=
X-Google-Smtp-Source: ABdhPJw9EkmCf6QkZW91s5gMVFfWkYgjJogZWLnXjuDYz8eTQxFEDEt9uCWBrQjtqwa7QBLraFvVdJghV1GRrBt3u5I=
X-Received: by 2002:a5e:d502:: with SMTP id e2mr38326764iom.118.1638824950346;
 Mon, 06 Dec 2021 13:09:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <4fbc6668845e699bf708aee5c11ad9fd012d4dcd.1638308023.git.andreyknvl@google.com>
 <YajX7pyIK27Gd+IE@elver.google.com>
In-Reply-To: <YajX7pyIK27Gd+IE@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:08:59 +0100
Message-ID: <CA+fCnZdWhnSDqtQ+q1RUV1U1uVtGpr0oxVK5jtUZUn=W+5rSjw@mail.gmail.com>
Subject: Re: [PATCH 21/31] kasan, fork: don't tag stacks allocated with vmalloc
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 3:28 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Once tag-based KASAN modes start tagging vmalloc() allocations,
> > kernel stacks will start getting tagged if CONFIG_VMAP_STACK is enabled.
> >
> > Reset the tag of kernel stack pointers after allocation.
> >
> > For SW_TAGS KASAN, when CONFIG_KASAN_STACK is enabled, the
> > instrumentation can't handle the sp register being tagged.
> >
> > For HW_TAGS KASAN, there's no instrumentation-related issues. However,
> > the impact of having a tagged SP pointer needs to be properly evaluated,
> > so keep it non-tagged for now.
>
> Don't VMAP_STACK stacks have guards? So some out-of-bounds would already
> be caught.

True, linear out-of-bounds accesses are already caught.

> What would be the hypothetical benefit of using a tagged stack pointer?
> Perhaps wildly out-of-bounds accesses derived from stack pointers?

Yes, that's the case that comes to mind.

> I agree that unless we understand the impact of using a tagged stack
> pointers, it should remain non-tagged for now.

Ack. I'll file a KASAN bug for this when the series is merged.

> > Note, that the memory for the stack allocation still gets tagged to
> > catch vmalloc-into-stack out-of-bounds accesses.
>
> Will the fact it's tagged cause issues for other code? I think kmemleak
> already untags all addresses it scans for pointers. Anything else?

Tagging stack memory shouldn't cause any stability issues like
conflicts with kmemleak. Tagging memory but not the pointers is not
worse than leaving memory tags uninitialized/random with regards to
this kind of issues.

Thanks!
