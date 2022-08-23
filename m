Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A351559EC25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiHWTWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiHWTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:21:52 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED2B4425;
        Tue, 23 Aug 2022 11:02:26 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-335624d1e26so400762497b3.4;
        Tue, 23 Aug 2022 11:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tPcD7EUnD6n/pd4xrlexLo0BVKkP6oVxoQ1jP9+QRfY=;
        b=dq9+DvYQEAGYeySAObrB8Sm77zs6J7I6OSPa27SGS/yS4RAYbRed2bRDS/7d+jegoq
         qe1H8p1ZNBguBnZvjfS+acDWhra3fZGYhwidlnImLGYfRoJZwk+f0De5rXoZGDY8Wx0i
         a393wIDbJYrM/zbh4V+G0KiFUptIpbl3rXDP4wqyQOLb9ExSfVqHB4/9r1wv4RImmWSo
         H/VshsFStlMxDMoZIQOIlbkb++zZ1aV8yB78GhKyKBCsAFqlYsYvHC6hDeVqZX4hw0Xp
         nJU6PfbMTHx7TRU0LsQccUXw1SO6pcPn+Uu2WGOhmxgXctem/yeeOVg5KmHJRhU82H81
         8tEA==
X-Gm-Message-State: ACgBeo2NMY4ZDm/8g1T+j6IGYMLzx3E6CL9XfHXZhW+leZwWQ0EYTS7k
        2lUNxtVUiVqHOF2CLNtErm7oN2fT0MerfNILOuI=
X-Google-Smtp-Source: AA6agR5itvcF2Towl5AH63xFZtsUG0OaVdX2gTPo9+tM4SABhEni3hBBXSHi+BCwk1FN1PKjRJ+1exKhcsqOiQuDcYI=
X-Received: by 2002:a25:ec0c:0:b0:690:d092:2d56 with SMTP id
 j12-20020a25ec0c000000b00690d0922d56mr23726786ybh.622.1661277745810; Tue, 23
 Aug 2022 11:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220816120157.24455-1-lukasz.luba@arm.com>
In-Reply-To: <20220816120157.24455-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 20:02:14 +0200
Message-ID: <CAJZ5v0jQpEL7SMjj83fbm-Afz7D7Wj41g5AFa2-8zoeehnRppg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: check only freq_table in __resolve_freq()
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 2:02 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> There is no need to check if the cpufreq driver implements callback
> cpufreq_driver::target_index. The logic in the __resolve_freq uses
> the frequency table available in the policy. It doesn't matter if the
> driver provides 'target_index' or 'target' callback. It just has to
> populate the 'policy->freq_table'.
>
> Thus, check only frequency table during the frequency resolving call.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Changes:
> v2:
> - collected ACK from Viresh
> - corrected patch description (Viresh)
>
>
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7820c4e74289..69b3d61852ac 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -532,7 +532,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
>
> -       if (!cpufreq_driver->target_index)
> +       if (!policy->freq_table)
>                 return target_freq;
>
>         idx = cpufreq_frequency_table_target(policy, target_freq, relation);
> --

Applied as 6.0-rc material, thanks!
