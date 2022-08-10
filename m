Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1D58EEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiHJPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHJPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:08:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 389976C74B;
        Wed, 10 Aug 2022 08:08:52 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1145)
        id DB27F210CB15; Wed, 10 Aug 2022 08:08:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB27F210CB15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660144131;
        bh=utP8oCB0AmtRBqpfmX/hnOHst41ba3KRLGZ8aBC/m0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFTaNA/9THXhHTsI3dirUuz+jiTc5/kvbFmP53vi+LJpQ/C3fPx95b/yn/gNFIuji
         PBEmQrjiEPpwY10x0h+Bn5YnrN9mUIcI2OX+fOtU3xDwSnGhYK3Vqvt5+Y1p2NNiJO
         pev/aYPKGXocsoHX+4CIfxjKgkS3tWY0Ms+qioIY=
Date:   Wed, 10 Aug 2022 08:08:51 -0700
From:   Brian Robbins <brianrob@linux.microsoft.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject jit: Ignore memfd mmap events if jitdump
 present
Message-ID: <20220810150851.GA21583@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20220802182502.85562-1-brianrob@linux.microsoft.com>
 <CAP-5=fXY8paDRMcyMokRMXOrrB2CHfY2=HkPsHZrWL_vd_-bWw@mail.gmail.com>
 <YvOr3t9JNlEI4p+6@kernel.org>
 <YvOslWVtSyHRJAOw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvOslWVtSyHRJAOw@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:03:17AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 10, 2022 at 10:00:14AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Aug 04, 2022 at 08:22:14AM -0700, Ian Rogers escreveu:
> > > On Tue, Aug 2, 2022 at 11:25 AM Brian Robbins <brianrob@linux.microsoft.com> wrote:
> > > > Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>
> > > 
> > > Acked-by: Ian Rogers <irogers@google.com>
> > 
> >   CC      /tmp/build/perf/util/jitdump.o
> >   CC      /tmp/build/perf/pmu-events/pmu-events.o
> >   LD      /tmp/build/perf/pmu-events/pmu-events-in.o
> > util/jitdump.c: In function ‘jit_process’:
> > util/jitdump.c:853:65: error: expected ‘)’ before ‘return’
> >   853 |                          (strncmp(filename, "/memfd:", 7) == 0))
> >       |                                                                 ^
> >       |                                                                 )
> >   854 |                         return 1;
> >       |                         ~~~~~~
> > util/jitdump.c:851:20: note: to match this ‘(’
> >   851 |                 if (jit_has_pid(machine, pid) &&
> >       |                    ^
> > util/jitdump.c:857:9: error: expected expression before ‘}’ token
> >   857 |         }
> >       |         ^
> > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/jitdump.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> > 
> > 
> > Trying to fix now.
> 
> Trivial, please compile test it...
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 335a3c61940b7b39..9983d21a5c42d70e 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -850,7 +850,7 @@ jit_process(struct perf_session *session,
>  		 */
>  		if (jit_has_pid(machine, pid) &&
>  			((strncmp(filename, "//anon", 6) == 0) ||
> -			 (strncmp(filename, "/memfd:", 7) == 0))
> +			 (strncmp(filename, "/memfd:", 7) == 0)))
>  			return 1;
>  
>  		return 0;

Apologies about that.  Fixed this in v2.

--Brian
