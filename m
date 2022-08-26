Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1375A3085
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiHZUhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbiHZUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:37:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B8DC7F9C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CmpOKqV7QViVwZMhkMvsB+taaaqNwqLn4k5e1LTQL9c=; b=ZqPSETxiO5qnSNwgKyx0mIUpgA
        EZbwrnXeDW8yIPVJ9xOm/zhd3K5ST+fZunQd0ct4tgb2OmJu1E+p5X0IlF1pfidPO2i0wl1ey9Inl
        VQInHKAvrZzFmfM+XA8LnFSzSAeXUxubREaU4ijPBBcK4Axs7QkSNVpXIo087H6wGsC+orYWgChnR
        bZqcC/HkEu9O9Bm9FZWT6S43sNNVor+Rivh+h1ahd0IOyZOyyCzCFqfv8F9unbNoUeoupGhl+41LD
        6BPlCajD63WtJlzVhEO03lHecIaejMl/yfekquoeTD4hMpccU0n3V0O5Hg+/gQBJbwgHQlu+330xb
        SH0JyLOQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRg4c-00Bwf2-6c; Fri, 26 Aug 2022 20:37:02 +0000
Message-ID: <b339d712-8229-469e-e976-6283b6fad842@infradead.org>
Date:   Fri, 26 Aug 2022 13:37:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/2] um: Cleanup syscall_handler_t cast in syscalls_32.h
Content-Language: en-US
To:     Lukas Straub <lukasstraub2@web.de>,
        linux-um <linux-um@lists.infradead.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220826152927.193d262c@gecko>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220826152927.193d262c@gecko>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/22 08:29, Lukas Straub wrote:
> Like in f4f03f299a56ce4d73c5431e0327b3b6cb55ebb9
> "um: Cleanup syscall_handler_t definition/cast, fix warning",
> remove the cast to to fix the compiler warning.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/um/shared/sysdep/syscalls_32.h b/arch/x86/um/shared/sysdep/syscalls_32.h
> index 68fd2cf526fd..f6e9f84397e7 100644
> --- a/arch/x86/um/shared/sysdep/syscalls_32.h
> +++ b/arch/x86/um/shared/sysdep/syscalls_32.h
> @@ -6,10 +6,9 @@
>  #include <asm/unistd.h>
>  #include <sysdep/ptrace.h>
>  
> -typedef long syscall_handler_t(struct pt_regs);
> +typedef long syscall_handler_t(struct syscall_args);
>  
>  extern syscall_handler_t *sys_call_table[];
>  
>  #define EXECUTE_SYSCALL(syscall, regs) \
> -	((long (*)(struct syscall_args)) \
> -	 (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
> +	((*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))

-- 
~Randy
