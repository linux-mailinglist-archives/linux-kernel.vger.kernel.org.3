Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590B65A0BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbiHYIlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiHYIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:41:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B1A74DD;
        Thu, 25 Aug 2022 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FdDKwLQIFF3XT7VdsHerVnHoM6og2GUoRewPRYo5YL0=; b=mm/qZb7Wpfja18NPet6+fdXPOz
        X89v/raFb0p3jtXBJQktL3E7bObQ+eRFEpIk4fzBUS3X39e4/wqs68cMsXx4A9E/hKM8CE2ZiWPEh
        nEvK0J4V5nzc/f0vmIou2Jnj4jM4LYXpeRss2kxPzVKL4THxieMykYtUpu8XQamTzdFJVhAUOoRxz
        35V+x3IgtW5xNvNWdsSfAvE0IJgbrhCGsoFQKdhqY5OnI4uVEokdyvbbBSm4mKc5C+VNtcgPVLKBy
        1wa6v1N6LKux+7sH/By4faExAk30UCjYkrnomwS6mdmFCziDdde1GwtP5BM0fQRuXwUm4pGnh+uK8
        TQ6VhGdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oR8QA-005xma-Fc; Thu, 25 Aug 2022 08:41:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7236598014D; Thu, 25 Aug 2022 10:41:01 +0200 (CEST)
Date:   Thu, 25 Aug 2022 10:41:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Shier <pshier@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] intel_idle: avoid tracing MSR writes while idling
Message-ID: <Ywc1naLthsmxI0cF@worktop.programming.kicks-ass.net>
References: <20220824234211.1625026-1-pshier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824234211.1625026-1-pshier@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:42:11PM -0700, Peter Shier wrote:
> With commit bf5835bcdb963 ("intel_idle: Disable IBRS during long idle"),
> enabling wrmsr trace with CONFIG_LOCKDEP causes "suspicious
> rcu_dereference_check() usage" warning because do_trace_write_msr does not
> use trace_write_msr_rcuidle.
> 
> Change intel_idle_ibrs to use native_wrmsr to avoid tracing
> 
> Signed-off-by: Peter Shier <pshier@google.com>
> ---

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  drivers/idle/intel_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 3e101719689a..df129c73786f 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -187,12 +187,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>  	int ret;
>  
>  	if (smt_active)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +		native_wrmsr(MSR_IA32_SPEC_CTRL, 0);
>  
>  	ret = __intel_idle(dev, drv, index);
>  
>  	if (smt_active)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
> +		native_wrmsr(MSR_IA32_SPEC_CTRL, spec_ctrl);
>  
>  	return ret;
>  }
> -- 
