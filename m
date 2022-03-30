Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7C4ECFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351651AbiC3Web (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242973AbiC3Wea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:34:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB75BE46
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:32:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648679562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nc9z3j2jxi+FrRfNGDqS68SB0aTB8VlUDCgHaat1Zms=;
        b=bjse9zTwIphvNyS4pc9RJ9csKA8bs18yjT2OUC0lE9Gs6TSkCVs+4HirONEIpSm/1mnIs4
        VR1Qvf8eaSP5GUKDU6uywSnY+X6ndEl78cfuEELNtkyBaHP0PC0AkyZu73A3gbMzKdMhJQ
        CL0RIXtlc6IjJtsPomQstitlNnQn+Qhf/c2fKkmH8Q0nO8Mt3dTpVUSBhjDzNyoqw4cD4J
        50R4fk6dWPqyC1j8/UkcZYxU+pzkxXRatX4+P+yImULQL/Ud7i7jy4f/7ISnjFRUXAT5ul
        2DlAMDC5d5b3WAvDC49k/RkeqyP+wT8zH1bYMGEV4o8sYR1RQIjQxSbR5gThZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648679562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nc9z3j2jxi+FrRfNGDqS68SB0aTB8VlUDCgHaat1Zms=;
        b=oV1YFtiJk/VZcX4CXrMCwe+VBuHk2bq65de5apEEtvaqQT3ZuInnvnE4alKeEgfMXkTkDX
        FdiFAue3yRrSNqCg==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: undef REG_IN/REG_OUT to avoid define collisions
In-Reply-To: <YkR9TD4+9LzH1N6b@smile.fi.intel.com>
References: <20220330152808.1461758-1-narmstrong@baylibre.com>
 <c54c8c77-d35f-49b0-ff2f-21eb597f41f0@intel.com>
 <YkR9TD4+9LzH1N6b@smile.fi.intel.com>
Date:   Thu, 31 Mar 2022 00:32:41 +0200
Message-ID: <8735iznkae.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30 2022 at 18:54, Andy Shevchenko wrote:
> On Wed, Mar 30, 2022 at 08:33:26AM -0700, Dave Hansen wrote:
>> On 3/30/22 08:28, Neil Armstrong wrote:
>> > diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
>> > index ba88edd0d58b..139a4b0a2a14 100644
>> > --- a/arch/x86/include/asm/arch_hweight.h
>> > +++ b/arch/x86/include/asm/arch_hweight.h
>> > @@ -52,4 +52,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
>> >  }
>> >  #endif /* CONFIG_X86_32 */
>> >  
>> > +#undef REG_IN
>> > +#undef REG_OUT
>> 
>> Wouldn't it be a bit less hackish to give these a more qualified name
>> like HWEIGHT_REG_IN?

Absolutely.

> Either way, would it be good to undef them here anyway?

No. Unconditional #undef is a guarantee for hard to diagnose trouble
because it papers over namespace collisions. You can end up with the
wrong constants in your binary which might work well except for the once
in the blue moon corner case.

Been there and stared at such nonsense for weeks...

Name spaces exist for a reason and we are not short of characters here.

Thanks,

        tglx
