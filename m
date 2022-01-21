Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C7495F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380430AbiAUMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350560AbiAUMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:42:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A75C061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:42:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso293017wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbauWvjEFr0VEys9tznLWPTDHaU2uug5P4EDNWbJ8+E=;
        b=uoPJ8mn9Kan1V+k3BDZDa7RTh/3CLdpRfMvVa7WsJ/gKSaS8pvkj5NERpKxKYq5GPz
         3mx5xTgJyma8/Ei4cpOGwy6BbvmD9lRqGLiyNJiBT8Kqxbjr26bM8058UvKMiFlNhQLA
         UlEM4cLyLjyIxUzHjwt5IM37pvGKvDt2SQw8m2Twh6MuwGQhhI5CPDdhyBRj8gEEkQeh
         7FGYa11oLjNOK19Yso7Ha8I9sK4eoaK9Qvuz2RBuDXW9wDhe2L6xgZSzO+gFDNXgA0ru
         /Yu7Ft9nMIkwk7QKYbKt9BMZBtLLQ4266yGPeTvUjAihNy5Vt9TjYDfCNcYmCjMaL4QX
         HNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbauWvjEFr0VEys9tznLWPTDHaU2uug5P4EDNWbJ8+E=;
        b=kAwgaoS9QO+7PoKgWUe8y8zXVSzIdYNwyuBqq7uBw8nrFOBgaENlFatlLzkm7csFOj
         IA5914NoSYYuaPEAH7lR3Iofox6xrqZaNKkSGlpBvCQFfqDYxOABONGoNP7epdvg/9Oy
         2mYFvaZBqe2oU11Djck4em/kdCUUF3pncVWF25wgtef7PP4ieinf1XwM8spN8ocJX5p8
         D67iOAPuS2DEME2bd40noFeSTLGWB1wMjvr3SlucktmAIE4ry0wWvZVX3aEcqVhMwjtX
         Z73yJBUxoZ574mO0QAbAw8lj//npko/7l3VKhg4GumMyaNyInXY9xlngGKezrnNxCFRU
         ONvw==
X-Gm-Message-State: AOAM532fB3lyspeHvZgB/8vRek0G/qkmjRuBYQ56RaCBWN0nuSNbKtQQ
        gUO/JKhMMXWUcPEtRQXG9NJ7Leq8llIRHe2AdDrMPQ==
X-Google-Smtp-Source: ABdhPJzLeZ7R7NMebRJM4vVfNZ690JvgI0zhKpWeLaP9Flzk3MULTYtYTkX5Voxns4JCqEDfY804I3cDD+Zgel9ktWE=
X-Received: by 2002:a05:6000:1c1e:: with SMTP id ba30mr3898662wrb.699.1642768964790;
 Fri, 21 Jan 2022 04:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-3-james.clark@arm.com>
In-Reply-To: <20220113091056.1297982-3-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 21 Jan 2022 12:42:34 +0000
Message-ID: <CAJ9a7ViuON11QZRhejcmCM3KOkWx-i0NZw_Kh-2m1Ps0bop2xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] coresight: Fail to open with return stacks if they
 are unavailable
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>

On Thu, 13 Jan 2022 at 09:11, James Clark <james.clark@arm.com> wrote:
>
> Maintain consistency with the other options by failing to open when they
> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
> requested but not supported by hardware.
>
> The consequence of not doing this is that the user may not be
> aware that they are not enabling the feature as it is silently disabled.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 04669ecc0efa..a93c1a5fe045 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>         }
>
>         /* return stack - enable if selected and supported */
> -       if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
> -               /* bit[12], Return stack enable bit */
> -               config->cfg |= BIT(12);
> -
> +       if (attr->config & BIT(ETM_OPT_RETSTK)) {
> +               if (!drvdata->retstack) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               } else {
> +                       /* bit[12], Return stack enable bit */
> +                       config->cfg |= BIT(12);
> +               }
> +       }
>         /*
>          * Set any selected configuration and preset.
>          *
> --
> 2.28.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
