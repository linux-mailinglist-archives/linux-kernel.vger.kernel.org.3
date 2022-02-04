Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7424A9800
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbiBDKnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiBDKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:43:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3848C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 02:43:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2977935wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 02:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6xzHZRwsIfVX6FLeg9txH2PD86m3v1U++GUnwW0q9U=;
        b=oSieZ4+5Uuw4lc035UIbXuwmj29uDTswGI+own2PFENNrBEJzPN0VsyeJKSlj8YdyQ
         OljjXmfrgBne31Z68dYmY50njfo8FJIAhM/g2uAItUI1ZVxSd+WEyEUZpcxrOYsJIkkl
         9Pa3qR/P4opTAjxNQlVdaRDi2PhtS3mqY+HRKVyRg0g+d7t5l3xkI5rDcRk/c/ciHys8
         dj8+eAsCP4mvACTkLGPLC0fNZPhDIAHne0/p2q4AxmjhIhtgBu+JODEJun33lzZncjQ1
         AoYDdKSbKR4k5KisPaufu/33JMaGfKQR3/Vu/gth9LjiqjeMbNA18CJCEvLx7sWrSRFW
         MznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6xzHZRwsIfVX6FLeg9txH2PD86m3v1U++GUnwW0q9U=;
        b=KCBfP906vUDgWYvg01bZG7zMIrSgQU7rY+nSh4EHhd+ao6tjrxcavN49b0hiZ6/cRh
         fl/vXEwBtMSPYc4HAQxN5GAYlMadSg25g7hn3sdGW1Axiy607F+92nVFJNPU26aXOZ7n
         4mGp6hjUwtWS44hrT6+WoN5PYDDmLE8P8LFZJsS+REyP1ukRvU07dPY+vaP79I2cgXmA
         Did5Qz2FqIrzLq7AONjrsG0XYaW+RR8gc6jRYqN5llsBqCStP/z/Tnr/1lxj/+i4ZX2e
         jiBHNVjbFT3Fnb+NcftEcfOIuu9i3xMiV4rkygZjeB+gcDzKEkb2rtImhw6tVmHU/qHZ
         jYQw==
X-Gm-Message-State: AOAM533XfWudp3sC5op6N+XTy6MyLvKXr33olMZrrc46DqQ1r0HkjYKh
        o99NWVKgChGTZovwoH5Luu+Q5Elp+bDSswTzt3Xpjg==
X-Google-Smtp-Source: ABdhPJxUSOYaBkFLZ9rPKQcTZYfnh4h4CY01MxxHYhbOWljhPoeRKQh1pnoYQARRY/IRnDefuLf07mSjcsQCHoZecwQ=
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr1717076wmp.83.1643971407318;
 Fri, 04 Feb 2022 02:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com> <20211215160403.69264-9-carsten.haitzler@foss.arm.com>
In-Reply-To: <20211215160403.69264-9-carsten.haitzler@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 4 Feb 2022 10:43:18 +0000
Message-ID: <CAJ9a7VjWPP+dyXBvb0-mVYXAQV0QPd2dkyi2zdwOVg_z_AiVhw@mail.gmail.com>
Subject: Re: [PATCH 09/12] perf test: Add add memcpy test for coresight
 quality checking
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten

From a trace ouput perspective, this test doesn't really add coverage
on top of what has gone before.
We only have instruction trace - so the data operations of the memcpy
do not result in any trace output.
From a trace perspective, memcpy is a tight loop - probably resulting
in a single atom element for each iteration, and nothing in between.

For this reason, I think this test, and the threaded memcpy test in
the next patch can be dropped.

Regards

Mike

