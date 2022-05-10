Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235352222C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347887AbiEJRXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347885AbiEJRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293272317E4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F7A618D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF0C385A6;
        Tue, 10 May 2022 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203128;
        bh=rBsmlgw2JqRI9P5/OOpNoQi1c6/dYuDxjjsyT3YBkfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrn5jlRVpSd3veE/yXxj42T7/MzLU561060MQ4xr6Go+DJyKsllRoDXkvoDj+rYHg
         9IGhWVt2YjL186aLYz7IKElRSM+EzAYgzY9lPFFlTeUB0Ff0Zs1/fOcGNTxrjMp+Ad
         +uKN4LRRMRlq+EQyE8I0B22vCc4pFun0HVvVx3R8sauKpq6XRKJRXl2w54zpRDBo0G
         bs8O4VYquwNTxoSyfeL53A7O2QgAxKUOePSB+FImFry6T0uQAap/tsC7rmB6jQlPPK
         ZCNeblaLPWcI4/cabNzEAWBCzROcMjCt4lusWcq9HQsXGJ5Hf7Rn+RAtnjKH6+kKwj
         YkTRusD4MEwKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20ECD400B1; Tue, 10 May 2022 14:18:44 -0300 (-03)
Date:   Tue, 10 May 2022 14:18:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/23] perf intel-pt: Add a test for system-wide side
 band
Message-ID: <YnqedF9WI//2oXw2@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-2-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:39PM +0300, Adrian Hunter escreveu:
> Add a test for system-wide side band even when tracing selected CPUs.
> 
> Tested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>


[root@quaco ~]# uname -a
Linux quaco 5.16.13-200.fc35.x86_64 #1 SMP PREEMPT Tue Mar 8 22:50:58 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
[root@quaco ~]# grep -m1 -i "model name" /proc/cpuinfo 
model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
[root@quaco ~]# perf test -v Misc
 97: Miscellaneous Intel PT testing                                  :
--- start ---
test child forked, pid 769475
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.352 MB /tmp/tmp.Ty4Rqnz4vz ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.352 MB /tmp/tmp.Ty4Rqnz4vz ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.446 MB /tmp/tmp.TnEqenwzZv ]
Failed to record MMAP events on CPU 1 when tracing CPU 0
test child finished with -1
---- end ----
Miscellaneous Intel PT testing: FAILED!
[root@quaco ~]# 

Do I need some more recent machine or kernel?

- Arnaldo

> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 71 +++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_intel_pt.sh
> 
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> new file mode 100755
> index 000000000000..a3298643884d
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +# Miscellaneous Intel PT testing
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# Skip if no Intel PT
> +perf list | grep -q 'intel_pt//' || exit 2
> +
> +skip_cnt=0
> +ok_cnt=0
> +err_cnt=0
> +
> +tmpfile=`mktemp`
> +perfdatafile=`mktemp`
> +
> +can_cpu_wide()
> +{
> +	perf record -o ${tmpfile} -B -N --no-bpf-event -e dummy:u -C $1 true 2>&1 >/dev/null || return 2
> +	return 0
> +}
> +
> +test_system_wide_side_band()
> +{
> +	# Need CPU 0 and CPU 1
> +	can_cpu_wide 0 || return $?
> +	can_cpu_wide 1 || return $?
> +
> +	# Record on CPU 0 a task running on CPU 1
> +	perf record -B -N --no-bpf-event -o ${perfdatafile} -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
> +
> +	# Should get MMAP events from CPU 1 because they can be needed to decode
> +	mmap_cnt=`perf script -i ${perfdatafile} --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
> +
> +	if [ ${mmap_cnt} -gt 0 ] ; then
> +		return 0
> +	fi
> +
> +	echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
> +	return 1
> +}
> +
> +count_result()
> +{
> +	if [ $1 -eq 2 ] ; then
> +		skip_cnt=`expr ${skip_cnt} \+ 1`
> +		return
> +	fi
> +	if [ $1 -eq 0 ] ; then
> +		ok_cnt=`expr ${ok_cnt} \+ 1`
> +		return
> +	fi
> +	err_cnt=`expr ${err_cnt} \+ 1`
> +}
> +
> +test_system_wide_side_band
> +
> +count_result $?
> +
> +rm -f ${tmpfile}
> +rm -f ${perfdatafile}
> +
> +if [ ${err_cnt} -gt 0 ] ; then
> +	exit 1
> +fi
> +
> +if [ ${ok_cnt} -gt 0 ] ; then
> +	exit 0
> +fi
> +
> +exit 2
> -- 
> 2.25.1

-- 

- Arnaldo
