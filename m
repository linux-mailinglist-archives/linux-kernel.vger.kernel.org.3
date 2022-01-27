Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55D949E339
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbiA0NTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiA0NTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:19:39 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D2C061714;
        Thu, 27 Jan 2022 05:19:39 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id g11so2769202qvu.3;
        Thu, 27 Jan 2022 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C74jfdbNawsIBV6R7zfjbmW2XPSzvOksBpOCdplGLqY=;
        b=gTEc3lRdhx7971tbOcZqznnIvd8m7BHhKe4pS5w4jH8y0NLOjLCWVNCHkajLrd13ha
         u+OHYdzSy/gCvVVvX1WrsvDrIkCgigqI20f0JGovIhoAAQG1nNvrcf7FqZH2GvNYPDCx
         XoYBB0/sl7gaSZT2I8Z4uwfmVyJq5WPDmkevZbaIYEKTjgLzBshxYZONJphIT4Elvol8
         Q/8FBfBU/i0gJuzdU6xUqlPeNC1DJBeP6XLal5QiliGs7IuxW6nTNi8ksmf94qVackQW
         wsq6bXmO7C4SUK54oFooF++/OTWFfd2F8xk9FTjSO9wFHPbldgW9UqfUUmVL+1qpswMD
         I8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C74jfdbNawsIBV6R7zfjbmW2XPSzvOksBpOCdplGLqY=;
        b=24TgOjkjttJJN4QFsuA+OsPm2S4SR+Qt+Z69mvMeHmshkTyZECGupH7dY6lZRTbdKy
         1R+TSgZr6qweA7ShqgR5hpna2LgNvRqwoHGCBnmF7hCmqOFUal8oFcw+BcYsVFAla1/u
         P0Y+VJsTkNyFSlkWv9qBd4/qU6+Op7uQPDIKjWkHCK4lq9nJEFPMy2ESGXfOp7k23Tu0
         J/+Voy93TN1orC/+Rt8BL6xjTpsoAevjFiJkqxNMsCaaUagNig5q8EWBSXz+2CbP4ysO
         M8QhZVl3AyaWuhtXvIOnyxEN6PWNWgDFwJnsHb/UAE8VHUT94bbwPyBGUw1hAkPgC6Zj
         tYbA==
X-Gm-Message-State: AOAM532QQoQbMDxFIUpi1rNNUTG3qxKb7OsLxrvOijv4ys4xCVwDWUV6
        twSovC/eLsL+MC/SaJHcAGY=
X-Google-Smtp-Source: ABdhPJyrjAbrE9n3FKI6tkKbcaepEq/htjIWbuyZQIKuoJSuWAn/lI2QFlIweN4FXQNqhuHN0NRkkQ==
X-Received: by 2002:a05:6214:e49:: with SMTP id o9mr2851724qvc.13.1643289578138;
        Thu, 27 Jan 2022 05:19:38 -0800 (PST)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id a16sm1379263qtx.7.2022.01.27.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:19:37 -0800 (PST)
Date:   Thu, 27 Jan 2022 21:19:29 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/ftrace: system_wide collection is not effective by
 default
Message-ID: <20220127131929.ydxtkpbguk7fyho5@mail.google.com>
References: <20220126151921.2519-1-changbin.du@gmail.com>
 <CAM9d7cipbsg46=UNY8-h-e9RAsqeJRcL=mi_RXbtQwQUbwPehQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cipbsg46=UNY8-h-e9RAsqeJRcL=mi_RXbtQwQUbwPehQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:47:48PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Jan 26, 2022 at 7:19 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > The ftrace.target.system_wide must be set before invoking
> > evlist__create_maps(), otherwise it has no effect.
> 
> Oh, right.  Thanks for pointing that out.
> 
> >
> > Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 45 ++++++++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index dec24dc0e767..26bff29ad277 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -1115,6 +1115,7 @@ enum perf_ftrace_subcommand {
> >  int cmd_ftrace(int argc, const char **argv)
> >  {
> >         int ret;
> > +       int (*cmd_func)(struct perf_ftrace *) = NULL;
> >         struct perf_ftrace ftrace = {
> >                 .tracer = DEFAULT_TRACER,
> >                 .target = { .uid = UINT_MAX, },
> > @@ -1221,6 +1222,28 @@ int cmd_ftrace(int argc, const char **argv)
> >                 goto out_delete_filters;
> >         }
> >
> > +       switch (subcmd) {
> > +       case PERF_FTRACE_TRACE:
> > +               if (!argc && target__none(&ftrace.target))
> > +                       ftrace.target.system_wide = true;
> 
> We can move only this part after parse_options().
>
I prefer that all parsing works get be done first. :)

> > +               cmd_func = __cmd_ftrace;
> > +               break;
> > +       case PERF_FTRACE_LATENCY:
> > +               if (list_empty(&ftrace.filters)) {
> > +                       pr_err("Should provide a function to measure\n");
> > +                       parse_options_usage(ftrace_usage, options, "T", 1);
> > +                       ret = -EINVAL;
> > +                       goto out_delete_evlist;
> 
> Otherwise, it should go to the out_delete_filters.
> 
yes, will fix it.

> > +               }
> > +               cmd_func = __cmd_latency;
> > +               break;
> > +       case PERF_FTRACE_NONE:
> > +       default:
> > +               pr_err("Invalid subcommand\n");
> > +               ret = -EINVAL;
> > +               goto out_delete_evlist;
> 
> Ditto.
> 
okay.

> Thanks,
> Namhyung
> 
> 
> > +       }
> > +
> >         ret = target__validate(&ftrace.target);
> >         if (ret) {
> >                 char errbuf[512];
> > @@ -1248,27 +1271,7 @@ int cmd_ftrace(int argc, const char **argv)
> >                         goto out_delete_evlist;
> >         }
> >
> > -       switch (subcmd) {
> > -       case PERF_FTRACE_TRACE:
> > -               if (!argc && target__none(&ftrace.target))
> > -                       ftrace.target.system_wide = true;
> > -               ret = __cmd_ftrace(&ftrace);
> > -               break;
> > -       case PERF_FTRACE_LATENCY:
> > -               if (list_empty(&ftrace.filters)) {
> > -                       pr_err("Should provide a function to measure\n");
> > -                       parse_options_usage(ftrace_usage, options, "T", 1);
> > -                       ret = -EINVAL;
> > -                       goto out_delete_evlist;
> > -               }
> > -               ret = __cmd_latency(&ftrace);
> > -               break;
> > -       case PERF_FTRACE_NONE:
> > -       default:
> > -               pr_err("Invalid subcommand\n");
> > -               ret = -EINVAL;
> > -               break;
> > -       }
> > +       ret = cmd_func(&ftrace);
> >
> >  out_delete_evlist:
> >         evlist__delete(ftrace.evlist);
> > --
> > 2.32.0
> >

-- 
Cheers,
Changbin Du
