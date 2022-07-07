Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204C856AAE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiGGSfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiGGSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:34:53 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DBD2CDC5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:33:46 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 185so8021434vse.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waymo.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=nn6eOwe8KztwdNAWxsTG87VOiKGbCAJEGM+HEwr2iD4=;
        b=Q8Xh+F/wfTZFJZOhAu9FZXg6j9b25n3noPIaoAROmFcqWadusg7tQGpSrsUHMLCSif
         mHIFrgoB0A71ptocb+Zk29/jcsgu5lp5xwy6Ae+nguP6zkCdjoT5iqk0kTHBjr3anHyq
         /vs1o9NqJmIRL4+IzufIpTzF1ZUEmG5ZKF6xSAAoURLCIDzdFEuWqQXIIyDLjI0HNIf6
         7OHNj9iYbPXjGIWuY4nhHimksGw9/j9HDTLybKCdS443WWfLOWlFMCFNVD5ki+aEMx7J
         RdaRqAkRZJiUnp9+lQb58hwdZQ6YZggNl9Zm78piGYbtC9sqEem9EPpXz23vD2b0noih
         szRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=nn6eOwe8KztwdNAWxsTG87VOiKGbCAJEGM+HEwr2iD4=;
        b=rndV18QgmSnjW4+y5okwpwLdpFHP+qp1QPw+sLFl6ybexupf0iowxcxiwtSkVquDiJ
         bwDXIaMeeryVBn+rl4EbftWTdJn5N/TP6U24/ReTKt0ttPEWwTEPSjWQF+PWO+vD6wlW
         UYvfrcRXcwgN6adxJWNh4IGN0iJoHfMf4oTj2u8hskDtNDFWAYmB27pKGde58h8Gz6aP
         DmXoSJzK77Hn5xWVmxi7zTASUmIlr571EUDEASoc5KhyG223QvPKAYvsFtQJc5FbneZQ
         Re2chd7RvIyRqTaG1XnVTfJl6hl+awWo9B4FGkZ30QC1NMc8MVEGgqb2yjdeMIbjVJih
         dqUQ==
X-Gm-Message-State: AJIora/MA94v0BVMH8qPowWTNbkzKuF84aAJo3w8nu1gWs0y8vZXCi1x
        wwuHlGeM7mBVrvwnqsye+okVZ5jAdEQTrdr5JOZ0jClDFnY=
X-Google-Smtp-Source: AGRyM1sGmQCk/AS0etpboCWPaSLmERvN0DIYgGhIrNpxADBFyD57k8O5yqxNdEYy9ZFdRQMTHZuaiBEfqaqqvEE7TgM=
X-Received: by 2002:a67:dc8c:0:b0:356:c204:fd6 with SMTP id
 g12-20020a67dc8c000000b00356c2040fd6mr12754936vsk.38.1657218825844; Thu, 07
 Jul 2022 11:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220630001825.3905089-1-rsilvera@google.com> <CAM9d7cjAHdZ3-NbZQgR5i9NmiBW3U5pY6crtvb7RQWG5QvmHqg@mail.gmail.com>
In-Reply-To: <CAM9d7cjAHdZ3-NbZQgR5i9NmiBW3U5pY6crtvb7RQWG5QvmHqg@mail.gmail.com>
Reply-To: rsilvera@waymo.com
From:   Raul Silvera <rsilvera@waymo.com>
Date:   Thu, 7 Jul 2022 11:33:19 -0700
Message-ID: <CA+PGoB80cDcbrJYqr5VKWC7F5DsaAedNiSdjCA0WiPcp7+wj_w@mail.gmail.com>
Subject: Re: [PATCH] perf inject: Add a command line option to specify build ids.
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. Will apply these suggestions and send an updated version shortly=
.

Ra=C3=BAl E. Silvera
Software Engineer
waymo.com

Ra=C3=BAl E. Silvera
Software Engineer
waymo.com


