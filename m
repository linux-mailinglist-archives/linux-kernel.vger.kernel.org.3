Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73328585205
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiG2PDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiG2PDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:03:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3CE95A8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:03:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r83-20020a1c4456000000b003a3a22178beso785861wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLTFSrskQrti9akgcOE2SqCBtE6dVVYg8MzlEVx8mCs=;
        b=SlwYP/S8pe1GMNTiked6ky3NS1yrgExEkZu0Y4j7YN6x2OhA+OeI37Kx7HWzkKa9ds
         5v5UupwW/7vJK+vGaFxDxry5KzteHtDQwBNDfhX2Z6XOBwCvyw9ViwX8VPRyphWdtTe7
         afge5SLEXkQP4ZBglaMZoSQT2b1B+pwX7zf5OVCYwzabnCl8ImN986DiPx6c8kpJ3xIn
         r5zpFZp3jSxzIhv2/v0qy8pCdufW4YfZQ7Uze170ByRX41HPON8jI/7iZcpFzta6Xnxa
         T9TfyNytf8tuwA8hsKIKmWr3En/2Q3kodzhm6bY3qRGx8sS3yq5s3H5iFR4wkMBydYqC
         hUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLTFSrskQrti9akgcOE2SqCBtE6dVVYg8MzlEVx8mCs=;
        b=y1z6KvgflTbOz9ejmEkkFBXp5nr15qXYcf+yJJbsT0EIQFeWCyZYv86A+GxCphxMwt
         QK9bqbyqBQTiSGAJ00deV7HOnwIW9A0uDtf6ftjCh8ZG5FMj/19xhVsWyYSGlVeA8cwU
         nKFtLxrvz4s13WrLAAvSKxDwZ2MkTAE1pfiUjy1fA1agXB9UhlItZ+Hb9NfPLzZ5YNDG
         pEkckemmURw78JxIlByTgCcwSlCTkcRXX5fLCqMYALaNrUzoFydv7C44Zp7xUmZfrHn4
         z7BGDiGQmXDwiOu6OWphPZLqRhU0h5lOFTMXG042DEbN3fUNDNbr1WLXCzJxqx/vJnQY
         uXMg==
X-Gm-Message-State: AJIora9eWzI0V8uSvdhQmNzIhZaa4D1iwA5QF5Z6Vp9khENahnQI2tMv
        Ib5NnGi26mJPwwAh4yUnvReHWELQisJHUYuP3C968w==
X-Google-Smtp-Source: AGRyM1u+s0zFw26fIdlAqeg6KuhGnaVQCCpNaNugIgWimXq9XGquAIiHIepjuQQNDb1Z/3Imc1kWxJV5JOsvNFW5hPE=
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id
 u18-20020a05600c19d200b003a32cdbcc02mr3128443wmq.182.1659107012876; Fri, 29
 Jul 2022 08:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 08:03:20 -0700
Message-ID: <CAP-5=fUJ2KaxLXwUhyTtAZhwQ=M=QEv4_tP6y5CU08tf_uKAnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add perf stat default events for hybrid machines
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:56 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> The patch series is to clean up the existing perf stat default and support
> the perf metrics Topdown for the p-core PMU in the perf stat default. The
> first 4 patches are the clean-up patch and fixing the "--detailed" issue.
> The last patch adds support for the perf metrics Topdown, the perf metrics
> Topdown support for e-core PMU will be implemented later separately.
>
> Kan Liang (4):
>   perf stat: Revert "perf stat: Add default hybrid events"
>   perf evsel: Add arch_evsel__hw_name()
>   perf evlist: Always use arch_evlist__add_default_attrs()
>   perf x86 evlist: Add default hybrid events for perf stat
>
> Zhengjun Xing (1):
>   perf stat: Add topdown metrics in the default perf stat on the hybrid
>     machine

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/arch/x86/util/evlist.c  | 64 +++++++++++++++++++++++++-----
>  tools/perf/arch/x86/util/evsel.c   | 20 ++++++++++
>  tools/perf/arch/x86/util/topdown.c | 51 ++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  1 +
>  tools/perf/builtin-stat.c          | 50 ++++-------------------
>  tools/perf/util/evlist.c           | 11 +++--
>  tools/perf/util/evlist.h           |  9 ++++-
>  tools/perf/util/evsel.c            |  7 +++-
>  tools/perf/util/evsel.h            |  1 +
>  tools/perf/util/stat-display.c     |  2 +-
>  tools/perf/util/topdown.c          |  7 ++++
>  tools/perf/util/topdown.h          |  3 +-
>  12 files changed, 166 insertions(+), 60 deletions(-)
>
> --
> 2.25.1
>
