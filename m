Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2F52472F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351118AbiELHmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351112AbiELHmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:42:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883131A15D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:42:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p12so4113357pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WgTgy6Q+d8TrDK1hHPXj5oNnS+nB3lnyhddRNxBZhpk=;
        b=OhYgBUt2hUmUJ+ybZL/wdXJLTU0v+/9O+N5ePdErfkb4ZTtdJ5P0t67WYjcdjFXEne
         2vPwS8X0CJy1h25YJo8wqCso1FL5di2KkfkbiMtLzZl8FVax2zIVTSD1r5cB1voGiKF4
         +XDyVWJvry04by0kx6zsSlLL1DW8PSOiTvF794KJCtUKVwVQ76fOdt3hWhfa9nRuw5fS
         mxrV809q5uSxkGUqEd/LYNrNru8VAtzAnM5erRvTwbYsMDExyUyXh7VQBMUk2ATHyh3L
         RkZoEpu2+XFPdhKXFJH+7Na36uTHaXDQmE13zYefldQeQ0E3s6T4QSYIy3RRjgCrN2bV
         3V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgTgy6Q+d8TrDK1hHPXj5oNnS+nB3lnyhddRNxBZhpk=;
        b=wmjo2Mi2qIssd+jBhSoIpPcXkWHwIPMhppLbAOr6CSUePplkEf4TZC92cRyNIvlTmK
         vxnS/vnz0ZkJAWcwLVgxUdBDmQOOBo5Rf+JtYK5w0PPcqB5McfekhKf5T9N+qqa1cCwJ
         Ra8AhNhV7abbNGSc0Mu2JcKO+/knkfQnalfkQEult8qZZTFdBN06nLa4aFahy0TuObpF
         AmqGMJCbmDmUtQemmHo8SOQc2qknVdSttxXkCJRL6Wqo3pRqowrqByQAevCVWPsa8HIF
         N4ovzNcTJBbQVGLvrZOk+dYnX4S3HLaHshm1CcC780pFvQav/6uTziw9sQ8msL6JddRL
         wh5Q==
X-Gm-Message-State: AOAM532er1vJi6+JoB59JEf9oTgj2/e2exj89YtO2VvaKHixuAl2eKvq
        83qeJf7Hqa1OI7kpXrhNPBtN7w==
X-Google-Smtp-Source: ABdhPJwia2Fq44GWsT7Jk6YqY2Am5aAvcWQiS8d5n/BYk4E3i6aXcP2rSAmGyo9C/F4nOfaSjhHBRQ==
X-Received: by 2002:a63:1d26:0:b0:3c1:eb3f:9daf with SMTP id d38-20020a631d26000000b003c1eb3f9dafmr23797634pgd.284.1652341358988;
        Thu, 12 May 2022 00:42:38 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090aef8300b001cd4989ff42sm1204989pjy.9.2022.05.12.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:42:38 -0700 (PDT)
Date:   Thu, 12 May 2022 13:12:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] cpufreq: Rearrange locking in cpufreq_remove_dev()
Message-ID: <20220512074236.bkamv2o5hgson243@vireshk-i7>
References: <5585781.DvuYhMxLoT@kreacher>
 <1836239.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1836239.tdWV9SEqCh@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-22, 17:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, cpufreq_remove_dev() invokes the ->exit() driver callback
> without holding the policy rwsem which is inconsistent with what
> happens if ->exit() is invoked directly from cpufreq_offline().
> 
> It also manipulates the real_cpus mask and removes the CPU device
> symlink without holding the policy rwsem, but cpufreq_offline() holds
> the rwsem around the modifications thereof.
> 
> For consistency, modify cpufreq_remove_dev() to hold the policy rwsem
> until the ->exit() callback has been called (or it has been determined
> that it is not necessary to call it).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
