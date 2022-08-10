Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823CA58ECB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiHJNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiHJNDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A06CD26;
        Wed, 10 Aug 2022 06:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D623E6143F;
        Wed, 10 Aug 2022 13:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAEAC433C1;
        Wed, 10 Aug 2022 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660136600;
        bh=h4aEJWedInCPM5c5hyMsi++l2BhJ1unrkZNoDXxgsBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwuoyFeOhfWn8bwx8qHXTWjg2NacpwaYMPlI1wz6TX47IIBOoxvbSAVfGYQIcGeRR
         TVxFn5D/gMxwYkZtS0UePxsBsslje6amNC7g2WjhxsHynPMvvQsWwipWWKieKcVaY+
         4LEFGt5xp5eKCe4G0x5l27czLTHLfBEFFbiG7U/1ik9Rt8Zy/pg2q/WteqY5ap9/XQ
         vy0r4k5g5aKGviVLk6nL3Jw4euIAktA/cbBccn4wR6HcdBNCguXBj/0DT1O9rO70Je
         5/D811gi9xdP3I99InODBHcIX0pH5EtpfV4+LTXQPJo9e3P5GC2cWln+D8ZmwFVo+L
         v7R1RPIsfcGnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9C1C4035A; Wed, 10 Aug 2022 10:03:17 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:03:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Brian Robbins <brianrob@linux.microsoft.com>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject jit: Ignore memfd mmap events if jitdump
 present
Message-ID: <YvOslWVtSyHRJAOw@kernel.org>
References: <20220802182502.85562-1-brianrob@linux.microsoft.com>
 <CAP-5=fXY8paDRMcyMokRMXOrrB2CHfY2=HkPsHZrWL_vd_-bWw@mail.gmail.com>
 <YvOr3t9JNlEI4p+6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvOr3t9JNlEI4p+6@kernel.org>
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

Em Wed, Aug 10, 2022 at 10:00:14AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Aug 04, 2022 at 08:22:14AM -0700, Ian Rogers escreveu:
> > On Tue, Aug 2, 2022 at 11:25 AM Brian Robbins <brianrob@linux.microsoft.com> wrote:
> > > Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
>   CC      /tmp/build/perf/util/jitdump.o
>   CC      /tmp/build/perf/pmu-events/pmu-events.o
>   LD      /tmp/build/perf/pmu-events/pmu-events-in.o
> util/jitdump.c: In function ‘jit_process’:
> util/jitdump.c:853:65: error: expected ‘)’ before ‘return’
>   853 |                          (strncmp(filename, "/memfd:", 7) == 0))
>       |                                                                 ^
>       |                                                                 )
>   854 |                         return 1;
>       |                         ~~~~~~
> util/jitdump.c:851:20: note: to match this ‘(’
>   851 |                 if (jit_has_pid(machine, pid) &&
>       |                    ^
> util/jitdump.c:857:9: error: expected expression before ‘}’ token
>   857 |         }
>       |         ^
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/jitdump.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> 
> 
> Trying to fix now.

Trivial, please compile test it...

- Arnaldo

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 335a3c61940b7b39..9983d21a5c42d70e 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -850,7 +850,7 @@ jit_process(struct perf_session *session,
 		 */
 		if (jit_has_pid(machine, pid) &&
 			((strncmp(filename, "//anon", 6) == 0) ||
-			 (strncmp(filename, "/memfd:", 7) == 0))
+			 (strncmp(filename, "/memfd:", 7) == 0)))
 			return 1;
 
 		return 0;
