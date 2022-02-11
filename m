Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792564B1D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiBKEbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:31:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiBKEbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:31:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF82655
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 20:31:02 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id r19so14106947pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 20:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MOb5E7ReyO7cniK0URV+jpDF2iMWhXYuuSt7FY8mKTQ=;
        b=gXyIIfsAFcbCW0UJihoeq9BYB7JsvLyScEFGAjVslTrQdnlPWycbuY7iDbvpqWHD3D
         kIuD6MPOwvID0Uf+XC1HlrtK3tfYU8IJjmTEXdn0moK8667rURP4uaJHVxa5J116OeXc
         zbcpl2vORiaZWckumJrX44XAuk9olEZEeCOb1e9tXzSRlbOzDQ8ouEoq8qF7rhlSjPKG
         bS4c7cEbhR6BLzVUzVx1YqmsC+Wm9BNKzOvnXe5pTfuscFztNJlHW+Rt6RVkbW3/5CMX
         UjlJxr7Q7ldXWmwrQh6cyf+d4XpGhRqbAmKimnMmYKW5x+ViZT+xJqqwa5wcrLrw7HgK
         dG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MOb5E7ReyO7cniK0URV+jpDF2iMWhXYuuSt7FY8mKTQ=;
        b=FT0TIfc+oZHJRhBKK7MRWkVtjvdkiI4BQWHX8082KdurQpTM6yoQy/Cy48LJ0cwLOD
         wx5wzJLNOgv6Rjn0QxBptVSRvIyZiPjJjzG2Gb+TGncbWKpI1UbyJcyCqQgnTW9i3mdS
         ZOJlfav4owX5ErwbJ81z1bzKwPnGJyKBLhy0qkYbqJIJH7I2TorFC8aaM+bip0yzfrdC
         5qO8kEzKXvaqihOiG88t+JPuJ6xQCQbjsgn9xJd74kYP+T8VMACJt6HWH+2Sb3XR5Vj+
         ekaNtFT0DaWtEhHxRz+C4/CFsQcmxUWyVWnNwP+SC5pEQ8USfrnKXxDf31lZgBL+IidW
         8uGg==
X-Gm-Message-State: AOAM531JwJeTnPGaRZwOvIIvjSoMGJZKVpizL59ddwi88aVjy+1azQUJ
        VkInc0iaN64jSTfGbVvKOV3jLg==
X-Google-Smtp-Source: ABdhPJxEgaPKRV8ImkrlO7f4zlF88I74iKBj5tEgkwQAwRZRwTGHI29w0sy/njhQSBsgejdH6mrvOw==
X-Received: by 2002:a05:6a00:2310:: with SMTP id h16mr10784788pfh.80.1644553862239;
        Thu, 10 Feb 2022 20:31:02 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id d20sm25427851pfv.74.2022.02.10.20.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 20:31:01 -0800 (PST)
Date:   Fri, 11 Feb 2022 10:00:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 17/49] cpufreq: replace cpumask_weight with cpumask_empty
 where appropriate
Message-ID: <20220211043057.t6ukpdtakcht3frc@vireshk-i7>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-18-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-18-yury.norov@gmail.com>
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

On 10-02-22, 14:49, Yury Norov wrote:
> drivers/cpufreq calls cpumask_weight() to check if any bit of a given
> cpumask is set. We can do it more efficiently with cpumask_empty() because
> cpumask_empty() stops traversing the cpumask as soon as it finds first set
> bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for SCMI cpufreq driver)
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  drivers/cpufreq/scmi-cpufreq.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I already applied it yesterday and replied to you as well. Did I miss
something ?

-- 
viresh
