Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3482357AAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiGTAYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiGTAYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:24:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AC85E801
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:24:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv24so32535wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DH6ylYmRIRurAAknH36JS8D3Dyn+hEB1ror1vSU92OE=;
        b=RQoQnuQq82XCYWimGQJZgNE5suclIhz3u6jIP+21QRS1gQDC3EAHHMCTJghOz1L6YT
         8aKgCt5Y5SSW5Oq0YWeyqTg8DbUnpjmS0wr+u6zx3nvIihpeANoJuUOSNzyh1H+6ALyn
         5Eg0X60Q8eRfqObTdXt9byGE7zi1XGczQ+qyuKV73exvvXczuYp77dv01YjYRThDsyIZ
         SMJIt80B8VfZhbpueaFw1IrKSZYGr4nE/zKfBdmHHehACE90CXtOcVEt5VtZgg7VKJ6s
         jJJOq1BthbReu/apbac36kCUCSLKnfT3JPzbko6IZUiPE5dr5KTh6MllOO3Khj54OO5T
         wWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DH6ylYmRIRurAAknH36JS8D3Dyn+hEB1ror1vSU92OE=;
        b=zcZtim0qCFSV9JtivDlFqaClFqLSYdKEntUVNpOzlY0/71Us/sEppl5251ywCQvTLg
         vm3ENLqT+w0uBI65bvsto82IJaEWJDNnkbVy8Qp4XNESumHFtqg+PlmlM1iSjIvbQdjm
         /TCaXkizSq4j8CCvl/5cWOe4AC8DPfA3q1NowEQ+1pWnRARwef0wCsylgd/sHcDyTnoL
         rZdiJOucqTgF4o6/9xw41RCs+whal7vIi0hGyE1k1dyv0NIQS6sXbdCHYX//lNhP3aRt
         hIlRzE4N3g+IB6xk720Jtj4ZpdA/7/kBAywKC3ypDwx/DuSKRCIcC6LlC2I986GMp7bx
         8XZw==
X-Gm-Message-State: AJIora9Y7GjYmGzppwj0XCJXWU+n/sz1aeRuHPuu+a8J2IkOSgaLAtQJ
        5dBDyCijCnMCM+qov9vKBh5A2YRhcCUKJaS7yss3Xw==
X-Google-Smtp-Source: AGRyM1tlK1ygCVCbUo6SA22TPENkA2dWMfAg7vYjC8Lf5nfhGckv/no0VYXj+k+lYqXF8+IRdeA8jO8GV0Qd+/id77Q=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr27600763wrx.343.1658276639650; Tue, 19
 Jul 2022 17:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-13-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-13-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 17:23:47 -0700
Message-ID: <CAP-5=fU5CHoxybx7U9zjz0S2vZ=vsR6ZmUoaD0ne9YCBQEvF_A@mail.gmail.com>
Subject: Re: [PATCH 12/35] perf tools: Add guest_cpu to hypervisor threads
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
> It is possible to know which guest machine was running at a point in time
> based on the PID of the currently running host thread. That is, perf
> identifies guest machines by the PID of the hypervisor.
>
> To determine the guest CPU, put it on the hypervisor (QEMU) thread for
> that VCPU.
>
> This is done when processing the id_index which provides the necessary
> information.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/session.c | 18 ++++++++++++++++++
>  tools/perf/util/thread.c  |  1 +
>  tools/perf/util/thread.h  |  1 +
>  3 files changed, 20 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1af981d5ad3c..91a091c35945 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2769,6 +2769,20 @@ static int perf_session__register_guest(struct perf_session *session, pid_t mach
>         return 0;
>  }
>
> +static int perf_session__set_guest_cpu(struct perf_session *session, pid_t pid,
> +                                      pid_t tid, int guest_cpu)
> +{
> +       struct machine *machine = &session->machines.host;
> +       struct thread *thread = machine__findnew_thread(machine, pid, tid);
> +
> +       if (!thread)
> +               return -ENOMEM;
> +       thread->guest_cpu = guest_cpu;
> +       thread__put(thread);
> +
> +       return 0;
> +}
> +
>  int perf_event__process_id_index(struct perf_session *session,
>                                  union perf_event *event)
>  {
> @@ -2845,6 +2859,10 @@ int perf_event__process_id_index(struct perf_session *session,
>                         last_pid = sid->machine_pid;
>                         perf_guest = true;
>                 }
> +
> +               ret = perf_session__set_guest_cpu(session, sid->machine_pid, e->tid, e2->vcpu);
> +               if (ret)
> +                       return ret;
>         }
>         return 0;
>  }
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 665e5c0618ed..e3e5427e1c3c 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -47,6 +47,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
>                 thread->tid = tid;
>                 thread->ppid = -1;
>                 thread->cpu = -1;
> +               thread->guest_cpu = -1;
>                 thread->lbr_stitch_enable = false;
>                 INIT_LIST_HEAD(&thread->namespaces_list);
>                 INIT_LIST_HEAD(&thread->comm_list);
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index b066fb30d203..241f300d7d6e 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -39,6 +39,7 @@ struct thread {
>         pid_t                   tid;
>         pid_t                   ppid;
>         int                     cpu;
> +       int                     guest_cpu; /* For QEMU thread */

Could we tweak the comments here to be something like:

int cpu;  /* The CPU the thread is currently running on or the CPU of
the hypervisor thread. */
int guest_cpu; /* The CPU within a guest (QEMU) that's running. */

Does -1 convey meaning beyond uninitialized, like with the 'any' CPU
perf_event_open argument?

Thanks,
Ian


>         refcount_t              refcnt;
>         bool                    comm_set;
>         int                     comm_len;
> --
> 2.25.1
>
