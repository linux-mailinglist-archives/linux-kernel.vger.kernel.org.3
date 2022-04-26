Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3B50EF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbiDZDOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiDZDOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:14:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC41D0FD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:11:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq10so3657580pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nVZE7WhCVgOEwloB9fBHGQug4Pq7JrYfcpVZZhNPJ8M=;
        b=iiY7SUkUJSKq6iMYy80qbFpI8F71DjyOcH/7mPrMqWFyNPbD2lkHEH7NA8dzfgGipp
         cEK5xybLp2PdHk3DhUw21XO/7wcO0wwCcC3YV5NDx1ZsfgJNhYYE1gF1rop1g6VnCglj
         aB3HUQOPnhi7McJq9O7w+Ii4s95NxdlUXHfOSY0Ogv5rDvhHbmLrLLzzUPlzxeFvVL9p
         RosKkUk6Lq08CQfp0KxhaBZCj+1wHuTzqlzoUUEzYkNp/zx4OofkTEZFCqAD/q+qYQmu
         mULY18x7ozUPXv8dJyCVakKXKx+YlO+J0xp83SzJ/DGLYOU/aH8rM3AtPMCQctL9HK9t
         hepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nVZE7WhCVgOEwloB9fBHGQug4Pq7JrYfcpVZZhNPJ8M=;
        b=2cUtjdkgpnaWgTZs6DcANyHtfUnKIH2/JwJUfgIwszE2FEHzKWJB9oph0kgd5TpToQ
         /qHV6zDMp4fiGHw5/C1Ss7Pghp+i24ZF4Gp4wiI6c9jON7as95/7+uhEnYpNfcH6pPCt
         ZhmwRxVkcaOsoRyhbbqVQuRaxAe/g2sJERMSs4fMmcXLORtBAmlar9zyhAfaqJ4epKKf
         p57YSCl/yUbuAjaI5Df9OxeHaV7hQ77NwVNGeiXTfpm/KrjhMa3n/3aEqFqAdn63cXET
         Dxgnlu3OnlklVwGKtgkdef6ygNJn/Goz9nAlpOsY+dlL5PMbArgoi6OrMDh8jeL8t4SP
         Xn5Q==
X-Gm-Message-State: AOAM532ZnoBDQD0nChTGT0xMuazBdsk0tVCjmu39Oz2pkLAKotK3/mSh
        M9cibJbtGqEe0+Z2VIyH1V4vlA==
X-Google-Smtp-Source: ABdhPJxRHU2DzKIyYipB+2M6WmYcQCgZLLx0Zvb2cm9K7vdm/I0skevBL6sFII9I04I+lVQWDRYwQA==
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id gx12-20020a17090b124c00b001bc369b7db5mr35040961pjb.179.1650942691168;
        Mon, 25 Apr 2022 20:11:31 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm13075988pfw.144.2022.04.25.20.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:11:30 -0700 (PDT)
Date:   Tue, 26 Apr 2022 08:41:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] Introduce Cpufreq Active Stats
Message-ID: <20220426031125.ozaxwecwvuby6wo3@vireshk-i7>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406220809.22555-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-22, 23:08, Lukasz Luba wrote:
> Hi all,
> 
> This is the 3rd version of patch set which tries to address issues which are
> due to missing proper information about CPU performance in time.
> 
> The issue description:
> 1. "Cpufreq statistics cover the time when CPUs are in idle states, so they
>    are not suitable for certain purposes, like thermal control." Rafael [2]
> 2. Thermal governor Intelligent Power Allocation (IPA) has to estimate power,
>    for the last period, e.g. 100ms, for each CPU in the Cluster, to grant new
>    power and set max possible frequency. Currently in some cases it gets big
>    error, when the frequency of CPU changed in the middle. It is due to the
>    fact that IPA reads the current frequency for the CPU, not aware of all
>    other frequencies which were actively (not in idle) used in the last 100ms.
> 
> This code focuses on tracking the events of idle entry/exit for each CPU
> and combine them with the frequency tracked statistics inside internal
> statistics arrays (per-CPU). In the old cpufreq stats we have one shared
> statistics array for the policy (all CPUs) and not take into account
> periods when each CPU was in idle.
> 
> Sometimes the IPA error between old estimation signal and reality is quite
> big (>50%).

It would have been useful to show how the stats hierarchy looks in userspace
now.

-- 
viresh
