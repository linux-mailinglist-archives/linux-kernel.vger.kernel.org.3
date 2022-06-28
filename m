Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7108E55DC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbiF1K2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbiF1K2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:28:19 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF751CB18
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:28:18 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i15so21521046ybp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tr8hNJ5eGXGi4MzVwC12AfLwt6PrO5SxdG32nN7sPTs=;
        b=DGI2+bQiZLRn7rOb21b70S3FwW5tLVuBbW1gU/KvN5VsrzkyQRAJKYRqO+5v/wyKLv
         SMPsnPa5AS5TofF80RGOdathylRq17vYNqTSKeFqG/wpo9IxO7Ra6A3OXIRf8WTAXFXG
         kfcJoq0WNCTSw+gHySXvUnAOGBybi9F/QGTDXbDI3nOKbJK9R11vuUDsYHmyGnpnbZ6s
         7kv4vHsU7Ll9Aa7Xrk0nVtCTeVYc01+UH9PCt0Fm6En6jMiI/DevzD2JHyytHDdSnTka
         CT6F7659sEP10CEDPUiAe3fzfVFjegKShwTBtgYlstEGfd4pZ73Ak11hOSc4zS7HBsUf
         DNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tr8hNJ5eGXGi4MzVwC12AfLwt6PrO5SxdG32nN7sPTs=;
        b=v7mCmNXbQhX8m/XyNXiRPSJDSXebvUAgefegyA7NsxNxo/FnbIL/VkFfRdrSE95Y8p
         r5UBv3KRacsQOo7/aFBpbtPsbUswhk1rpfs0s18FLGih9FpDy+qzGStzj5HSfGWE4SDV
         gxRCJ9Ue1us5PkrzA+/NJnBIauxu5cvypVbzvOkgCTHmeoIKJlsqDLQMr/ld77hjJFor
         XAOsj/D5scWE1K0/4wdmXzKRppApTFLP93uwB/iWQhmO9lUO364zCuJ96pcd3D+l+eTd
         i71Tp83X80L6B6TU3VXy/UTpT4sb3aLS8yf8fciMBte2IDjkq2Tz4H7x3fuFwTM2SlU4
         HIpw==
X-Gm-Message-State: AJIora8GHaJbM5wR+FfTl6TcI0Y3Z+eiK1IrsROS8M+NkJh12COhKKZd
        jldW1ssLSfOi8/24io3eAcbyGwktNxiiHVtEvI3K8A==
X-Google-Smtp-Source: AGRyM1tyhQmIiBjffMOtzfYHHShHgpDSi1VYIPKvp76WScOPCV1jQFvsODs545vwIDZGE+tg+nLGwWDvjgZ0IJ4tq0o=
X-Received: by 2002:a25:e695:0:b0:66c:faea:ca55 with SMTP id
 d143-20020a25e695000000b0066cfaeaca55mr7128367ybh.300.1656412098004; Tue, 28
 Jun 2022 03:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220627165047.336669-1-sudeep.holla@arm.com> <20220627165047.336669-17-sudeep.holla@arm.com>
In-Reply-To: <20220627165047.336669-17-sudeep.holla@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 28 Jun 2022 12:28:05 +0200
Message-ID: <CAKfTPtAxNKV=L0DHuBGmBiUww5tDhyAiw-6N3cun11iQLALYHA@mail.gmail.com>
Subject: Re: [PATCH v5 16/19] arch_topology: Limit span of cpu_clustergroup_mask()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 at 18:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> From: Ionela Voinescu <ionela.voinescu@arm.com>
>
> Currently the cluster identifier is not set on DT based platforms.
> The reset or default value is -1 for all the CPUs. Once we assign the
> cluster identifier values correctly, the cluster_sibling mask will be
> populated and returned by cpu_clustergroup_mask() to contribute in the
> creation of the CLS scheduling domain level, if SCHED_CLUSTER is
> enabled.
>
> To avoid topologies that will result in questionable or incorrect
> scheduling domains, impose restrictions regarding the span of clusters,
> as presented to scheduling domains building code: cluster_sibling should
> not span more or the same CPUs as cpu_coregroup_mask().
>
> This is needed in order to obtain a strict separation between the MC and
> CLS levels, and maintain the same domains for existing platforms in
> the presence of CONFIG_SCHED_CLUSTER, where the new cluster information
> is redundant and irrelevant for the scheduler.
>
> While previously the scheduling domain builder code would have removed MC
> as redundant and kept CLS if SCHED_CLUSTER was enabled and the
> cpu_coregroup_mask() and cpu_clustergroup_mask() spanned the same CPUs,
> now CLS will be removed and MC kept.
>
> Link: https://lore.kernel.org/r/20220621192034.3332546-18-sudeep.holla@arm.com
> Cc: Darren Hart <darren@os.amperecomputing.com>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 46fa1b70b02b..277b65cf3306 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -686,6 +686,14 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>
>  const struct cpumask *cpu_clustergroup_mask(int cpu)
>  {
> +       /*
> +        * Forbid cpu_clustergroup_mask() to span more or the same CPUs as
> +        * cpu_coregroup_mask().
> +        */
> +       if (cpumask_subset(cpu_coregroup_mask(cpu),
> +                          &cpu_topology[cpu].cluster_sibling))
> +               return get_cpu_mask(cpu);

AFAICT, this will change the Altra scheduling topology which will now
have a MC level instead of the CLS but it's probably not a problem as
the flags are the same for now

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> +
>         return &cpu_topology[cpu].cluster_sibling;
>  }
>
> --
> 2.36.1
>
