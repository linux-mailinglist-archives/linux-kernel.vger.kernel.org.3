Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D525530A46
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiEWHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEWHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:32:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8454E2632
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:32:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso16708056pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v6pOY5u9Xf6A3Kt1uWvJSEsHw5j9g/fdOSLGZ65o8Gk=;
        b=Rh0hMGETtsu517ry/T9riUCh0WoTh7KBsWj+R6HNHfWgM9d1YOzQb+++l8QEkM8TkT
         BR7RRIPcOHw1PcE7o9WR+Yj7CrOh7NjAxTWAQSWabAWYUn1hnF1lPteRbwofFzxGfP6c
         dlYvi7Qiwls3ttBnxiA8ZpKx/DfrUI7CjcmElj+glPYFa+fhbYJ45NnzMNjTDCFUd4LJ
         L3vMyg2n4PGfOm6U6GEdxu+TqCxiZSmobMtb6ptRieRejzKHGROLhmQPYZylubnU8psE
         Tz6ZG0R7pIOxV0swCRUXxRYy+q+1GOAE/TCqZNt1wGkZF808JPokiQ6QhvnAzEew1rj+
         Gn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v6pOY5u9Xf6A3Kt1uWvJSEsHw5j9g/fdOSLGZ65o8Gk=;
        b=Tpbul1Oq/mhnuF6ZY1WBdPxllbLGOwuajzs9vvptJGYtbyClgID3a7h/a3tFjUoXHp
         4ay77KCyoKPgjLYAWVd7kVIJ7v6U3LrOy7iX03CTVjClJgH1UddPtpK1LLp377uVf3kX
         /W3Cthwy6MhzHL6iXVBo86sRIvMGeBEtsAzaKHUm1VF20ZGIQACBd9OwRKfppcjGtnQz
         bSVBQIiV0RF8SXGqpOyOxChldk5SJ6elvroRrBsoRnX3bdF/uO4Q62RTeqlMaWJV+c7j
         vH0BRzDcq0H0E926wjZvkB1ySYmq7S4v5IJWJQN1SWN6CD4y5EORXJAoxEoIW/q5iCRg
         GNXw==
X-Gm-Message-State: AOAM531o7lRlyten1Dwl99qflRQpFcOGUfRpuOBiAdeR4TKKeiWgnSMQ
        CtaD6pY53Rdvc2Pvy79AaJWNb74hRDghZA==
X-Google-Smtp-Source: ABdhPJxu2th6oFts/Ww2O/QBBPj+6FmL42fAW6DCdsthlSEOt/394d44jyeFuGSdOmTAnOuJ94NTsA==
X-Received: by 2002:a17:902:bf45:b0:15c:df47:3d6 with SMTP id u5-20020a170902bf4500b0015cdf4703d6mr21373791pls.58.1653289132554;
        Sun, 22 May 2022 23:58:52 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id z14-20020aa79f8e000000b0050dc762818bsm6417466pfr.101.2022.05.22.23.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:58:52 -0700 (PDT)
Date:   Mon, 23 May 2022 12:28:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     rafael@kernel.org, Pierre.Gondois@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gaochao49@huawei.com
Subject: Re: [PATCH -next] cpufreq: CPPC: Fix build error without
 CONFIG_ACPI_CPPC_CPUFREQ_FIE
Message-ID: <20220523065850.lhnpsc2u3dxzzwx7@vireshk-i7>
References: <20220521032438.2504155-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220521032438.2504155-1-zhengbin13@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-22, 11:24, Zheng Bin wrote:
> If CONFIG_ACPI_CPPC_CPUFREQ_FIE is not set, building fails:
> 
> drivers/cpufreq/cppc_cpufreq.c: In function ‘populate_efficiency_class’:
> drivers/cpufreq/cppc_cpufreq.c:584:2: error: ‘cppc_cpufreq_driver’ undeclared (first use in this function); did you mean ‘cpufreq_driver’?
>   cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
>   ^~~~~~~~~~~~~~~~~~~
>   cpufreq_driver
> 
> Make declare of cppc_cpufreq_driver out of CONFIG_ACPI_CPPC_CPUFREQ_FIE
> to fix this.
> 
> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
