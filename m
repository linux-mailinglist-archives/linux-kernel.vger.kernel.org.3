Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CA951CC40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386405AbiEEWlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiEEWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:41:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D3B7C0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:37:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i5so7801728wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ql0HXJVghBlbsqNqm2+/tT3Gxe/0ckmKTqGfhOimqQw=;
        b=j/5cLDiYS/NCrX3MUEgw3zeohdxZ/t9nSK2LM0B2UL3EAc1TvvhUzXzvfxUvEP1RBu
         ++t6udqsh8jdpFDPMnhrBILYPdQI5jL4nbQzTxlxTyOU5TLWyXLiMBD/begP+4Y0V3U8
         vs0S6sIHYlcdil248CGWkHu1WUcUyZm1xzQZDzQy4+KpzNgSpULYl9L+zu8Ho6CjlLVU
         tNm7OOTnhQkOclaY+SB4B/fo1TGBXUajqXuCW/4G8Nfv+mYHS58QpKMYKqSJTGVZA0U2
         wPET6GBtPYuvl7bacdADrGvZS03InoWZ4jFe5Qt6E5wfdDaHkFgKHz0IHMmNeqsJb0Jj
         aT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ql0HXJVghBlbsqNqm2+/tT3Gxe/0ckmKTqGfhOimqQw=;
        b=7cPkR/lZY+z13Vz/NCztK+c5i9oVV1tE6Ovjkpg43iwcMF20FdBCQEsdtZNgx//w7M
         soG7sO/YKq1VussbbzPdxqP70FCYBmyGMzT5AJJBn+gPt61dr6YY0AGIxSnzY3wjJmEp
         EmpnppqORqBaKFrLhZ3zbGVkpg5FnDvPuGX/oi0IYExlTypSV0sTkKxUf3+AkGmECsM4
         8142CSU8Cd3Jq8r4Q3Z2mZKoRB9dnbH6CmlPMSsXjAA00eHY2my3HmVxhOFUHI2gZwDe
         CTmagnXWaPK+B13PQg7BxBR04IzaDxi52vaB65VyLg+1AKqCvk94+MPl2kGqs77qShoM
         On5Q==
X-Gm-Message-State: AOAM53284+5XGU9/RScdDyllXo3O4Yu+Gn+6O9ij5perN3Ifta4mZf6x
        kIoHdWAXvdYnUWZfslszCvSHzxDz6C5eNrgbq7SCcIsROFg=
X-Google-Smtp-Source: ABdhPJz+C06nGgdreQAezapIFxZEP91r5kHZYhZ/YvHIAG8jFnoM7MyrYXPDq2Y8U27nCA537bTKDzKP7k23FC29MwY=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr228262wrd.375.1651790257229; Thu, 05 May
 2022 15:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-2-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-2-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 15:37:23 -0700
Message-ID: <CAP-5=fWdUFSbm3D5MeO9x3Zc9P-x=g6B_v3GoHgrD1p8LBdEoA@mail.gmail.com>
Subject: Re: [PATCH V1 01/23] perf intel-pt: Add a test for system-wide side band
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 9:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add a test for system-wide side band even when tracing selected CPUs.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

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
> +       perf record -o ${tmpfile} -B -N --no-bpf-event -e dummy:u -C $1 true 2>&1 >/dev/null || return 2
> +       return 0
> +}
> +
> +test_system_wide_side_band()
> +{
> +       # Need CPU 0 and CPU 1
> +       can_cpu_wide 0 || return $?
> +       can_cpu_wide 1 || return $?
> +
> +       # Record on CPU 0 a task running on CPU 1
> +       perf record -B -N --no-bpf-event -o ${perfdatafile} -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
> +
> +       # Should get MMAP events from CPU 1 because they can be needed to decode
> +       mmap_cnt=`perf script -i ${perfdatafile} --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
> +
> +       if [ ${mmap_cnt} -gt 0 ] ; then
> +               return 0
> +       fi
> +
> +       echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
> +       return 1
> +}
> +
> +count_result()
> +{
> +       if [ $1 -eq 2 ] ; then
> +               skip_cnt=`expr ${skip_cnt} \+ 1`
> +               return
> +       fi
> +       if [ $1 -eq 0 ] ; then
> +               ok_cnt=`expr ${ok_cnt} \+ 1`
> +               return
> +       fi
> +       err_cnt=`expr ${err_cnt} \+ 1`
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
> +       exit 1
> +fi
> +
> +if [ ${ok_cnt} -gt 0 ] ; then
> +       exit 0
> +fi
> +
> +exit 2
> --
> 2.25.1
>
