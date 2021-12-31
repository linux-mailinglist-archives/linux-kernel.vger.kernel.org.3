Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D0B48244B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 15:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLaOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 09:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhLaOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 09:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640959817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZA7VWkCPr41q8/Hb/ehlM3EuRdCqmcpsIFtWCkCNsyY=;
        b=gSaZ5Ymw6DDuHhqUSJDb6Cpl9nKCJHgBFK5jqfZ/+DSB81fN7NhNmj+Afrs+tyOhoIVRrK
        1PfSiN96SZrBNK6/PdyC/69LlttTJJLKxCwjkNrPW9A0hgAsxv3PhAJqn2XIds/ywVGSba
        xqt6Exmnq+mgeyf51jkgzeEKQGOUlNI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-GvKHXCAmNDGjfrGSAjpXmw-1; Fri, 31 Dec 2021 09:10:16 -0500
X-MC-Unique: GvKHXCAmNDGjfrGSAjpXmw-1
Received: by mail-ed1-f72.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so18869960edd.15
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 06:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZA7VWkCPr41q8/Hb/ehlM3EuRdCqmcpsIFtWCkCNsyY=;
        b=h7haNXwTdlKmNhHdSVGysLd/vXaenrdsvvMoKup9K2Znt4P0dF1iVZD1drm8N0z68s
         sGIXzusQByY6huySGg9SCjaTUiLoiBAQBlAd7y5lerlCOytIxlIL06tkcV4FtqEuLPoX
         n43l+R89pPSUbWPLuZRAb+j3I/OrZ5SV/mERLBxZU0uc2POKDy6QI2R58HfEhjLsKYw8
         6GCqcjKfBBFOEI093hOTzlhezBlHr+sWhTcNCXZVPCS/S7YUlN0tLMzC3GU+21LG/wW6
         vl0wcZJc79r1EiCGO5U1brEbzIb1dD2dCA7axuhfCTzW902Otweml8r6b8sN1GZu7Ze5
         1ybg==
X-Gm-Message-State: AOAM530LF+z/qGCTzriP1xoAp8wCTZsXWMlMyA9xrNtL16CLZFxEBBZ5
        NWIpGBoqtgwS5US7K8CYXPKcPijJ/dL5KxZI3Ba1v0ifkFQYF1NyFWezI1pMytqApbGhikfsg9U
        QgApjRI9OVzyR1MoK/QUzC7sS
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr35102426edd.10.1640959814983;
        Fri, 31 Dec 2021 06:10:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXtpIURiz+yNaLNBLGV+WSn/jF2jDc9Bt4tyqjwsuq38M6N4JPJi2er/re4Hlsy4la5AJufA==
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr35102414edd.10.1640959814778;
        Fri, 31 Dec 2021 06:10:14 -0800 (PST)
Received: from krava ([83.240.62.97])
        by smtp.gmail.com with ESMTPSA id u21sm10615429eds.8.2021.12.31.06.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 06:10:14 -0800 (PST)
Date:   Fri, 31 Dec 2021 15:10:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     yaowenbin <yaowenbin1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hewenliang4@huawei.com, wuxu.wu@huawei.com
Subject: Re: [PATCH] perf top: add concurrent access protection of the SLsmg
 screen management
Message-ID: <Yc8PRcFFSvIev0c5@krava>
References: <a91e3943-7ddc-f5c0-a7f5-360f073c20e6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91e3943-7ddc-f5c0-a7f5-360f073c20e6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 04:55:19PM +0800, yaowenbin wrote:
> When the following command is executed several times, a coredump file is generated.
> 	$ timeout -k 9 5 perf top -e task-clock
> 	*******
> 	*******
> 	*******
> 	0.01%  [kernel]                  [k] __do_softirq
> 	0.01%  libpthread-2.28.so        [.] __pthread_mutex_lock
> 	0.01%  [kernel]                  [k] __ll_sc_atomic64_sub_return
> 	double free or corruption (!prev) perf top --sort comm,dso
> 	timeout: the monitored command dumped core
> 
> When we terminate "perf top" using sending signal method, SLsmg_reset_smg
> function is called. SLsmg_reset_smg resets the SLsmg screen management routines
> by freeing all memory allocated while it was active. However SLsmg_reinit_smg
> function maybe be called by another thread. SLsmg_reinit_smg function will
> free the same memory accessed by SLsmg_reset_smg functon, thus it results
> in double free. SLsmg_reinit_smg function is called already protected by
> ui__lock, so we fix the problem by adding pthread_mutex_trylock of ui__lock
> when calling SLsmg_reset_smg function.
> 
> Signed-off-by: yaowenbin <yaowenbin1@huawei.com>
> Signed-off-by: hewenliang <hewenliang4@huawei.com>
> Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
> ---
>  tools/perf/ui/tui/setup.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> index d4ac41679..1fdf92062 100644
> --- a/tools/perf/ui/tui/setup.c
> +++ b/tools/perf/ui/tui/setup.c
> @@ -170,9 +170,11 @@ void ui__exit(bool wait_for_ok)
>  				    "Press any key...", 0);
> 
>  	SLtt_set_cursor_visibility(1);
> -	SLsmg_refresh();
> -	SLsmg_reset_smg();
> +	if (!pthread_mutex_trylock(&ui__lock)) {

trylock because it can be called from signal, right?
could you plase add some comment about that

thanks,
jirka

> +		SLsmg_refresh();
> +		SLsmg_reset_smg();
> +		pthread_mutex_unlock(&ui__lock);
> +	}
>  	SLang_reset_tty();
> -
>  	perf_error__unregister(&perf_tui_eops);
>  }
> --
> 2.27.0
> 

