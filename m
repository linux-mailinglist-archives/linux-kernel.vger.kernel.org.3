Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEE24DB982
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357963AbiCPUiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358310AbiCPUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:38:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBBF65817
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC956141B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B61C340E9;
        Wed, 16 Mar 2022 20:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647463021;
        bh=TT5aj2bS0CfHdcNhyjXK54D7ZtehWAt5yO7XurUnSfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hY5Lo9rqrd03oiydupg7X2xccQyXWiDOE/UGjqL6xvdziwaFpfViFUWpsltAO3kHy
         DwDE+T/8FnyodlGo7a2H33X5mtGnxtCEprkTbnYn71W5WSDf0ity58lAU9MuN6hJNW
         0851jotxe9ODCxZo7CXlqjqBXptnjfrySAyDmHkfbtFZvebPXYH2KXkuRrbjD9wwR0
         Zx5tiOwk9KOQw09HcXPXjD4nuYMKY08dViUERENMXn54NrzGWqTLakpDzvYurJhR5f
         GMCdgYD7n3whSX0/PpNCCtyk3RIInVBixM+oi1JmV3IwsZG1GYCxQtbkIhuwIHLOU8
         wzQkYa57YTEHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 730F940407; Wed, 16 Mar 2022 17:36:57 -0300 (-03)
Date:   Wed, 16 Mar 2022 17:36:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf trace: Fix SIGSEGV when processing augmented args
Message-ID: <YjJKaSanKI7LQdEk@kernel.org>
References: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
 <Yi+9G1nK1shEIXVN@kernel.org>
 <1647364864.3xrhklc7kl.naveen@linux.ibm.com>
 <YjDSRb1wwswKpJNJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjDSRb1wwswKpJNJ@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 15, 2022 at 02:52:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 15, 2022 at 10:57:57PM +0530, Naveen N. Rao escreveu:
> > Yes, it looks like the current check in 'perf' isn't working. The below
> > patch also resolves the crash we are seeing:
>  
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 2f1d20553a0aa3..86b459f4ebdd61 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2326,7 +2326,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
> >         * thinking that the extra 2 u64 args are the augmented filename, so just check
> >         * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
> >         */
> > -       if (evsel != trace->syscalls.events.sys_enter)
> > +       if (strcmp(evsel__name(evsel), "raw_syscalls:sys_enter"))
> >                augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
> >        ttrace->entry_time = sample->time;
> >        msg = ttrace->entry_str;
> 
> Interesting, that should be equivalent :-\ humm, not really, understood,
> when processing perf.data files we don't setup
> trace->syscalls.events.sys_enter...
> 
> switching from strcmp() to something cheaper but equivalent should be
> the fix for now.

I'll add a trace->use_augmented_args boolean that will do this test
once, and then use it in this case and will audit to check if this
should be used in other places.

- Arnaldo
