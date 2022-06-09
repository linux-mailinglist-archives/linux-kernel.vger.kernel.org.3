Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3C544E22
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbiFINy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbiFINyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7217908D;
        Thu,  9 Jun 2022 06:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA2161D6D;
        Thu,  9 Jun 2022 13:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF7C34114;
        Thu,  9 Jun 2022 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654782858;
        bh=EqK3l8EhZM8vr8CZoAbl3TZw+eC3UTreMJMI61a6pu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nu066p8wi8D0b/W+KtAIMZXEqf8T5so/ZpPARpp2F80qtM8hICLFVIgHQFkZ6BnDU
         t5Neeq1Qhx6wQjAPHmQ+nUQqPt8y+RGBiiu+lSmynWCOcFRGvfGsiNjviJ2veJmhyz
         EW2jUoonxInuUbEktvsPb844zUPaQl4vyrpk7Lg7o0s7jJ45/OjKVakLMMxPW1NzLF
         37g/d8NyLdPYnQp5Mpr/bQP0rcovdbrKay5aAtNarjj6kIjIqSvTM47G5pTtgfLOYc
         Dl+R6HHCMTebu5wxbkSEOaLfKXW92LbHmNYnfIDhu4P6Xrw2vJrebP4rb8KV8y7xkp
         GwOtLKhonzk1w==
Date:   Thu, 9 Jun 2022 14:54:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?iso-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RISC-V PMU DRIVERS" <linux-riscv@lists.infradead.org>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] RISC-V: Support CPUID for risc-v in perf
Message-ID: <20220609135411.GB3064@willie-the-truck>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
 <20220607131648.29439-3-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607131648.29439-3-nikita.shubin@maquefel.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:16:45PM +0300, Nikita Shubin wrote:
> From: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> 
> This patch creates the header.c file for the risc-v architecture and introduces support for
> PMU identification through sysfs.
> It is now possible to configure pmu-events in risc-v.
> 
> Depends on patch [1], that introduces the id sysfs file.
> 
> Signed-off-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> [Nikita: replaced soc:pmu to riscv-pmu/id]
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> Tested-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> v2->v3:
> - Change 'soc/soc:pmu/id' to 'riscv-pmu/id'
> ---
>  drivers/perf/riscv_pmu.c            | 18 ++++++++
>  tools/perf/arch/riscv/util/Build    |  1 +
>  tools/perf/arch/riscv/util/header.c | 66 +++++++++++++++++++++++++++++

You will need to separate out the kernel changes from the tooling changes in
order to get this merged.

Thanks,

Will
