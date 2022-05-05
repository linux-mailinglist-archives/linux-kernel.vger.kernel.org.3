Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE84D51BD85
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356165AbiEEKzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiEEKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:55:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7059046176
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207E8B82C1E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55A8C385A4;
        Thu,  5 May 2022 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651747916;
        bh=NIJkYKl/hW+WFzyJqjUk1izZjzqY0T3DC7dZmolwU1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzimN9Ge3VB/R86xhqPmOuRufmGrToud2QgXfcvJmwVPxm3sIDpO9GXiDz9EJqHwF
         CX6M9gURGhJLrmA/CJ4lIxj5d7yIyfMircj7xiN+BEbEuahdhLfY3Gsfc1XmDdqoFI
         jEtJUnn62VefteAmYLnea4rVGng10HYQ5EI1HFNKncIhKxTKcmBqps993Z70RGVCvd
         gGZ0cWribMl+Y+b3JsCOIi/pYOkXftmgkygXpMmtFoEsuQDK/2Ek/m7oije0PrRTvg
         Km11MVAchAZGmZfQSeiVio8JFDNC9WGCk7A5k2sch5sy+GuC9JY/LGGSekWx+PLPwX
         WFdkQbot05UBQ==
Date:   Thu, 5 May 2022 11:51:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: add the printing of tpidr_elx in __show_regs()
Message-ID: <20220505105147.GB21596@willie-the-truck>
References: <20220505095640.312-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505095640.312-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:56:40PM +0800, Zhen Lei wrote:
> Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
> using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
> tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
> pcpu access. However, when performing reverse execution based on the
> registers and the memory contents in kdump, this information is sometimes
> required if there is a pcpu access.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/kernel/process.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> v2 --> v3:
> 1) Relace "switch (read_sysreg(CurrentEL))" statement with
>    "if (is_kernel_in_hyp_mode())" statement.
> 2) Change the register name to lowercase.
> 
> v1 --> v2:
> Directly print the tpidr_elx register of the current exception level.
> Avoid coupling with the implementation of 'my_cpu_offset'.
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 7fa97df55e3ad3f..7b6bccce9721c36 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -216,6 +216,11 @@ void __show_regs(struct pt_regs *regs)
>  	show_regs_print_info(KERN_DEFAULT);
>  	print_pstate(regs);
>  
> +	if (is_kernel_in_hyp_mode())
> +		printk("tpidr_el2 : %016llx\n", read_sysreg(tpidr_el2));
> +	else
> +		printk("tpidr_el1 : %016llx\n", read_sysreg(tpidr_el1));
> +

I'd still much prefer if we only printed this information for exceptions
taken in kernel mode. What use is this information for user faults?

We may only store an offset in the register today, but that could easily
change and nobody will come back and fix this code up.

Thanks,

Will
