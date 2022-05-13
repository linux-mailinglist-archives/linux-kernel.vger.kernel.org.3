Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE58E52675A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382458AbiEMQpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380256AbiEMQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:44:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D4013CD8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:44:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so5156911wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLl1Ai3+5yqqnQbitkLo268aeXr5rmYysO1HcDqU5yM=;
        b=S4GhaWhcyUpPoJ5lggTeuTH0MjQoxEYbnpHH9bwHXFmP7yjd6FAMpuEGclAfW+/Gkt
         XxM6yNJ9bvNehnB9Nr6qTBPUG2LX5HR3K6auzP96vRl3UjEfT2dOoCFzVX17sLwfKqx6
         wOcOGPREC3UGRpBFAXgpMsf5fwysR86uk/b1ZgTV9QvB9Q9BhU3tFKxD6byK4fi26rLr
         YYe3YWxZNQf8e9QcGqgotoegXPMgnIlLtgpggRN93018KVVwX4O14/ucIm7Y6kj0aeY7
         QbFHP6WBKiT5Ku+66kH9lQ/p3iIGKDgn0djyYLmFpDWyFbyFD4KBXOxYaVzmlS4+YBVv
         W2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLl1Ai3+5yqqnQbitkLo268aeXr5rmYysO1HcDqU5yM=;
        b=0Z5R6U3P6Puh7vQHD4rGZ8k6iAf+7g471hsHCnXQ/2EHGNUALL914D9v7QWyKpKrbx
         sjaranQEalrMXevddOFj0Y7jTcZIqZm+74kWuDytx1rsmlBjV/u6+zGTusBMJJaFH70Z
         Xc8jubr8tGrGmMI6jo5lKsQuGEwEefitPafigU+uTuTYbqZ06fj9ZJT+Jgj+7wQ38HWN
         e9Beq7iQ0xXhAG5VUWnlJHDAz02EFiLi3muV8JCdNQifxFQrpsT2TpuK7P6O+OT9mfF4
         tQv2pngR/9RemvJO3BOvLXndiQ6C4CencR4sWnLBTZRc2h0aiK8jl2lMBl3ZPHy+zRAT
         Tl8w==
X-Gm-Message-State: AOAM532f+hchOsxcb+pH4SZsgebGOtRpSHM5s+Y5/MebcmSMbs2/62qr
        +kL2sAQQGvY1B0nQqDs1JISRhW/AQTturf0B/bCHWA==
X-Google-Smtp-Source: ABdhPJz3/T3d4FtiHrGsUXeBLuV07r5YHYGCEKw//rIIAyFq5BclWYeJRZcUcOuDyIQ0HNnXxz52OsDUFz/ZbwSfom4=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr4799895wro.654.1652460297267; Fri, 13
 May 2022 09:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220513151554.1054452-1-kan.liang@linux.intel.com> <20220513151554.1054452-4-kan.liang@linux.intel.com>
In-Reply-To: <20220513151554.1054452-4-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 09:44:44 -0700
Message-ID: <CAP-5=fXL3f_CQrq=q31BiikthTkUjuDohNp8eiowqOeo28FANw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf parse-events: Support different format of the
 topdown event name
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The evsel->name may have a different format for a topdown event, a pure
> topdown name (e.g., topdown-fe-bound), or a PMU name + a topdown name
> (e.g., cpu/topdown-fe-bound/). The cpu/topdown-fe-bound/ kind format
> isn't supported by the arch_evlist__leader(). This format is a very
> common format for a hybrid platform, which requires specifying the PMU
> name for each event.
>
> Without the patch,
>
> $perf stat -e '{instructions,slots,cpu/topdown-fe-bound/}' -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      <not counted>      instructions
>      <not counted>      slots
>    <not supported>      cpu/topdown-fe-bound/
>
>        1.003482041 seconds time elapsed
>
> Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
> The events in group usually have to be from the same PMU. Try reorganizing the group.
>
>
> With the patch,
>
> perf stat -e '{instructions,slots,cpu/topdown-fe-bound/}' -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>        157,383,996      slots
>         25,011,711      instructions
>         27,441,686      cpu/topdown-fe-bound/
>
>        1.003530890 seconds time elapsed
>
> Fixes: bc355822f0d9 ("perf parse-events: Move slots only with topdown")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index cfc208d71f00..75564a7df15b 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -36,7 +36,7 @@ struct evsel *arch_evlist__leader(struct list_head *list)
>                                 if (slots == first)
>                                         return first;
>                         }
> -                       if (!strncasecmp(evsel->name, "topdown", 7))
> +                       if (strcasestr(evsel->name, "topdown"))
>                                 has_topdown = true;
>                         if (slots && has_topdown)
>                                 return slots;
> --
> 2.35.1
>
