Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567214A9807
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbiBDKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiBDKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:51:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B53C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 02:51:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m14so10456893wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 02:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IupUYcAq9pXfexuyVPLYhERsbR8KVVc9nKx0AKNozQY=;
        b=ZxQ9yWdh/DQb0mqgcFJhtvIp2IqhrrJW4EWaLPb5gDsQEydXXWt+P/DAsatyg9AC/b
         D6VqclhyWfappFE9G/W1I2V2ft5uyCXJ+0H/gghTh5SwiMIYadEKgNVekZyEb6xWEY5k
         X6tHysOj12D1RBIzO2M9h+EIFnYfeAX1Bf4uA0ARo5WKdf5c5sxPHGTIjCzRJUZqyPDP
         X9DI/M44lQgpeI5yptkiTQJHISmgys9yOqRh9Qv1MkOlXmKsL5MexdrJKg+tg+QLEvr5
         Wd9LdosZbX5g0k1RpdDqSXKBbGY1fcLz37vCiHNR+psL8K3TK9VmG26sTjTZG4M5Pdcw
         5pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IupUYcAq9pXfexuyVPLYhERsbR8KVVc9nKx0AKNozQY=;
        b=LZZpBvflRy5hJtL7MJoayRJPnYgXJaiZnX0ZJhTwcI/AyYD01niBCrVLy0sYVjxzZ1
         lXtb0mfU03qCiVmP5S2mYMfXGNf/3smSgDz6aWafZpa3JPbtG4a/jJvQRSC5yzk7YohP
         QLUX+jOXPOgmlScjQ2JN6CMkyo3N5x0ciA4DWaWkhDCWcZnCiO/ah/joxXhCvU634F9a
         4zN2V7JTDhA5YpKvAcau+V7yQ2bW4/y0OWuAjqG9iPg4LNmRQyAF/2GbTxpWw5gUfQVA
         g5mpSyG98UpLch4d+iqQeoU88PbbXjCbuRewOsrs+u4x83VxQ745vi27dcN/ABNMUlUf
         ZnqQ==
X-Gm-Message-State: AOAM53199O3VPmAbub+I10yNjwyyzFx1JwJmhBCN85yReeXyhqjqNzbV
        NgwUjW5Yzi2ygr1tJNpgZhGdKuC6PFvuPtoEDQzWcw==
X-Google-Smtp-Source: ABdhPJzffKCY19Co4sAwr5VZT58d4AXKaQ417I9R71XVOwIok3KH1t1ZJKkxyx6Tvxuhklq6z63BhFxW33VYshyltoU=
X-Received: by 2002:a5d:6543:: with SMTP id z3mr2018204wrv.619.1643971883840;
 Fri, 04 Feb 2022 02:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com> <20211215160403.69264-11-carsten.haitzler@foss.arm.com>
In-Reply-To: <20211215160403.69264-11-carsten.haitzler@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 4 Feb 2022 10:51:15 +0000
Message-ID: <CAJ9a7VjpnGOKjc-Kx6XBBLXZgBc-XzQx=GoRRQu2q7fSVCq_Pw@mail.gmail.com>
Subject: Re: [PATCH 11/12] perf test: Add unrolled loop tests for coresight
 aux data
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

Same comment here as for the memcpy tests - the unrolled loop will not
result in extra coverage. Irrespective of there being 1 add
instruction in the loop, or 100000 add instructions in the loop, the
output will be a single atom element at the end of the loop as a
result of the for() statement.

This test could also be dropped.

Regards

Mike

