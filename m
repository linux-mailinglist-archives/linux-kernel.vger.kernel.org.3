Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455A951B8F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiEEHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbiEEHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:32:21 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B148325
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:28:25 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ef5380669cso39167857b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48+VPlemZJQL+qvD7CaffUbdWdX7cgwHukCbmFSwzDA=;
        b=DlDNwa0ZgSuGFaPb9/5V4xdJuzdc1qvt84MDes0CBs0+t3E5jO2bQtLFtvOgOGVpY/
         K3EDNQt/lzJdGsDI2h1TldQhtUIJQXkflCiTjhHmgu7gIFp7yHW3fsp2Hy8uIf+2HBRV
         hoWXI70o7DYT+XVPsNsYYbmiaqG27BxNGD54j5VBu8oR9Bf5oY8ITksM2oLOiBgsP7JK
         4PnpFjptob373B7FmzkOO64UL0fF4fWokILUdrWeQb/9YKAQGLi36glJ1Tcqkox4VwDO
         kH48CKYKvfxteTh4CzEZxOUG6UN3tO4j0xfpWcogcQz0PXcxEY2jA5/ZuqOrYtquWhF0
         bobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48+VPlemZJQL+qvD7CaffUbdWdX7cgwHukCbmFSwzDA=;
        b=6CWVvMW+xDq5nxX7GsuNI5k2pMN9lyRoKoGkaTuGgjWqpWt0OG8prQrCv360bp751b
         eNzK+r7hqu8hncqnmotLwXZhb1XIyHeCjXFsFZ6XpSax3FhZbZR8Ugakc3jVSrKqBMMd
         sa7rvcCFCODW9Za+e4zOeYJK2HdFIg6BOEDKHGuDoY2IFzT1zJJGoepyakymvie2u5V3
         A52qkDEzvIH0H0QoUTb7ubmjkmPpA43FdWAUIPLbEeQ1Zn/lftxyUK/4H0EFiELozCnc
         GONtHK4UsG6M8ZSF7vhW3dkH/kEOG1179fuJE18QWkvMeFh7qQraxJ5P1w0G3zSF1Xvm
         7F5Q==
X-Gm-Message-State: AOAM533E3fO3gRID9xxtTPQ1siMAMn/QFSVp05y33GgYLsyBs+JT9o4y
        Zd9tK9xmz+UpaGW8hRPB2O+a9Z2POxh8QxrLKSV8Z2kfzjQ=
X-Google-Smtp-Source: ABdhPJySMA4IYtf0tSy4AlHAEslsKT1Sgz5FwyhMbz396ZGiZIF5CHRLdSW+QVBf1xsup+mUhFKCXMJ8YCqPwplVMDA=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr21387188ywb.319.1651735705105; Thu, 05
 May 2022 00:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
In-Reply-To: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 May 2022 09:28:13 +0200
Message-ID: <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to mismatch
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 at 10:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> For some platforms, the frequency returned by hardware may be slightly
> different from what is provided in the frequency table. For example,

Do you have more details ?

Do you mean that between 2 consecutives reads you can get either
500Mhz or 499Mhz ?

Or is it a fixed mismatch between the table and the freq returned by HW ?

> hardware may return 499 MHz instead of 500 MHz. In such cases it is
> better to avoid getting into unnecessary frequency updates, as we may
> end up switching policy->cur between the two and sending unnecessary
> pre/post update notifications, etc.
>
> This patch has chosen allows the hardware frequency and table frequency
> to deviate by 1 MHz for now, we may want to increase it a bit later on
> if someone still complains.
>
> Reported-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d58b0f8f3af..233e8af48848 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -28,6 +28,7 @@
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/tick.h>
> +#include <linux/units.h>
>  #include <trace/events/power.h>
>
>  static LIST_HEAD(cpufreq_policy_list);
> @@ -1708,6 +1709,16 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>                 return new_freq;
>
>         if (policy->cur != new_freq) {
> +               /*
> +                * For some platforms, the frequency returned by hardware may be
> +                * slightly different from what is provided in the frequency
> +                * table, for example hardware may return 499 MHz instead of 500
> +                * MHz. In such cases it is better to avoid getting into
> +                * unnecessary frequency updates.
> +                */
> +               if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
> +                       return policy->cur;
> +
>                 cpufreq_out_of_sync(policy, new_freq);
>                 if (update)
>                         schedule_work(&policy->update);
> --
> 2.31.1.272.g89b43f80a514
>
