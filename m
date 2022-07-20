Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7296557BB29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiGTQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbiGTQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:13:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2221852FDC;
        Wed, 20 Jul 2022 09:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9481B82078;
        Wed, 20 Jul 2022 16:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50258C341C7;
        Wed, 20 Jul 2022 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658333599;
        bh=wSEX2UuN+q5jlF2IsRuSYl0hA2XlW9/f0OQOD1VuN5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISId+4eARJuS8HyL7M1Gk/HDKmUVYGgTXmFR4u4B+JgEj6wdBewDa2CPDopco1EmL
         5XsQzNVX14yhsolOLW5n4cHHIip+N/JpfdpgttS9nxlveoOkd2sAtJSYFcJXNOgVmh
         I6VeHRSCWrNEMtMHUj8L06w/VifXetXzhPCn40dMfJUOLTiy8dB5IlMQ9GVRfRBriv
         W8hWL+Cz+ZBnny8GAAy9pJNvw5uhAzSKZJQPZKxk0fP4gTKICg6ir6wp4mzEoKmWyz
         3u15JJ3yASjm0XrwuWS0QJeHio+qWyDU9owtEII+DmkRKfdxOLcODlii4COrlwdcWy
         KIjYpCdxldl5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CDD440374; Wed, 20 Jul 2022 13:13:16 -0300 (-03)
Date:   Wed, 20 Jul 2022 13:13:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] perf/tests: Fix test case 83 on s390
Message-ID: <YtgpnIBpt+zNYHyu@kernel.org>
References: <20220720123419.220953-1-tmricht@linux.ibm.com>
 <CAP-5=fWeUh2hyGAqc4XidJZ7X06f4=MojyQwuOtbL3cs3u+T=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWeUh2hyGAqc4XidJZ7X06f4=MojyQwuOtbL3cs3u+T=w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 20, 2022 at 06:16:44AM -0700, Ian Rogers escreveu:
> On Wed, Jul 20, 2022, 5:34 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
> > Perf test case 83: perf stat CSV output linter might fail
> > on s390.
> > The reason for this is the output of the command
> >
> >  ./perf stat -x, -A -a --no-merge true
> >
> > which depends on a .config file setting. When CONFIG_SCHED_TOPOLOGY
> > is set, the output of above perf command is
> >
> >    CPU0,1.50,msec,cpu-clock,1502781,100.00,1.052,CPUs utilized
> >
> > When CONFIG_SCHED_TOPOLOGY is *NOT* set the output of above perf
> > command is
> >
> >    0.95,msec,cpu-clock,949800,100.00,1.060,CPUs utilized
> >
> > Fix the test case to accept both output formats.
> >
> > Output before:
> >  # perf test 83
> >  83: perf stat CSV output linter       : FAILED!
> >  #
> >
> > Output after:
> >  # ./perf test 83
> >  83: perf stat CSV output linter       : Ok
> >  #
> >
> > Fixes: ec906102e5b7 ("perf test: Fix "perf stat CSV output linter" test on
> > s390")
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> >
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> ---
> >  tools/perf/tests/shell/stat+csv_output.sh | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+csv_output.sh
> > b/tools/perf/tests/shell/stat+csv_output.sh
> > index 38c26f3ef4c1..eb5196f58190 100755
> > --- a/tools/perf/tests/shell/stat+csv_output.sh
> > +++ b/tools/perf/tests/shell/stat+csv_output.sh
> > @@ -8,7 +8,8 @@ set -e
> >
> >  function commachecker()
> >  {
> > -       local -i cnt=0 exp=0
> > +       local -i cnt=0
> > +       local exp=0
> >
> >         case "$1"
> >         in "--no-args")         exp=6
> > @@ -17,7 +18,7 @@ function commachecker()
> >         ;; "--interval")        exp=7
> >         ;; "--per-thread")      exp=7
> >         ;; "--system-wide-no-aggr")     exp=7
> > -                               [ $(uname -m) = "s390x" ] && exp=6
> > +                               [ $(uname -m) = "s390x" ] && exp='^[6-7]$'
> >         ;; "--per-core")        exp=8
> >         ;; "--per-socket")      exp=8
> >         ;; "--per-node")        exp=8
> > @@ -34,7 +35,7 @@ function commachecker()
> >                 x=$(echo $line | tr -d -c ',')
> >                 cnt="${#x}"
> >                 # echo $line $cnt
> > -               [ "$cnt" -ne "$exp" ] && {
> > +               [[ ! "$cnt" =~ $exp ]] && {
> >                         echo "wrong number of fields. expected $exp in
> > $line" 1>&2
> >                         exit 1;
> >                 }
> > --
> > 2.36.1
> >
> >

-- 

- Arnaldo
