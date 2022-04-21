Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF350A491
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390260AbiDUPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390333AbiDUPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:47:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E85DB0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:44:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so9413480lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSC/5Oarouj/IhL754LRTmrVdMvDDrWtXfrr59Z4nhk=;
        b=PUkYGIZ7ik5E9H8lnQqVXvgb0eGPjMYQ3O+Z1xj74HOz3+1ncR35ixTv8UGZI5JWZA
         cs+cNoP3Yrf91evx+8ZuL6EnE7+dJ2Ia89gpjl/iQcdVzIiw7H6duMF7mHEZaWT4lWgt
         UrVcdYkaY9nTaKfvi4Xzp9b+c1qMCNNWfAVHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSC/5Oarouj/IhL754LRTmrVdMvDDrWtXfrr59Z4nhk=;
        b=VRROu4WyBKs+mwmyNOD9c/YsQPGyH5nOYpsTYP5yKuU21N+a61OuRBGD7HiKwIQEZh
         PDy2kvmUeYPREYJFcRXbOoS2Ki40mqR5SbzMcJQZ/AvJHIzj4L2gjgTx5HrzYszhPEQi
         mWRd9NoasEXvrX6g5817B2tPSl0S4oZ0QRwJrH6XL56FjoPfmTxx1q+3H3iMtHQP5rW8
         XB4ed3c0je76yyJvN1SHSDwJPGh1hYI5cXzgW48T6FKPZpkDyAqQsraZEMchdVZ7g/ui
         zHEkJ0YSeKu32bfrrxh5CbK0sl+tmTv8o+YKzjCvEfnS/KCkYZlNQrK7qjDi1rwPFWh9
         tTsw==
X-Gm-Message-State: AOAM532e4mFPglgxT1VyfDgFtD6URN+E8iXBgY6MpjFfhY3yLrNtNt8Y
        E0wjD7iGGCRbAOVWMAvqpcm0NM4XYGm5CpCoc7w=
X-Google-Smtp-Source: ABdhPJxSVUtlWvcZD9Pj4vvLtnALHhJuzSKsxtK8cIP7AhAaVOTbqpA3fWpzV+bSQiAnrtMJCmrgTg==
X-Received: by 2002:a05:6512:3b9d:b0:470:9708:b1bb with SMTP id g29-20020a0565123b9d00b004709708b1bbmr91021lfv.418.1650555891389;
        Thu, 21 Apr 2022 08:44:51 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p7-20020ac24ec7000000b00443d65ea161sm2215366lfr.291.2022.04.21.08.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 08:44:51 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x33so9455368lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:44:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr77831lfv.27.1650555890298; Thu, 21 Apr
 2022 08:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <1650511496.iys9nxdueb.astroid@bobo.none> <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
 <1650530694.evuxjgtju7.astroid@bobo.none>
In-Reply-To: <1650530694.evuxjgtju7.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 08:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
Message-ID: <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
        Mike Rapoport <rppt@kernel.org>,
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

On Thu, Apr 21, 2022 at 1:57 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Those were (AFAIKS) all in arch code though.

No Nick, they really weren't.

The bpf issue with VM_FLUSH_RESET_PERMS means that all your arguments
are invalid, because this affected non-architecture code.

So the bpf case had two independent issues: one was just bpf doing a
really bad job at making sure the executable mapping was sanely
initialized.

But the other was an actual bug in that hugepage case for vmalloc.

And that bug was an issue on power too.

So your "this is purely an x86 issue" argument is simply wrong.
Because I'm very much looking at that power code that says "oh,
__module_alloc() needs more work".

Notice?

Can these be fixed? Yes. But they can't be fixed by saying "oh, let's
disable it on x86".

Although it's probably true that at that point, some of the issues
would no longer be nearly as noticeable.

                  Linus
