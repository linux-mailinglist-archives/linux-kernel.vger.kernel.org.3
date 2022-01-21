Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684A8495F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380486AbiAUMpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380494AbiAUMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:44:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ED3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:44:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso28809578wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPQjdtK4pXoEDJ51K+ZcxZTPO84Dqge8Jmq/wEYY82I=;
        b=YOn+JJpaTq4eYiycePZ7qnAtcezSFmqZfjSUg+PQ8EExDCxkuoxpNrt+J6+bmx6RFr
         hhPSiNtKvghUg8lFwRVuSTrdy4o4Zh5Pbu3otC6JszaRZKLGMAJOJCmWFyzAij7kKSMP
         jn1GJtBgwbAExJ0ehEJ1qfdvaZ8vT/0BrcSvWkI0S6fntkcIj6e9P2zYM4WkatFO8XIZ
         bq2fPYT7g4guGDiSEUglon4PA8gHiz1bAhUJw8SjPOFox0jmpEvF3UUjLXFByeDKcFiZ
         VxwHeY1WRa1r4pMX6mIFORD8eXi+2dzqe+MwuNrzY9ucgeXicF5v2rcPPxw8VlvYuJu/
         NsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPQjdtK4pXoEDJ51K+ZcxZTPO84Dqge8Jmq/wEYY82I=;
        b=qzCwrcAmb5PpI1lfvU0dXE8qg2kvQYt+P1OENWqK84hLXufaQnAvLq8hnQQxr/O6rf
         qRmvFOF/85af09SsGLNTSaL3j49D+TABYqiROXYZv835Tai668qvBJxGxJrWtXU3i0pO
         1V9JaRbNQhKpufiIq3j145XBz/i1wf6SF6I9yl2e1ThKKOL6tOqG34WMGmaSh0frrx97
         EKZ1zxnLypUVtZRq9/xLZk3q/XbFFQyBVbBf8FAUrATJdOgdEL6lgQaEnhPF2wyX87tC
         6PwlFGYXPL/ru61vafivJVB2WRTa0F47p/32AUCeA6MlIrIHJgSzJY5qs/M23mPLqMdW
         fWJQ==
X-Gm-Message-State: AOAM531n8yY/25PXcvdwpyZ17MAlJxq/dGckDoIHIYiN/kGS/KDARo1Z
        nQrgYWkKeNKDRtygKJ+8KCUueaKWjSntKICtrPH+eA==
X-Google-Smtp-Source: ABdhPJz4QOjqVkZxNGF7KOwGwgPMHWlelSBELk2kW26iBm4WwgkvOXimF67qWWx4a11KNN8oUewr3BjwQ9LjfmEwKEg=
X-Received: by 2002:adf:df84:: with SMTP id z4mr3699794wrl.519.1642769088620;
 Fri, 21 Jan 2022 04:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-4-james.clark@arm.com>
In-Reply-To: <20220113091056.1297982-4-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 21 Jan 2022 12:44:37 +0000
Message-ID: <CAJ9a7ViKA_vHd8WOfoxnHrjS4Cx7R9-G28VHMK7e03c+8vZ8Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] perf cs-etm: Update deduction of TRCCONFIGR
 register for branch broadcast
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

On Thu, 13 Jan 2022 at 09:11, James Clark <james.clark@arm.com> wrote:
>
> Now that a config flag for branch broadcast has been added, take it into
> account when trying to deduce what the driver would have programmed the
> TRCCONFIGR register to.
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/include/linux/coresight-pmu.h | 2 ++
>  tools/perf/arch/arm/util/cs-etm.c   | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 4ac5c081af93..6c2fd6cc5a98 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -18,6 +18,7 @@
>   * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>   * directly use below macros as config bits.
>   */
> +#define ETM_OPT_BRANCH_BROADCAST 8
>  #define ETM_OPT_CYCACC         12
>  #define ETM_OPT_CTXTID         14
>  #define ETM_OPT_CTXTID2                15
> @@ -25,6 +26,7 @@
>  #define ETM_OPT_RETSTK         29
>
>  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> +#define ETM4_CFG_BIT_BB         3
>  #define ETM4_CFG_BIT_CYCACC    4
>  #define ETM4_CFG_BIT_CTXTID    6
>  #define ETM4_CFG_BIT_VMID      7
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 293a23bf8be3..c7ef4e9b4a3a 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -527,6 +527,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
>         if (config_opts & BIT(ETM_OPT_CTXTID2))
>                 config |= BIT(ETM4_CFG_BIT_VMID) |
>                           BIT(ETM4_CFG_BIT_VMID_OPT);
> +       if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
> +               config |= BIT(ETM4_CFG_BIT_BB);
> +
>         return config;
>  }
>
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
