Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D0597E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiHRGLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbiHRGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:11:18 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E58FD5D;
        Wed, 17 Aug 2022 23:11:17 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id j5so603951oih.6;
        Wed, 17 Aug 2022 23:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7wi5Dq09PF7tBJQH6bXSrTc2e9ldESvsPGRPC2plYto=;
        b=08eoDGAZ4ma5mLjnmUhg1kTXYwdKly5CbDncWVWiwiiCkJPiKC+7GFhNeKoGyIb01P
         F8hUezEpAA8jzFQKdtW1E0nvU+UmcaXOTFUZBm7gEEY2SyKBSDkYKgVuDKwSyakyNOKo
         68GQ9DTCtvrqToGK7AJqQn82sISiXeVRwVYhxMcGF91K0ocR9vercT1AklU+CLrwzqYG
         b4ByGecZe88QuqQXsDdPIqJIMw1YahK7GO3S2MuEbJ9Rp7c+0Gg8R6oVhzIE7/UysMRT
         FcXgfLKDEImnXkxCGAOwij5XAFHbHn1qo8BBV9gYHO9UCub7xcl+ErcjhlEEplVMXgHO
         d6qw==
X-Gm-Message-State: ACgBeo1yqGW3NAz/CCj90LMzfSaD/NRvIRYKy9qmmohT1K1A5TabKAh6
        uxutmA2nAsEZKiSfIyglx2lqt5d9Po17hHiUpFo=
X-Google-Smtp-Source: AA6agR4/sPvTIzjHQaJmNk55ffpb1MSMI0f8hww9p7bOSxJWVEuIYeW5MYOhK0zcxE+zpqSo2p6nc7U+NyhPVjAcmJM=
X-Received: by 2002:aca:6088:0:b0:343:75a6:d6a3 with SMTP id
 u130-20020aca6088000000b0034375a6d6a3mr694163oib.92.1660803076558; Wed, 17
 Aug 2022 23:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com> <20220817053930.769840-7-irogers@google.com>
In-Reply-To: <20220817053930.769840-7-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 17 Aug 2022 23:11:04 -0700
Message-ID: <CAM9d7cgd-KsqJNxh_MbX9h4tr8rOtAqKe-t7Qfck0m9pTxWK7w@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] perf build: Enable -Wthread-safety with clang
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Aug 16, 2022 at 10:39 PM Ian Rogers <irogers@google.com> wrote:
>
> If building with clang then enable -Wthread-safety warnings.

Do you know the minimal supported version for the option?
I'm not sure we have a check for that kind of thing.

Thanks,
Namhyung


>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0661a1cf9855..0ef6f572485d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -19,6 +19,11 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>  CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>  HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>
> +# Enabled Wthread-safety analysis for clang builds.
> +ifeq ($(CC_NO_CLANG), 0)
> +  CFLAGS += -Wthread-safety
> +endif
> +
>  include $(srctree)/tools/scripts/Makefile.arch
>
>  $(call detected_var,SRCARCH)
> --
> 2.37.1.595.g718a3a8f04-goog
>
