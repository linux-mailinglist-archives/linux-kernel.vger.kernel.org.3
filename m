Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D2495481
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377384AbiATS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377373AbiATS4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:56:52 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A32C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:56:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id r29so838232pfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BLjtA7Aums/ilXFg+4gjh+nfchSZIUu6a21JuAeXehM=;
        b=1r7ggSjoyjiEd0AgERULWPQKaqUaILvMLutii1XqZIybZBPD173WhgtoRWQ5dB7bxJ
         pdVZtqJWOHBYqyrmwsfefuhQ0coEepqdXHfu5zQnB1VpbSCOR1LRNmkFnW5/HiUW0oNA
         eojnyHhq6AsFTvbWG5Tk+6coYuGPWIFa7meblIfUBMhjKSqMGNcLYn9om51xCcBiS6c0
         3cu03oNy8YmWTky1JwuR3D+7cVMIEQByfN8SqvEhSujckzxsJkA2sdRD0v21DkdVjQRm
         ShzllnfXIy3Zx6gHc/PdNmLTHn5/X/Y+TqvnszOEq/+BTRfVrvKTxzTRA8YEMlAGjlEz
         6Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BLjtA7Aums/ilXFg+4gjh+nfchSZIUu6a21JuAeXehM=;
        b=OWk/oG7zeJNyFsXfG2/souKo4kkH2VJG6FWNzhhrOxg5F9PLXIqDqjpkKO0DLS3N7H
         yPZpt/c0RAx/pfmNPK9DD//BYyuUjdyerxouW44oXyoYilN70coQAqKLg8YPSV3tWuxs
         UYbbKeHpTQ4nwiwHsW6lSVnbo1ljBGXShb/IUyztDamav7kQdUuG2WmjsVI94kdkh2WK
         z74CnPK1GRmK/47qnVeXAfEFgOJ8oSKRMzdZHd7bCZkE2LlutcxdEzWk8O0hZwRdWhKw
         F01/iMC7XqUK+Eq8/LHtgVWXoPTNhtwvvZ6x3HRK+bfbllVYt4YVMf3HH6LQSCGotOT+
         znIA==
X-Gm-Message-State: AOAM530gDuie4Rg2tyFhXec6Yp8N/DOxMj+bMA3MMdkOvzRmnpZVimGM
        rGvY9doDnVxPUxMLqTGwVyO4cw==
X-Google-Smtp-Source: ABdhPJxdE/w6f1aJwRVw74resTa1XXc33k37AYF3EbNOLlPLmRzeKe7qDQ0i6GxH8YBBPkP+X3A5HQ==
X-Received: by 2002:a63:610b:: with SMTP id v11mr111312pgb.183.1642705011241;
        Thu, 20 Jan 2022 10:56:51 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id v17sm4231250pfu.220.2022.01.20.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:56:50 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:56:50 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 10:56:08 PST (-0800)
Subject:     Re: [PATCH] arch/riscv/kernel: remove redundant err variable
In-Reply-To: <20220112082729.667743-1-chi.minghao@zte.com.cn>
CC:     oleg@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn,
        zealci@zte.com.cn, cgel.zte@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     cgel.zte@gmail.com
Message-ID: <mhng-c795fe10-28e3-4762-92ae-0b8a99b58f96@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 00:27:29 PST (-0800), cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Return value from user_regset_copyin() directly instead
> of taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  arch/riscv/kernel/ptrace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 9c0511119bad..a89243730153 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -42,12 +42,10 @@ static int riscv_gpr_set(struct task_struct *target,
>  			 unsigned int pos, unsigned int count,
>  			 const void *kbuf, const void __user *ubuf)
>  {
> -	int ret;
>  	struct pt_regs *regs;
>
>  	regs = task_pt_regs(target);
> -	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
> -	return ret;
> +	return user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
>  }
>
>  #ifdef CONFIG_FPU

Thanks, this is on for-next.
