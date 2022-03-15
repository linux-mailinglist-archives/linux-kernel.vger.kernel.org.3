Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29344D950C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiCOHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbiCOHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:14:11 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3882755BA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:12:59 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id u124so19712395vsb.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9gQzM4WgodiwgsEK8zJj7FBjgYRuL2M0zsnUh0K7/M=;
        b=MXpBgzExUEKpXk5PjEC0s1oaNP4PzMCLVbFg4yQZaP1E/P0ou5ZGPs0r9wEft4DUXR
         JNJegl/FezY6/tMWB3RDmkOH/9SBCYvgg93HsWT1jLSU6cMyb/FbHD0g0E/vbEJB8WFE
         2FvRIDjD9nBCu4TZJUJoamB2woIqc050xFpdX80m2YhJAcn+o8yARjZTh8LSlOxdI90/
         5truD2oRixa+dcdpDrYH91SP2LvfeV1lhFr1hx5fHNyGxKHDIiPVdNec2Li1zHY+5rU7
         +0ScSQqnV0QgSL4VbItOGqNwo16r+EWMEpZplbusWCNWTso6ZbGrYK2nE56Tlr9o6q0W
         GqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9gQzM4WgodiwgsEK8zJj7FBjgYRuL2M0zsnUh0K7/M=;
        b=r8uRZ0y80osTOavYrCLcuYp9Tzehjsn1zLW/xMiARbHaXEbs11qbQCeDKjfMD9I+mK
         8CQ9qTzKVBP9Fo/X8Ovj7HzYL6NEHwHXMO4N8P/HmRFOXsnezGrbbjdMWCOUooiTaXg4
         KtmfTLRvASK1uwOuNwXjPd3nhj6loXbTjnFuwtrKHa/ZpquDwL2COyzQhzqL4zTOwvz9
         rtOLcDX+5NzcZ77rkqV+S35+9KpnRnTcX3eH/xZaCMb1L79JLBre4WevzTuXwOMIdwkU
         oT5SGyoPRPFT57aIL2I1R26gbLzD3IgAkeNsD2TqqpIfkb7JfgxnN/rR8LPrekj5FMqc
         1dAA==
X-Gm-Message-State: AOAM5338N4cGRuFJkbbq5BaGyJMvCzh3Fj49lm7RUKagqN2gNGrxKAju
        cAzbcR/HBPvJauxk4ui9xqP38J/SmNl3CeIjq0dRVg==
X-Google-Smtp-Source: ABdhPJxvNB6F2jKdwdUY1eJaDMcOgZysmzj0s9gqbe23TSbgI6jg+PKggPugGX2tEV50aoUM+ZrektHZK7olAPbm1YI=
X-Received: by 2002:a05:6102:3748:b0:323:1115:f961 with SMTP id
 u8-20020a056102374800b003231115f961mr301799vst.67.1647328378092; Tue, 15 Mar
 2022 00:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com> <20220208211637.2221872-11-eranian@google.com>
 <CABPqkBSzc167wNbJpWu7msfZ-KrGu-nMtFdw-naN+M7Q0py-vA@mail.gmail.com> <5609a43a-afbe-7629-b84d-75ace62da4fe@amd.com>
In-Reply-To: <5609a43a-afbe-7629-b84d-75ace62da4fe@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 15 Mar 2022 00:12:46 -0700
Message-ID: <CABPqkBSnuMkT6t8SG-sFZ1-VN-CWLN4wNnS0zg40OHaUJB+99A@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com,
        linux-kernel@vger.kernel.org
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

On Mon, Mar 14, 2022 at 11:23 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> >> +static bool is_amd(const char *arch, const char *cpuid)
> >> +{
> >> +       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
> >> +}
> >> +
> >> +static bool is_amd_ibs(struct evsel *evsel)
> >> +{
> >> +       return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
> >> +}
> >> +
> >>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >>                          int err, char *msg, size_t size)
> >>  {
> >> +       struct perf_env *env = evsel__env(evsel);
> >> +       const char *arch = perf_env__arch(env);
> >> +       const char *cpuid = perf_env__cpuid(env);
> >
> >
> > This code dies for me on the latest tip.git because env = NULL and
> > perf_env_cpuid() is broken for NULL argument.
> > I don't quite know where this env global variable is set but I hope
> > there is a better way of doing this, maybe using
> > the evsel__env() function in the same util/evsel.c file.
> >
> > Similarly, the is_amd_ibs() suffers from a NULL pointer dereference
> > because evsel->pmu_name maybe NULL:
> >
> > $ perf record -e rc2 .....
> >
> > causes a NULL pmu_name.
>
> This should fix the issue:
>
> @@ -2965,7 +2989,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>
>  struct perf_env *evsel__env(struct evsel *evsel)
>  {
> -       if (evsel && evsel->evlist)
> +       if (evsel && evsel->evlist && evsel->evlist->env)
>                 return evsel->evlist->env;
>         return &perf_env;
>  }
>
I will check with that change. Similarly, the IBS helper needs to have
the following change:
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2854,13 +2854,18 @@ static bool is_amd(const char *arch, const char *cpuid)

 static bool is_amd_ibs(struct evsel *evsel)
 {
-       return evsel->core.attr.precise_ip ||
!strncmp(evsel->pmu_name, "ibs", 3);
+       return evsel->core.attr.precise_ip
+           || (evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3));
 }