On Wed, Jul 6, 2022 at 2:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Raul,
>
> On Wed, Jun 29, 2022 at 5:18 PM Raul Silvera <rsilvera@google.com> wrote:
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
> > $ perf record ls /tmp                  # Create perf.data file
> > $ perf record --no-buildid ls /tmp -o perf.data.no-buildid
> > $ perf buildid-list > /tmp/build-ids.txt
> > $ perf inject -b --known-build-ids=3D'file:///tmp/build-ids.txt' \
> > $  -i perf.data.no-buildid -o perf.data.buildid
>
> You'd better indent the block for the readability and to prevent
> possible interference from the shell (for comments usually).
>
> The last line is a continuation from the above line and it used
> to print other prompts like ">".
>
> >
> > Signed-off-by: Raul Silvera <rsilvera@google.com>
> > ---
> >  tools/perf/builtin-inject.c | 57 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index a75bf11585b5..667b942f870e 100644
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
> > +       struct strlist          *known_build_ids;
> >  };
> >
> >  struct event_entry {
> > @@ -570,9 +574,43 @@ static int dso__read_build_id(struct dso *dso)
> >         return dso->has_build_id ? 0 : -1;
> >  }
> >
> > +static bool perf_inject__lookup_known_build_id(struct perf_inject *inj=
ect,
> > +                                              struct dso *dso)
> > +{
> > +       struct str_node *pos;
> > +       int bid_len;
> > +
> > +       strlist__for_each_entry(pos, inject->known_build_ids) {
> > +               const char *space;
> > +
> > +               pos->s =3D skip_spaces(pos->s);
> > +               space =3D strstr(pos->s, " ");
> > +               if (space =3D=3D NULL ||
> > +                   !strcmp(dso->long_name, skip_spaces(space)))
> > +                       continue;
> > +               bid_len =3D space - pos->s;
> > +               if (bid_len =3D=3D 0 || bid_len / 2 > BUILD_ID_SIZE)
>
> I'm not sure how bid_len can be 0.  And you can compare to
> SBUILD_ID_SIZE (without dividing by 2) - but it'd be ">=3D".
> Also it could be worthwhile to check if bid_len is even.
>
>
> > +                       return false;
> > +               for (int ix =3D 0; 2 * ix + 1 < bid_len; ++ix) {
> > +                       if (!isxdigit(pos->s[2 * ix]) ||
> > +                           !isxdigit(pos->s[2 * ix + 1]))
> > +                               return false;
> > +
> > +                       dso->bid.data[ix] =3D (hex(pos->s[2 * ix]) << 4=
 |
> > +                                            hex(pos->s[2 * ix + 1]));
> > +               }
> > +               dso->bid.size =3D bid_len / 2;
> > +               dso->has_build_id =3D 1;
> > +               return true;
> > +       }
> > +       return false;
> > +}
> > +
> >  static int dso__inject_build_id(struct dso *dso, struct perf_tool *too=
l,
> >                                 struct machine *machine, u8 cpumode, u3=
2 flags)
> >  {
> > +       struct perf_inject *inject =3D container_of(tool, struct perf_i=
nject,
> > +                                                 tool);
> >         int err;
> >
> >         if (is_anon_memory(dso->long_name) || flags & MAP_HUGETLB)
> > @@ -580,6 +618,10 @@ static int dso__inject_build_id(struct dso *dso, s=
truct perf_tool *tool,
> >         if (is_no_dso_memory(dso->long_name))
> >                 return 0;
> >
> > +       if (inject->known_build_ids !=3D NULL &&
> > +           perf_inject__lookup_known_build_id(inject, dso))
> > +               return 1;
> > +
> >         if (dso__read_build_id(dso) < 0) {
> >                 pr_debug("no build_id found for %s\n", dso->long_name);
> >                 return -1;
> > @@ -1082,6 +1124,9 @@ int cmd_inject(int argc, const char **argv)
> >                             "Inject build-ids into the output stream"),
> >                 OPT_BOOLEAN(0, "buildid-all", &inject.build_id_all,
> >                             "Inject build-ids of all DSOs into the outp=
ut stream"),
> > +               OPT_STRING(0, "known-build-ids", &inject.known_build_id=
s_source,
> > +                          "buildid path [buildid path...]",
> > +                          "build-ids to use for specific files"),
> >                 OPT_STRING('i', "input", &inject.input_name, "file",
> >                            "input file name"),
> >                 OPT_STRING('o', "output", &inject.output.path, "file",
> > @@ -1215,6 +1260,18 @@ int cmd_inject(int argc, const char **argv)
> >                  */
> >                 inject.tool.ordered_events =3D true;
> >                 inject.tool.ordering_requires_timestamps =3D true;
> > +               if (inject.known_build_ids_source !=3D NULL) {
> > +                       struct strlist *known_build_ids;
> > +
> > +                       known_build_ids =3D strlist__new(
> > +                           inject.known_build_ids_source, NULL);
> > +
> > +                       if (known_build_ids =3D=3D NULL) {
> > +                               pr_err("Couldn't parse known build ids.=
\n");
> > +                               goto out_delete;
> > +                       }
> > +                       inject.known_build_ids =3D known_build_ids;
>
> You need to release it after use.  Note that strlist__delete()
> accepts a NULL pointer.
>
> Thanks,
> Namhyung
>
>
> > +               }
> >         }
> >
> >         if (inject.sched_stat) {
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
