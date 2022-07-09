Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220CF56C4FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiGIAWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGIAWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:22:13 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2817AC15
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:22:12 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id i186so110010vsc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waymo.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dWRkMsWdpewDgIm6lFE+X1sR3lKe+BSFG65aDsAFy9c=;
        b=ipDZHcuEwpdEazaq+Gh4aAIo3A5bN5TOrQZu+7xabPLUGJzUYByOPsAeh8lsvbuOmK
         U9DqpmkoJeBSlYd+Sp49ewFiIcXSm8zmwiwEaKNSERqSVFqeZuwIS7f/2kiTZZ/pAVbj
         D3PeVCbMZHC/cTjEc8U1jL8Sr3Y7UduyIGkjBxiFn8cHyWS9gLr4wJF4BV7MlNHmDOyq
         H9IbjGpX+ct5ZyabqSfDbVPKssipkFxuQvUjUj0Q52ebrjjrzjiX6NfHKXd1RqSVRSyY
         KubmAU00YhykotHM2xqyVjBf8OTah4sbetdw0N8OcEJhfnbV9rG3pfg4TWCPVdVqK13E
         ZzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dWRkMsWdpewDgIm6lFE+X1sR3lKe+BSFG65aDsAFy9c=;
        b=1zZRz8SXJRPWVmuUgClYzYcQk5/rJQ2BXw1v5gcpoGdlFqmS9Vv28lkw5mY+swI9nL
         v8Dq6bC5MQ6WbnETs2WtrKV9O4uJ3UWpvSnar73aEp5/Mel6NYHjksKzhB4NZdbZsZxs
         RrTnQEij6VyXvL0va0NS7LKoObCH4nynbKXx2zDBptBF3pmZGywWp5Jne5UY0hjSEuAs
         2R5XYI4OFYCDARuJzgkw9WRR8ZmSWq19rVhc3SCW7h4ErXYApltF9UJ6c117Ga9OLLs2
         sik2r5TV8s4+ajtSXp4zZsDv1CnOo4/2Y95WjFP8IQxMBcmZwVmu1RpzkAd8DGo6MbNs
         5X/g==
X-Gm-Message-State: AJIora9/kRWvmWMB9gY0Tc+FEev0/wWXKx5BMYhZv2sCGIz0qrT9h6Qk
        UZ/7nt2vpw9ek5RTlowCPHesocrz7sQSAGblbnWJFRGmg4Y=
X-Google-Smtp-Source: AGRyM1tNh32YyFSO6yBdwccWw/tHcxyeM51sI4DbuaY7DOmWDfhFh2bIAsz/D9em2zYI7RYZVSFnHT0f6CiY8BHc/Xw=
X-Received: by 2002:a05:6102:3747:b0:354:6214:8683 with SMTP id
 u7-20020a056102374700b0035462148683mr2675981vst.37.1657326131449; Fri, 08 Jul
 2022 17:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220707215606.2409166-1-rsilvera@google.com> <CAM9d7cgcvQTZWPFh+ebC-68CrjuQDw5C8biko+KtWPtN9gYT7Q@mail.gmail.com>
In-Reply-To: <CAM9d7cgcvQTZWPFh+ebC-68CrjuQDw5C8biko+KtWPtN9gYT7Q@mail.gmail.com>
Reply-To: rsilvera@waymo.com
From:   Raul Silvera <rsilvera@waymo.com>
Date:   Fri, 8 Jul 2022 17:21:45 -0700
Message-ID: <CA+PGoB9VOoDJJL29nBb08EDjTF8PoN7nNP18Lpqd9mTCNxiOYA@mail.gmail.com>
Subject: Re: [PATCH v2] perf inject: Add a command line option to specify
 build ids
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. I just uploaded a new version addressing this feedback.

Raul E. Silvera
Software Engineer
waymo.com

