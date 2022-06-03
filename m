Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384C53CBFC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbiFCPFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiFCPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:05:17 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8E64D8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:05:16 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j3so5783101qvn.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cllboZHiVczGnHfW6HsiE6kGDCt0KqAkqMwEbcO5ZyQ=;
        b=yG0jjw+ZXuTfAKzTsYnPPb3n6i2Y5eQSUU7g2+O4ca7JlB0M2jX8bIQpTjafIzt415
         J1NNwKDaHSMNOQJeEmQbJY+Vbo+pbIPzCY2ZRW8I4WP82MjJADczj3log1eDk8oOhBJY
         ODAn1YOpP0yuPSHyoylf3oAI9axDsZTNjn0HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cllboZHiVczGnHfW6HsiE6kGDCt0KqAkqMwEbcO5ZyQ=;
        b=BNCA9YKnPauAtQZTFW905/njxuL4brkokxrxXIRV5ETl0Hg07H654jJ+QIllVqyEy1
         CbE6k3cqukonz9RSI/DVN6oZJvgarEdhmOn6yMvWOZdjM2JRk/vS1lsx6QWWeTtkEMpH
         Y7mVkoRGhJEtHEDfhklMgAJJS1/lZOkLWND7oklvetlwrJt1nyAfQRfxpU6acOwNqMVs
         p/Emu9j06VwiQklKHFfAjYX0ImualfvvFbMDhN68PjWf+v7a15Rp0nYEuDQlB/9pU6SP
         yP1A7wHhQbwvwrSX6kT5ANqqWaPr86MA3eIC62zt5LZgbuVJZKt7pqFJm3pXdZ/WLepI
         d+eg==
X-Gm-Message-State: AOAM533ku8/E5QVLlFbv8lzbBNtbUqfPG85cgaWdEH4h9PqmViDj5Ivn
        8hEtCKoqbnA8Cteb3lX+tO9JaA==
X-Google-Smtp-Source: ABdhPJwu/AosTQGX+41XOFG+X3xAR4RlHUc16mMpPfjSCpspZQ24Q71q6gl0sMfEZILoYzpqOPEAkg==
X-Received: by 2002:a05:6214:2301:b0:435:38af:2f87 with SMTP id gc1-20020a056214230100b0043538af2f87mr7243142qvb.83.1654268715843;
        Fri, 03 Jun 2022 08:05:15 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a010700b00302ee555a18sm5410437qtw.5.2022.06.03.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:05:15 -0700 (PDT)
Date:   Fri, 3 Jun 2022 15:05:15 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH] perf/core: Call LSM hook after copying perf_event_attr
Message-ID: <YpojK0iaPofkAzd4@google.com>
References: <20220602224754.602074-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602224754.602074-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 03:47:54PM -0700, Namhyung Kim wrote:
> It passes the attr struct to the security_perf_event_open() but it's
> not initialized yet.
> 
> Fixes: da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/events/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7858bafffa9d..e035545f624f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12033,12 +12033,12 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (flags & ~PERF_FLAG_ALL)
>  		return -EINVAL;
>  
> -	/* Do we allow access to perf_event_open(2) ? */
> -	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
> +	err = perf_copy_attr(attr_uptr, &attr);
>  	if (err)
>  		return err;
>  
> -	err = perf_copy_attr(attr_uptr, &attr);
> +	/* Do we allow access to perf_event_open(2) ? */
> +	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel



>  	if (err)
>  		return err;
>  
> -- 
> 2.36.1.255.ge46751e96f-goog
> 
