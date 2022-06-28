Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634655E3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbiF1M7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiF1M7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:59:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0E2F67E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:59:15 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXPkK2Xv6zdZrk;
        Tue, 28 Jun 2022 20:56:57 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 20:59:12 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 20:59:12 +0800
Subject: Re: [PATCH -next] riscv: lib: uaccess: fix CSR_STATUS SR_SUM bit
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <akira.tsukamoto@gmail.com>,
        <jszhang@kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <alankao@andestech.com>
References: <20220615014714.1650349-1-chenlifu@huawei.com>
From:   chenlifu <chenlifu@huawei.com>
Message-ID: <11a0698c-5726-15e8-2448-3529d2d0b098@huawei.com>
Date:   Tue, 28 Jun 2022 20:58:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220615014714.1650349-1-chenlifu@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since commit 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> and commit ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code"),
> if __clear_user and __copy_user return from an fixup branch,
> CSR_STATUS SR_SUM bit will be set, it is a vulnerability, so that
> S-mode memory accesses to pages that are accessible by U-mode will success.
> Disable S-mode access to U-mode memory should clear SR_SUM bit.
> 
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Fixes: ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code")
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>   arch/riscv/lib/uaccess.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index 8c475f4da308..ec486e5369d9 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -173,11 +173,11 @@ ENTRY(__asm_copy_from_user)
>   	ret
>   
>   	/* Exception fixup code */
>   10:
>   	/* Disable access to user memory */
> -	csrs CSR_STATUS, t6
> +	csrc CSR_STATUS, t6
>   	mv a0, t5
>   	ret
>   ENDPROC(__asm_copy_to_user)
>   ENDPROC(__asm_copy_from_user)
>   EXPORT_SYMBOL(__asm_copy_to_user)
> @@ -225,10 +225,10 @@ ENTRY(__clear_user)
>   	j 3b
>   
>   	/* Exception fixup code */
>   11:
>   	/* Disable access to user memory */
> -	csrs CSR_STATUS, t6
> +	csrc CSR_STATUS, t6
>   	mv a0, a1
>   	ret
>   ENDPROC(__clear_user)
>   EXPORT_SYMBOL(__clear_user)
> 

friendly ping ...
