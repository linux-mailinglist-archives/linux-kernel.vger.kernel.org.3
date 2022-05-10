Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB4521266
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiEJKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbiEJKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75D28ABA9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B225761784
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178B2C385C6;
        Tue, 10 May 2022 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652179221;
        bh=O7wGDdbvzyYaDqEfzW2f8qf2bbg8+hQwT/vCW4k2cPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phCPQqig6FC2alGkWQ8R32QnauSaXdQbGwPQJW7klNNmjGnnhdKTCmtdSyM0/+zQj
         RvDY62lsTU5oFrYIWVHofXNSl1IUD98LbiMKorX54tgLvh85blX8AeKE9VglPa0G1K
         17RNOz3wzdC/uNBgixKY9VAFegx6OpKFziZAay3Kj0RaT5EZZUSfpuk6rxG70TmULT
         FZae+mdtNIGMDBNSFNW6dwfLhLPT5aL+y4WLCuN0tRhYt4YHrkI07vPcAsrR/a+n5a
         JuLI7T2F6mCtW07dTsuanJuddo+gMMfHWT2dMdmar5DKKfSxU1fHGB0knXPEXpClfI
         J2mm0ndPDVsyA==
Date:   Tue, 10 May 2022 11:40:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     catalin.marinas@arm.com, broonie@kernel.org, pcc@google.com,
        mark.rutland@arm.com, keescook@chromium.org, daniel.kiss@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com, gongruiqi1@huawei.com
Subject: Re: [PATCH -next] arm64: add missing header dependencies
Message-ID: <20220510104014.GA27557@willie-the-truck>
References: <20220509061751.3434059-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509061751.3434059-1-cuigaosheng1@huawei.com>
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

On Mon, May 09, 2022 at 02:17:51PM +0800, Gaosheng Cui wrote:
> We get one error when building module with processor.h:
> 
> ./arch/arm64/include/asm/processor.h:263:36: error: implicit declaration of function ‘task_stack_page’;
>   ((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
> ./arch/arm64/include/asm/processor.h:266:42: note: in expansion of macro ‘task_pt_regs’
>  #define KSTK_ESP(tsk) user_stack_pointer(task_pt_regs(tsk))
> 
> task_stack_page is declared in linux/sched/task_stack.h, so this patch
> add the missing header dependencies.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  arch/arm64/include/asm/processor.h | 1 +
>  1 file changed, 1 insertion(+)

Do you know which commit is causing this error? I haven't seen any other
reports, but it's hard to know which tree should take your patch as it
stands.

Thanks,

Will

> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 73e38d9a540c..1c239841c4d6 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -28,6 +28,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/cache.h>
>  #include <linux/init.h>
> +#include <linux/sched/task_stack.h>
>  #include <linux/stddef.h>
>  #include <linux/string.h>
>  #include <linux/thread_info.h>
> -- 
> 2.25.1
> 