On Fri, Jul 8, 2022 at 11:51 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Raul,
>
> On Thu, Jul 7, 2022 at 2:56 PM Raul Silvera <rsilvera@google.com> wrote:
> >
> > This commit adds the option --known-build-ids to perf inject.
> > It allows the user to explicitly specify the build id for a given
> > path, instead of retrieving it from the current system. This is
> > useful in cases where a perf.data file is processed on a different
> > system from where it was collected, or if some of the binaries are
> > no longer available.
> >
> > The build ids and paths are specified in pairs in the command line.
> > Using the file:// specifier, build ids can be loaded from a file
> > directly generated by perf buildid-list. This is convenient to copy
> > build ids from one perf.data file to another.
> >
> > ** Example: In this example we use perf record to create two
> > perf.data files, one with build ids and another without, and use
> > perf buildid-list and perf inject to copy the build ids from the
> > first file to the second.
> >
> >  $ perf record ls /tmp
> >  $ perf record --no-buildid -o perf.data.no-buildid ls /tmp
> >  $ perf buildid-list > /tmp/build-ids.txt
> >  $ perf inject -b --known-build-ids='file:///tmp/build-ids.txt' \
> >         -i perf.data.no-buildid -o perf.data.buildid
>
> Please add documentation for new options.  Some nit pickings below.
>
> >
> > Signed-off-by: Raul Silvera <rsilvera@google.com>
> > ---
> >  V1 -> V2: Cleaned up patch description, deleted the strlist during
> >            cleanup, and updated validation of the build id strings
> >
> >  tools/perf/builtin-inject.c | 60 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index a75bf11585b5..4efb992ed1a0 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -21,6 +21,7 @@
> >  #include "util/data.h"
> >  #include "util/auxtrace.h"
> >  #include "util/jit.h"
> > +#include "util/string2.h"
> >  #include "util/symbol.h"
> >  #include "util/synthetic-events.h"
> >  #include "util/thread.h"
> > @@ -35,6 +36,7 @@
> >
> >  #include <linux/list.h>
> >  #include <linux/string.h>
> > +#include <ctype.h>
> >  #include <errno.h>
> >  #include <signal.h>
> >
> > @@ -59,6 +61,8 @@ struct perf_inject {
> >         struct itrace_synth_opts itrace_synth_opts;
> >         char                    event_copy[PERF_SAMPLE_MAX_SIZE];
> >         struct perf_file_section secs[HEADER_FEAT_BITS];
> > +       const char              *known_build_ids_source;
>
> Nit: It doesn't need to be here.  You can use a local variable in
> cmd_inject for parsing.
>
>
> > +       struct strlist          *known_build_ids;
> >  };
> >
> >  struct event_entry {
> > @@ -570,9 +574,45 @@ static int dso__read_build_id(struct dso *dso)
> >         return dso->has_build_id ? 0 : -1;
> >  }
> >
> > +static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
> > +                                              struct dso *dso)
> > +{
> > +       struct str_node *pos;
> > +       int bid_len;
> > +
> > +       strlist__for_each_entry(pos, inject->known_build_ids) {
> > +               const char *build_id, *dso_name;
> > +
> > +               build_id = skip_spaces(pos->s);
> > +               dso_name = strchr(build_id, ' ');
> > +               if (dso_name == NULL)
> > +                       continue;
> > +               bid_len = dso_name - pos->s;
> > +               dso_name = skip_spaces(dso_name);
> > +               if (strcmp(dso->long_name, dso_name))
> > +                       continue;
> > +               if (bid_len % 2 != 0 || bid_len >= SBUILD_ID_SIZE)
> > +                       return false;
> > +               for (int ix = 0; 2 * ix + 1 < bid_len; ++ix) {
> > +                       if (!isxdigit(build_id[2 * ix]) ||
> > +                           !isxdigit(build_id[2 * ix + 1]))
> > +                               return false;
> > +
> > +                       dso->bid.data[ix] = (hex(build_id[2 * ix]) << 4 |
> > +                                            hex(build_id[2 * ix + 1]));
> > +               }
> > +               dso->bid.size = bid_len / 2;
> > +               dso->has_build_id = 1;
> > +               return true;
> > +       }
> > +       return false;
> > +}
> > +
> >  static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
> >                                 struct machine *machine, u8 cpumode, u32 flags)
> >  {
> > +       struct perf_inject *inject = container_of(tool, struct perf_inject,
> > +                                                 tool);
> >         int err;
> >
> >         if (is_anon_memory(dso->long_name) || flags & MAP_HUGETLB)
> > @@ -580,6 +620,10 @@ static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
> >         if (is_no_dso_memory(dso->long_name))
> >                 return 0;
> >
> > +       if (inject->known_build_ids != NULL &&
> > +           perf_inject__lookup_known_build_id(inject, dso))
> > +               return 1;
> > +
> >         if (dso__read_build_id(dso) < 0) {
> >                 pr_debug("no build_id found for %s\n", dso->long_name);
> >                 return -1;
> > @@ -1082,6 +1126,9 @@ int cmd_inject(int argc, const char **argv)
> >                             "Inject build-ids into the output stream"),
> >                 OPT_BOOLEAN(0, "buildid-all", &inject.build_id_all,
> >                             "Inject build-ids of all DSOs into the output stream"),
> > +               OPT_STRING(0, "known-build-ids", &inject.known_build_ids_source,
> > +                          "buildid path [buildid path...]",
> > +                          "build-ids to use for specific files"),
> >                 OPT_STRING('i', "input", &inject.input_name, "file",
> >                            "input file name"),
> >                 OPT_STRING('o', "output", &inject.output.path, "file",
> > @@ -1215,6 +1262,18 @@ int cmd_inject(int argc, const char **argv)
> >                  */
> >                 inject.tool.ordered_events = true;
> >                 inject.tool.ordering_requires_timestamps = true;
> > +               if (inject.known_build_ids_source != NULL) {
> > +                       struct strlist *known_build_ids;
>
> Nit: I think you can use inject.known_build_ids directly.
>
> Thanks,
> Namhyung
>
>
> > +
> > +                       known_build_ids = strlist__new(
> > +                           inject.known_build_ids_source, NULL);
> > +
> > +                       if (known_build_ids == NULL) {
> > +                               pr_err("Couldn't parse known build ids.\n");
> > +                               goto out_delete;
> > +                       }
> > +                       inject.known_build_ids = known_build_ids;
> > +               }
> >         }
> >
> >         if (inject.sched_stat) {
> > @@ -1241,6 +1300,7 @@ int cmd_inject(int argc, const char **argv)
> >         ret = __cmd_inject(&inject);
> >
> >  out_delete:
> > +       strlist__delete(inject.known_build_ids);
> >         zstd_fini(&(inject.session->zstd_data));
> >         perf_session__delete(inject.session);
> >  out_close_output:
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
