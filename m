Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48FE525AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357836AbiEME3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348393AbiEME33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:29:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E9292797
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:29:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so9745342pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOkWkR9Ocy2CU7QPzBKs2WmW8Yr7OVdgCwKhMEH1vEU=;
        b=pr9XuWJgiU/uRmmT5fZbBoUYR2ZQfOvIP/fG8IH7DKeqmuojFuDZ5c8c4YUHPmqBmh
         zXNWMD3IgW8+O/7EHImSmJOMWPbw4I/GwppQwL8wZOPiK6LvvlpuBjNBTHMbMwZqiD8y
         hXkWpEI31SeVpwZGidBW3OrJdvIc1VSzXbPDMG45/V9kihbRiwTFLZdv3bmc2a9zzgEj
         yzGnffWVkfmvcPTQeqLwmZIq34n4O5wVfPfXE/Ebg4edrwrZE9reXxaAFO42AqvAMI6V
         KA6K1ScFTbKuf+vbjXXUv0zz2w8of7sO+JSJwKPDa4ZO9gJlXH+fbjEA1MHINOZ3fxbd
         EIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOkWkR9Ocy2CU7QPzBKs2WmW8Yr7OVdgCwKhMEH1vEU=;
        b=dlgTdX/5Kuu4hzPaz3ZqoYMi5+qNAo77De9giGVwU3bWbLyZ01Lr9cF/uCa5gf9CGE
         Q0/y5MawD0/lI2YEfQJLCLX/11zARryS6OOUiKDCRZg2HWDesl/4z77fxHoWMGJ/nxoC
         vSZIBQsMXDayFeIDgx78fNohF219ZxTllCIs/M4RNk+tkkKQkedpkMoYxncud9zQBimg
         6xR6ruM7qiDMMaEJA4Iv8siifF+71j9Cb/B3EulfSgjL1l+EHTepMWS9dNj2Wa6Q4sf/
         kA1vFod4hrloR6xT3bUW/117HOw63bOTRy1DOCHa+wiKxsfu8tpN2yQqbapJu3m1Xxax
         HZLA==
X-Gm-Message-State: AOAM531KbrjsXLP/TELkPwe0j4uh9CuqKC8s4qh0fjyliCKrKuSJhl8F
        9OOh4g4wcPnRrCjSgW2Qkn2m0A==
X-Google-Smtp-Source: ABdhPJzXX3SKeWx7mB3jrDkUEdCdK+qjACy3ZkK/roOebknMQ5MhRsCd4gkNu9EYHwd4fa4whpthOw==
X-Received: by 2002:a17:90b:4c85:b0:1dc:5778:5344 with SMTP id my5-20020a17090b4c8500b001dc57785344mr14165956pjb.8.1652416167522;
        Thu, 12 May 2022 21:29:27 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090aab1500b001cd4989fed4sm2555583pjq.32.2022.05.12.21.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 21:29:26 -0700 (PDT)
Date:   Fri, 13 May 2022 09:59:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cpufreq: make interface functions and lock
 holding state clear
Message-ID: <20220513042925.42hvv26ejup6js3h@vireshk-i7>
References: <20220512135231.10076-1-schspa@gmail.com>
 <20220512135231.10076-2-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512135231.10076-2-schspa@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-22, 21:52, Schspa Shi wrote:
> cpufreq_offline() calls offline() and exit() under the policy rwsem
> But they are called outside the rwsem in cpufreq_online().
> 
> This patch move the offline(), exit(), online(), init() to be inside
> of policy rwsem to achieve a clear lock relationship.
> 
> All the init() online() implement only initialize policy object without
> holding this lock and won't call cpufreq APIs need to hold this lock.
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
