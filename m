Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985DF57A5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiGSRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiGSRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:51:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B29564D4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:51:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r2so21712202wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SieDmqK9J1h609x4vSmfoTVzQMopY1SXeRb3Ll+BMWc=;
        b=Rx/6js5ipM757vGZL6pg2GyudRa09IykQ8MRFpbIRUFuy1mBqjCKrhsXxznN0xprPN
         x29xEl/Qaqr/vKjZ7I7K2ofEYGt6o+WJuqtvvWX9RIqlKl8dEHzFyGrb6rbWkMSGQbqq
         5ueLNicDXZYEjXXetR+PMiKBVAqyePG4LRgB6Vfldl7+nXCpf4zGetYbHTNKQHp2xB5y
         R6+s4BlazmhyFlV5ZV/R5OPEvrkimqTSfGHHIbQ3wcanqbkrQ/V9YLresql07lpQVC0D
         1Qbjps2NYf0mTTtXSIrAuvvE4jhEBFh+AlUISbrRjnkl/HobcsSXHQtZq91lQDjWjmlT
         MkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SieDmqK9J1h609x4vSmfoTVzQMopY1SXeRb3Ll+BMWc=;
        b=CdBhS+nu36FJX9IznWHFEs1c7JPRRdHncSQI4cm5xleVswFnKxhFFw3nS8Bk/AeLGZ
         /vCRubeTnG2hABFe5e5kOW5QrNwTo2C+CaBFZl6ECYJQsVtxV2aFEgyEUAgjgC8fB8VW
         fFKvOjeneFtvbkezXIyZ5s4je12/wuEtl3JLkDgdjJm66g96JBkTu/idF//xmjLbH2hD
         do+aCnUFU8ZHl2uLkRkKZGbvoacUOrdpVTCWmvHDXaybK4LAygfai3MwBQ2kUUd1mPfY
         yLHcfLcCrtQ8VI3nJRSSsKRlh9lFR6MrGjc6rUG08t5RlVVD3UGL3OHGJXuu9JCYCRER
         sr8w==
X-Gm-Message-State: AJIora+uHUFVv+Vc2AOIFcMjvX40eNt7idgSYfcVu0Vs2fRu3sqhTtUO
        qEOWmRGW1OYNgWK0H66FlHa3Z/H38nzFpQDGvqtKag==
X-Google-Smtp-Source: AGRyM1vgAlJo4741zJxidIxS1f+q/y3qjO10bkWI8pwZWh4HfDxzQZHuMOAcMwVRZ7HxSUF5ynNRS83ySShFqJo1/sE=
X-Received: by 2002:a5d:6a4c:0:b0:21e:46d4:6eec with SMTP id
 t12-20020a5d6a4c000000b0021e46d46eecmr782189wrw.375.1658253099207; Tue, 19
 Jul 2022 10:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-12-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-12-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 10:51:27 -0700
Message-ID: <CAP-5=fVmRXQr9WmygngsCZ1=4f9e4YK_6GqTv9o1S3-8O=C1TA@mail.gmail.com>
Subject: Re: [PATCH 11/35] perf session: Create guest machines from id_index
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Now that id_index has machine_pid, use it to create guest machines.
> Create the guest machines with an idle thread because guest events
> for "swapper" will be possible.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Nothing obviously off to my unqualified eyes :-)

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/session.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5141fe164e97..1af981d5ad3c 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2751,6 +2751,24 @@ void perf_session__fprintf_info(struct perf_session *session, FILE *fp,
>         fprintf(fp, "# ========\n#\n");
>  }
>
> +static int perf_session__register_guest(struct perf_session *session, pid_t machine_pid)
> +{
> +       struct machine *machine = machines__findnew(&session->machines, machine_pid);
> +       struct thread *thread;
> +
> +       if (!machine)
> +               return -ENOMEM;
> +
> +       machine->single_address_space = session->machines.host.single_address_space;
> +
> +       thread = machine__idle_thread(machine);
> +       if (!thread)
> +               return -ENOMEM;
> +       thread__put(thread);
> +
> +       return 0;
> +}
> +
>  int perf_event__process_id_index(struct perf_session *session,
>                                  union perf_event *event)
>  {
> @@ -2762,6 +2780,7 @@ int perf_event__process_id_index(struct perf_session *session,
>         size_t e2_sz = sizeof(struct id_index_entry_2);
>         size_t etot_sz = e1_sz + e2_sz;
>         struct id_index_entry_2 *e2;
> +       pid_t last_pid = 0;
>
>         max_nr = sz / e1_sz;
>         nr = ie->nr;
> @@ -2787,6 +2806,7 @@ int perf_event__process_id_index(struct perf_session *session,
>         for (i = 0; i < nr; i++, (e2 ? e2++ : 0)) {
>                 struct id_index_entry *e = &ie->entries[i];
>                 struct perf_sample_id *sid;
> +               int ret;
>
>                 if (dump_trace) {
>                         fprintf(stdout, " ... id: %"PRI_lu64, e->id);
> @@ -2814,6 +2834,17 @@ int perf_event__process_id_index(struct perf_session *session,
>
>                 sid->machine_pid = e2->machine_pid;
>                 sid->vcpu.cpu = e2->vcpu;
> +
> +               if (!sid->machine_pid)
> +                       continue;
> +
> +               if (sid->machine_pid != last_pid) {
> +                       ret = perf_session__register_guest(session, sid->machine_pid);
> +                       if (ret)
> +                               return ret;
> +                       last_pid = sid->machine_pid;
> +                       perf_guest = true;
> +               }
>         }
>         return 0;
>  }
> --
> 2.25.1
>
