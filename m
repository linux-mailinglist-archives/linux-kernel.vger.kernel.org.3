Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7192F5159B5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiD3CB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 22:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiD3CB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:01:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9314012
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:58:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t6so12841764wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SQwkLL+ZCA5hN5KohCZn3RbFdUHh1hif+oq0ZUhMv5I=;
        b=owZ8cKOChI3/JZyZRkbJjlSsXPG4Grznrs1QYnjy3aXQ45WjDe5O//Ft/iPCf3V7/h
         H9EFfOwaV2PyWOmbN22il1h2bJirF4nTzXnmldTdgkKSQChAc3YqBUJYaWoOD6lIEP6Q
         Mz7hAqukkkAE/GJFyT8mmvGgi7A4gQ1QNmWtf/hu0sB4cUrG9sF4lAqzmyUR3FYWKZKC
         OweeoNfsih40MkSd5EtUp8fb4XTlHbWjdbmCuYrsNfAHVKKNL3ZFfBVaCV7zQ6H/rFh+
         MixEvqDHBo5+oMJqTX2533MiroEu2UEDTXMnLHDPzB5GHl7d1jeKPx8qf7uLK+OLMLfE
         Yx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SQwkLL+ZCA5hN5KohCZn3RbFdUHh1hif+oq0ZUhMv5I=;
        b=BQMiNtWkhW4ln4ui/riKFowY9LhlkDzmcuQhwxlgru1uJsBfOF1US36guiJ8N5Jums
         SSntFauVK6GZEbetOgvoxa1+D7Z0WjFdPCjE+j9SVpfTYuA6DXyh8XMFvJNyr4K93WL3
         JlvIAp+HETBvPw2N2pkWccG2ArZIjTqIakE5qlZ2rwWJT4XIWjgmJ56A4vRnUqRPuMKH
         gVMMdYVsjvrbeYdERd27etGu0ErT07mX81AzQ50C0wn5j8Q4NE+lYTuUqTcuvS1eazQt
         rTUHr4DUwEq1GgIX2SXJmwPDL87plfgQsXIQHYHjkDH1mrhZ1cpCPtCHzbNHPQBSHAyT
         6DTw==
X-Gm-Message-State: AOAM532EHAXlD1UaW6TIg/LA/z53xALVs/boRNFUA2ZuJUJXY22r/oZi
        Vhuq09Jfiqsof8Uyqcceh3bduUtL+HhXSkd5OojB8w==
X-Google-Smtp-Source: ABdhPJy+EQ9OKcMWXOWC9o3tshTa5CDPLuDr75dSqrhUXBjwOTNRAKMntrHvFw2CKo+Gm2p3c9VrgdUEwZAnFq2eKOk=
X-Received: by 2002:adf:dd0e:0:b0:20a:c689:f44a with SMTP id
 a14-20020adfdd0e000000b0020ac689f44amr1365573wrm.40.1651283914930; Fri, 29
 Apr 2022 18:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220428202912.1056444-1-irogers@google.com> <FDBE8FEC-CC4B-43C2-B2AA-3ECCFF95A98E@linux.vnet.ibm.com>
In-Reply-To: <FDBE8FEC-CC4B-43C2-B2AA-3ECCFF95A98E@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Apr 2022 18:58:22 -0700
Message-ID: <CAP-5=fVr2Egp=_vw1nHc1QN4T4uLaGygQGQuvTRpaA-hFR8uOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf bench: Fix two numa NDEBUG warnings
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 29, 2022 at 2:21 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 29-Apr-2022, at 1:59 AM, Ian Rogers <irogers@google.com> wrote:
> >
> > BUG_ON is a no-op if NDEBUG is defined, otherwise it is an assert.
> > Compiling with NDEBUG yields:
> >
> > bench/numa.c: In function =E2=80=98bind_to_cpu=E2=80=99:
> > bench/numa.c:314:1: error: control reaches end of non-void function [-W=
error=3Dreturn-type]
> >  314 | }
> >      | ^
> > bench/numa.c: In function =E2=80=98bind_to_node=E2=80=99:
> > bench/numa.c:367:1: error: control reaches end of non-void function [-W=
error=3Dreturn-type]
> >  367 | }
> >      | ^
> >
> > Add return statements to cover this case.
>
> Looks fine to me
>
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>
> Thanks
> Athira

Thanks Athira :-) Arnaldo, could we get this in the 5th batch for 5.18
to keep NDEBUG building? It looks like there is a missing build test
for NDEBUG too.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > tools/perf/bench/numa.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > index 44e1f8a44087..d5289fa58a4f 100644
> > --- a/tools/perf/bench/numa.c
> > +++ b/tools/perf/bench/numa.c
> > @@ -311,6 +311,7 @@ static cpu_set_t *bind_to_cpu(int target_cpu)
> >
> >       /* BUG_ON due to failure in allocation of orig_mask/mask */
> >       BUG_ON(-1);
> > +     return NULL;
> > }
> >
> > static cpu_set_t *bind_to_node(int target_node)
> > @@ -364,6 +365,7 @@ static cpu_set_t *bind_to_node(int target_node)
> >
> >       /* BUG_ON due to failure in allocation of orig_mask/mask */
> >       BUG_ON(-1);
> > +     return NULL;
> > }
> >
> > static void bind_to_cpumask(cpu_set_t *mask)
> > --
> > 2.36.0.464.gb9c8b46e94-goog
> >
>
