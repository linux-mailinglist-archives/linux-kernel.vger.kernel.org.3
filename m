Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC658A009
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiHDRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiHDRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:51:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60EFA252BB;
        Thu,  4 Aug 2022 10:51:42 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1145)
        id EFE8A20FFD77; Thu,  4 Aug 2022 10:51:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFE8A20FFD77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659635501;
        bh=DA2WdpGD1N3fcW6Dsv5m5wiKHrGeoNd5c50fiNvhp5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvQcFnxQRNl4/WLq33i0JzbCPxbjU1svjIha/mscRx0GZkgQmORxIUcDlxxTo2QSB
         nuTjSIysihYk8eF/BP88ceadz4TvxzgcdKbYbqo5tELhAXBqo6LlS09j76fMl3L3dV
         KMP3uZHylt/dSFhVWkXrDEp2ulA7peQggkpK2HKY=
Date:   Thu, 4 Aug 2022 10:51:41 -0700
From:   Brian Robbins <brianrob@linux.microsoft.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject jit: Ignore memfd mmap events if jitdump
 present
Message-ID: <20220804175141.GA3858@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20220802182502.85562-1-brianrob@linux.microsoft.com>
 <CAP-5=fXY8paDRMcyMokRMXOrrB2CHfY2=HkPsHZrWL_vd_-bWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXY8paDRMcyMokRMXOrrB2CHfY2=HkPsHZrWL_vd_-bWw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:22:14AM -0700, Ian Rogers wrote:
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
> 
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

I have not run into this case yet, but I suspect you are right that this should be handled as well.  I can create a follow-up patch for this.

Thanks.
--Brian
