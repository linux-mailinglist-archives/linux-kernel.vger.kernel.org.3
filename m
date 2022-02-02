Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170674A690F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiBBAGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:06:25 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42448 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiBBAGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:06:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E5CFCE1B00
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 00:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6412FC340EB;
        Wed,  2 Feb 2022 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643760377;
        bh=rRJiER/f4hPq9llhspKUo3w5v2Ov/Oz7Az2urSqBxQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3Eykh474WaM/f0r7IOdv6vnRgup2is987C6Zv5aB9lMOMpZBORSep2OdYK9KuRJL
         uh88OwZinQbPfH1spm8ZxNmRMJxC3N0gQGrF6965ds8SisHnB2vvHqxd5HSXBFWkXj
         fDMAZ4XIiOGXUxQiUq6TTnf7PU9SLw96SBwSrqqDEq/+QgtCXO/dsY/SddKzVXbBgI
         beI8kT/oaneFJ/TIFVhB6uTDE2JwULUFyk75rtnVozKXOLrcll1wqJvwcHuQGHfFvj
         m8rtTk6s2/pBytwwEyyM8jAM13Jw4B3C5rPL8jzivtC+sKYzViX/2Pd7WCsFvEh7Y0
         A62MczGFofgjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1B1940466; Tue,  1 Feb 2022 21:06:15 -0300 (-03)
Date:   Tue, 1 Feb 2022 21:06:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/3] perf annotate: Try chroot filename for objdump
Message-ID: <YfnK95pk1AzcL7LZ@kernel.org>
References: <20220128203950.3371061-1-namhyung@kernel.org>
 <20220128203950.3371061-4-namhyung@kernel.org>
 <Yfg3KXNcyUPaRebE@krava>
 <CAM9d7cgpkzhmEAhnUA39YOVaHFw_-A2yzMX9zE9JbE+pFVBVGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgpkzhmEAhnUA39YOVaHFw_-A2yzMX9zE9JbE+pFVBVGw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 01, 2022 at 11:54:14AM -0800, Namhyung Kim escreveu:
> Hi Jiri,
> 
> On Mon, Jan 31, 2022 at 11:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 12:39:50PM -0800, Namhyung Kim wrote:
> > > Likewise, it should use a proper name in case the task runs under
> > > chroot.  The child_process.err was needed to set to -1 to show error
> > > messages properly in TUI.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/annotate.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index 01900689dc00..e4c641b240df 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -33,6 +33,7 @@
> > >  #include "string2.h"
> > >  #include "util/event.h"
> > >  #include "arch/common.h"
> > > +#include "namespaces.h"
> > >  #include <regex.h>
> > >  #include <pthread.h>
> > >  #include <linux/bitops.h>
> > > @@ -1696,6 +1697,15 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> > >                * DSO is the same as when 'perf record' ran.
> > >                */
> > >               __symbol__join_symfs(filename, filename_size, dso->long_name);
> > > +
> > > +             if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
> > > +                     char *new_name = filename_with_chroot(dso->nsinfo->pid,
> > > +                                                           filename);
> > > +                     if (new_name) {
> > > +                             strlcpy(filename, new_name, filename_size);
> > > +                             free(new_name);
> > > +                     }
> > > +             }
> > >       }
> > >
> > >       free(build_id_path);
> > > @@ -2036,6 +2046,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> > >       memset(&objdump_process, 0, sizeof(objdump_process));
> > >       objdump_process.argv = objdump_argv;
> > >       objdump_process.out = -1;
> > > +     objdump_process.err = -1;
> >
> > is this unrelated fix?
> 
> Right, it's unrelated.  Maybe I can split it if Arnaldo wants.

Yes, please split.
 
> >
> > otherwise the whole patchset looks good to me
> >
> > I guess we'd need to add something like PERF_RECORD_CHROOT to
> > handle and instrument sys_chroot to handle this completely?
> 
> Are you talking about an env variable?  Maybe we can track
> chroot syscall.  But it needs to be task-specific rather than a
> global setup.
> 
> As it hasn't been an issue so far, I think it's ok to have it as
> a fallback right now.
> 
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks for your review!

Indeed, thank you guys!

> Namhyung
> 
> 
> >
> > >       if (start_command(&objdump_process)) {
> > >               pr_err("Failure starting to run %s\n", command);
> > >               err = -1;
> > > --
> > > 2.35.0.rc2.247.g8bbb082509-goog
> > >
> >

-- 

- Arnaldo
