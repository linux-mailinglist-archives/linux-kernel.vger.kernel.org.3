Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5AA513131
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiD1KZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiD1KZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:25:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802C61EEEF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38F0FB82C74
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3FCC385A0;
        Thu, 28 Apr 2022 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651141321;
        bh=T43eOhfkYAIAzcaX7ZyWux1tIjqtySnRoASDc6wbkZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F996I4S4t1o/qpGlQMeoCI18EdMkugEGUVE4eT4lWEJ31c7fc3fX6Kiux04EkDOli
         IzjnWkzVMb18Paq1hS2Z+LhwCupL6tBQkupyd9Sk7Q4ZkF4o/a/7LNfHyDuuEPJDmb
         8pPTy2w84iMooyZdbzZGm4kszMKvplvocuDBWbkNflh5elHlKywCHKDh5WTRiWO8IJ
         9mP4ogrY3YFd6N5SvbhvKeWCq8Xza9M8fvQHLAGu3PRtuzfN3PArKZMlZIVLz/yCi6
         m6LhJtVZu+8MTDNhX5LLG19OFf2tnfhk4sf6ml2HBwLIWDKCjxidv62Xhsrw+mX7kv
         oXHMcAJ45SKFA==
Date:   Thu, 28 Apr 2022 11:21:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2] arm64: add the printing of tpidr_elx in __show_regs()
Message-ID: <20220428102156.GA14123@willie-the-truck>
References: <20220316062408.1113-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316062408.1113-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 02:24:08PM +0800, Zhen Lei wrote:
> Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
> using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
> tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
> pcpu access. However, when performing reverse execution based on the
> registers and the memory contents in kdump, this information is sometimes
> required if there is a pcpu access.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/kernel/process.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> v1 --> v2:
> Directly print the tpidr_elx register of the current exception level.
> Avoid coupling with the implementation of 'my_cpu_offset'.
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5369e649fa79ff8..738932e6fa4e947 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -216,6 +216,17 @@ void __show_regs(struct pt_regs *regs)
>  	show_regs_print_info(KERN_DEFAULT);
>  	print_pstate(regs);
>  
> +	switch (read_sysreg(CurrentEL)) {

This should use is_kernel_in_hyp_mode() to detect if we're running at El2.

> +	case CurrentEL_EL1:
> +		printk("tpidr_el1 : %016llx\n", read_sysreg(TPIDR_EL1));
> +		break;
> +	case CurrentEL_EL2:
> +		printk("tpidr_el2 : %016llx\n", read_sysreg(TPIDR_EL2));
> +		break;
> +	default:
> +		break;
> +	}

I think this path can be triggered directly from usermode, so we really
shouldn't be printing raw kernel virtual addresses here.

Will
