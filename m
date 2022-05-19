Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785A52DFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiESWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiESWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:04:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92AC8BFA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FRhvNyoi9JNty0fezPLmqEugjyT5imBlcHaOEqSVPXQ=; b=ipGU7OB9CdsPzvr6GdVEfEuEsa
        S/So5FAv5z7ntO6PlfcsNhUi0wE1vP4uLvi6DlLhEeGATiepF248vN+eSxGIwg2XAzsZDqGC+/tGB
        z73xIXXGDbjkUGKLC51+SZBGpZrsrBYkN4Pqla3n+7juMCiki2+XFPOgxjzX6zq/0TbpAr/50c36U
        QFHoe4l5il3VdceNVUK8SQwiNjlUoBom+mYvi/ws5vz7eKwrjaO4B/fsTPaoUQ/0hY3h2B3pHdJO4
        E4qPlZgtHs5hHL/Y8ut755g/KTH6vwKyOU8yLMNZlSX6X3oZxQNM0FEacD2obIw64p4DV1+4B5ktw
        Gey5CQBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nroFL-00D8Hs-HE; Thu, 19 May 2022 22:03:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2506981005; Fri, 20 May 2022 00:03:49 +0200 (CEST)
Date:   Fri, 20 May 2022 00:03:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, kirill.shutemov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <20220519220349.GM2578@worktop.programming.kicks-ass.net>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519213422.119695559@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 19, 2022 at 11:27:59PM +0200, Peter Zijlstra wrote:
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -178,6 +178,9 @@ void __cpuidle tdx_safe_halt(void)
>  	 */
>  	if (__halt(irq_disabled, do_sti))
>  		WARN_ONCE(1, "HLT instruction emulation failed\n");
> +
> +	/* XXX I can't make sense of what @do_sti actually does */
> +	raw_local_irq_disable();
>  }
>  

Kirill, Dave says I should prod you :-)
