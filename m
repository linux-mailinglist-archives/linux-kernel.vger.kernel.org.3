Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102D250EAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245281AbiDYVCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiDYVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:02:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C4C2AE0F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:59:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so273970wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+0NQ0MbGYoEB5Jsr85JSxqkzHf5iQdh5cM2NyrsDis=;
        b=BGex542dDfYT9HHYZfLCHcpHPGYA2/GNKIzZeosJgIywm2a3Tc6iL/Vtz2vWx7zjQc
         EVZT+T3Xu2N4CqQCITrP+06X+HS178Z/m41youJ1Drv4CbDKwtXRfqEm+kAuaet77TA3
         2QP5Wkh4qoafLDELvHmpJ2Uf/l9c6gHRn6YvMuq3QclOu4lKu121I0V/AVyvcx/Va5Wg
         /lNJla5ZwrUfCRleKMpea1Tc5hSbbcjXAWI2MPhjhFRY1ntLQBiYgKGNSfyGdWeUc7+Q
         eZu6TYEToZPYaZWgpoEC5Vz5FKdeAH7Y1gZfV/T6j40u+brBqffIhGmaocuLo+FinP0h
         wTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+0NQ0MbGYoEB5Jsr85JSxqkzHf5iQdh5cM2NyrsDis=;
        b=vZrhLxXVdaCsADbkttJVlrV5xMbiWhHvYY4a5ZSvwJozvyQwiX0D4sEAFeEhhOllrr
         LjF+U9+3njyUMTmKV+MWXo5Qy2bC4uQfCLTWNi4W6zllSm3hcACzg6LU4XKQeaZk/Uxk
         U0uNZNAcPoW2g0aGHNRREwJAkyLEvshqQfZRBca75Q0hPuN4gC5MCRrLw9qRyp+j6N1T
         n53HJpoTYxgnObhi4H483zqn7L/A6sT8zeAcPkKpYfO58HFk6eJgu3npOxUGbrnlL5x8
         LqkVuCPiDF2v1g9jytt7NGBVTqeRw5382wFV7VOF1aFJm8o0ohjFXbCRJxiBB4ZHbTpK
         SwrQ==
X-Gm-Message-State: AOAM53006byDQw2soUA/alel9RwbWAuNUaNd8cH/VF37bwokTF6P1xhQ
        5kMaIbL5fuOynAkDspS587i6ln3bsl/vg5F4twXnkg==
X-Google-Smtp-Source: ABdhPJwv8xGoKyyqY7JuRQboD78b5Wduxo+WwgNk1JdFTzVpIPkAlXaxUrQaqx469hajLw6aXoAByPWhfpp1OFNyuHw=
X-Received: by 2002:a1c:4e19:0:b0:393:dc47:b808 with SMTP id
 g25-20020a1c4e19000000b00393dc47b808mr15703552wmh.182.1650920355956; Mon, 25
 Apr 2022 13:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220416004048.1514900-1-namhyung@kernel.org>
In-Reply-To: <20220416004048.1514900-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 25 Apr 2022 13:59:03 -0700
Message-ID: <CAP-5=fUUeqimTKoO9PQbm4yDWXZtTqxWm9ZAsNt1=K5N1Rq_Lg@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Tidy up symbol end fixup (v3)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 5:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> This work is a follow-up of Ian's previous one at
>   https://lore.kernel.org/all/20220412154817.2728324-1-irogers@google.com/
>
> Fixing up more symbol ends as introduced in:
>   https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
>
> it caused perf annotate to run into memory limits - every symbol holds
> all the disassembled code in the annotation, and so making symbols
> ends further away dramatically increased memory usage (40MB to >1GB).
>
> Modify the symbol end fixup logic so that special kernel cases aren't
> applied in the common case.
>
> v3 changes)
>  * rename is_kernel to is_kallsyms
>  * move the logic to generic function
>  * remove arch-specific functions
>
> Thanks,
> Namhyung

Thanks Namhyung! The series:

Acked-by: Ian Rogers <irogers@google.com>

> Namhyung Kim (3):
>   perf symbol: Pass is_kallsyms to symbols__fixup_end()
>   perf symbol: Update symbols__fixup_end()
>   perf symbol: Remove arch__symbols__fixup_end()
>
>  tools/perf/arch/arm64/util/machine.c   | 21 ---------------
>  tools/perf/arch/powerpc/util/Build     |  1 -
>  tools/perf/arch/powerpc/util/machine.c | 25 -----------------
>  tools/perf/arch/s390/util/machine.c    | 16 -----------
>  tools/perf/util/symbol-elf.c           |  2 +-
>  tools/perf/util/symbol.c               | 37 +++++++++++++++++++-------
>  tools/perf/util/symbol.h               |  3 +--
>  7 files changed, 29 insertions(+), 76 deletions(-)
>  delete mode 100644 tools/perf/arch/powerpc/util/machine.c
>
>
> base-commit: 41204da4c16071be9090940b18f566832d46becc
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>
