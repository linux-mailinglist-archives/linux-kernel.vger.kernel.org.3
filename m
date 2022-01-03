Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6A482EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiACHHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiACHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:07:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6175C061784
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 23:07:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iy13so28149489pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 23:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qMoL7xjsBZvBYi6RzZGf4qxh7OZLQ+beedbmpjzt0+M=;
        b=aUaeN3x0dz+JHbDqVnqKOG9SnHaRwyLC+14ezzqUWu5B+ncNs7Q3/8juTqiipetI8w
         6SAtH7mU0j3Ry5O16xUu0jE8P4TVQt3kHnXwwqka4BIXyTu+YMspU2RBVeuuEeP+VIYh
         lC0CUEw4Fbb7g8Yxvd9t9srie1zPYXSORzixPljbzC6xVZZBECPrfuadcz4Ueka9xCv7
         FiW3cNllGtcMVVXfrPo1rjuYQ24c+6il/Ahk67aFQC970fT3zBbsHVs+kXjpuJ+Pn+1f
         WASnUuiCry6dG+l+0DH3YRkJYRrRHWoyjwt3aIn+YMutlVj4K0K00oZ8IJWWk7LSw5TZ
         IMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMoL7xjsBZvBYi6RzZGf4qxh7OZLQ+beedbmpjzt0+M=;
        b=L/klvPTdANb/oAvcNrQ7h+taF+G3KVwxnOvaO7Ni/ls4OkbgztmVf0xzyvIU/9G3SK
         ZLFAAskPsf88twNXtMY0X72UVBV0axbEoKsYJByRYEQqG1hZg+cOX/1QUcEH8h0lowy9
         6T8EBiE1xNUVVAkn9HyLB6S2bijwly2xP17ELw/9U99qiv1hoCv22+WEpwwm4KDjNr3+
         eGHZcCElIa/xQ1iAO6l+Pi+fmqv0dQ2i1Xwt+AFbCN5wREuGL8sj8fVhWI9Af9Jszv8T
         jrR5iHIh4TRda+6Xd4hYwFiJrOVc0h95HxUmMRUokYC1tFpGJ/S/W+fIW/edJNEaoxcL
         cpdA==
X-Gm-Message-State: AOAM5313TSbJCXfOpsNf1RW5eCdiyse5po47FA9JzB8CNXJCnUyQaReO
        5A1jEq5wLU+/oNPRnWBXexz/OQ==
X-Google-Smtp-Source: ABdhPJw6yQauAS6Lzxr/uqFYNpIXLzE564dBGdWWFmqPeMiPGKtQVwormdkAs8ONOceC1VIpZbFe6w==
X-Received: by 2002:a17:90b:1d81:: with SMTP id pf1mr53936506pjb.42.1641193626969;
        Sun, 02 Jan 2022 23:07:06 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id y8sm37936695pjt.25.2022.01.02.23.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 23:07:06 -0800 (PST)
Date:   Mon, 3 Jan 2022 15:07:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 05/12] perf test: Add coresight test to check all threads
 get some data logged
Message-ID: <20220103070700.GA2660949@leoy-ThinkPad-X240s>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-5-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215160403.69264-5-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 04:03:56PM +0000, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> This adds a test and test scripts to check that all threads in the
> target binary end up logging some kind of coresight aux data and that
> they are not missing.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  .../coresight_thread_loop_check_tid_10.sh     | 19 ++++
>  .../coresight_thread_loop_check_tid_2.sh      | 19 ++++
>  .../coresight_thread_loop_check_tid_250.sh    | 19 ++++
>  .../perf/tests/shell/tools/coresight/Makefile |  3 +-
>  .../tools/coresight/thread_loop/Makefile      | 29 +++++++
>  .../tools/coresight/thread_loop/thread_loop.c | 86 +++++++++++++++++++
>  6 files changed, 174 insertions(+), 1 deletion(-)
>  create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
>  create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
>  create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
>  create mode 100644 tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
>  create mode 100644 tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
> 
> diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
> new file mode 100755
> index 000000000000..283ad9facdee
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh -e
> +# Coresight / Thread Loop 10 Threads - Check TID
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="thread_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="10 2000"
> +DATV="check-tid-10th"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +STDO="$DATD/perf-$TEST-$DATV.stdout"
> +
> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
> +
> +perf_dump_aux_tid_verify "$DATA" "$STDO"
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
> new file mode 100755
> index 000000000000..ce8ba534bba2
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh -e
> +# Coresight / Thread Loop 2 Threads - Check TID
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="thread_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="2 4000"
> +DATV="check-tid-2th"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +STDO="$DATD/perf-$TEST-$DATV.stdout"
> +
> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
> +
> +perf_dump_aux_tid_verify "$DATA" "$STDO"
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
> new file mode 100755
> index 000000000000..cb14581c1e68
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh -e
> +# Coresight / Thread Loop 250 Threads - Check TID
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="thread_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="250 100"
> +DATV="check-tid-250th"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +STDO="$DATD/perf-$TEST-$DATV.stdout"
> +
> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
> +
> +perf_dump_aux_tid_verify "$DATA" "$STDO"
> +
> +err=$?
> +exit $err

