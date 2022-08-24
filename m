Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B259F419
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiHXHW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiHXHW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:22:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5083E74B;
        Wed, 24 Aug 2022 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mix4Z1ieLqwGJpAe/P3K6Otr3/J9t+fBDCBXsDZJNGA=; b=SRq2wmllmF/baBGSQo++fRl8eC
        1Dmkq/nLeW7kFGOZj/FuTzPLLrD7d/KwA1yWpXszKRR/fqmQzhFI3uj49YJPEkjQt+hQ+dpEz7DWC
        PHRThED7wBAE+JkAoh/pwKSAP4wyyd1iAKA7SeOiPzbyZePRrA3wfu5EDh6kDoG2brO4oWZAP0YNF
        zhPGqdgemzbeTTIuJba4vGg33w6BRDanUFTwXpdZB1klQNrnaZ4dK1c4WOMs151BFHQL4h262Y92M
        IPqhTDkz0/m7E+WDt9KcFke6ojhwr0MLMZQ/kxFo5wZ3wiPeTj4UANiFYM4h5V7ocnmMiSZ/GAD/+
        16KWXnzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQkiI-005eus-T7; Wed, 24 Aug 2022 07:22:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 030E5980403; Wed, 24 Aug 2022 09:22:09 +0200 (CEST)
Date:   Wed, 24 Aug 2022 09:22:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     FirstName LastName <pshier@google.com>
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
Subject: Re: [PATCH] x86/msr: add idle version of wrmsr trace
Message-ID: <YwXRoUfI87HYOnTd@worktop.programming.kicks-ass.net>
References: <20220823234353.937002-1-pshier@google.com>
 <YwXJwTOFWRFPilOy@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwXJwTOFWRFPilOy@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 08:48:33AM +0200, Peter Zijlstra wrote:
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 3e101719689a..6e82b2df29cb 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -187,12 +187,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>  	int ret;
>  
>  	if (smt_active)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +		__native_wrmsr(MSR_IA32_SPEC_CTRL, 0);
>  
>  	ret = __intel_idle(dev, drv, index);
>  
>  	if (smt_active)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
> +		__native_wrmsr(MSR_IA32_SPEC_CTRL, spec_ctrl);
>  
>  	return ret;
>  }

Clearly I should not be sending email before having wake-up-juice.. that
should of course be native_wrmsr(SPEC_CTRL, val, 0) etc..
