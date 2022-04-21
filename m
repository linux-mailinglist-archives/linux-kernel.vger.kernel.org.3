Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E309509710
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384612AbiDUF6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384587AbiDUF6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:58:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350D06591
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:55:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v4so5075490edl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9b5jBflzggfzAqpilsQ3cgeetEBu+zmZUTEStBQLTg=;
        b=aJVQF93EoxUgAr6y80PEHphqgGX/lXqnHarYrsjx2H1pDtSf32ATDs9IspUDQm7j9b
         mW2JllHJRcsWjDZyLKdMEiYWo0UOYgul/fPhHOyGjZuz4YXgf1s6cxBXngG6CTkZyfar
         5p8zDSWMN7hmx4Z8y61hjflCRv3P8+r05YOQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9b5jBflzggfzAqpilsQ3cgeetEBu+zmZUTEStBQLTg=;
        b=Mbjvl5T0+PzV8Hrb6NQUybSObOaUGehCnFmcIjhxs/XbsTeF/58sYvToyTtJ67eGai
         XPmQx/su2Ai8NZDbotU+3KDr9CoSizNrn1V9t3NEdK6YbIuvQ6SBD8aDASKChmdBmyr1
         shPpmYMj+Bz1xpAOD7uWskFpT2OCcDGzMIM70ETdfPg3zi6fp6SlKk08nx9diwC6Eo8W
         je6cGv2WnxJPRl3vrQhEVHEd03QQRFN817WILTguyS96nqcKe3BaUxxoMTI5j0BvvS59
         CF58EreYmGQardNnxxAFEsMvjuTM82LCe9oBsG52SBK3VJA023+bmrZGVNL8IChtyu15
         u6uQ==
X-Gm-Message-State: AOAM531cqKnFzDcaZ+mW3GC+GsEi+P5ZyVJmBHi1bR3FZhmuXhk/WQBN
        FKszrlpaVrpNUo3cIaSYySBWq1He2otdnRZD5Ig=
X-Google-Smtp-Source: ABdhPJyfZ0khMIdLjYXxy4MTW9wGAOzd5kn+MahFGPLnesWJ9NRFVtsBj+lxyNPfpVbu8cJfU+FIcw==
X-Received: by 2002:a05:6402:3283:b0:423:e141:f3df with SMTP id f3-20020a056402328300b00423e141f3dfmr21438878eda.154.1650520547625;
        Wed, 20 Apr 2022 22:55:47 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b006e889ee7741sm7435218ejc.75.2022.04.20.22.55.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 22:55:47 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id k23so7815110ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:55:47 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr14909260ljh.152.1650520116613; Wed, 20
 Apr 2022 22:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com> <1650511496.iys9nxdueb.astroid@bobo.none>
In-Reply-To: <1650511496.iys9nxdueb.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Apr 2022 22:48:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
Message-ID: <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "song@kernel.org" <song@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 8:25 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Why not just revert fac54e2bfb5b ?

That would be stupid, with no sane way forward.

The fact is, HUGE_VMALLOC was badly misdesigned, and enabling it on
x86 only ended up showing the problems.

It wasn't fac54e2bfb5b that was the fundamental issue. It was the
whole "oh, we should never have done it that way to begin with".

The whole initial notion that HAVE_ARCH_HUGE_VMALLOC means that there
must be no PAGE_SIZE pte assumptions was simply broken. There were
actual real cases that had those assumptions, and the whole "let's
just change vmalloc behavior by default and then people who don't like
it can opt out" was just fundamentally a really bad idea.

Power had that random "oh, we don't want to do this for module_alloc",
which you had a comment about "more testing" for.

And s390 had a case of hardware limitations where it didn't work for some cases.

And then enabling it on x86 turned up more issues.

So yes, commit fac54e2bfb5b _exposed_ things to a much larger
audience. But all it just made clear was that your original notion of
"let's change behavior and randomly disable it as things turn up" was
just broken.

Including "small" details like the fact that apparently
VM_FLUSH_RESET_PERMS didn't work correctly any more for this, which
caused issues for bpf, and that [PATCH 4/4]. And yes, there was a
half-arsed comment ("may require extra work") to that effect in the
powerpc __module_alloc() function, but it had been left to others to
notice separately.

So no. We're not going back to that completely broken model. The
lagepage thing needs to be opt-in, and needs a lot more care.

               Linus
