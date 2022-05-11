Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47880522D48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbiEKH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiEKH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:27:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7733BBC1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WqQvvzTawsUra3llaTMtecCGxHMoJa0AaVmr+uqshgk=; b=rXYulYiOCSxQOkz21USvuZ8PMZ
        TFMOCQktj/apPUevOQxpan2cX+AhwEDOr7WXdUVoA21F/MINzQLqplcr3DnEtIkCuBFQzIYGlVpcz
        iwTSzsGhevzamCUouHqSkWI3AzTOR7KDHHraSFvv9iCDUougczpM5iSCjchEwHWyrEx8seEsjAFp8
        I0Q2NoC2U43NCqaZFejkQApFweQvaB9ecj+xvMJMinXynwM/qFm1Xl0IRWUgf+OLAUoz4Phf3g5fo
        URRiGJ+HUn/aRnclAPxEz8gn39NHtp0w1CftST7ng5oE4E/lV+ya7UHoIaI3XcAW0iJTYXP22RTgA
        LdIbpmEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nogkG-005ENO-GQ; Wed, 11 May 2022 07:26:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CFF0980E3A; Wed, 11 May 2022 09:26:52 +0200 (CEST)
Date:   Wed, 11 May 2022 09:26:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 09/10] x86/mm: Add userspace API to enable Linear Address
 Masking
Message-ID: <20220511072651.GV76023@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-11-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511022751.65540-11-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:27:50AM +0300, Kirill A. Shutemov wrote:
> @@ -1013,8 +1017,23 @@ static long thread_feature_prctl(struct task_struct *task, int option,
>  
>  	/* Handle ARCH_THREAD_FEATURE_ENABLE */
>  
> +	if (features & (X86_THREAD_LAM_U48 | X86_THREAD_LAM_U57)) {
> +		long ret;
> +
> +		/* LAM is only available in long mode */
> +		if (in_32bit_syscall())
> +			return -EINVAL;

So what happens if userspace sets up a 32bit code entry in the LDT and
does the LAM thing as a 64bit syscamm but then goes run 32bit code?

> +
> +		ret = enable_lam(task, features);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	task->thread.features |= features;
>  out:
> +	/* Update CR3 to get LAM active */
> +	switch_mm(task->mm, task->mm, task);
> +
>  	return task->thread.features;
>  }
>  
