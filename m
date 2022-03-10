Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040CA4D488D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbiCJOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiCJOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:05:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FA514FFE9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D455A61B41
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF40DC340F3;
        Thu, 10 Mar 2022 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646921069;
        bh=4QAFdOcbM6HfxA2VpiB4rxhMzT878FQSxt8Fb2E3d70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=REDpicKX+Qj9tTtI2+mvNhDtinFX/CmjbSyfKWjYghAg+/1p1nPzi1sSM6iwKKjhy
         kxTRdGbUcla1vCM3ZKEMpzlsGO9TT2aD5ssaITXtEfhzA5bi5DHBuEChj5S7i7Voh6
         5D/qHENSUepTnRJa6I++x5YuG9ColNKlp5YzrIT1zmnZAhVggOAcMepgKaBANDBcbE
         CbVbNwwTx2kWXfI5v8cONssIXWfdHr2kUtMfvh/qDkEi6D3uImvQvWG8z4kxpsGTC9
         klPFIf7U9QPt+rA99U7WFEEslP7M67ssNyfK3mqFpFfCBMs0uHOvwySQM7SKA3EKFV
         iGAxjjvv7ikTA==
Date:   Thu, 10 Mar 2022 23:04:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <peterz@infradead.org>, <tglx@linutronix.de>,
        <alexandre.chartre@oracle.com>, <mhiramat@kernel.org>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <laijs@linux.alibaba.com>,
        <chang.seok.bae@intel.com>, <fenghua.yu@intel.com>,
        <thomas.tai@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/traps: Mark do_int3() NOKPROBE_SYMBOL
Message-Id: <20220310230424.b1f3ad6987d5aafc8b339e98@kernel.org>
In-Reply-To: <20220310120915.63349-1-lihuafei1@huawei.com>
References: <20220310120915.63349-1-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 20:09:15 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> Since kprobe_int3_handler() is called in do_int3(), probing do_int3()
> can cause a breakpoint recursion and crash the kernel. Therefore,
> do_int3() should be marked as NOKPROBE_SYMBOL.
> 
> Fixes: 21e28290b317 ("x86/traps: Split int3 handler up")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Good catch!
This should be backported to stable kernel.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org


Thank you,

> ---
>  arch/x86/kernel/traps.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c9d566dcf89a..8143693a7ea6 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -659,6 +659,7 @@ static bool do_int3(struct pt_regs *regs)
>  
>  	return res == NOTIFY_STOP;
>  }
> +NOKPROBE_SYMBOL(do_int3);
>  
>  static void do_int3_user(struct pt_regs *regs)
>  {
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