On Wed, 15 Dec 2021 at 16:04, <carsten.haitzler@foss.arm.com> wrote:
>
> From: Carsten Haitzler <carsten.haitzler@arm.com>
>
> These tests have large batches of code manually unrolled with macros
> to ensure that the processor has to walk through a lot of instructions
> and memory for those instructions to generate the coresight aux data.
>
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  .../shell/coresight_unroll_loop_thread_1.sh   | 18 +++++
>  .../shell/coresight_unroll_loop_thread_10.sh  | 18 +++++
>  .../shell/coresight_unroll_loop_thread_2.sh   | 18 +++++
>  .../shell/coresight_unroll_loop_thread_25.sh  | 18 +++++
>  .../shell/coresight_unroll_loop_thread_250.sh | 18 +++++
>  .../perf/tests/shell/tools/coresight/Makefile |  3 +-
>  .../coresight/unroll_loop_thread/Makefile     | 29 ++++++++
>  .../unroll_loop_thread/unroll_loop_thread.c   | 74 +++++++++++++++++++
>  8 files changed, 195 insertions(+), 1 deletion(-)
>  create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh
>  create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
>  create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh
>  create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh
>  create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh
>  create mode 100644 tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile
>  create mode 100644 tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c
>
> diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh
> new file mode 100755
> index 000000000000..9175ec532bd8
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Unroll Loop Thread 1
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="unroll_loop_thread"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="1"
> +DATV="1"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 118 14 14
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
> new file mode 100755
> index 000000000000..66cf0245294e
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Unroll Loop Thread 10
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="unroll_loop_thread"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="10"
> +DATV="10"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 127 17 17
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh
> new file mode 100755
> index 000000000000..ff2e293699b0
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Unroll Loop Thread 2
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="unroll_loop_thread"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="2"
> +DATV="2"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 65 6 6
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh
> new file mode 100755
> index 000000000000..7d7669a797ab
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Unroll Loop Thread 25
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="unroll_loop_thread"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="25"
> +DATV="25"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 72 26 25
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh
> new file mode 100755
> index 000000000000..7a0e23aff0dc
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Unroll Loop Thread 250
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="unroll_loop_thread"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="250"
> +DATV="250"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 544 2417 2417
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
> index be671aac06b8..b9cdeff1149b 100644
> --- a/tools/perf/tests/shell/tools/coresight/Makefile
> +++ b/tools/perf/tests/shell/tools/coresight/Makefile
> @@ -10,7 +10,8 @@ SUBDIRS = \
>         bubble_sort \
>         bubble_sort_thread \
>          memcpy \
> -        memcpy_thread
> +        memcpy_thread \
> +        unroll_loop_thread
>
>  all: $(SUBDIRS)
>  $(SUBDIRS):
> diff --git a/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile
> new file mode 100644
> index 000000000000..45ab2be8be92
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../Makefile.miniconfig
> +
> +BIN=unroll_loop_thread
> +LIB=-pthread
> +
> +all: $(BIN)
> +
> +$(BIN): $(BIN).c
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +       $(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
> +endif
> +endif
> +
> +install-tests: all
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +       $(call QUIET_INSTALL, tests) \
> +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
> +               $(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
> +endif
> +endif
> +
> +clean:
> +       $(Q)$(RM) -f $(BIN)
> +
> +.PHONY: all clean install-tests
> diff --git a/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c
> new file mode 100644
> index 000000000000..cb9d22c7dfb9
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +struct args {
> +       pthread_t th;
> +       unsigned int in, out;
> +       void *ret;
> +};
> +
> +static void *thrfn(void *arg)
> +{
> +       struct args *a = arg;
> +       unsigned int i, in = a->in;
> +
> +       for (i = 0; i < 10000; i++) {
> +               asm volatile (
> +// force an unroll of thia add instruction so we can test long runs of code
> +#define SNIP1 "add %[in], %[in], #1\n"
> +// 10
> +#define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
> +// 100
> +#define SNIP3 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2
> +// 1000
> +#define SNIP4 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3
> +// 10000
> +#define SNIP5 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4
> +// 100000
> +                       SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5
> +                       : /* out */
> +                       : /* in */ [in] "r" (in)
> +                       : /* clobber */
> +               );
> +       }
> +}
> +
> +static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
> +{
> +       pthread_t t;
> +       pthread_attr_t attr;
> +
> +       pthread_attr_init(&attr);
> +       pthread_create(&t, &attr, fn, arg);
> +       return t;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       unsigned int i, thr;
> +       pthread_t threads[256];
> +       struct args args[256];
> +
> +       if (argc < 2) {
> +               printf("ERR: %s [numthreads]\n", argv[0]);
> +               exit(1);
> +       }
> +
> +       thr = atoi(argv[1]);
> +       if ((thr > 256) || (thr < 1)) {
> +               printf("ERR: threads 1-256\n");
> +               exit(1);
> +       }
> +       for (i = 0; i < thr; i++) {
> +               args[i].in = rand();
> +               args[i].th = new_thr(thrfn, &(args[i]));
> +       }
> +       for (i = 0; i < thr; i++)
> +               pthread_join(args[i].th, &(args[i].ret));
> +       return 0;
> +}
> --
> 2.32.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
