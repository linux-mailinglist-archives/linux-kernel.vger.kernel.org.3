Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B64A5786BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiGRPtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiGRPta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98C6594;
        Mon, 18 Jul 2022 08:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0F26145B;
        Mon, 18 Jul 2022 15:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874EEC341CA;
        Mon, 18 Jul 2022 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658159367;
        bh=IfAevGzlpYCavmnr3ns+VPAyXBT6NE4h2pno3np3Oyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGCPao167W/S4i0fNSIkzBvgCNkf8Y8RqKtTF8saQLEUstEOL4tdYCAm1ieeZfVWU
         2rIVnC+hnGwZ8cTIb2zOBJT3c7kzhHgw/FLW3Lcu8YCvBf/kfUpI6/KX7MycQwOB+9
         /hkZckzOJONozJ23Br0wG+PItJ57+Azmc4jBn/JMLURHTFwbE3pSx01VoRkx4sjofg
         bjjN0lDcJcgEq3zAqYJHg3cVqO5jTnL/445JVJ53ZMUgl4/i7+a7vX01MHY5Qn5Ywi
         zYU7Vj64PuMqIQv0sheHmBahZz6tz1Z+bvPwSyNTLCfOg9OG/zS3kTNctQR/cDnOQe
         wI46ITQXy6cqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F21240374; Mon, 18 Jul 2022 12:49:25 -0300 (-03)
Date:   Mon, 18 Jul 2022 12:49:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v6 2/2] perf test: Json format checking
Message-ID: <YtWBBSHK2hAtykro@kernel.org>
References: <20220707201213.331663-1-irogers@google.com>
 <20220707201213.331663-3-irogers@google.com>
 <YtV/+yRsA9SJuntp@kernel.org>
 <YtWAQqXFp98+N9ej@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtWAQqXFp98+N9ej@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 18, 2022 at 12:46:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jul 18, 2022 at 12:44:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jul 07, 2022 at 01:12:13PM -0700, Ian Rogers escreveu:
> > > From: Claire Jensen <cjense@google.com>
> > > 
> > > Add field checking tests for perf stat JSON output.
> > > Sanity checks the expected number of fields are present, that the
> > > expected keys are present and they have the correct values.
> > 
> > it isn't installing the lib:
> > 
> > [root@five ~]# perf test -v json
> >  91: perf stat JSON output linter                                    :
> > --- start ---
> > test child forked, pid 4086678
> > Checking json output: no args python3: can't open file '/var/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py': [Errno 2] No such file or directory
> > test child finished with -2
> > ---- end ----
> > perf stat JSON output linter: Skip
> > [root@five ~]#
> > 
> > I'm trying to fix, but please test it after installing...
> 
> 
> It should:
> 
> install-tests: all install-gtk
>         $(call QUIET_INSTALL, tests) \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
>                 $(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
>                 $(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
>                 $(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>                 $(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> 
> /me checking...

The patch below is needed, but then should we mix .py and .sh in that
directory?

⬢[acme@toolbox perf]$ git diff
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8f0b1fb39984fb7b..65e5ba767fd6210e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1006,6 +1006,7 @@ install-tests: all install-gtk
                $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
                $(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+               $(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'

 install-bin: install-tools install-tests install-traceevent-plugins

⬢[acme@toolbox perf]$

And then, after that I'm getting:

[root@five ~]# perf test json
 91: perf stat JSON output linter                                    : FAILED!
[root@five ~]# perf test -v json |& tail -20
{"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "2675.000000", "unit" : "", "event" : "stalled-cycles-backend", "event-runtime" : 2864158, "pcnt-running" : 100.00, "metric-value" : 0.341252, "metric-unit" : "backend cycles idle"}

{"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "233533.000000", "unit" : "", "event" : "instructions", "event-runtime" : 2865528, "pcnt-running" : 100.00, "metric-value" : 0.297920, "metric-unit" : "insn per cycle"}

{"core" : "S0-D0-C15", "aggregate-number" : 2, "metric-value" : 0.192975, "metric-unit" : "stalled cycles per insn"}

{"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "50214.000000", "unit" : "", "event" : "branches", "event-runtime" : 2865638, "pcnt-running" : 100.00, "metric-value" : 17.295742, "metric-unit" : "M/sec"}

{"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "1513.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 1564989, "pcnt-running" : 54.00, "metric-value" : 3.013104, "metric-unit" : "of all branches"}

Traceback (most recent call last):
  File "/var/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py", line 92, in <module>
    check_json_output(expected_items)
  File "/var/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py", line 53, in check_json_output
    raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
RuntimeError: wrong number of fields. counted 3 expected 8 in '{"core" : "S0-D0-C0", "aggregate-number" : 2, "metric-value" : 0.094345, "metric-unit" : "stalled cycles per insn"}
'
test child finished with -1
---- end ----
perf stat JSON output linter: FAILED!
[root@five ~]#

Can you please check and send a v7?

- Arnaldo
