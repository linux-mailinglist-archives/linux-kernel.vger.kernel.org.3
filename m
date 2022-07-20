Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C057AB85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiGTBMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbiGTBMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:12:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB0643FE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:12:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so339337wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwSUfPkQVeR7NYyFbUEPjbwfxOPGOsnMvFnmzzVWm6o=;
        b=h4ETeloH7fEzsDaxeEtLaNiME7Eki7tRET7EZCLK7UzBLTYNLSYhlTtHO6ZXX54qZB
         V+VQSn3Ze3N0m69Yoef6AzDyaIvqxGobzhyOhIJzJpZQpxaNmqqOgGzB5ZJbL06ppK98
         SC13T2eXLjk5VCwEf4g+wkasGTtt2/C/hfd9S5sZ/ubeLq+GzlKmY8Dd/Ffn+EgLRykz
         zP5e+w3YsEnztn6erjcBq0skxh67Z5wKwf+or+2RKr/6yidd6a/Hx/TEJUcKE5ZdpzbW
         k8V0ZV8weXP7ESvWMMGnsTMaE+kcYVzMV12so0c9QAP6j92x7cPIIzM0i4aHAJ+Kww7k
         fvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwSUfPkQVeR7NYyFbUEPjbwfxOPGOsnMvFnmzzVWm6o=;
        b=Cq7XSlBu53JyaVBdeFFFdKQWzPnbE/r0ut30vHWd+wSHpWOcJx+FXd9a26efnm4d+p
         3U60sn98rxi1vZYjTO2DFW8MIlBKZESsWZXn5upRNEfYcJ/jnymcwJCurDbk6FxNOl2E
         dHBDH/lI8T130cLYMELYkh4DYAxE3feclQZSzu8dpJkTOFI2pg9Z+89YP3f2b4xWcmfM
         NnpeNkF9X1xJ/6fT5a9oFC3ZKBGKpX0w7gMOxGkc0ErL+wQ1y4u1y1Tnal7phP74CJi8
         qNHBLoznprPYZM91JM90Yhuyg5mOw5tBieEtUp/xenWWd2sOXsimH4Vq9+LPCtTRO3+8
         2IqA==
X-Gm-Message-State: AJIora/biQf4iMXIMNwNHUyZo9BjQe8U8sdFm6F4pVgwa2wdD7Mz9S9w
        a/0xlRNF8XIDlIL85bRJ6zaY4yJGsZB0LeJBPydQrw==
X-Google-Smtp-Source: AGRyM1s9XPVY6MfzpZH32z0fEyhH1tdpOtvVVTAtcchSfPEZbHXO0IiLEbmDmgZPUyD9pxe7setPm0Vm7rCc/6ZhyY4=
X-Received: by 2002:a7b:c8d3:0:b0:3a2:fe0d:ba2e with SMTP id
 f19-20020a7bc8d3000000b003a2fe0dba2emr1533504wml.115.1658279519587; Tue, 19
 Jul 2022 18:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-28-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-28-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 18:11:47 -0700
Message-ID: <CAP-5=fXC4SYyV3DJKxy0atW1RRSS8EouD+t=pXuqJPSQ=x_jMA@mail.gmail.com>
Subject: Re: [PATCH 27/35] perf tools: Add perf_event__is_guest()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add a helper function to determine if an event is a guest event.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/event.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index a660f304f83c..a7b0931d5137 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h

Would this be better under tools/lib/perf ?

Thanks,
Ian

> @@ -484,4 +484,25 @@ void arch_perf_synthesize_sample_weight(const struct perf_sample *data, __u64 *a
>  const char *arch_perf_header_entry(const char *se_header);
>  int arch_support_sort_key(const char *sort_key);
>
> +static inline bool perf_event_header__cpumode_is_guest(u8 cpumode)
> +{
> +       return cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
> +              cpumode == PERF_RECORD_MISC_GUEST_USER;
> +}
> +
> +static inline bool perf_event_header__misc_is_guest(u16 misc)
> +{
> +       return perf_event_header__cpumode_is_guest(misc & PERF_RECORD_MISC_CPUMODE_MASK);
> +}
> +
> +static inline bool perf_event_header__is_guest(const struct perf_event_header *header)
> +{
> +       return perf_event_header__misc_is_guest(header->misc);
> +}
> +
> +static inline bool perf_event__is_guest(const union perf_event *event)
> +{
> +       return perf_event_header__is_guest(&event->header);
> +}
> +
>  #endif /* __PERF_RECORD_H */
> --
> 2.25.1
>
