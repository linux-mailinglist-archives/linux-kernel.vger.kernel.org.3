Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAB563264
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiGALRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiGALRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:17:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D9E38DA3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39710B82CEF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95393C3411E;
        Fri,  1 Jul 2022 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656674227;
        bh=nHu0ElrLXx8qkNrtLKo6/SodmCcmwAbd6i/rONrG0i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dI65g5VZNhEYnslFvcbgfHVrl5cQ8nndqBpreT83lFNydq2BCmovJwkZTFKaHV2i6
         Sp00emQaSVXMXH5jI/ri+yEBbiwlOcVYux9XXo4EYvPbZW4uzZJcFfgfLkKc6tPpgN
         D8OBMJoNReSXvoxtMnff0bU9fTxRMJZNojO34gvYpsW9kE/TaiZEUZvRR1MN7XJka5
         o6F+iOQLRk8jEcS9CeQNZXsLhIXUE2lhiTy3qKoDxcmPkvbpT8wrdpmiwYhmtz7/ca
         I9y56WZojJOyDgWqCQzF8oMsLGQUKxoHMlIlAYtCy4aLzC4QN7sqEV51gWcvSA1Uw+
         2ErncFjyBZcKw==
Date:   Fri, 1 Jul 2022 12:17:02 +0100
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= 
        <haibinzhang@tencent.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: fix oops in concurrently setting insn_emulation
 sysctls
Message-ID: <20220701111702.GA28070@willie-the-truck>
References: <6C55A58E-6F30-4EDD-B943-421226DBC4AD@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C55A58E-6F30-4EDD-B943-421226DBC4AD@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 02:27:17AM +0000, haibinzhang(张海斌) wrote:
> How to reproduce:
>     launch two shell executions:
>        #!/bin/bash
>        while [ 1 ];
>        do
>            echo 1 > /proc/sys/abi/swp
>        done
> 
> Oops info:
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
>     Internal error: Oops: 96000006 [#1] SMP
>     Call trace:
>     update_insn_emulation_mode+0xc0/0x148
>     emulation_proc_handler+0x64/0xb8
>     proc_sys_call_handler+0x9c/0xf8
>     proc_sys_write+0x18/0x20
>     __vfs_write+0x20/0x48
>     vfs_write+0xe4/0x1d0
>     ksys_write+0x70/0xf8
>     __arm64_sys_write+0x20/0x28
>     el0_svc_common.constprop.0+0x7c/0x1c0
>     el0_svc_handler+0x2c/0xa0
>     el0_svc+0x8/0x200
> 
> emulation_proc_handler changes table->data for proc_dointvec_minmax
> and so it isn't allowed to reenter before restoring table->data,
> which isn't right now.
> To fix this issue, Add mutal exclusion covering related code section.

typo: mutual

> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
> ---
>  arch/arm64/kernel/armv8_deprecated.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 6875a16..c519792 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -207,8 +207,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>  				  loff_t *ppos)
>  {
>  	int ret = 0;
> -	struct insn_emulation *insn = (struct insn_emulation *) table->data;
> -	enum insn_emulation_mode prev_mode = insn->current_mode;
> +	struct insn_emulation *insn;
> +	enum insn_emulation_mode prev_mode;
> +
> +	raw_spin_lock(&insn_emulation_lock);
> +	insn = (struct insn_emulation *) table->data;
> +	prev_mode = insn->current_mode;
>  
>  	table->data = &insn->current_mode;
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> @@ -224,6 +228,7 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>  	}
>  ret:
>  	table->data = insn;
> +	raw_spin_unlock(&insn_emulation_lock);
>  	return ret;

This looks very similar to the patch previously posted here:

https://lore.kernel.org/r/20220128090324.2727688-1-hewenliang4@huawei.com

but Catalin's suggestion was ignored:

https://lore.kernel.org/all/Yf0dxon1d07rzxZH@arm.com/

Please can have you send a v2 along the line that he suggested?

I also think a mutex is probably better than a spinlock given that we
can end up cross-calling in the proc handler.

Thanks,

Will
