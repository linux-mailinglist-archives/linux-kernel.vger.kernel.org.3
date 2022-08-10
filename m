Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAD58ECA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiHJNAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiHJNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFFB2717A;
        Wed, 10 Aug 2022 06:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A9D61425;
        Wed, 10 Aug 2022 13:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75075C433C1;
        Wed, 10 Aug 2022 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660136416;
        bh=zQPYsSjGoy5+dUcfGx9q9n9WbpRBQD+ECEKKdt88zUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCbJZrVaQsbrpnlKnwBBo366+Pd6dpu/rfRTq+rqEsEIz+i23bsA61bMfCbmtE57U
         8AOAzSuyxK1fDWShN2VUau2saA8WT0efTnLoV5hO+3bRTZR87fZhBxSUS/aLpL+9eL
         Je+YPAPb5/vnT+Q03g09ZT3qhtXK/LzDF8ovAA7H3fxplG4rkYIAYzWd7IO6nvk71V
         HgNisFNUIIYPGbhkJ1Ypm3aCGCl82Ry5StoFv6JfPD00KFoeIzOTpcgDJx/gb0Vfb9
         T70krRQpwJcXbZpq1ASOrb660miBC7Z/jiNYbpneBV4CI0QmV3ff3SbQUWtZ1+w/06
         y/7Jgtziy62fg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6CF5F4035A; Wed, 10 Aug 2022 10:00:14 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:00:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Brian Robbins <brianrob@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject jit: Ignore memfd mmap events if jitdump
 present
Message-ID: <YvOr3t9JNlEI4p+6@kernel.org>
References: <20220802182502.85562-1-brianrob@linux.microsoft.com>
 <CAP-5=fXY8paDRMcyMokRMXOrrB2CHfY2=HkPsHZrWL_vd_-bWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXY8paDRMcyMokRMXOrrB2CHfY2=HkPsHZrWL_vd_-bWw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 04, 2022 at 08:22:14AM -0700, Ian Rogers escreveu:
> On Tue, Aug 2, 2022 at 11:25 AM Brian Robbins
> <brianrob@linux.microsoft.com> wrote:
> >
> > Some processes store jitted code in memfd mappings to avoid having rwx
> > mappings.  These processes map the code with a writeable mapping and a
> > read-execute mapping.  They write the code using the writeable mapping
> > and then unmap the writeable mapping.  All subsequent execution is
> > through the read-execute mapping.
> >
> > perf inject --jit ignores //anon* mappings for each process where a
> > jitdump is present because it expects to inject mmap events for each
> > jitted code range, and said jitted code ranges will overlap with the
> > //anon* mappings.
> >
> > Ignore /memfd: mappings so that jitted code contained in /memfd:
> > mappings is treated the same way as jitted code contained in //anon*
> > mappings.
> >
> > Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

  CC      /tmp/build/perf/util/jitdump.o
  CC      /tmp/build/perf/pmu-events/pmu-events.o
  LD      /tmp/build/perf/pmu-events/pmu-events-in.o
util/jitdump.c: In function ‘jit_process’:
util/jitdump.c:853:65: error: expected ‘)’ before ‘return’
  853 |                          (strncmp(filename, "/memfd:", 7) == 0))
      |                                                                 ^
      |                                                                 )
  854 |                         return 1;
      |                         ~~~~~~
util/jitdump.c:851:20: note: to match this ‘(’
  851 |                 if (jit_has_pid(machine, pid) &&
      |                    ^
util/jitdump.c:857:9: error: expected expression before ‘}’ token
  857 |         }
      |         ^
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/jitdump.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2


Trying to fix now.

- Arnaldo
 
> > ---
> >  tools/perf/util/jitdump.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> > index a23255773c60..335a3c61940b 100644
> > --- a/tools/perf/util/jitdump.c
> > +++ b/tools/perf/util/jitdump.c
> > @@ -845,8 +845,12 @@ jit_process(struct perf_session *session,
> >         if (jit_detect(filename, pid, nsi)) {
> >                 nsinfo__put(nsi);
> >
> > -               // Strip //anon* mmaps if we processed a jitdump for this pid
> > -               if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
> > +               /*
> > +                * Strip //anon* and /memfd:* mmaps if we processed a jitdump for this pid
> > +                */
> > +               if (jit_has_pid(machine, pid) &&
> > +                       ((strncmp(filename, "//anon", 6) == 0) ||
> > +                        (strncmp(filename, "/memfd:", 7) == 0))
> 
> Related to this there is the prctl PR_SET_VMA_ANON_NAME which will
> name mapping to start with "[anon:"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/proc.rst#n434
> I wonder also we should be checking the pages are executable.
> 
> Thanks,
> Ian
> 
> >                         return 1;
> >
> >                 return 0;
> > --
> > 2.25.1
> >

-- 

- Arnaldo
