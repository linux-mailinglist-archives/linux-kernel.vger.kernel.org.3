Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321DA46574A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353138AbhLAUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353016AbhLAUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:24 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C2C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:41:01 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id j21so26758834ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfM/nWKMWbGBLmnV2at31PPwZCgJsXOpcFB/isQorhM=;
        b=RqrC3vCuo8LxuVLAFUajJky8dtj0Mq2SWM21mTGIoMqt4vT5dhQZzGOUvbzmyR0rZ3
         cjOwFx0zTn+MKK7yqE0TlcUidmZNa9faXs4kDLPZydhjDtZcLdG3r9wHCtHi5ijyIken
         AqGZzC8ew1zKqlxXjPutLRfcoZiuowG8hhRSA8DQniR8sjYKogDB32Rrh6H57okPHDWU
         GO6+mSSNMG01gBth2Rn3NqOAoZRDqcOWVjLB+Rdya5WjBBYlhwYKswAVaw372+dJz9aQ
         x1pJs+LxHl2rAm2iXSjIifHQFEtlVeQfnvh10rlXhrCCIimRexXtwclE6e9La5eImgQ5
         iiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfM/nWKMWbGBLmnV2at31PPwZCgJsXOpcFB/isQorhM=;
        b=1bDnT1KgIIzEnH6Pbj73ldApxCYoU2NfQ844axvmkpzxx5WPbXNe/dJNYp0z5gKHeC
         g8IYvwubz4RxyyeZtyPs53Lm4RCAyVQtuB/nOmFjGg0ocyKFOFW25d0TkBQMMcHDETRm
         0Afp2KaVVVBNMPHcCdLDF9zcdbfAyKpnT1T4zWjUHLCEgalXszFfojt88uZavCYc5JfB
         LY/W5iH/6fPq2sZW2e6m9UZS6cPRIYxN2DpUKQgtZZr9qj8ngOuWPk0SwkGI/57APARD
         ZONExk24W6ppVArBn0qf3y58kmjA8+ZSNDG1w9kzBzSKhK4Mqx9D8nVTMuUjr5pEn4Jm
         7AAA==
X-Gm-Message-State: AOAM532lBERd2eIFrB2bQID8bnUn3ebP780EN5HReNiL3m3M448Kaz3l
        ifu7uic7jXzYXVTZZ9qt6Fg95OW/73U9DCAYh+74Og==
X-Google-Smtp-Source: ABdhPJx231bav+T9Lgj4p7s6Lb4F0PCXv0zQl4y3C9fO7f+Ye/z/CVOfL7Zl6Y9u6eiSPS3fQ2D24xkXFZWca4plZjk=
X-Received: by 2002:a05:6e02:1947:: with SMTP id x7mr10905003ilu.295.1638391260690;
 Wed, 01 Dec 2021 12:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com> <20211201010217.886919-12-eranian@google.com>
 <25f7b261-3f2a-942d-8d3f-d501d9dc9612@amd.com>
In-Reply-To: <25f7b261-3f2a-942d-8d3f-d501d9dc9612@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 1 Dec 2021 12:40:49 -0800
Message-ID: <CABPqkBT8gLPzZrwAxeBbkftaFxecDv2Xo1x6dS86emRcZELrhQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] perf tools: improve IBS error handling
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kim,

Could you send me the patch you want to integrate in the series. I
thought I had integrated the change in V3.


On Wed, Dec 1, 2021 at 7:30 AM Kim Phillips <kim.phillips@amd.com> wrote:
>
> Hi Stephane,
>
> This v3 looks like it's the same as in the v1 of the series,
> which got nacked by acme.
>
> Please use the newer patches provided.  Instructions to do
> so haven't changed since then.
>
> Thanks,
>
> Kim
>
> On 11/30/21 7:02 PM, Stephane Eranian wrote:
> > From: Kim Phillips <kim.phillips@amd.com>
> >
> > This patch improves the error message returned on failed perf_event_open() on
> > AMD when using IBS.
> >
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> > ---
> >   tools/perf/util/evsel.c | 42 +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index ac0127be0459..39e9063c0a80 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2852,12 +2852,52 @@ static bool find_process(const char *name)
> >       return ret ? false : true;
> >   }
> >
> > +static bool is_amd;
> > +
> > +static char *fgrep(FILE *inf, const char *str)
> > +{
> > +     char line[256];
> > +     int slen = strlen(str);
> > +
> > +     while (!feof(inf)) {
> > +             if (!fgets(line, 256, inf))
> > +                     break;
> > +             if (strncmp(line, str, slen))
> > +                     continue;
> > +
> > +             return strdup(line);
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static void detect_amd(void)
> > +{
> > +     FILE *inf = fopen("/proc/cpuinfo", "r");
> > +     char *res;
> > +
> > +     if (!inf)
> > +             return;
> > +
> > +     res = fgrep(inf, "vendor_id");
> > +
> > +     if (res) {
> > +             char *s = strchr(res, ':');
> > +
> > +             is_amd = s && !strcmp(s, ": AuthenticAMD\n");
> > +             free(res);
> > +     }
> > +     fclose(inf);
> > +}
> > +
> >   int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >                        int err, char *msg, size_t size)
> >   {
> >       char sbuf[STRERR_BUFSIZE];
> >       int printed = 0, enforced = 0;
> >
> > +     detect_amd();
> > +
> >       switch (err) {
> >       case EPERM:
> >       case EACCES:
> > @@ -2950,6 +2990,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >                       return scnprintf(msg, size, "wrong clockid (%d).", clockid);
> >               if (perf_missing_features.aux_output)
> >                       return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> > +             if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
> > +                     return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> >               break;
> >       case ENODATA:
> >               return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> >