From this case I start to understand why the lib/coresight.sh sets
AUX buffer as 250MB, setting a large buffer size can capture trace
data for all threads, especially for big amount of threads.

Seems to me, if we test on server, this case can run for short time, but
I think (sorry if I am wrong) it might take much longer time to test on
the embedded system, which might cause testing failure by two factors:

- The resource (e.g. the required big memory size) is pressure for
  embedded system;
- The execution time (IIRC, every test case should be finished within
  5 minutes).

Do you think does it make sense for us to only use 32 threads or 64
threads for the testing and it can give us a good testing coverage,
and we don't need to maintain multiple cases for 2/10/250 threads?

Thanks,
Leo

> diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
> index 723006ea827c..1edab729db76 100644
> --- a/tools/perf/tests/shell/tools/coresight/Makefile
> +++ b/tools/perf/tests/shell/tools/coresight/Makefile
> @@ -5,7 +5,8 @@ include ../../../../../../tools/scripts/Makefile.arch
>  include ../../../../../../tools/scripts/utilities.mak
>  
>  SUBDIRS = \
> -	asm_pure_loop
> +	asm_pure_loop \
> +	thread_loop
>  
>  all: $(SUBDIRS)
>  $(SUBDIRS):
> diff --git a/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile b/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
> new file mode 100644
> index 000000000000..424df4e8b0e6
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../Makefile.miniconfig
> +
> +BIN=thread_loop
> +LIB=-pthread
> +
> +all: $(BIN)
> +
> +$(BIN): $(BIN).c
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
> +endif
> +endif
> +
> +install-tests: all
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +	$(call QUIET_INSTALL, tests) \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
> +endif
> +endif
> +
> +clean:
> +	$(Q)$(RM) -f $(BIN)
> +
> +.PHONY: all clean install-tests
> diff --git a/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
> new file mode 100644
> index 000000000000..c0158fac7d0b
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +// define this for gettid()
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <pthread.h>
> +#include <sys/syscall.h>
> +#ifndef SYS_gettid
> +// gettid is 178 on arm64
> +# define SYS_gettid 178
> +#endif
> +#define gettid() syscall(SYS_gettid)
> +
> +struct args {
> +	unsigned int loops;
> +	pthread_t th;
> +	void *ret;
> +};
> +
> +static void *thrfn(void *arg)
> +{
> +	struct args *a = arg;
> +	int i = 0, len = a->loops;
> +
> +	if (getenv("SHOW_TID")) {
> +		unsigned long long tid = gettid();
> +
> +		printf("%llu\n", tid);
> +	}
> +	asm volatile(
> +		"loop:\n"
> +		"add %[i], %[i], #1\n"
> +		"cmp %[i], %[len]\n"
> +		"blt loop\n"
> +		: /* out */
> +		: /* in */ [i] "r" (i), [len] "r" (len)
> +		: /* clobber */
> +	);
> +	return (void *)(long)i;
> +}
> +
> +static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
> +{
> +	pthread_t t;
> +	pthread_attr_t attr;
> +
> +	pthread_attr_init(&attr);
> +	pthread_create(&t, &attr, fn, arg);
> +	return t;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned int i, len, thr;
> +	pthread_t threads[256];
> +	struct args args[256];
> +
> +	if (argc < 3) {
> +		printf("ERR: %s [numthreads] [numloops (millions)]\n", argv[0]);
> +		exit(1);
> +	}
> +
> +	thr = atoi(argv[1]);
> +	if ((thr < 1) || (thr > 256)) {
> +		printf("ERR: threads 1-256\n");
> +		exit(1);
> +	}
> +	len = atoi(argv[2]);
> +	if ((len < 1) || (len > 4000)) {
> +		printf("ERR: max loops 4000 (millions)\n");
> +		exit(1);
> +	}
> +	len *= 1000000;
> +	for (i = 0; i < thr; i++) {
> +		args[i].loops = len;
> +		args[i].th = new_thr(thrfn, &(args[i]));
> +	}
> +	for (i = 0; i < thr; i++)
> +		pthread_join(args[i].th, &(args[i].ret));
> +	return 0;
> +}
> -- 
> 2.32.0
> 
