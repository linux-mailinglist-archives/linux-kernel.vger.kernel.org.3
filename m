Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E455AD126
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbiIELEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiIELDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:03:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855D521E25
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=39ctGYtpjBvqxaxhX+JGoXm7WH3Dsu7ZcN8472gz0/Y=; b=kjYVFGZ/kFVziLBYIGoMoHKrZ8
        P8Yol8ya84cXbFssvqZLTBK5UFChRXQvqh1ydfF9KGPzaqdvcdATm+bk90oHlc625sSQYeKzINQhq
        n0JG+MVXe6gdwqHdjAiKiZeBghmJl4FAPZ4HpsEpGKi8W2bfIL9fzjrqhc9TbOrauOKD+1ObM7CpW
        EdwVMCYhcVeLC+cBbCnKQzVu0Wc0Pn2mFvTDgPtXFYhX4klx9uueqfklaup10hkR2DX1Rd3GXXG+i
        IIs0cZztNlAxZIEcQgJ5E7qKRTCPH2345lUUopqdHN9fG0QL0WJ17QYjt3NC4BI0Hotp+F2/g+P1O
        9DZ8lhCg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oV9sw-009Ptv-VR; Mon, 05 Sep 2022 11:03:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31FB83002A3;
        Mon,  5 Sep 2022 13:03:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22D42209EC608; Mon,  5 Sep 2022 13:03:21 +0200 (CEST)
Date:   Mon, 5 Sep 2022 13:03:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 02/16] powerpc: override __ALIGN() and __ALIGN_STR()
 macros
Message-ID: <YxXXeRr0E/rSWgJe@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-3-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-3-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:09AM +0530, Sathvika Vasireddy wrote:
> Powerpc instructions must be word-aligned. Currently,
> there is an alignment of 16 bytes (by default), and it is
> much more than what is required for powerpc (4 bytes).
> 
> The default expansion of __ALIGN() macro is:
> #define __ALIGN       .align 4,0x90
> 
> Since Powerpc Linux does not require a 16 byte alignment,
> override __ALIGN() and __ALIGN_STR() macros to use required
> 4 byte alignment.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/linkage.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
> index b71b9582e754..8df88fe61438 100644
> --- a/arch/powerpc/include/asm/linkage.h
> +++ b/arch/powerpc/include/asm/linkage.h
> @@ -2,8 +2,12 @@
>  #ifndef _ASM_POWERPC_LINKAGE_H
>  #define _ASM_POWERPC_LINKAGE_H
>  
> +#include <linux/stringify.h>
>  #include <asm/types.h>
>  
> +#define __ALIGN			.align 2
> +#define __ALIGN_STR		__stringify(__ALIGN)


Related thread:

  https://lkml.kernel.org/r/YxXJswK9QjhCGmPN@hirez.programming.kicks-ass.net
