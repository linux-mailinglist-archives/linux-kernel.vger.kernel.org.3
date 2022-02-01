Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E14A6535
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiBATy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:54:27 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:36600 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiBATy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:54:26 -0500
Received: by mail-lf1-f43.google.com with SMTP id z4so36136960lft.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeCMwlNAwf570Z2wvd4HDxQkPnXgfxYZn4cq1D2dOlI=;
        b=Au9Msmg2lryYyk3+fJKoP1VPxJ7UV1XUMdQBHtp78AYNAamflUBHZLTkHh4c1n70qB
         L/ubidGp3YhUYdQH3b8ZHgzF2KGWwOO3JGL+R25XUi7ryCPuSwkp4vbEmjeGxCgF1vUU
         +4hS/RYJqcznlhBpTd9T4goywDJZ78cCzRmfbKvZCQFHCnALkQViPeuF51faxMhNDnN5
         CVoBGuPBA08Y2BkP7DsQyql52wpB/93Mdktd6EWn+AraeKcBOwVAq+Q/mxGCwu1Muzn0
         tpnLnZWFi2ENiLrT4c+8WTbhYnph3hJd9nr87mvipC8675w1DRIa2vzpLZD2gIgwYIAq
         8HQA==
X-Gm-Message-State: AOAM531Aj75CYFR7pBaqaQbmbud8eQ2aEOynakFSrHL+bzPSEn/691dA
        d8JGH9785j3VD22ffbv5pcY0CTSQQH08DA6E2R0=
X-Google-Smtp-Source: ABdhPJz/MmhCG2Kpxog5+Y/2pxlXMxuSAYpeJu1p0KOcyk3Z61sHujYEW/CY5WuAuPoiazcj0ir+W7Jd3BzRUHYfjLg=
X-Received: by 2002:a05:6512:3186:: with SMTP id i6mr17870320lfe.47.1643745265335;
 Tue, 01 Feb 2022 11:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20220128203950.3371061-1-namhyung@kernel.org> <20220128203950.3371061-4-namhyung@kernel.org>
 <Yfg3KXNcyUPaRebE@krava>
In-Reply-To: <Yfg3KXNcyUPaRebE@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Feb 2022 11:54:14 -0800
Message-ID: <CAM9d7cgpkzhmEAhnUA39YOVaHFw_-A2yzMX9zE9JbE+pFVBVGw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf annotate: Try chroot filename for objdump
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Jan 31, 2022 at 11:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jan 28, 2022 at 12:39:50PM -0800, Namhyung Kim wrote:
> > Likewise, it should use a proper name in case the task runs under
> > chroot.  The child_process.err was needed to set to -1 to show error
> > messages properly in TUI.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 01900689dc00..e4c641b240df 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -33,6 +33,7 @@
> >  #include "string2.h"
> >  #include "util/event.h"
> >  #include "arch/common.h"
> > +#include "namespaces.h"
> >  #include <regex.h>
> >  #include <pthread.h>
> >  #include <linux/bitops.h>
> > @@ -1696,6 +1697,15 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> >                * DSO is the same as when 'perf record' ran.
> >                */
> >               __symbol__join_symfs(filename, filename_size, dso->long_name);
> > +
> > +             if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
> > +                     char *new_name = filename_with_chroot(dso->nsinfo->pid,
> > +                                                           filename);
> > +                     if (new_name) {
> > +                             strlcpy(filename, new_name, filename_size);
> > +                             free(new_name);
> > +                     }
> > +             }
> >       }
> >
> >       free(build_id_path);
> > @@ -2036,6 +2046,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >       memset(&objdump_process, 0, sizeof(objdump_process));
> >       objdump_process.argv = objdump_argv;
> >       objdump_process.out = -1;
> > +     objdump_process.err = -1;
>
> is this unrelated fix?

Right, it's unrelated.  Maybe I can split it if Arnaldo wants.

>
> otherwise the whole patchset looks good to me
>
> I guess we'd need to add something like PERF_RECORD_CHROOT to
> handle and instrument sys_chroot to handle this completely?

Are you talking about an env variable?  Maybe we can track
chroot syscall.  But it needs to be task-specific rather than a
global setup.

As it hasn't been an issue so far, I think it's ok to have it as
a fallback right now.

>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks for your review!
Namhyung


>
> >       if (start_command(&objdump_process)) {
> >               pr_err("Failure starting to run %s\n", command);
> >               err = -1;
> > --
> > 2.35.0.rc2.247.g8bbb082509-goog
> >
>
