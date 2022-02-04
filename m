Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22B4A97EC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358113AbiBDKg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352439AbiBDKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:36:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042BDC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 02:36:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2969518wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+QUWzUX52F8tsTk8PHF1GZ9Q0wJ7rAAt3Hw/ekUdU8=;
        b=rh/IAkXlB7/6tbYrB1cHe1xBMCNPP6FprjU4Gk39z1pH+YYXWQ+pyWJxqswqHRj9f9
         Ye+Y0/bFqY2w1s1xIt6UZPrNj6UDeJVlP6LAysrDsV0czwuwyuXWrhJmNcygJQhjCOEN
         c22G3xMwXhLyqtl3TGYw9svgzMqyGLZ1pFJ3wTfNzp0z7k9pg8zcq0FkI1Jry4//uv6X
         kiWqd2Q2nWBnLZMzsZ4JGWoNXpyfWGL5arrEgR7BEqWe2JdBpxIDIfY5iwZlPgaVkTji
         oCCXBhzvhr5W7UkH2o+fZkV8WtBVPPnAbY9nygqx5+ppmuZyI+TpFJl+smzHnAsmcd//
         AwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+QUWzUX52F8tsTk8PHF1GZ9Q0wJ7rAAt3Hw/ekUdU8=;
        b=z9f9dDQc1D+0a5x02ZckYLAhVnbbbkOONWAUZyKcgmKTLynGzj6edyfrThbaw7bN+Y
         iHs+FtUXV3sGzQdks5KFsiJauJceRxkejISKKrvP/A2p/FO0njLa9KWEVWj/J9vxt/zg
         NuzTZxE256W8gIBo0BNYVHsC9Ec16hhuivdfnPAgw9BNVjqcNwJMTBPQ30r415gOZoJl
         wiJOCBmCRcsjbvFLk4Vs4kYfjsqYJ+mJmjNmLDCwLQBn/vEyNLkYo/Dj/jbEhKutHcHl
         xsJ2szBihT59gmN3h0Hm8FKmACda/QG6E+lICJGI1S1qZ6LogN7MUX9auDI4D/YpWXky
         qItA==
X-Gm-Message-State: AOAM533VCAP0cF/Y5mGC21LJv5uS8ODVvCikAFo/NoNV1wv1q1HaU9aj
        3gQ08SOPYStAEevOJ+fhRFhGxJJDe6ihqlO5QCVlbQ==
X-Google-Smtp-Source: ABdhPJy2xq/9pZcldbHFxrg5/tUHWXDrj/j7P66pGEaRQsTDwSf19T0GBIVmKkrWH6TDMN9x0gdgKSm1rHO+YFeUJCg=
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr1720153wmr.26.1643971013593;
 Fri, 04 Feb 2022 02:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com> <20211215160403.69264-6-carsten.haitzler@foss.arm.com>
In-Reply-To: <20211215160403.69264-6-carsten.haitzler@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 4 Feb 2022 10:36:45 +0000
Message-ID: <CAJ9a7Vj+f5p+mYsnot3=kRtsf-aGY99PX6Uy0FmWeN0WrwOphQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] perf test: Add tests to re-use the thread loop test
 to check aux data
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On Wed, 15 Dec 2021 at 16:04, <carsten.haitzler@foss.arm.com> wrote:
>
> From: Carsten Haitzler <carsten.haitzler@arm.com>
>
> This checks to see that the thread_loop tests produces sensible
> amounts of aux coresight data.
>
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  .../tests/shell/coresight_thread_loop_2.sh     | 18 ++++++++++++++++++
>  .../tests/shell/coresight_thread_loop_25.sh    | 18 ++++++++++++++++++
>  .../tests/shell/coresight_thread_loop_250.sh   | 18 ++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100755 tools/perf/tests/shell/coresight_thread_loop_2.sh
>  create mode 100755 tools/perf/tests/shell/coresight_thread_loop_25.sh
>  create mode 100755 tools/perf/tests/shell/coresight_thread_loop_250.sh
>
> diff --git a/tools/perf/tests/shell/coresight_thread_loop_2.sh b/tools/perf/tests/shell/coresight_thread_loop_2.sh
> new file mode 100755
> index 000000000000..6d790b870a67
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_thread_loop_2.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Thread Loop 2 Threads
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="thread_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="2 20"
> +DATV="2th"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 724 11 11
> +

The only difference I can see between this test and the set of tests
in patch 05 is the verification script run on the output file.
Is there some reason that both scripts cannot be run on the same
output file, rather than rerun perf ?

Regards

Mike


> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_thread_loop_25.sh b/tools/perf/tests/shell/coresight_thread_loop_25.sh
> new file mode 100755
> index 000000000000..cce74202e4db
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_thread_loop_25.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Thread Loop 25 Threads
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="thread_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="25 2"
> +DATV="25th"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 388121 1255 1255
> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/coresight_thread_loop_250.sh b/tools/perf/tests/shell/coresight_thread_loop_250.sh
> new file mode 100755
> index 000000000000..55f271462a4d
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_thread_loop_250.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / Thread Loop 250 Threads
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="thread_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS="250 1"
> +DATV="250th"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 724 11 11
> +
> +err=$?
> +exit $err
> --
> 2.32.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
