Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA05670F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiGEOZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiGEOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:25:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34278116;
        Tue,  5 Jul 2022 07:25:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FA05D6E;
        Tue,  5 Jul 2022 07:25:08 -0700 (PDT)
Received: from [10.32.33.51] (e121896.warwick.arm.com [10.32.33.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33323F66F;
        Tue,  5 Jul 2022 07:25:06 -0700 (PDT)
Message-ID: <f6b21fa9-7e0b-cb0d-d708-cfd7f3f53087@arm.com>
Date:   Tue, 5 Jul 2022 15:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 08/14] perf test: Add memcpy thread test shell script
Content-Language: en-US
To:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
 <20220701120804.3226396-9-carsten.haitzler@foss.arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220701120804.3226396-9-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2022 13:07, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add a script to drive the threaded memcpy test that gathers data so
> it passes a minimum bar for amount and quality of content that we
> extract from the kernel's perf support.
> 

On this one I get a failure about 1/50 times on N1SDP (I ran it about 150
times and saw 3 failures so it's quite consistent). Usually it records
about a 1.4MB file with one aux record. But when it fails the file is
only 20K and has one small aux record:

   0 0 0x1a10 [0x30]: PERF_RECORD_AUXTRACE size: 0x1820  offset: 0  ref: 0x1c23126d7ff3d2ab  idx: 3  tid: 682799  cpu: 3

Nothing was dropped, and the load on the system wasn't any different
to when it passes. So I'm not sure if this is a real coresight bug
or that the test is flaky. There was a bug in SPE before where
threads weren't followed after forking, but only very rarely. It feels
a bit like that.

It could also be some contention issue because 10 threads are launched
but the machine only has 4 cores.

The failure message from the test looks like this:

   77: CoreSight / Memcpy 16k 10 Threads                               :
   --- start ---
   Couldn't synthesize bpf events.
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.012 MB ./perf-memcpy_thread-16k_10.data ]
   Sanity check number of ASYNC is too low (3 < 10)
    ---- end ----
   CoreSight / Memcpy 16k 10 Threads: FAILED!

I didn't see this issue on any of the other tests. Sometimes very small
files were made if I loaded the system, but the tests still passed.

Thanks
James

> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  .../shell/coresight/memcpy_thread_16k_10.sh    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100755 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
> 
> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
> new file mode 100755
> index 000000000000..d21ba8545938
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# CoreSight / Memcpy 16k 10 Threads
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="memcpy_thread"
> +. $(dirname $0)/../lib/coresight.sh
> +ARGS="16 10 1"
> +DATV="16k_10"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 10 10 10
> +
> +err=$?
> +exit $err
