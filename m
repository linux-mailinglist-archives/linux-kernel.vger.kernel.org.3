Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B58568E51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiGFPwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiGFPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DD2655F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1691E61FAC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E70C3411C;
        Wed,  6 Jul 2022 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657122626;
        bh=ViaMuLi4HNR/JkZs+Ue4PdCTt9ZbO+5BZ+zjC0V0VwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7llt3fpXNTF1QgDdMNjSHXYfeFNwRC7UcZzyFsGfl2yJ4JQ7Yqy+Ovm76QbFGzXG
         JtF9qCbzMXqCb2VWjMMXtldmgs04nBPJXXyKxrlxSVl32Y/eQAn9q3mwm+C0EZ/3hJ
         0++2TvirDwB1AiAawYphlq9VSrnqKCTDn2PW4vSV1mBWOkZEdJ+4xNj7O+FEgZg6DD
         XfzzD8pCMe6H3dfe/gQbQ5RQgazcdI5j+3ID5iRLAkMGKxOdT+ALy09UJ3MyJbulkB
         PPq0xN99M99qXfMPPC1Kb6Yu37OWpV21KBWHKqE5koCY0k/YurN6NIyfFqIqRrot+L
         4iQcEaKlcgwcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DCB14096F; Wed,  6 Jul 2022 12:50:23 -0300 (-03)
Date:   Wed, 6 Jul 2022 12:50:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel? Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf trace: Fix SIGSEGV when processing augmented args
Message-ID: <YsWvPwRirNIT67tl@kernel.org>
References: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
 <Yi+9G1nK1shEIXVN@kernel.org>
 <1647364864.3xrhklc7kl.naveen@linux.ibm.com>
 <YjDSRb1wwswKpJNJ@kernel.org>
 <YjJKaSanKI7LQdEk@kernel.org>
 <1657110053.93m1349h4k.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657110053.93m1349h4k.naveen@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 06, 2022 at 06:01:29PM +0530, Naveen N. Rao escreveu:
> Hi Arnaldo,
> 
> Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 15, 2022 at 02:52:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Mar 15, 2022 at 10:57:57PM +0530, Naveen N. Rao escreveu:
> > > > Yes, it looks like the current check in 'perf' isn't working. The below
> > > > patch also resolves the crash we are seeing:
> > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > > index 2f1d20553a0aa3..86b459f4ebdd61 100644
> > > > --- a/tools/perf/builtin-trace.c
> > > > +++ b/tools/perf/builtin-trace.c
> > > > @@ -2326,7 +2326,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
> > > >         * thinking that the extra 2 u64 args are the augmented filename, so just check
> > > >         * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
> > > >         */
> > > > -       if (evsel != trace->syscalls.events.sys_enter)
> > > > +       if (strcmp(evsel__name(evsel), "raw_syscalls:sys_enter"))
> > > >                augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
> > > >        ttrace->entry_time = sample->time;
> > > >        msg = ttrace->entry_str;
> > > 
> > > Interesting, that should be equivalent :-\ humm, not really, understood,
> > > when processing perf.data files we don't setup
> > > trace->syscalls.events.sys_enter...
> > > 
> > > switching from strcmp() to something cheaper but equivalent should be
> > > the fix for now.
> > 
> > I'll add a trace->use_augmented_args boolean that will do this test
> > once, and then use it in this case and will audit to check if this
> > should be used in other places.
> 
> Does something like the below look reasonable?
> 
> I know this isn't quite what you proposed, but it fixes the problem for me
> while avoiding the need for a string comparison. I also think this addresses
> all uses in 'perf trace', though I didn't audit the need for a similar fix
> elsewhere in 'perf'.

I'll check and test, but I like it, two-liner even :-)

- Arnaldo
 
> 
> Thanks,
> Naveen
> 
> ---
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d2de2a4073e7eb..352b88a51dec2d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4291,6 +4292,8 @@ static int trace__replay(struct trace *trace)
>                goto out;
>        }
> 
> +       trace->syscalls.events.sys_enter = evsel;
> +
>        evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_exit");
>        if (evsel == NULL)
>                evsel = evlist__find_tracepoint_by_name(session->evlist, "syscalls:sys_exit");
> @@ -4301,6 +4304,8 @@ static int trace__replay(struct trace *trace)
>                goto out;
>        }
> 
> +       trace->syscalls.events.sys_exit  = evsel;
> +
>        evlist__for_each_entry(session->evlist, evsel) {
>                if (evsel->core.attr.type == PERF_TYPE_SOFTWARE &&
>                    (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ||
> 
> 

-- 

- Arnaldo
