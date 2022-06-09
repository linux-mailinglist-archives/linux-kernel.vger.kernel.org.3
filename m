Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60694545092
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbiFIPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiFIPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F520F6B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 186DA61E11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C823C3411B;
        Thu,  9 Jun 2022 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654788008;
        bh=fBki9nO6xq1gqJlRzYx6W6ZH8oFXBaFxwwteOEGxAwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKMssPoBaSxYbTDnpkbJxcD5hXLG3SLBoRT0Uw1r+Jtw3Bsmo2O9TgWckgMz2ApM1
         4Vg+rtmeTsg5xsA+71R3ReTP2VEtG6ILnd/LCxxjlgoivpflo7w0FFXm7qMaT+ApH6
         4/KTOQs4TWpZdRS1TbA6fzaBFZKftMwTJOjDIBboDygODUD/e1cb1azkFzx7qkFSB3
         WrIDjAnG82wXQhN33/bYrEekqrLJPxLxxlhQyArVaLLK/KnnWi9fjcQkvTohYicQhf
         FTHc0fWQXbGJEBv6nUu7jBLHdAa0CdC93G0Ib+vMvshzbJl8ktszbe1Cx+ArvsoxO0
         FXe3PANAfLKDw==
Date:   Thu, 9 Jun 2022 16:20:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, xuqiang36@huawei.com
Subject: Re: [PATCH] arm64/smp: check !ipi_desc[i] in arch_show_interrupts
Message-ID: <20220609152003.GC3289@willie-the-truck>
References: <20220527082236.78037-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527082236.78037-1-chenjun102@huawei.com>
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

On Fri, May 27, 2022 at 08:22:36AM +0000, Chen Jun wrote:
> There is a potential dereferencing null pointer issue in
> arch_show_interrupts.
> 
> Problem 1:
> int arch_show_interrupts(struct seq_file *p, int prec)
>         for (i = 0; i < NR_IPI; i++) {
>                 seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i],
> 			cpu));
> 
> Only ipi_desc[0..nr_ipi - 1] are initialized in set_smp_ipi_range.
> and ipi_desc[nr_ipi..NR_IPI] are NULL.
> irq_desc_kstat_cpu will dereference NULL pointer.
> For now, the problem can not be triggered, because NR_IPI is always
> equal to nr_ipi.
> 
> Problem 2:
> If request_percpu_irq failed in set_smp_ipi_range, ipi_desc[i]
> would be NULL.
> irq_desc_kstat_cpu will dereference NULL pointer.
> 
> check !ipi_desc[i] (as arm does) to avoid the problem.
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  arch/arm64/kernel/smp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 62ed361a4376..3d54f464428b 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -781,6 +781,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  	unsigned int cpu, i;
>  
>  	for (i = 0; i < NR_IPI; i++) {
> +		if (!ipi_desc[i])
> +			continue;

Why not just use nr_ipi instead of NR_IPI?

Will
