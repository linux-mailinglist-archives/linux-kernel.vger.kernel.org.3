Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA34EC601
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbiC3Nws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbiC3Nwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8E213CA15;
        Wed, 30 Mar 2022 06:50:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u26so24468037eda.12;
        Wed, 30 Mar 2022 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFscs9a4lBA8lnwkkutsSsPBXiFXGYRCiVbsg2PtHhk=;
        b=oCRtzICXcGnyB/eQ+oVQIlB7OaiwlgstHYPMvB0t35KOpq9RjfKcUMPhcNU1QGGk5U
         ko+WAQ9c/s29BJ2Xi6zT0QOqaKwYa63tKfxYFA6vYTSY+ARO4sJfGg8ulScWZX56axd6
         +D3aqi00sV8Wlcl9LR8VszDTpAz/JzLLElryVuJsUhJANOGTgPqzBHnjuytvZK5AMM7g
         3accHYU9lHPfXqyunhqaU7Bfk9rPkDSCDu0b9UvT2RvsT3dUic+e74s1kD+W1X1eCPPN
         eD7WmauBrYBig6O3sIZTUWrc/RGEP2IWDhoGAP1T2F0Qbw/pNofoNmiWXX/AvIYLAQJB
         gT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFscs9a4lBA8lnwkkutsSsPBXiFXGYRCiVbsg2PtHhk=;
        b=JdJ/3JJsWFWQRf4dUF+n5bDPihDqthO/WAcxRZdvszYD/DSL4JC6P0utcYdWu0EZfr
         o2+2WzHxnNy3NAdoplkzi2hKf4qdALjbUHFR5DyO2vFUv9FMLT3YS29828Yw7vC29TWH
         YfEQv1OtzsHo5N4RpGA7m2soxqcsq1b3TepSck+ig0DaTMQ/dRAz89YiIUbWQ+8iHKaS
         R4EA49/8bKoJ3gGUgcFJ45em8QRByz0mlImPgbpN2l8ROs8aU64HJwBlJRlXoZsP5LOn
         wQji2w0FyAcaQmdSwkx/ZUANhjMMNPWzH4kQYHERF7U2nqG3+ZGv+FMNYFNkh11/hCUZ
         v9pQ==
X-Gm-Message-State: AOAM533hH0B1WAvOe/HttXAjhDS6DvVaHXwUG5Y0fJh1dQiftgruteGc
        /J04oThH91TWhXvaaZYFMWY=
X-Google-Smtp-Source: ABdhPJyCVIJlRb8MMd1Pq+G/UU1G1Oe49NrXcdYhzrtVxeXio5dFpoL9A5Inp56OMsqhxP4WHdszUg==
X-Received: by 2002:a05:6402:2789:b0:419:5317:7d39 with SMTP id b9-20020a056402278900b0041953177d39mr10689377ede.53.1648648245946;
        Wed, 30 Mar 2022 06:50:45 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906255500b006e08c4862ccsm7369328ejb.96.2022.03.30.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:50:45 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:50:43 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/7] libperf: Introduce perf_{evsel,
 evlist}__open_opt with extensible struct opts
Message-ID: <YkRgM1obkBQsY2FR@krava>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-5-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325043829.224045-5-nakamura.shun@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:38:26PM +0900, Shunsuke Nakamura wrote:

SNIP

> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index b17842581dea..db9b7274feb5 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif

I think we can make this global set in Makefile, like we do in perf

jirka
