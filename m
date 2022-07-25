Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89852580329
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiGYQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGYQyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:54:33 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0289F1D311;
        Mon, 25 Jul 2022 09:54:33 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id u76so14181178oie.3;
        Mon, 25 Jul 2022 09:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jixhLRXWZLkPKYEPDWgQPh6SGq09TVIqqu6cu1z6t7k=;
        b=YuHTg+pfPwb6ajwrekCUuNPITe9RjMHUh0ViLjsgf4uTKn/O+PnJ5Lp5LHHmKmlRG9
         axgRFXviZ7XhXSO9oaCUeX/Jn7njkcvkFb5N0no1968VgUpAAZBv0wcPCuMWEjh7fdQx
         Mn0dbDR7mZsZqBEcKmiBAZ4lX6Ll0w1OoCeVk2ovoJM0rrE05VX2ue/8A0u37nRy2l+7
         6J0ENX3lzCDfzXO9qybK8ZivP7oDQjzmOpoO2H4EqKkfjMwboUACS6YsF/v1Vo0nwQiY
         t1na3aNUyWdrHmWY216bayRZsCywWhAcYfBRqXqaX6grZ2SogNA6mMpvmb2Hs2Uv/u3+
         ZLDw==
X-Gm-Message-State: AJIora8oH7P9QbgcjxU9WWEqNbcsdiJ0w2SyRIXRvQ8BOJAz9J/KS7OI
        TnYQ1CCZLzzzWyREpxNkTMSNHhZM+oZl2YnEtAo=
X-Google-Smtp-Source: AGRyM1sY9XQjlieNOPS1xj8ijNpJJYffrn3LQVtSb+4IZMinDmFXOwpvpYSyMljfnuQLz9VNmJBzf5u5EugoiFtb3AQ=
X-Received: by 2002:a05:6808:1492:b0:33a:7448:8b98 with SMTP id
 e18-20020a056808149200b0033a74488b98mr6228395oiw.92.1658768072284; Mon, 25
 Jul 2022 09:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220724060013.171050-1-leo.yan@linaro.org>
In-Reply-To: <20220724060013.171050-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 25 Jul 2022 09:54:21 -0700
Message-ID: <CAM9d7chkrqr4P5AMRYw48JcDNsrGSMRKhwyamY5NAWbuF6jttw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf symbol: Minor fixing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Leo,

On Sat, Jul 23, 2022 at 11:00 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch set contains two minor fixing for parsing symbols.
>
> The first patch changes to use program header for parsing symbols of
> user space executable and shared objects.  Since kernel's symbol parsing
> is more complex than userspace for support both kernel symbols and module
> symbols, this is why this patch set uses conservative way and doesn't
> change kernel symbols parsing.
>
> The second patch is to detect symbols from sections without setting
> attribute flag SHF_ALLOC, these symbols are used for linker warning,
> skip to record them to avoid spurious symbols.
>
> Changes from v2:
> - Changed to use more gernal way to check the attribute bit SHF_ALLOC
>   for sections rather than check the section string name (Fangrui).
>
> Changes from v1:
> - Changed to use program header / PT_LOAD segments to parse symbols for
>   userspace executable and shared object files (Fangrui).
>
>
> Leo Yan (2):
>   perf symbol: Correct address for bss symbols
>   perf symbol: Skip symbols if SHF_ALLOC flag is not set

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/util/symbol-elf.c | 56 +++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 4 deletions(-)
>
> --
> 2.25.1
>
