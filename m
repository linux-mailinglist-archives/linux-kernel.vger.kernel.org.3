Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849005508C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 07:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiFSFoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 01:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 01:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85166B843
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cgaYumtYbqc1jS524wk3xxBH4a5y3RzjEQYyweJst40=; b=S3KI0WkL83yv/Z7AU7TAN/Xf+l
        PZUVpOK0EFc6yWVCaZ5WUD8cGKimi/PGRnHBHEWd97mb6WFid496ZgMzrnoXh3JGLIkP04N+bJy+T
        NMdU3r0tk9BR8bI5jxr1lqjOEXh90Sp7AUJt1ClO+Q/7adsSo+88yy5Qz3mXqKTx6TanRvET9qcC+
        /FlHLc0rcT8GhhctAwGq6/pNrmDDDeCl4Y66snxd8GNfM0rxM0cGOrcKW/VrpzYaDjkLFnT4R2XUz
        a2XKOMezfCvP+R+yxYzYHxBKGBGIBz+cyIc03wSHaPkH23y4twsr0hfXRipOKHHEKw4Mz2gkp3rIF
        eGRcZ8VA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2niE-0049NX-MD; Sun, 19 Jun 2022 05:43:06 +0000
Message-ID: <48034eb1-3f37-f4fd-24b3-0eb7e517b35e@infradead.org>
Date:   Sat, 18 Jun 2022 22:42:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] powerpc/interrupt: Put braces around empty body in an
 'if' statement
Content-Language: en-US
To:     Souptick Joarder <jrdr.linux@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        mark.rutland@arm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kernel test robot <lkp@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20220619031114.92060-1-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220619031114.92060-1-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/22 20:11, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> Kernel test robot throws warning ->
> 
> arch/powerpc/kernel/interrupt.c:
> In function 'interrupt_exit_kernel_prepare':
> 
>>> arch/powerpc/kernel/interrupt.c:542:55: warning: suggest
> braces around empty body in an 'if' statement [-Wempty-body]
>      542 |                 CT_WARN_ON(ct_state() == CONTEXT_USER);

That must be when CONFIG_CONTEXT_TRACKING_USER is not set/enabled.
Can you confirm that?

Then the preferable fix would be in <linux/context_tracking.h>:

change
#define CT_WARN_ON(cond)

to either an empty do-while loop or a static inline function.

(adding Frederic to Cc:)

> 
> Fix it by adding braces.
> 
> Reported-by: Kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  arch/powerpc/kernel/interrupt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 784ea3289c84..b8a918bab48f 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -538,8 +538,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>  	 * CT_WARN_ON comes here via program_check_exception,
>  	 * so avoid recursion.
>  	 */
> -	if (TRAP(regs) != INTERRUPT_PROGRAM)
> +	if (TRAP(regs) != INTERRUPT_PROGRAM) {
>  		CT_WARN_ON(ct_state() == CONTEXT_USER);
> +	}
>  
>  	kuap = kuap_get_and_assert_locked();
>  

-- 
~Randy
