Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4856A861
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiGGQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiGGQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:37:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164D564D7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:37:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r22so12588972pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tV06X8ZwNG1YBW7qI4+9zEQPn4cces6TNXHqdWyfoC4=;
        b=kbGamTCBrLg0oYMpjTNMko7htfU0e7BF3RC13JW65s78vOyzbUBDgfcuvDxlAskpL0
         4di1UMNwDc9jSx1j6TVrXpaem4bEpE6L9IfQWCoEzjTTb0aE0oawrFPaInrrvOxziQ1y
         FALtax7m1GT5J1rv7Z6NC1vROJ145ws/dnLm/Ih6unMwnkSpBzjrDTa3YKrPnlhPxJG9
         7YGHuMgHV05txyHNaD0HrqgyGa3o1H/uQdl4V89MzBua7O0JgrkGZiKW/iBSwbLD40y4
         sSO4mrAtAWbY4pOkXQFM+QNmnO9ykUIN0oLQUz9w/foNqqC2y0Omgu69TZBgL3+4RU09
         O1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tV06X8ZwNG1YBW7qI4+9zEQPn4cces6TNXHqdWyfoC4=;
        b=nQ1k/592jC6g6KY4MS2k7gjBazZf2VWs/0amR6UilKNU9csZD6qhN8nU7AFx8WzzVh
         yrYTT9D/O1ZtSAVb2RLTAtG1Fk1tD+HkvUKcBW6T0KQx4BcKqzEGStg9h89KI+4/UtYB
         EKfXmv2k14Z54TeyOvKRz3TWJm5eIwAemO1RB7h4gW1swjSnOwSTNGoxSfzQ5hVnED4t
         /KXbhacpltuvTZMvnNs5MG0IuorAOtu3ZOQcl9vvKBDwAic+kwFxajG4v9mzbazHCPKi
         3udOPro8j9ySMUcv1NWkNloWM0DpbLUGTeUXWTys6zbLwJoNQPUsKF0R/7gBLqNBdQwv
         To0w==
X-Gm-Message-State: AJIora9BxZ7rQyv7Nx9tGe9ig70e5d0KVzAzRxwG6CTJUqCgmwu1Dpn0
        1Cn+ibJzBEmBb0Rpc8hcCdvP1g==
X-Google-Smtp-Source: AGRyM1vzAxHVb8A5BM3cUTrB9ok+3+VShZVSqqsL9IGVRhf5PjhVblMcH7rfAoI61MaxE2OBZG+aWg==
X-Received: by 2002:aa7:96da:0:b0:525:1752:85b with SMTP id h26-20020aa796da000000b005251752085bmr53522453pfq.63.1657211825312;
        Thu, 07 Jul 2022 09:37:05 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f126-20020a623884000000b0052891272298sm6048037pfa.120.2022.07.07.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:37:03 -0700 (PDT)
Date:   Thu, 7 Jul 2022 10:37:01 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     suzuki.poulose@arm.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mike.leach@linaro.org, leo.yan@linaro.org
Subject: Re: [RESEND PATCH v3 0/2] perf: ARM CoreSight PMU support
Message-ID: <20220707163701.GA2616901@p14s>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621055035.31766-1-bwicaksono@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will look at this patchset next week.

Thanks,
Mathieu

On Tue, Jun 21, 2022 at 12:50:33AM -0500, Besar Wicaksono wrote:
> Add driver support for ARM CoreSight PMU device and event attributes for NVIDIA
> implementation. The code is based on ARM Coresight PMU architecture and ACPI ARM
> Performance Monitoring Unit table (APMT) specification below:
>  * ARM Coresight PMU:
>         https://developer.arm.com/documentation/ihi0091/latest
>  * APMT: https://developer.arm.com/documentation/den0117/latest
> 
> Notes:
>  * There is a concern on the naming of the PMU device.
>    Currently the driver is probing "arm-coresight-pmu" device, however the APMT
>    spec supports different kinds of CoreSight PMU based implementation. So it is
>    open for discussion if the name can stay or a "generic" name is required.
>    Please see the following thread:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2022-May/740485.html
> 
> The patchset applies on top of
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   master next-20220524
> 
> Changes from v2:
>  * Driver is now probing "arm-system-pmu" device.
>  * Change default PMU naming to "arm_<APMT node type>_pmu".
>  * Add implementor ops to generate custom name.
> Thanks to suzuki.poulose@arm.com for the review comments.
> v2: https://lore.kernel.org/all/20220515163044.50055-1-bwicaksono@nvidia.com/
> 
> Changes from v1:
>  * Remove CPU arch dependency.
>  * Remove 32-bit read/write helper function and just use read/writel.
>  * Add .is_visible into event attribute to filter out cycle counter event.
>  * Update pmiidr matching.
>  * Remove read-modify-write on PMCR since the driver only writes to PMCR.E.
>  * Assign default cycle event outside the 32-bit PMEVTYPER range.
>  * Rework the active event and used counter tracking.
> Thanks to robin.murphy@arm.com for the review comments.
> v1: https://lore.kernel.org/all/20220509002810.12412-1-bwicaksono@nvidia.com/
> 
> Besar Wicaksono (2):
>   perf: coresight_pmu: Add support for ARM CoreSight PMU driver
>   perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
> 
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/perf/Kconfig                          |    2 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/coresight_pmu/Kconfig            |   11 +
>  drivers/perf/coresight_pmu/Makefile           |    7 +
>  .../perf/coresight_pmu/arm_coresight_pmu.c    | 1316 +++++++++++++++++
>  .../perf/coresight_pmu/arm_coresight_pmu.h    |  177 +++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  312 ++++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
>  9 files changed, 1844 insertions(+)
>  create mode 100644 drivers/perf/coresight_pmu/Kconfig
>  create mode 100644 drivers/perf/coresight_pmu/Makefile
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h
> 
> 
> base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
> -- 
> 2.17.1
> 
