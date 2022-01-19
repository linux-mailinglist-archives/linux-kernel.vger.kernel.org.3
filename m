Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6243D493EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356264AbiASQ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:58:52 -0500
Received: from foss.arm.com ([217.140.110.172]:32832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239673AbiASQ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:58:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5987B1FB;
        Wed, 19 Jan 2022 08:58:51 -0800 (PST)
Received: from [10.57.35.152] (unknown [10.57.35.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE1E93F73D;
        Wed, 19 Jan 2022 08:58:49 -0800 (PST)
Subject: Re: [PATCH 04/12] perf test: Add beginning of test infra + test to
 exercise coresight
To:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org, mike.leach@linaro.org,
        suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-4-carsten.haitzler@foss.arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <a7f01bb8-9b5a-6121-5fcc-38ddffa633fe@arm.com>
Date:   Wed, 19 Jan 2022 16:58:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215160403.69264-4-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2021 16:03, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> This adds the initial test harness to run perf record and examine the
> resuling output when coresight is enabled on arm64 and check the
> resulting quality of the output as part of perf test.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
[...]
> diff --git a/tools/perf/tests/shell/coresight_asm_pure_loop.sh b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
> new file mode 100755
> index 000000000000..542d4a37e349
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / ASM Pure Loop
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="asm_pure_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS=""
> +DATV="out"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 2601 334 334
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
> new file mode 100644
> index 000000000000..cd6c1283e6f5
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/coresight.sh
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +# This is sourced from a driver script so no need for #!/bin... etc. at the
> +# top - the assumption below is that it runs as part of sourcing after the
> +# test sets up some basic env vars to say what it is.
> +
> +# perf record options for the perf tests to use
> +PERFRECMEM="-m ,128M"
> +PERFRECOPT="$PERFRECMEM -e cs_etm//u"
> +
> +# These tests need to be run as root or coresight won't allow large buffers
> +# and will not collect proper data

I've somewhat fixed this with the change 7cc9680c4be. Can you re-test that it
works without sudo? I think it's best to avoid it unless necessary and the
cs_etm//u seems to suggest that it's not necessary.

If 'proper data' can't be collected without root then it seems more like the
tests have found a real issue to fix rather than something to be worked around.

James
