Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE6530AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiEWHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiEWHci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:32:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26951FF1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:32:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q18so12324798pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l6vKoyEya/r3/MqVEEJWzCpNcuuesZvhsyqXin89G20=;
        b=QkkPzppkGobaBMNtLMjTdS88K0En7cKbJRSLr/uCDJHYpNDsXdoNt7dKWMSOumeJuW
         2hUbrbUVFiJiun2+NVvuDJghnz5x3AhxhqVZh7ilPtoik3nOgS6EwjLGMR57IVlIsMIS
         E51jAnuW6i5mKRZ36FgcV6rz2yQXfXyZdbsLWcMk4m3+fvRBa2MD3Dy1nAg1QiRfXSkv
         ZqsxVjyeUlyzPoEpqYpxtQy5j0L6WE2P3v486BQvYR0FuuXCjYH+CSGEucQ0NFS/aM7K
         oGOQU/xmKbrDqirJI0e1slSZb2NDdorb53JovJb8o4GRFSKF3iRHzvvfECqhiufy81fH
         fO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l6vKoyEya/r3/MqVEEJWzCpNcuuesZvhsyqXin89G20=;
        b=VrvP1Ai0BrzRMHrB4PSEWYQu43uoPRhZmXZ1pa72Z4JfcNGEB9Uy11gcCjb2hxf1iQ
         pKnW1utK2frlngtN1BcHkWARyke2FkbTN920c1eps/lWcCSy3ZG07j1/h/8qLfqs2xyf
         e9+AI6itd1ONLmP6JPqBQ1Y9kuRdsg9eeB5RvAaeGxAWgvx2uTkTBgizA99/8442rTGO
         hzqO+KyhFtJJl647VqCBV9eh1VvlWhFuwcjVrCkogCNGacu3P0eRUwWwK01vsh3CzGbS
         d5dc4Btw4ETaUYd5H2rarYIaIbFmbHyD2JDtrpCN8eDJ3ZN6KRsAEyAAJZxpzfKbovve
         NJqQ==
X-Gm-Message-State: AOAM530Yy2K1wciNBWNGM40XLN50BeDZ7Kv4ZFJHG1e9Skv4MVDjAvnE
        jONcbHt6Ki8xEinmM1J0WV3vNQ==
X-Google-Smtp-Source: ABdhPJxua26V/dTD9Xrx6ogoO6c0plBdrLo/kP7vn5fAlM3y5vBZrLDMIXXKyZRHMsd33ZQVnFsxyA==
X-Received: by 2002:a17:902:f710:b0:15f:165f:b50b with SMTP id h16-20020a170902f71000b0015f165fb50bmr22287217plo.158.1653291123694;
        Mon, 23 May 2022 00:32:03 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b0015e8d4eb2d8sm4322308ple.290.2022.05.23.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 00:32:03 -0700 (PDT)
Date:   Mon, 23 May 2022 13:02:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Meng Li <li.meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Message-ID: <20220523073201.asdi35v5f43aoaee@vireshk-i7>
References: <20220522115423.1147282-1-li.meng@amd.com>
 <20220522115423.1147282-3-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522115423.1147282-3-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-22, 19:54, Meng Li wrote:
> Add amd-pstate-ut module, which is conceptually out-of-tree module
> and provides ways for selftests/amd-pstate driver to test various
> kernel module-related functionality. This module will be expected by
> some of selftests to be present and loaded.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/Kconfig.x86     |   7 +
>  drivers/cpufreq/Makefile        |   1 +
>  drivers/cpufreq/amd-pstate-ut.c | 293 ++++++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 drivers/cpufreq/amd-pstate-ut.c

I wonder if this should be moved to selftest directories instead ?

-- 
viresh
