Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1352CAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiESEIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiESEIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:08:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE8AFB32
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:08:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z2so7519064ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NuTN6+F3TBVlFzEcXPbTfTSxJJpUOQDs3Y2ry8Jne0=;
        b=mH2llISZenMBvGXANBcqE5aANz8QcBamzb+hFox7K8HGfGN/weV2lCOdRhy/dPSPCO
         3z3OXGaMdfYxtwPSOduMuc2kYwvHrLSKBpcUhlgW/stCQzC8NPyYNDO4cyA5T+OKPuZJ
         CNaR8UiojwlJ2MMZAzLARljH+2A8OblwDbaYp1A9Wx9X4vKuojYxUiIRq8DFS304i8vY
         OIWojYSH/2ofFVTbXBTf4UCB/WSc2ZBN0ChjfqUviwzjZQ8mgrXmc90Moy/N/t+I4OVq
         uhQY3n4xH35mgxMEGit9nVTDO3hZxN4FBSJeyOlKz9iguRPkWU2X9KiTd2YgCn0aNvKt
         1ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NuTN6+F3TBVlFzEcXPbTfTSxJJpUOQDs3Y2ry8Jne0=;
        b=Kv6nK1/i7KTqgF78+e5/RqQASHp1qqwpVPgfwecpehPCsghtzGAL/Nz3Xfo0OcxSwV
         ItOYpcA+sybl7cI/fixWJVv26bpdIsR26oxqUcFa/92pdVaJi8Avvi/A6NcsOptKKjSW
         emEroo7pv+CT6vVPUuHOqf9/MR88n020HhtmgIStJgfJH9W59y1RCtL6k55rrwawxkDO
         8qdxPDCtIry34ZkeLTOuxnrzLv/Z2qs/l05mxid3VTYA7EMuyFLaK6le82eZu13HAHpn
         ry0ClVeRaylGpG4ICaWCHKUfewDm4ewvHG3N/AH6zi/bLSfm/E+XsqGLoLp2plAtm2YZ
         jrVA==
X-Gm-Message-State: AOAM533X759YXtY305J/0E5lL15bvsSqMj+t47/uO+lo9lXKa76qEfRP
        UIdycM3Qey4drJ7srcvnnXltsN2l2r/MwUgGnaYHzP5YdUxysjzV
X-Google-Smtp-Source: ABdhPJxWnZ/+po2yuf7QTqvUbRYgFyJlL22dsPnz5xfr+cYG0iUXYo+9qOcpeEbzVPemTgXOZyJ3sflpJUuYqb9FRPk=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr2119695wrb.300.1652933313841; Wed, 18
 May 2022 21:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220518224725.742882-1-namhyung@kernel.org> <20220518224725.742882-7-namhyung@kernel.org>
In-Reply-To: <20220518224725.742882-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:08:21 -0700
Message-ID: <CAP-5=fWyH=-XDdOsCjLTOHO09vCHnUcnijvVT0mw0zp6Ft57zA@mail.gmail.com>
Subject: Re: [PATCH 6/6] perf test: Add a basic offcpu profiling test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
>   $ sudo ./perf test -v offcpu
>    88: perf record offcpu profiling tests                              :
>   --- start ---
>   test child forked, pid 685966
>   Basic off-cpu test
>   Basic off-cpu test [Success]
>   test child finished with 0
>   ---- end ----
>   perf record offcpu profiling tests: Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record_offcpu.sh | 60 +++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_offcpu.sh
>
> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
> new file mode 100755
> index 000000000000..96e0739f7478
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +# perf record offcpu profiling tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +  rm -f ${perfdata}
> +  rm -f ${perfdata}.old
> +  trap - exit term int
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup exit term int
> +
> +test_offcpu() {
> +  echo "Basic off-cpu test"
> +  if [ `id -u` != 0 ]
> +  then
> +    echo "Basic off-cpu test [Skipped permission]"
> +    err=2
> +    return
> +  fi
> +  if perf record --off-cpu -o ${perfdata} --quiet true 2>&1 | grep BUILD_BPF_SKEL
> +  then
> +    echo "Basic off-cpu test [Skipped missing BPF support]"
> +    err=2
> +    return
> +  fi
> +  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
> +  then
> +    echo "Basic off-cpu test [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time"
> +  then
> +    echo "Basic off-cpu test [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q --percent-limit=90 | egrep -q sleep
> +  then
> +    echo "Basic off-cpu test [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic off-cpu test [Success]"
> +}
> +
> +test_offcpu
> +
> +cleanup
> +exit $err
> --
> 2.36.1.124.g0e6072fb45-goog
>
