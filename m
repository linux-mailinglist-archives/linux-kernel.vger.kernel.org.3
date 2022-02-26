Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701494C571C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiBZRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiBZRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:23:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4ACC49;
        Sat, 26 Feb 2022 09:23:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m3so11589233eda.10;
        Sat, 26 Feb 2022 09:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YcpZK+xr5EvJE7NBNH0TKzpdMRtHf+7OM+HfHyAdVJ4=;
        b=KyfgXokUYlGABMuZ8I4NhMguyngYa0xh/Cuk3vfRvFGCjTqPAVRD7Fpq2SsFw7jQGP
         ExaojrmnClfLvBlVQdcxHzQlArLQN+kRcGywPuj0qPcQBbsY5XoKJkOHwZbnbgsGTmNR
         ouA+ra7nBiwexfFWOalFSq+ouY+XHO840mbUeku/htns8jKg3WzVTdF5cC2XJUIK6K1w
         IbJnhS9DPpzBvsuAJsMsbnATMIebh7J1LWFXUTthTe/OvhWqwqEQZBWPdVdrwCNhNZuY
         g1CMPxlvbtfEtDgvHuyLZZbaEL56PzYUK2PUoxxqE+gprNmR5VoReyS5tHac8gX2X0rd
         1Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcpZK+xr5EvJE7NBNH0TKzpdMRtHf+7OM+HfHyAdVJ4=;
        b=uFgb4WekO7eEF7TBn6N8ONAyXZqUlXO4P4e5fmswXf2EvFCHKWKrklbgKguHCsLKjr
         oAje+YwamF7DyaP1Aq8MXPJe457J4/1tRX4aTDMPaxfvDaZ8KZLx9heGoHBYQdmirlCn
         fvErCcVmKWhosyW1EDmGYTZ+JuUmgFBjpkvKQjFTz9BCoU/r5QnFS7AJP2pIFJQHbwYD
         pU8BbNPSJOUy4KMlxhbdyiyOzYCeZR23fMWSZVxq/AmH4ML4MokNtGODtcnixzgSG4Kh
         cujc8a5b60+q//2uTPZstBATRfr0FOggIOfMGXLBZblm5d4QwAEzk1sDeQ4aXFY7PS4M
         2c/A==
X-Gm-Message-State: AOAM533X8/dJqx/gZ0zlQ0vCfY1IO/+N+Y2yXXyYWu/14TB8PpnNmMPd
        GX6uhhVMPZ2Lpmg5pRNrkpCwN0cevMcIJg==
X-Google-Smtp-Source: ABdhPJzJpPw83QjgZyzUfYuVGM9fIbeqnebzhxf9ZbgbQ5Yb4Uaan809IOjAIWCk/GEzAQs4PR7Atg==
X-Received: by 2002:a05:6402:2546:b0:412:d0eb:2a4a with SMTP id l6-20020a056402254600b00412d0eb2a4amr12399710edb.306.1645896193877;
        Sat, 26 Feb 2022 09:23:13 -0800 (PST)
Received: from krava ([2a00:102a:4012:7bee:99f7:73f9:d8ed:b1a])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm3085832eds.21.2022.02.26.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 09:23:13 -0800 (PST)
Date:   Sat, 26 Feb 2022 18:23:10 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Shunsuke <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] libperf: Add overflow detection of sampling
 events
Message-ID: <Yhph/u/Jxl31uXew@krava>
References: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:31:07PM +0900, Shunsuke wrote:
> From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> 
> This patch series adds sampling event overflow detection capability
> to libperf.
> 
> First patch fixes a typo in the error message that I noticed.
> 
> Second patch  adds a interface to set PERF_FLAG_FD_CLOEXEC
> 
> Third patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.
> 
> Fourth patch adds a interface to set the signal handler.
> 
> Fifth patch adds a interface to detect overflowed events.
> 
> Sixth and seventh patch adds tests.
> 
> Shunsuke Nakamura (7):
>   libperf tests: Fix typo in the error message "evsel" -> "evlist"
>   libperf: Add perf_evsel__set_close_on_exec() function
>   libperf: Add perf_evsel__refresh()/period() functions
>   libperf: Add perf_evsel__set_signal() functions
>   libperf: Add perf_evsel__check_fd() functions
>   libperf test: Add test_stat_overflow()
>   libperf test: Add test_detect_overflow_event()

hi,
I think the interface might be more clear if we use additional options
for new and open functions, same way like it's done in libbpf

how about adding following interface:

  - perf_evsel__new_opts would allow to setup needed attr fields before opening

    struct perf_evsel_new_opts {
      /* size of this struct, for forward/backward compatiblity */
      size_t sz;

      int open_flags;
      int sample_period;
    }
   
    struct perf_evsel *perf_evsel__new_opts(struct perf_event_attr *attr,
                                            struct perf_evsel_new_opts *opts);

  - perf_evlist__open_opts would do additional setup 'after' the event
    is open and we have file descriptor available


    struct perf_evsel_open_opts {
      /* size of this struct, for forward/backward compatiblity */
      size_t sz;

      int flags; /* fcntl flags */
      int signal;
      int owner_type;
    }

    int perf_evlist__open_opts(struct perf_evlist *evlist,
                               struct perf_evsel_open_opts *opts);)

    int perf_evsel__open_opts(struct perf_evsel *evsel,
                              struct perf_cpu_map *cpus,
                              struct perf_thread_map *threads,
                              struct perf_evsel_open_opts *opts)

    not sure we want special opts for evlist.. the evlist open
    is just a wrapper and I don't think there's special open
    info just for evlist

I did not analyze your usecases deeply, so I might be missing some
case where above API would need some adjustment, but from the quick
look this could fit and I think it's better than special functions
for each feature

there are additional macros like DECLARE_LIBBPF_OPTS that allows to
define the opts structures in backward compatible way, we'd need to
'borrow' that as well

thoughts?

thanks,
jirka