On Wed, 15 Dec 2021 at 16:04, <carsten.haitzler@foss.arm.com> wrote:
>
> From: Carsten Haitzler <carsten.haitzler@arm.com>
>
> This adds memory bound tests for quality checking perf's aux data
> recording.
>
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  tools/perf/tests/shell/coresight_memcpy_1m.sh | 18 +++++++++
>  .../perf/tests/shell/coresight_memcpy_32m.sh  | 18 +++++++++
>  .../perf/tests/shell/coresight_memcpy_64k.sh  | 18 +++++++++
>  .../perf/tests/shell/tools/coresight/Makefile |  3 +-
>  .../shell/tools/coresight/memcpy/Makefile     | 29 ++++++++++++++
>  .../shell/tools/coresight/memcpy/memcpy.c     | 40 +++++++++++++++++++
>  6 files changed, 125 insertions(+), 1 deletion(-)
>  create mode 100755 tools/perf/tests/shell/coresight_memcpy_1m.sh
>  create mode 100755 tools/perf/tests/shell/coresight_memcpy_32m.sh
>  create mode 100755 tools/perf/tests/shell/coresight_memcpy_64k.sh
>  create mode 100644 tools/perf/tests/shell/tools/coresight/memcpy/Makefile
>  create mode 100644 tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c
>
> diff --git a/tools/perf/tests/shell/coresight_memcpy_1m.sh b/tools/perf/tests/shell/coresight_memcpy_1m.sh
> new file mode 100755
> index 000000000000..fa1c28d73b66
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_memcpy_1m.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Memcpy 1M
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="memcpy"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="1024 2"
> +DATV="1m"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 39 766 766
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_memcpy_32m.sh b/tools/perf/tests/shell/coresight_memcpy_32m.sh
> new file mode 100755
> index 000000000000..4ab5459e3824
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_memcpy_32m.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Memcpy 32M
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="memcpy"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="32768 1"
> +DATV="32m"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 39 7804 7804
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_memcpy_64k.sh b/tools/perf/tests/shell/coresight_memcpy_64k.sh
> new file mode 100755
> index 000000000000..5b6ba2a6d394
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_memcpy_64k.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Memcpy 64K
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="memcpy"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="64 40"
> +DATV="64k"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 40 934 934
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
> index a1a752f45c46..99030c889b04 100644
> --- a/tools/perf/tests/shell/tools/coresight/Makefile
> +++ b/tools/perf/tests/shell/tools/coresight/Makefile
> @@ -8,7 +8,8 @@ SUBDIRS = \
>         asm_pure_loop \
>         thread_loop \
>         bubble_sort \
> -       bubble_sort_thread
> +       bubble_sort_thread \
> +        memcpy
>
>  all: $(SUBDIRS)
>  $(SUBDIRS):
> diff --git a/tools/perf/tests/shell/tools/coresight/memcpy/Makefile b/tools/perf/tests/shell/tools/coresight/memcpy/Makefile
> new file mode 100644
> index 000000000000..7c31fe4ec399
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/memcpy/Makefile
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../Makefile.miniconfig
> +
> +BIN=memcpy
> +LIB=
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
> diff --git a/tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c b/tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c
> new file mode 100644
> index 000000000000..1aa0617448ad
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +int main(int argc, char **argv)
> +{
> +       unsigned long i, len, size;
> +       unsigned char *src, *dst;
> +       long long v;
> +
> +       if (argc < 3) {
> +               printf("ERR: %s [copysize Kb] [numloops (hundreds)]\n", argv[0]);
> +               exit(1);
> +       }
> +
> +       v = atoll(argv[1]);
> +       if ((v < 1) || (v > (1024 * 1024))) {
> +               printf("ERR: max memory 1GB (1048576 KB)\n");
> +               exit(1);
> +       }
> +       size = v;
> +       v = atoll(argv[2]);
> +       if ((v < 1) || (v > 40000000000ll)) {
> +               printf("ERR: loops 1-40000000000 (hundreds)\n");
> +               exit(1);
> +       }
> +       len = v * 100;
> +       src = malloc(size * 1024);
> +       dst = malloc(size * 1024);
> +       if ((!src) || (!dst)) {
> +               printf("ERR: Can't allocate memory\n");
> +               exit(1);
> +       }
> +       for (i = 0; i < len; i++)
> +               memcpy(dst, src, size * 1024);
> +       return 0;
> +}
> --
> 2.32.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
