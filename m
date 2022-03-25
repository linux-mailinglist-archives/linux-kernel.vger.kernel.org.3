Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855A4E7BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiCYUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiCYUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:06:58 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1365523C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:02:13 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id z134so5439710vsz.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGC0gNtc1FK7KuXrxzyTPEzkz0c3t2NTRJcLl+Gk2qo=;
        b=MJgNJJ1JjcKwOvdMtUof9IGlcOtfDtATjWPklVuECFNCBKCr5v/EhdzNkLzvauGncf
         K3GvVs3qjrYLZbMSmEF4cUIPuE8eDe2BilvaCiETKfQ/EhhKdYQjdTPKTcZuLBXqDR1J
         DuW/PH360nb5EWUmISPk/jKRtawgFu4WHuvxuhEa6++JIepDoG8CD9eRP1EtzHUPhZwc
         54UeJb+5FymNCB2pqYyQcEH6PcH7ZMNer00Xi/Jd2uyVnPoLW2x4REJto4l3b6mEyOQm
         H6RwWpYYb4iL7kkDf2olCJuCVgjKLJ357MK6iAS2nH/iiUPzOflDOle1PbD9o+fVnnIC
         5rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGC0gNtc1FK7KuXrxzyTPEzkz0c3t2NTRJcLl+Gk2qo=;
        b=1VlUzdfpoxOxGA6xnqzPSZVZikx+SlRXSGb6iahwFvmtUi2GsBREopaVnVveOrdV8e
         5N3KVUv381qvmEWt76c+D7xmIq4pQJGHFkABPpuDwIyAOGcYTi+PM0lti0jpsHhT1iKS
         1tUqvld/FBoOmCuoDgiuncGjsnewO4n8ClVWzaj5Yvmz7ydkqrAfqinn7e4o8KWQ9SpE
         Eq3sIwhLYFyiJET7Ng1uJR/rPM+c1EHz3cA/ksdFEIXL/6yWuawmcBon+r62K3P/fC3a
         Lm0Rc5pduIMoQeoZ9rnjj3wlIc+hnGoFM0T3uE9GoUtk4D5PsmQntP7THn2UtAZmJbn9
         0Yww==
X-Gm-Message-State: AOAM530XpQniL0d5I17ysDRsfq1i7t+5qtkV4osGvvumVECfdpVuQCQl
        ql5j17k+yn6cNRmuNDCVqGlzyFwscLKE4e4y8N/w1w==
X-Google-Smtp-Source: ABdhPJzmvTTds0fsXrVEh7q/dGyWtOS4f+EOS63I23cKymJySb5vCDzadUHdJxF9qjbKxwujfqwIIyH2eK4vUFrXw78=
X-Received: by 2002:a05:6102:3576:b0:325:46eb:fdde with SMTP id
 bh22-20020a056102357600b0032546ebfddemr6028813vsb.11.1648238532309; Fri, 25
 Mar 2022 13:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com> <20220322221517.2510440-11-eranian@google.com>
 <Yj4JqAimNd1INLjB@kernel.org>
In-Reply-To: <Yj4JqAimNd1INLjB@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 25 Mar 2022 13:02:01 -0700
Message-ID: <CABPqkBRPAFb9ZsbXf8Crz_jarZL6U9NpCJkh=WqVoorUSq_3mw@mail.gmail.com>
Subject: Re: [PATCH v7 10/13] perf tools: fix NULL point in evsel__env()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, rafael@kernel.org, ravi.bangoria@amd.com,
        Sandipan.Das@amd.com
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

On Fri, Mar 25, 2022 at 11:27 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Mar 22, 2022 at 03:15:14PM -0700, Stephane Eranian escreveu:
> > evsel_env() cannot return NULL. In case evsel->evlist->env is NULL default
> > to perf_env. Fixes crashes in evsel__open_strerror()
> >
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Reviewed-by: Stephane Eranian <eranian@google.com>
>
> I have this already in from a patch by Kim Phillips.
>
Ok, then. We are all set.

> - Arnaldo
>
> > ---
> >  tools/perf/util/evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 22d3267ce294..14b0e7ffa2c7 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2965,7 +2965,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >
> >  struct perf_env *evsel__env(struct evsel *evsel)
> >  {
> > -     if (evsel && evsel->evlist)
> > +     if (evsel && evsel->evlist && evsel->evlist->env)
> >               return evsel->evlist->env;
> >       return &perf_env;
> >  }
> > --
> > 2.35.1.894.gb6a874cedc-goog
>
> --
>
> - Arnaldo
