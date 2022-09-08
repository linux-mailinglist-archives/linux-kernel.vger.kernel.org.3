Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A3E5B265A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiIHS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiIHS63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:58:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3624910305A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C372B8222B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6B5C433D6;
        Thu,  8 Sep 2022 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662663501;
        bh=cPFByCvu/C3KPtwJZt53ds68xxl4eDNJgHnYFaX4Pdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWKqnOWuiXLyqG0Q5B5eFkIklwaMSfR/KfU+WTtEsZqfH8ynkAG4bgb8cZlY9Jhev
         lDmXIM1Q8cXD0rxInJv81VQvX+tZpXSdOdpGRwNV3AsBHwysKbF+BerkVOz9ObSVi9
         ufH5lwwDmkN4+4bnzpWxUNmqqvNOTcq+dOzAD4MOE8wJvVw8A+e2/DEsxlNfL+qY7o
         +n7Typ9u6KZF/l3yWovoCE7jrkrKC9YcAwoAoMf+hF2C6lxBKdutMUQNroc0f3eki9
         XHo5/J3v40HvHdOYMuYQy3rRQ9mgj9X3ZhQhg+d54FOaReY4rnFA7RWfHAEvEpz62O
         3I7pZmBfD7yYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E339C404A1; Thu,  8 Sep 2022 15:58:18 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:58:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Fix synthesis failure warnings
Message-ID: <Yxo7SkkijJj1vuZW@kernel.org>
References: <20220907162458.72817-1-adrian.hunter@intel.com>
 <CAM9d7cj=yyfmCRfEVvp7kCHRE8cTEkRFf_unThde2kNoo-x+GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj=yyfmCRfEVvp7kCHRE8cTEkRFf_unThde2kNoo-x+GA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 07, 2022 at 10:58:58AM -0700, Namhyung Kim escreveu:
> On Wed, Sep 7, 2022 at 9:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Some calls to synthesis functions set err < 0 but only warn about the
> > failure and continue.  However they do not set err back to zero, relying
> > on subsequent code to do that.
> >
> > That changed with the introduction of option --synth. When --synth=no
> > subsequent functions that set err back to zero are not called.
> >
> > Fix by setting err = 0 in those cases.
> >
> > Example:
> >
> >  Before:
> >
> >    $ perf record --no-bpf-event --synth=all -o /tmp/huh uname
> >    Couldn't synthesize bpf events.
> >    Linux
> >    [ perf record: Woken up 1 times to write data ]
> >    [ perf record: Captured and wrote 0.014 MB /tmp/huh (7 samples) ]
> >    $ perf record --no-bpf-event --synth=no -o /tmp/huh uname
> >    Couldn't synthesize bpf events.
> >
> >  After:
> >
> >    $ perf record --no-bpf-event --synth=no -o /tmp/huh uname
> >    Couldn't synthesize bpf events.
> >    Linux
> >    [ perf record: Woken up 1 times to write data ]
> >    [ perf record: Captured and wrote 0.014 MB /tmp/huh (7 samples) ]
> >
> > Fixes: 41b740b6e8a9 ("perf record: Add --synth option")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/builtin-record.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index bce8c941d558..7713246a393f 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1974,14 +1974,18 @@ static int record__synthesize(struct record *rec, bool tail)
> >
> >         err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
> >                                                 machine, opts);
> > -       if (err < 0)
> > +       if (err < 0) {
> >                 pr_warning("Couldn't synthesize bpf events.\n");
> > +               err = 0;
> > +       }
> >
> >         if (rec->opts.synth & PERF_SYNTH_CGROUP) {
> >                 err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
> >                                                      machine);
> > -               if (err < 0)
> > +               if (err < 0) {
> >                         pr_warning("Couldn't synthesize cgroup events.\n");
> > +                       err = 0;
> > +               }
> >         }
> >
> >         if (rec->opts.nr_threads_synthesize > 1) {
> > --
> > 2.25.1
> >

-- 

- Arnaldo
