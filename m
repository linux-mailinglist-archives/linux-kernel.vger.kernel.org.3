Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1C4A690E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiBBAGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbiBBAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:05:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D2C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:05:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D0C1B82FD7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 00:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7425AC340EB;
        Wed,  2 Feb 2022 00:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643760338;
        bh=VUqkqquIWg/3d9hQ17R1PT2mAcvYBQq+wr0ehgJEG/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDgPQHj8lacBWG8rb5OT+SQM8G5eWj39mnZPLScp6pId+rH590Vf32Cd84rV38Q9Z
         DNA9EY1+1wiSarbQYsT4koBF5/p64vb22+b7cZ7AILrkvwxR4jU1/6LCGVy9Kl0ewX
         +7+DI3vjCbMD6zni82bvi3oALVF7fZZRscLkU/VZsHU2P6XXzCUSvLIZPEdpIBK+KQ
         h8eYErFH3X8/fhjFTQaybL0EP0tlCYhWUJPGyeyLONl4/GdY9AJXSePpFjUfzhpog8
         zXH5RM7upBq3dr3L8oY3sylLXeeoxLNIDlUyj8JAKCFEPYswvWfHSCDYujhVWGvXee
         pENftZyedvw6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 398D640466; Tue,  1 Feb 2022 21:05:36 -0300 (-03)
Date:   Tue, 1 Feb 2022 21:05:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Colin Cross <ccross@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf beauty: Make the prctl arg regexp more strict
 to cope with PR_SET_VMA
Message-ID: <YfnK0KfMknsqKb2Z@kernel.org>
References: <YflZqY0rYQ3d1bKt@kernel.org>
 <CAM9d7cgVmH=sKH07+fPVzEPzCfDiKaMs_-kNgFHFc6W+0F9MfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgVmH=sKH07+fPVzEPzCfDiKaMs_-kNgFHFc6W+0F9MfA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 01, 2022 at 11:46:25AM -0800, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Tue, Feb 1, 2022 at 8:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > FYI, I'm carrying this on the perf tools tree:
> >
> > ---
> >
> > This new PR_SET_VMA value isn't in sequence with all the other prctl
> > arguments and instead uses a big, 0x prefixed hex number: 0x53564d41 (S V M A).
> 
> It seems that we also have PR_SET_PTRACER: 0x59616d61.

so it has precedent, oh well, so we probably need a switch based
id->string and back for such cases, will check.
 
