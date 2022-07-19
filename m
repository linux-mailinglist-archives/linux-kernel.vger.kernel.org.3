Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0465457A46D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbiGSQ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiGSQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:57:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9534F657
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:56:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a5so22488901wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjzI8Y5AFZSjQh4cY4GKqmaCg1K0UQucOPz5+/QiYwM=;
        b=dokUPJWuCe4HUQ2XEI1u/VZC8wAmp4o+IFhtkaeR4iasVCBEWU08xfzK1uv9p5HlPk
         nien7tPJ4L39gthmcuC5oQpFnzwWHeDrGHVC0WQre3cPAv+ZY0fmOH9yZfJTdNYuODv1
         NpL6R8tIlLZ7CY590YIrWi77dKa+Vx0xzaoU4JfYODCon96dB35xbmY5OvRspEaTJVHL
         4mBJnwyNWpwWzGNYi+/7aYINsCK1S0NDyGAeVjxGn6Jlb51FY0tYwW/Mv7rDb+KQaeNO
         m8tnKGu2G7qgdXUp7EVOQGZDiiCQJ5uw5tkFQYkGZNaVA5lTsAcnJvRSf2g/OxzmCd+h
         23oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjzI8Y5AFZSjQh4cY4GKqmaCg1K0UQucOPz5+/QiYwM=;
        b=J/5VOOGQF5fK+tvo6w4s4g24krfftzWXtUX2hrdMLG22Wf0MdxkURAMpELwl0Jrkf1
         5OgBz3frzVzrrIfuaNZphoR5sgGwkA0c7MAjAskTOq/50cqN1mqA9E5d+LZA/NtpoFKx
         q+6KnLeAhy3DH1lfZnMAWm/2VrncxzlJ7vPMF9wuznadFD1knnrw0EjQveRVQIFPwk7C
         1n4GbH5dDh2X8nFz5VP71ryf+IQ6iPkUAjFEJParxcsFaqiiLN9HmX0GHdDfcvQJ0qj3
         RXXwrx00LnsqMj0p+T+LGWTICpy25ditF42tJDPxyXl5pk1bfgcChATZeqLsAFFgWP40
         d3lA==
X-Gm-Message-State: AJIora8tt6tYB0hXmuk/0H936nvfR7uho2mSFpDfqqgRP5gsDu5g6/Lj
        utL8oU55johOPmRQl1isMqMbZwEZU9yv6oS7jZolatB1LNcYGB9E
X-Google-Smtp-Source: AGRyM1txVzkio7oKFun4OwE14uQx7ilwn6eAe1/lyvt+pd0N/bzekFoP9cEO6aXKtzhzHB/IAdMFOcmIZVQK6Yj/bbI=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr26650190wrx.343.1658249817686; Tue, 19
 Jul 2022 09:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-4-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-4-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 09:56:45 -0700
Message-ID: <CAP-5=fUHG=-QdsP5dGxZ444DUfgaYLGhXevQuUH3dmcQnyexYg@mail.gmail.com>
Subject: Re: [PATCH 03/35] perf ordered_events: Add ordered_events__last_flush_time()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
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

On Mon, Jul 11, 2022 at 2:32 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Allow callers to get the ordered_events last flush timestamp.
>
> This is needed in perf inject to obey finished-round ordering when
> injecting additional events (e.g. from a guest perf.data file) with
> timestamps. Any additional events that have timestamps before the last
> flush time must be injected before the corresponding FINISHED_ROUND event.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/ordered-events.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> index 0b05c3c0aeaa..8febbd7c98ca 100644
> --- a/tools/perf/util/ordered-events.h
> +++ b/tools/perf/util/ordered-events.h
> @@ -75,4 +75,10 @@ void ordered_events__set_copy_on_queue(struct ordered_events *oe, bool copy)
>  {
>         oe->copy_on_queue = copy;
>  }
> +
> +static inline u64 ordered_events__last_flush_time(struct ordered_events *oe)
> +{
> +       return oe->last_flush;
> +}
> +
>  #endif /* __ORDERED_EVENTS_H */
> --
> 2.25.1
>
