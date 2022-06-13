Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61269548389
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiFMJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240982AbiFMJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:42:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E221928F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:41:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so8344493pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3zv9VsT6GzeRZjX4O+xZTpLY3T0iHWEg6o7/ybQPGqE=;
        b=pnDooppCijgVu+c5EHkgxq5MtPcp+Xe5B5JMr6y8KHrza3VbjrMaNTmgErQ18vwgoM
         WFaSL/Ij0uKr6VqTmLcP12mgf7cQUt0V02o7Zz2oGhZrModewH1rwdC9nBAJMEo4yYCF
         8gl2xEwRmgVF9klKKzACJCPeRiwy0e8hyY/YPp2EOKHcD3Ir+1PT5WuAZ4M7I3QJ8WAw
         12M6x1e9swHjGg6XuKLTPWqksFVuUc8Jjm5CvLHG5i9kyjqp8U/1Qq3iXxjuOyFjl047
         Al9A12LoYARj21EHDJJMqMziEjUt8OoZ2ZCTxkoTh3dOQ6rw66EBbrAZAQPLGpoArPzC
         rEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zv9VsT6GzeRZjX4O+xZTpLY3T0iHWEg6o7/ybQPGqE=;
        b=djKSwQZq0hPHpNaoU6WH8XWN+tJSq6I6UJKMW5Btr9Lf8EWy87tYGaXTlHRxulQiia
         BE4UrOhBcusX+6a2tmW7FHvmdhUiGcxS6cV5EY/hQ6+h3uiOzysS30xLntKcKMQjcxec
         4GYa8J3/6hP0m3BOApV1zNYkqfh6FeTtWDIOKrvkRUB9ATGfySDgt2FeuZVr9aXNnPwE
         6tE2oIlXRETsa6INFIGR9/NlHcNEM1/DfKGna4EaYWSG6PyGzdgUiJxZlLxcCQdzmDko
         m7uaZiLHwkecrf21bnkYsN0ABWRXpDuvAnePrDpD73hYuwEmBDMkG7DOr9TSBM9pRagC
         CJoA==
X-Gm-Message-State: AOAM533AOKyffDR9GKuK62ymmJ/91aUqkxC/bIwt5VIeCvL1rXKltq5m
        Y8PhNZe8UkG4e6iJSd3Ve5VoBg==
X-Google-Smtp-Source: ABdhPJx133e0QYjh4mQCycLtNgyWHXlHe3WCispa0l0G1q0/u6q7YHKIuewm1Uefa83Kxz38zcDQjg==
X-Received: by 2002:a17:90b:384a:b0:1e6:9e79:4072 with SMTP id nl10-20020a17090b384a00b001e69e794072mr14906450pjb.10.1655113314419;
        Mon, 13 Jun 2022 02:41:54 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id q14-20020a638c4e000000b003fb098151c9sm2681732pgn.64.2022.06.13.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:41:53 -0700 (PDT)
Date:   Mon, 13 Jun 2022 15:11:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 2/3] thermal: cpufreq_cooling : Refactor
 thermal_power_cpu_get_power
Message-ID: <20220613094152.yfduve64kdp6ztxg@vireshk-i7>
References: <20220610100343.32378-1-lukasz.luba@arm.com>
 <20220610100343.32378-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610100343.32378-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-22, 11:03, Lukasz Luba wrote:
> Simplify the thermal_power_cpu_get_power trace event by removing
> complicated cpumask and variable length array. Now the tools parsing trace
> output don't have to hassle to get this power data. The simplified format
> version uses 'policy->cpu'. Remove also the 'load' information completely
> since there is very little value of it in this trace event. To get the
> CPUs' load (or utilization) there are other dedicated trace hooks in the
> kernel. This patch also simplifies and speeds-up the main cooling code
> when that trace event is enabled.
> 
> Rename the trace event to avoid confusion of tools which parse the trace
> file.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 18 +-----------------
>  include/trace/events/thermal.h    | 28 ++++++++--------------------
>  2 files changed, 9 insertions(+), 37 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
