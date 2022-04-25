Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1158350E94A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244860AbiDYTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbiDYTR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:17:56 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6399B2ED62;
        Mon, 25 Apr 2022 12:14:51 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id w19so27934949lfu.11;
        Mon, 25 Apr 2022 12:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHw3bSR/H7CsKHNYVZ388J1hNpCRBRDwS8dgecfZChM=;
        b=hicR/D69ANxKVPCF+DF7id9Artecst5j9WieldcfF6yVeaMpAHW6VxiUua7Otzi/qZ
         c9WmgBjW8pnONB4M9Xqd4cKTl/I8nOegNHNZ9d8UGf44ToG3buIHAwO0ZRCokmF2TX7n
         GFMEMWzJU84BAhiDZq5lbBsYjyt2GroP8f6UHniOmR0ICTx06dvJbwbqX9QxklEYItUo
         xkWDwb5pBgRjUZckmlcVuvj10j0YfhKiUSbMTroBihMnXR3osaLmSegNLDyHVjQgl8Gd
         B+xaHrKaZK8PEzEkRjUOm31DIr/A7WuRvpvj1RH9YeLzebQiJ60pRjOzpxfIjuRvIatX
         R/vg==
X-Gm-Message-State: AOAM533C4KkQnlExerDEwAtpOda7J2hl1v0cRji05/QQwMdACFtTdCvA
        K8ClGO6hYIuq6Z6JIzqg69LY5tUIxXj+7BgQMCk=
X-Google-Smtp-Source: ABdhPJyhIu6bV/7PCchygWQAOXBLRo+nw25DWy7AdnYXRE222Wbp82PwUfbfw5cBzUzTpTwxnu0Yw930jpFPtAOIVa8=
X-Received: by 2002:ac2:4c4f:0:b0:44a:4357:c285 with SMTP id
 o15-20020ac24c4f000000b0044a4357c285mr13820828lfk.99.1650914089654; Mon, 25
 Apr 2022 12:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220416004048.1514900-1-namhyung@kernel.org> <20220416004048.1514900-2-namhyung@kernel.org>
 <CAP-5=fX5S2CR58REzAhXH4s8_27=D2LbKksS7mHoSoxYOOmN4g@mail.gmail.com>
In-Reply-To: <CAP-5=fX5S2CR58REzAhXH4s8_27=D2LbKksS7mHoSoxYOOmN4g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 25 Apr 2022 12:14:38 -0700
Message-ID: <CAM9d7cgSZu43YLAWgJdw8d1TUS9geD9QrWqSQw1sWPU7ocVRtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf symbol: Pass is_kallsyms to symbols__fixup_end()
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sat, Apr 16, 2022 at 7:59 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Apr 15, 2022 at 8:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The symbol fixup is necessary for symbols in kallsyms since they don't
> > have size info.  So we use the next symbol's address to calculate the
> > size.  Now it's also used for user binaries because sometimes they
> > miss size for hand-written asm functions.
> >
> > There's a arch-specific function to handle kallsyms differently but
> > currently it cannot distinguish kallsyms from others.  Pass this
> > information explicitly to handle it properly.  Note that those arch
> > functions will be moved to the generic function so I didn't added it
> > to the arch-functions.
>
> Thanks Namhyung, in:
> https://lore.kernel.org/linux-perf-users/20220412154817.2728324-3-irogers@google.com/
> I used "dso->kernel != DSO_SPACE__USER" in symbol-elf to make this
> more than just kallsyms as presumably kernel code is the issue. Do we
> know elf kernel code has correctly sized symbols?

Yeah, IIUC the whole point of the symbol end fixup is because the
kallsyms doesn't have the symbol size info.  Every ELF binaries
should have the size except for some hand-written asm functions
which missed adding it manually.  I guess that's the reason it was
added to other DSO loading paths.

Also considering "[" (and "]") in the symbol name is specific to
kallsyms which has both kernel and module symbols together.

Thanks,
Namhyung
