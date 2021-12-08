Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4EF46DD83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhLHVWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237042AbhLHVWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638998343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i3DaNxZ+DCtlOdYYs61z7M12v8oVSYtpfxHsaarpyvw=;
        b=CQy5JOqLo9Uab0QIT+t+PSWmKksA0RmIPEcIzUgayAE/nga47GnkznljaUe7EnerqKgAY3
        3oHD9bv375LbyqwjATQ1v5LPa1OzRhXXuwxMD4gMaRnBzJZeEixv54BXEkd3eVK+x20tau
        Y4bLaAwxm8VeoCkdh4Xg8+GWHcF1df0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-14RIyuw4MmednhIGNMzTdA-1; Wed, 08 Dec 2021 16:19:01 -0500
X-MC-Unique: 14RIyuw4MmednhIGNMzTdA-1
Received: by mail-wr1-f72.google.com with SMTP id c4-20020adfed84000000b00185ca4eba36so706834wro.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 13:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i3DaNxZ+DCtlOdYYs61z7M12v8oVSYtpfxHsaarpyvw=;
        b=WjPu41ayGLggkbzGUR5k2t9njFXhPSpLWt7Iq5nJbBWgU5NdKewg3MvclttrRtt49D
         9ltoNh+Ele4bymAwaNmmCMJFn2zUozKXuqF5ORjKmo6RDmpHFIsdyi0kvR74AC+WY2q8
         9yqnn/ef0Dj7+0kDoPG2Aep5KkKV7dNYW/CXBDGEZKw0CoixklKxVD27S0J3u/tYrvv8
         7rxSHGNfbaoBn5vBvMMEe1Zhg5JZlecXb1qYUefPm1W/eL5nbvpFEGPz/GCaEdlrM8aJ
         YB6hLPGkXUI2bCC3RlDGxv8owGqQp1x/tnGvCnMonGuL8MkQI9A97cVKBY7O4hXtA8xN
         H/kA==
X-Gm-Message-State: AOAM531F31sRdoUF4fefelL98YmrEl+mOSrBAPY4xTmWYmXSasy3bkDH
        8eO4Gxf4ZM4ihG3+TOEgjCInlWG7dIZ2aFRDUx17CTCnjqCzXNiZGnwchPwOrC0w5HrTWAforv1
        4KxfHn4Ey7cSyBVb8KdUyb2Ay
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr1474971wmc.39.1638998340654;
        Wed, 08 Dec 2021 13:19:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAZb+D1/TGDxkBCGwSmISvdDV38qwpS2yyMvufggSdypDmeUA1tumVaXCcWxVzlmlI36HXTw==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr1474935wmc.39.1638998340376;
        Wed, 08 Dec 2021 13:19:00 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p12sm4697373wrr.10.2021.12.08.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:18:59 -0800 (PST)
Date:   Wed, 8 Dec 2021 22:18:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, robh@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 0/3] libperf: Unify scaling of counters obtained from
 perf_evsel__read()
Message-ID: <YbEhQvkGRzX2K1pq@krava>
References: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:22:42PM +0900, Shunsuke wrote:
> This patch series unifies the counters that can be obtained from
> perf_evsel__read() to "no scaling".
> The counter scaling will be done using a function moved from
> tools/perf/util.
> 
> The first patch move perf_counts_values__scale from tools/perf/util
> to tools/lib/perf so that it can be used with libperf.
> 
> The second patch removes the scaling process from
> perf_mmap__read_self().
> 
> The third patch adds a verification test to make sure that it scales
> correctly when multiplexed.
> 
> ---
> Previous version at:
> https://lore.kernel.org/linux-perf-users/20211129090627.592149-1-nakamura.shun@fujitsu.com/
> 
> Changes in v5:
>  - Update tools/lib/perf/Documentation/libperf.txt

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Changes in v4:
>  - Modify type s8 to type __s8
> 
> Changes in v3:
>  - Move scaling process from tools/perf/util to tools/lib/perf
>  - Remove scaling process from perf_mmap__read_self()
>  - Remove test to verify that no division by zero occurs
> 
> Changes in v2:
>  - Fix not to divide by zero when counter scaling
>  - Add test to verify that no division by zero occurs
> 
> 
> [1] https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/rdpmc_multiplexing.c
> 
> 
> Shunsuke Nakamura (3):
>   libperf: Move perf_counts_values__scale to tools/lib/perf
>   libperf: Remove scaling process from perf_mmap__read_self()
>   libperf tests: Add test_stat_multiplexing test
> 
>  tools/lib/perf/Documentation/libperf.txt |   2 +
>  tools/lib/perf/evsel.c                   |  19 +++
>  tools/lib/perf/include/perf/evsel.h      |   4 +
>  tools/lib/perf/libperf.map               |   1 +
>  tools/lib/perf/mmap.c                    |   2 -
>  tools/lib/perf/tests/test-evlist.c       | 157 +++++++++++++++++++++++
>  tools/perf/util/evsel.c                  |  19 ---
>  tools/perf/util/evsel.h                  |   3 -
>  8 files changed, 183 insertions(+), 24 deletions(-)
> 
> -- 
> 2.25.1
> 

