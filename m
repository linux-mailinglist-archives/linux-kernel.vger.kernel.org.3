Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8749D4E320E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiCUUyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCUUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:54:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36608D63;
        Mon, 21 Mar 2022 13:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABD32B819E1;
        Mon, 21 Mar 2022 20:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30816C340E8;
        Mon, 21 Mar 2022 20:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647895973;
        bh=RMHwF+upYOMgTMbO+pQMLcTl41MLqg+oxmrwPn97eaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/GLssabZsc03oSZsONB+Xl4TIThhWoSwwpkIiw8nUfZFIBSF86YKRBhZTYQxBVD8
         0e7WtnD/IX6C2sNWSRPGGkBbEVT8AGxzR7W1Y420eLf4id1DgKv9+O2ppwEBtADXja
         fYc9zJZGRcSyNhvgWMkWf6TtfQDx9EdbqUg7kjuX3rzG9hA7WV3jQxewla6cMEqBx2
         mULb1ET3Z4c2PrwAQkiFblv3hhwwxYaTyU5QooW+GzyaAZvYKMH4gtTlD5HGP5nqW2
         oUl2fjzQwC8YVwbcd0+cUi6GQLqZBy0WdnejhzDTEEYcI5lLyPpsr0MSxkLeZcKF47
         m3VVCa94IjeIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DDAD40407; Mon, 21 Mar 2022 17:52:50 -0300 (-03)
Date:   Mon, 21 Mar 2022 17:52:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, leo.yan@linaro.org, Alexandre.Truong@arm.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 1/1] perf test arm64: Test unwinding using
 fame-pointer (fp) mode
Message-ID: <YjjlohvNAL8lKlV+@kernel.org>
References: <20220316172015.98000-1-german.gomez@arm.com>
 <592a32d6-b618-951c-9db9-711d022ff85e@arm.com>
 <b2ff473a-f252-89c9-78b3-bacff2876869@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2ff473a-f252-89c9-78b3-bacff2876869@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 16, 2022 at 05:48:50PM +0000, German Gomez escreveu:
> 
> On 16/03/2022 17:30, James Clark wrote:
> >
> > On 16/03/2022 17:20, German Gomez wrote:
> >> Add a shell script to check that the call-graphs generated using frame
> >> pointers (--call-graph fp) are complete and not missing leaf functions:
> >>
> >>   | $ perf test 88 -v
> >>   |  88: Check Arm64 callgraphs are complete in fp mode                  :
> >>   | --- start ---
> >>   | test child forked, pid 8734
> >>   |  + Compiling test program (/tmp/test_program.Cz3yL)...
> >>   |  + Recording (PID=8749)...
> >>   |  + Stopping perf-record...
> >>   | test_program.Cz
> >>   |                  728 leaf
> >>   |                  753 parent
> >>   |                  76c main
> >>   | test child finished with 0
> >>   | ---- end ----
> >>   | Check Arm SPE callgraphs are complete in fp mode: Ok
> >>
> > Ran it on N1SDP and it passes, and it fails if b9f6fbb3b2c2 isn't applied.
> 
> I forgot to mention in the notes that it's supposed to work with both unwinders:
> 
> $ make                # for libunwind (default)
> $ make NO_LIBUNWIND=1 # for libdw

I'll add it to the cset commit log, and also will fix this:

⬢[acme@toolbox perf]$        git am ./v2_20220316_german_gomez_perf_test_arm64_test_unwinding_using_fame_pointer_fp_mode.mbx
Applying: perf test arm64: Test unwinding using fame-pointer (fp) mode
.git/rebase-apply/patch:72: trailing whitespace.
# program
warning: 1 line adds whitespace errors.
tools/perf/tests/shell/test_arm_callgraph_fp.sh:58: trailing whitespace.
+# program
⬢[acme@toolbox perf]$
 
> >
> > Reviewed-by: James Clark <james.clark@arm.com>
> >
> >> Fixes: b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf record --call-graph=fp'")
> >> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> >> Signed-off-by: German Gomez <german.gomez@arm.com>
> >> ---
> >> Changes since v1: https://lore.kernel.org/all/a6ba0ea8-f070-9f79-f018-f638ff677c7c@arm.com/
> >>  - Add explicit '-g' flag to GCC command
> >> ---
> >>  .../perf/tests/shell/test_arm_callgraph_fp.sh | 68 +++++++++++++++++++
> >>  1 file changed, 68 insertions(+)
> >>  create mode 100755 tools/perf/tests/shell/test_arm_callgraph_fp.sh
> >>
> >> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> >> new file mode 100755
> >> index 000000000..ea1b4e6bb
> >> --- /dev/null
> >> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> >> @@ -0,0 +1,68 @@
> >> +#!/bin/sh
> >> +# Check Arm64 callgraphs are complete in fp mode
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +lscpu | grep -q "aarch64" || exit 2
> >> +
> >> +if ! [ -x "$(command -v cc)" ]; then
> >> +	echo "failed: no compiler, install gcc"
> >> +	exit 2
> >> +fi
> >> +
> >> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >> +TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
> >> +TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
> >> +
> >> +cleanup_files()
> >> +{
> >> +	rm -f $PERF_DATA
> >> +	rm -f $TEST_PROGRAM_SOURCE
> >> +	rm -f $TEST_PROGRAM
> >> +}
> >> +
> >> +trap cleanup_files exit term int
> >> +
> >> +cat << EOF > $TEST_PROGRAM_SOURCE
> >> +int a = 0;
> >> +void leaf(void) {
> >> +  for (;;)
> >> +    a += a;
> >> +}
> >> +void parent(void) {
> >> +  leaf();
> >> +}
> >> +int main(void) {
> >> +  parent();
> >> +  return 0;
> >> +}
> >> +EOF
> >> +
> >> +echo " + Compiling test program ($TEST_PROGRAM)..."
> >> +
> >> +CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
> >> +cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> >> +
> >> +# Add a 1 second delay to skip samples that are not in the leaf() function
> >> +perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
> >> +PID=$!
> >> +
> >> +echo " + Recording (PID=$PID)..."
> >> +sleep 2
> >> +echo " + Stopping perf-record..."
> >> +
> >> +kill $PID
> >> +wait $PID
> >> +
> >> +# expected perf-script output:
> >> +#
> >> +# program 
> >> +# 	728 leaf
> >> +# 	753 parent
> >> +# 	76c main
> >> +# ...
> >> +
> >> +perf script -i $PERF_DATA -F comm,ip,sym | head -n4
> >> +perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
> >> +	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
> >> +						       sym[1] != "parent" ||
> >> +						       sym[2] != "main") exit 1 }'

-- 

- Arnaldo
