Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36C446615F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356937AbhLBKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbhLBKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:25:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6113C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:22:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so37729543wrw.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e2CI3s+qc3l0KIfBWaOSCWRJ87QQ1SRqvUo2BVvjmHQ=;
        b=upIXAYbG3/iaLyoXO2Im9gJtusVYVjH2ZpBvbS7wdC6co3rmb4A2CSOP5DK7CdbPSZ
         l2oqIBBhwc0xLaPtw2qigD+KWar+7DPhgXEvB0t0yOL9hX9PHJFUAzCJuzMLQOwYn4Jj
         /Ls4zzkAPFMX65LliElRVUjT54eAqKTYUxR1thvH+POS8SQGf7NxCpDTb+RD4X8WJsjY
         j7miC3gIz0VDCp8Ph7FFMSWatDPY14HeIt+9NvO6B3+hEH/XWbFs3KxDBpsRnkOtTpEU
         ywWubvvzXr+n0gpRQO+vZXnq6aaAlV+0erYoa2mKe5sVYqOH5AofQpInHSneey67n3cR
         CXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e2CI3s+qc3l0KIfBWaOSCWRJ87QQ1SRqvUo2BVvjmHQ=;
        b=kwyjdWwSST+L7LHCn9eN8sXtPeUVPnmZFoHbyxsM6OvYa9BqapzIVVOhZuRTTzy3q6
         GuwSS8nof63FGadMtH45qJTMgV3tLSTrdUSY1/u48vEbLooo5JV2rkd8GXAxPyDerOdv
         2qDK1ZKz1ej6VD1On4EHwlcC63wyY7DKk+bw/Pv7xb8Kq0L+it5nxSCzx9rEhqGuarN8
         px43cFWFlLRSDAlbizP7TjRWZleWiUhWQeF8o/vDBVppjlvVJkDXRFIeCPM8252nUzDd
         7J1u2K15fyYrp+EM9ST6fyZJFVRs3Rp0GxD1mVVffMv/ZTPnh/4l3K4WmoCWSoBBB49G
         uEDA==
X-Gm-Message-State: AOAM531OkSWmDrxpLt923u5tyMVXpZf++rOu0iqPFxrxzOu+SiOXgOmA
        tyMldHcGhT2rVmjUWRgBqRvipA==
X-Google-Smtp-Source: ABdhPJx1SKD6YvDp85QSxzRBRb+Q8ouDEm+WIW36C1XVsx6W7DTO4SNM0Z6q+zY/U815jKycPsrzIg==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr12763604wrn.448.1638440537248;
        Thu, 02 Dec 2021 02:22:17 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:72d0:52a1:d4ea:f564? ([2a01:e34:ed2f:f020:72d0:52a1:d4ea:f564])
        by smtp.googlemail.com with ESMTPSA id az4sm1741476wmb.20.2021.12.02.02.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 02:22:16 -0800 (PST)
Subject: Re: [PATCH 2/2] clocksource: timer-imx-sysctr: set cpumask to
 cpu_possible_mask
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, tglx@linutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
 <20211201125030.2307746-2-peng.fan@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <80578aa9-35dd-02ca-fb07-5895991572e2@linaro.org>
Date:   Thu, 2 Dec 2021 11:22:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201125030.2307746-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 13:50, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Actually we have CLOCK_EVT_FEAT_DYNIRQ, the irq affinity will be runtime
> changed and no issue. But the system counter timer is not tied to CPU0,
> so use cpu_possible_mask here.

Did you mean:

"There is no reason to tie the system counter timer to CPU0, change its
affinity to cpu_possible_mask.

Moreover, the timer has the flag CLOCK_EVT_FEAT_DYNIRQ set, changing to
cpu_possibl_mask will reduce the number of wakeups related to the system
timer"

?

Note you may want to explain why 'there is no reason'


> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clocksource/timer-imx-sysctr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
> index 2b309af11266..55a8e198d2a1 100644
> --- a/drivers/clocksource/timer-imx-sysctr.c
> +++ b/drivers/clocksource/timer-imx-sysctr.c
> @@ -119,7 +119,7 @@ static struct timer_of to_sysctr = {
>  
>  static void __init sysctr_clockevent_init(void)
>  {
> -	to_sysctr.clkevt.cpumask = cpumask_of(0);
> +	to_sysctr.clkevt.cpumask = cpu_possible_mask;
>  
>  	clockevents_config_and_register(&to_sysctr.clkevt,
>  					timer_of_rate(&to_sysctr),
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
