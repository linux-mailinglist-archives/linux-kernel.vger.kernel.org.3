Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE45714E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiGLIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGLIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:41:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBDCA5E47
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:41:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l12so6654177plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jlvp3ctzfV5qIwygKhimi/OMZvViFDBhQEGu7/yFHI=;
        b=kzLKsiAjlkufjLDqxapjEYgh1ncbzgUECLW+oHEZVys0qAYcP5sn6XnrSv2Awsbk3v
         vaImKcE/YZfn8AzNPNKbopI/23QAPmafu/HOvBFr/mTB5xtRR3GGJ/Lq/lz88K1h4m51
         NiDl3LyxnUUoT82Jk/KhkQJ1yEJTW3DqpbYO0MnhPEgqD4dc5tYPsThWnoNrtQ728teU
         JDE+DSUJ2vfntqY4SQ6gpDU9Y+EUY7EkLM5kC9CgizxqAxTIsmu/Y63aCmBteDtIYl1f
         kvKmA/zpWkf7tktfx/ui/7XvzbnyKkayZvBL59rGSLDFB6lHIUsV/MeeQlwN9Nfrw8Nr
         1DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9jlvp3ctzfV5qIwygKhimi/OMZvViFDBhQEGu7/yFHI=;
        b=rXlYNavpknP2Ei166K91GBfUT4jWV2r9lQzZjTHNl/abAaPl/D6vqFT1QjyhOq6HaF
         mlEwaOo3ibqBBHfn0g6h0Li/Wea5V1LToC8V5ySS/zSIS+Hc1a4nVwEMXrvLwREcxYfl
         filmHW/JXhWpCTAXrGlcL/I68PcFVZZU+cmR2rugSiLXG2RuMYqtSe3UKjqF0RXZjQhT
         7PT/InGiFTps7ibP7xq2Yz6nmeRxqit5dvC7wq//3OtxiFz5qf8JWB8wdqc1UMD2eADg
         nhJA0c/HbFQe4WVWmVhOsCmpbbuYbiRkpMymZAUQgo9cwKpP4ZzHAscbk9tJ7H64vMpe
         P8cQ==
X-Gm-Message-State: AJIora8LJVAaOdC+KmDMge6gwM2kjxnuqJba+MdmEcelRZPb6dk74pEd
        VphJ55jV4H3YmuIpykfrUpKwGg==
X-Google-Smtp-Source: AGRyM1u0Orb3NyHrPVrygHCrKYTYrtkpqltCrDm7vAH9cwSewR2UFTT/T76rR7qWddA2MUIBo0A5Hg==
X-Received: by 2002:a17:902:ce8c:b0:16c:4be6:254d with SMTP id f12-20020a170902ce8c00b0016c4be6254dmr8898036plg.51.1657615300935;
        Tue, 12 Jul 2022 01:41:40 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id l7-20020a622507000000b0052aaf7fe731sm6174399pfl.45.2022.07.12.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:41:40 -0700 (PDT)
Date:   Tue, 12 Jul 2022 14:11:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
Message-ID: <20220712084137.pb24lolhuk2yln4e@vireshk-i7>
References: <20220711124229.16516-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711124229.16516-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-22, 13:42, Lukasz Luba wrote:
> There is no need to keep the max CPU capacity in the per_cpu instance.
> Furthermore, there is no need to check and update that variable
> (sg_cpu->max) everytime in the frequency change request, which is part
> of hot path. Instead use struct sugov_policy to store that information.
> Initialize the max CPU capacity during the setup and start callback.
> We can do that since all CPUs in the same frequency domain have the same
> max capacity (capacity setup and thermal pressure are based on that).
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

I tried to check all possible combinations on how this can break, but
couldn't find one. I had to check that as this code is there since
ages and none of us thought of it, which was surprising.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
