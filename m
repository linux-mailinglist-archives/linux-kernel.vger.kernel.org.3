Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6886150AE44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443680AbiDVC7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbiDVC67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:58:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12B4ECE0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:56:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g13so13721667ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppxYJpilG8kq+TFq7q0/hAFZJS7FtFUQSQusR4SqlvA=;
        b=Xctnh2iK5uByYnDTDm5OXbRfKcEVx4Xs78FxhxW87Sw/K0tponrZPQ+y9TipNokajo
         yMZLfRCLO6Pr6DCynUM4uHbdbfAIEevQALChH2DhzRyAy3ocXyIrbT+tBuTUR1rxaypw
         q+M9mSEDvFTqlaMTl/bftJ5L/6+6k0Tkc5roo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppxYJpilG8kq+TFq7q0/hAFZJS7FtFUQSQusR4SqlvA=;
        b=P+FbLw96mrsvPMsPxZWDh/+q09+z+tqSgwHDX3TLCLHlgNbnakvM7k2HYeTx5NCsrN
         XJ/0RyerHIgkfjuRe7wajTn0Xd84fOAEgGLjF/JI8mRtQ4OAm84hH//anXCdy5VvJgyG
         haLkDNclwTToZm3hswiRaJmHd2K4shlt/QfEzbYm7PuwQmNQNDWg4s3r3DPli8Ldd0dP
         HYKvmv3PgLPC9YXbpEixBzkz1h/jmqP++LkNh73qcKzJFF5keoQAIbR0L8BpJMfJ3bFb
         BGNI6lUlldYS6qjYJVVlHgXFM+4Osj63N08SidD2Mix6rd1s5CSO/KyE/JYpltEW2z8B
         Kdgw==
X-Gm-Message-State: AOAM533ocuBCbD3Nno0q5EPLmZty9px6EvRkLp6O2Nga2QH36vmDdo/e
        VEBbTzx3ILBdzkJnqVp9q9uAYoyPlas+2pB+YKs=
X-Google-Smtp-Source: ABdhPJzYo7AM9d3GKrfcway/wMVkIAuuyE5+5LtPAFI9XtEAI/38Jk7NZtrF6vj82tTIDwGggdeudw==
X-Received: by 2002:a17:907:6d25:b0:6ef:5af5:f1d3 with SMTP id sa37-20020a1709076d2500b006ef5af5f1d3mr2064526ejc.315.1650596159627;
        Thu, 21 Apr 2022 19:55:59 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm279910ejc.147.2022.04.21.19.55.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 19:55:59 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id q7so1471010wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:55:59 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr1630672lfv.27.1650595688485; Thu, 21
 Apr 2022 19:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <1650511496.iys9nxdueb.astroid@bobo.none> <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
 <1650530694.evuxjgtju7.astroid@bobo.none> <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
 <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
 <1650584815.0dtcbd4qky.astroid@bobo.none> <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
In-Reply-To: <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 19:47:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+xn7WbSEb1boSCj+AEUwwAGmXf5Hvb0822BHyBwRoDw@mail.gmail.com>
Message-ID: <CAHk-=wg+xn7WbSEb1boSCj+AEUwwAGmXf5Hvb0822BHyBwRoDw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
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

On Thu, Apr 21, 2022 at 7:29 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> FWIW, I like this direction. I think it needs to free them differently
> though?

Very much so.

> Besides fixing the bisected issue (hopefully), it also more cleanly
> separates the mapping from the backing allocation logic. And then since
> all the pages are 4k (from the page allocator perspective), it would be
> easier to support non-huge page aligned sizes. i.e. not use up a whole
> additional 2MB page if you only need 4k more of allocation size.

I don't disagree, but I think the real problem is that the whole "oen
page_order per vmalloc() area" itself is a bit broken.

For example, AMD already does this "automatic TLB size" thing for when
you have multiple contiguous PTE entries (shades of the old alpha
"page size hint" thing, except it's automatic and doesn't have
explicit hints).

And I'm hoping Intel will do something similar in the future.

End result? It would actually be really good to just map contiguous
pages, but it doesn't have anything to do with the 2MB PMD size.

And there's no "fixed order" needed either. If you have mapping that
is 17 pages in size, it would still be good to allocate them as a
block of 16 pages ("page_order = 4") and as a single page, because
just laying them out in the page tables that way will already allow
AMD to use a 64kB TLB entry for that 16-page block.

But it would also work to just do the allocations as a set of 8, 4, 4 and 1.

But the whole "one page order for one vmalloc" means that doesn't work
very well.

Where I disagree (violently) with Nick is his contention that (a) this
is x86-specific and (b) this is somehow trivial to fix.

Let's face it - the current code is broken. I think the sub-page issue
is not entirely trivial, and the current design isn't even very good
for it.

But the *easy* cases are the ones that simply don't care - the ones
that powerpc has actually been testing.

So for 5.18, I think it's quite likely reasonable to re-enable
large-page vmalloc for the easy case (ie those big hash tables).

Re-enabling it *all*, considering how broken it has been, and how
little testing it has clearly gotten? And potentially not enabling it
on x86 because x86 is so much better at showing issues? That's not
what I want to do.

If the code is so broken that it can't be used on x86, then it's too
broken to be enabled on powerpc and s390 too. Never mind that those
architectures might have so limited use that they never realized how
broken they were..

                 Linus
