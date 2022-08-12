Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA0591619
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbiHLTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHLTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049BB3B0A;
        Fri, 12 Aug 2022 12:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD12617D0;
        Fri, 12 Aug 2022 19:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66EAC433D6;
        Fri, 12 Aug 2022 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333665;
        bh=sLwV+GfE5JlpxI6fGKXia79sYL3aNd8bTMsFSGrZUMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8rwd8NdYRL7FXj7T2VnfGlYsburhFeYY59+RumlqhM+U5jny6jvfNmoIEumJyl+a
         qhfk8HzlOYttknjvbDoY9NS+f+So3V8mxdVytNdD3Dlw0yPDHhEWSblN6VEEC/pM4v
         J3hS87H3VD+p+WAcFoHN6fREEOYh+0uQraoSmeKbme/9HgKX1JN19Gcx0pj5hxa9au
         O6N/NpfztNDNBioSDvFrRy0XQvTx7SrfseIR5TiYUTHr/EHRfG7r5Cb82XefrdDbFZ
         p6RDYyRvz6SqcwXIdsTRY5d2X81N3ZHcv5UurNOAEGd8rnNyk0o0tJFi4bJrV1skDp
         F/20I7PiewWcA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E07E34035A; Fri, 12 Aug 2022 16:47:43 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:47:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Introduce script for java symbol testing
Message-ID: <YvauX7u69u9AeID/@kernel.org>
References: <20220806033434.121908-1-leo.yan@linaro.org>
 <20220806033434.121908-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806033434.121908-3-leo.yan@linaro.org>
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

Em Sat, Aug 06, 2022 at 11:34:34AM +0800, Leo Yan escreveu:
> This commit introduces a script for testing java symbols.
> 
> The test records for java program, inject samples with JIT samples, then
> check specific words "Interpreter" and "jdk.internal" in the report, the
> test will pass if these two symbols are detected.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/shell/test_java_symbol.sh | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_java_symbol.sh
> 
> diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
> new file mode 100755
> index 000000000000..45d42a9fdca5
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_java_symbol.sh
> @@ -0,0 +1,66 @@
> +#!/bin/bash
> +# Test java symbol
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Leo Yan <leo.yan@linaro.org>, 2022
> +
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +PERF_INJ_DATA=$(mktemp /tmp/__perf_test.perf.data.inj.XXXXX)
> +
> +cleanup_files()
> +{
> +	echo "Cleaning up files..."
> +	rm -f ${PERF_DATA}
> +	rm -f ${PERF_INJ_DATA}
> +}
> +
> +trap cleanup_files exit term int
> +
> +if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
> +	LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so


Will this only work if we do a:

make -C tools/perf

?

> +elif [ -e "$PWD/libperf-jvmti.so" ]; then
> +	LIBJVMTI=$PWD/libperf-jvmti.so
> +elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
> +	LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
> +elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
> +	LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
> +else
> +	echo "Fail to find libperf-jvmti.so"
> +	exit 1
> +fi
> +
> +cat <<EOF | perf record -k 1 -o $PERF_DATA jshell -s -J-agentpath:$LIBJVMTI
> +int fib(int x) {
> +	return x > 1 ? fib(x - 2) + fib(x - 1) : 1;
> +}
> +
> +int q = 0;
> +
> +for (int i = 0; i < 10; i++)
> +	q += fib(i);
> +
> +System.out.println(q);
> +EOF
> +
> +if [ $? -ne 0 ]; then
> +	echo "Fail to record for java program"
> +	exit 1
> +fi
> +
> +if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
> +	echo "Fail to inject samples"
> +	exit 1
> +fi
> +
> +# Below is an example of the instruction samples reporting:
> +#   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
> +#   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
> +perf report --stdio -i ${PERF_INJ_DATA} 2>&1 | \
> +	egrep " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
> +
> +if [ $? -ne 0 ]; then
> +	echo "Fail to find java symbols"
> +	exit 1
> +fi
> +
> +exit 0
> -- 
> 2.25.1

-- 

- Arnaldo