> >
> > This makes it harder to generate a string table as it would be rather
> > sparse, so make the regexp more stricter to avoid catching those.
> >
> > A followup patch for 'perf trace' to cope with such oddities will be
> > needed, but then its a matter for the next merge window.
> >
> > The next patch will update the prctl.h file to cope with this perf build
> > warning:
> >
> >   Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
> >   diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
> >
> > Here is the output of this script:
> >
> >   $ tools/perf/trace/beauty/prctl_option.sh
> >   static const char *prctl_options[] = {
> >         [1] = "SET_PDEATHSIG",
> >         [2] = "GET_PDEATHSIG",
> >         [3] = "GET_DUMPABLE",
> >         [4] = "SET_DUMPABLE",
> >         [5] = "GET_UNALIGN",
> >         [6] = "SET_UNALIGN",
> >         [7] = "GET_KEEPCAPS",
> >         [8] = "SET_KEEPCAPS",
> >         [9] = "GET_FPEMU",
> >         [10] = "SET_FPEMU",
> >         [11] = "GET_FPEXC",
> >         [12] = "SET_FPEXC",
> >         [13] = "GET_TIMING",
> >         [14] = "SET_TIMING",
> >         [15] = "SET_NAME",
> >         [16] = "GET_NAME",
> >         [19] = "GET_ENDIAN",
> >         [20] = "SET_ENDIAN",
> >         [21] = "GET_SECCOMP",
> >         [22] = "SET_SECCOMP",
> >         [23] = "CAPBSET_READ",
> >         [24] = "CAPBSET_DROP",
> >         [25] = "GET_TSC",
> >         [26] = "SET_TSC",
> >         [27] = "GET_SECUREBITS",
> >         [28] = "SET_SECUREBITS",
> >         [29] = "SET_TIMERSLACK",
> >         [30] = "GET_TIMERSLACK",
> >         [31] = "TASK_PERF_EVENTS_DISABLE",
> >         [32] = "TASK_PERF_EVENTS_ENABLE",
> >         [33] = "MCE_KILL",
> >         [34] = "MCE_KILL_GET",
> >         [35] = "SET_MM",
> >         [36] = "SET_CHILD_SUBREAPER",
> >         [37] = "GET_CHILD_SUBREAPER",
> >         [38] = "SET_NO_NEW_PRIVS",
> >         [39] = "GET_NO_NEW_PRIVS",
> >         [40] = "GET_TID_ADDRESS",
> >         [41] = "SET_THP_DISABLE",
> >         [42] = "GET_THP_DISABLE",
> >         [43] = "MPX_ENABLE_MANAGEMENT",
> >         [44] = "MPX_DISABLE_MANAGEMENT",
> >         [45] = "SET_FP_MODE",
> >         [46] = "GET_FP_MODE",
> >         [47] = "CAP_AMBIENT",
> >         [50] = "SVE_SET_VL",
> >         [51] = "SVE_GET_VL",
> >         [52] = "GET_SPECULATION_CTRL",
> >         [53] = "SET_SPECULATION_CTRL",
> >         [54] = "PAC_RESET_KEYS",
> >         [55] = "SET_TAGGED_ADDR_CTRL",
> >         [56] = "GET_TAGGED_ADDR_CTRL",
> >         [57] = "SET_IO_FLUSHER",
> >         [58] = "GET_IO_FLUSHER",
> >         [59] = "SET_SYSCALL_USER_DISPATCH",
> >         [60] = "PAC_SET_ENABLED_KEYS",
> >         [61] = "PAC_GET_ENABLED_KEYS",
> >         [62] = "SCHED_CORE",
> >   };
> >   static const char *prctl_set_mm_options[] = {
> >         [1] = "START_CODE",
> >         [2] = "END_CODE",
> >         [3] = "START_DATA",
> >         [4] = "END_DATA",
> >         [5] = "START_STACK",
> >         [6] = "START_BRK",
> >         [7] = "BRK",
> >         [8] = "ARG_START",
> >         [9] = "ARG_END",
> >         [10] = "ENV_START",
> >         [11] = "ENV_END",
> >         [12] = "AUXV",
> >         [13] = "EXE_FILE",
> >         [14] = "MAP",
> >         [15] = "MAP_SIZE",
> >   };
> >   $
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Colin Cross <ccross@google.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/trace/beauty/prctl_option.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
> > index 3109d7b05e113bb5..3d278785fe574a0e 100755
> > --- a/tools/perf/trace/beauty/prctl_option.sh
> > +++ b/tools/perf/trace/beauty/prctl_option.sh
> > @@ -4,7 +4,7 @@
> >  [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
> >
> >  printf "static const char *prctl_options[] = {\n"
> > -regex='^#define[[:space:]]+PR_(\w+)[[:space:]]*([[:xdigit:]]+).*'
> > +regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*\/.*)?$'
> 
> I'm not sure what the last parenthesis takes care of.

Comments, the two first entries are:

#define PR_SET_PDEATHSIG  1  /* Second arg is a signal */
#define PR_GET_PDEATHSIG  2  /* Second arg is a ptr to return the signal */

In a tool friendly universe these should be in an enum and then we would
use BTF to do these integer to string and back translations, but where
we live we need to cope with these variations.
 
> >  egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
> 
> Maybe just adding PR_SET_VMA here is enough?

Possibly, but that thing with PR_SET_PTRACER was a workaround that ended
up being forgotten :-\

Yeah, this is all fragile, having integer syscall args as enum entries
would help a lot tool writers, but then, don't complain, use what is
available.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> >         sed -r "s/$regex/\2 \1/g"       | \
> >         sort -n | xargs printf "\t[%s] = \"%s\",\n"
