Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EF57ABE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiGTBRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiGTBRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:17:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90CA6717B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:14:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d8so4055869wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJBZv4Q6ih78sOcuYMsxNeE+4gVsZnpn/0Sr9oGu6h4=;
        b=OXZe2KbCnA5IMhDjgQjh5nF9PEttZ41HWw3AZKRtdB19MLjDISfZpFmg3RfSjHTXvc
         fl6NEVXdHaSRLW6+6TxVbd8k3fvnecxEDkwFwpoR2ZWjlicjVaEZYh4EwbyHRO+Q/CbI
         D15OE6m2NStHXukDDmLL0zwaNTqyCpnrSKVU7jRYwPIF+jy2QLZ3Hep/l3Tm5imglTwF
         j5Cll5QnEQv8uRRZGslD/O3j5PT4aReL64TL2CQQndNYfdm/ls51xc86x1LG0jsPpiC5
         TIqfS4LTU0P9xD1ohPe97mCf+0K7JkW6Da8u6e7EqOURQt1drNN+FE5ahM5fkjF8AA7n
         sgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJBZv4Q6ih78sOcuYMsxNeE+4gVsZnpn/0Sr9oGu6h4=;
        b=iHnR0tIroQkCEUn0zS2an8iiVddfKvQ3wTngTLe1xH3PR4yngffVD0K8Gwoy8XFzsv
         mFXmEgIWblCi+A2gbdlgF4AC9x50YkD5oP3CWOk8UhhER7bmuYyUFxM+oaP3uAjVxfzN
         gUPMzu4fv2KUi/8PtwRcKq0z7Q52obUlh/uq7AltGC7HstUJzj74JADyFhSJBm8EbF4F
         5afsFoDfQal+qZJJYYF8tVnHgPUeb52hsO9ikWuEfkLqyoklHHZ2wzEoR2wrV4xB3ZqC
         uOZ573td48JSEN2kFXnW9hs+fqIZDedkKdAkDPMi9W4bHjSSYwzAa9GfwMJIS/nkCjPQ
         B7sw==
X-Gm-Message-State: AJIora+QyWNv/tJec6oHidbDuRdUmvn2Ztq1v2c0Hfzr/wbjbqK7dXU0
        t3eNcJFjG/te+/QpIouE1cHAHOH2AodCE+63l7rBjA==
X-Google-Smtp-Source: AGRyM1u/Bwh/R9Ajr9HzYVxMxebtsdWlhxDZxGxv5wVJCM8/ETMrerIKmXFV2uqFy2OW/ykb1SuqwYH92xXYyfip10c=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr27695297wrx.343.1658279647101; Tue, 19
 Jul 2022 18:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-31-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-31-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 18:13:54 -0700
Message-ID: <CAP-5=fUGVEDKCZxhBRh-o15qEQ1h-nrOfSy=PRsqhKuoib4=0Q@mail.gmail.com>
Subject: Re: [PATCH 30/35] perf intel-pt: Track guest context switches
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
> Use guest context switch events to keep track of which guest thread is
> running on a particular guest machine and VCPU.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/intel-pt.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index a8798b5bb311..98b097fec476 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -78,6 +78,7 @@ struct intel_pt {
>         bool use_thread_stack;
>         bool callstack;
>         bool cap_event_trace;
> +       bool have_guest_sideband;
>         unsigned int br_stack_sz;
>         unsigned int br_stack_sz_plus;
>         int have_sched_switch;
> @@ -3079,6 +3080,25 @@ static int intel_pt_context_switch_in(struct intel_pt *pt,
>         return machine__set_current_tid(pt->machine, cpu, pid, tid);
>  }
>
> +static int intel_pt_guest_context_switch(struct intel_pt *pt,
> +                                        union perf_event *event,
> +                                        struct perf_sample *sample)
> +{
> +       bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
> +       struct machines *machines = &pt->session->machines;
> +       struct machine *machine = machines__find(machines, sample->machine_pid);
> +
> +       pt->have_guest_sideband = true;
> +
> +       if (out)
> +               return 0;
> +
> +       if (!machine)
> +               return -EINVAL;
> +
> +       return machine__set_current_tid(machine, sample->vcpu, sample->pid, sample->tid);
> +}
> +
>  static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
>                                    struct perf_sample *sample)
>  {
> @@ -3086,6 +3106,9 @@ static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
>         pid_t pid, tid;
>         int cpu, ret;
>
> +       if (perf_event__is_guest(event))
> +               return intel_pt_guest_context_switch(pt, event, sample);
> +
>         cpu = sample->cpu;
>
>         if (pt->have_sched_switch == 3) {
> --
> 2.25.1
>
