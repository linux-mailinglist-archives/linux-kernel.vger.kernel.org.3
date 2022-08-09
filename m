Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33B058E09D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbiHIUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbiHIUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:06:35 -0400
Received: from galois.linutronix.de (unknown [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C931EAE0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:06:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660075577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBTwmz2rPJKGWSSwRXS8i02OixhR40SD6KCPKUvKk6w=;
        b=ckejNwe6FrsRxTbgsNJCUykONduBpIZjiQQfSLhxwAXffLAEetoPKttRSd6jAq/c8o+bkB
        mAe9FjP2sly+3UIusQYt4EBvNkY+ZQdspmHSS0hLjD250yTASIoQ5Cbphguj2iCwkbHgho
        UjSzWxuCrZpZ9AIIiqiRQoz36bjJtLP1XYLisiLazoibEjUGcrjyHSDMxdOxYEdPJ9fVKL
        HVY4c655ui4F9/KTmYIgSu1bnHIZk0Qp+GXt8p+edWXO+KY3ptM9uI2LURUR2GHMU0nrnL
        0Hxn+pbiE3zc+HQqeQlWnXIlEypJXQ6eSWhbHvyfglceXdQoPxHIGzkSO7opMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660075577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBTwmz2rPJKGWSSwRXS8i02OixhR40SD6KCPKUvKk6w=;
        b=SFHyKU9+zBxwEiZ7g/IG8qmcCPxn50vJ0Ydza45N8GGb5LeELXxppZnQ/btRi/h7+wVS9G
        Ms1IW5noLW7Zs0Cg==
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
In-Reply-To: <YvD7FNovYh7UzrAc@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
 <Yu4t0jkpIY4grgxL@gmail.com> <Yu4wON0MRGH7h5Jv@zn.tnic>
 <Yu+Nwbn4CZUmyD14@gmail.com> <Yu+VV8xFTYRh0D0a@zn.tnic>
 <YvAaXet3sBg3mRDe@iweiny-desk3> <YvDtfKRyMGenRMU5@gmail.com>
 <YvD7FNovYh7UzrAc@zn.tnic>
Date:   Tue, 09 Aug 2022 22:06:16 +0200
Message-ID: <87o7wtqj0n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08 2022 at 14:01, Borislav Petkov wrote:
> On Mon, Aug 08, 2022 at 01:03:24PM +0200, Ingo Molnar wrote:
>> I'd like to hear what Andy Lutomirski thinks about the notion that
>> "2 instructions don't matter at all" ...
>> 
>> Especially since it's now 4 instructions:
>
> He wasn't opposed to it when we talked on IRC last week.
>
>> ... 4 instructions in the exception path is a non-trivial impact.
>
> How do I measure this "impact"?
>
> Hell, we recently added retbleed - and IBRS especially on Intel - on
> the entry path which is whopping 30% perf impact in some cases. And
> now we're arguing about a handful of insns. I'm sceptical they'll be
> anything else but "in-the-noise" in any sensible workload.

I'm not worried about the 4 instructions per se, but storing the CPU
number on every exception and interrupt entry just to use it in exactly
one place, i.e. the user mode #PF handler, does not make any sense at
all.

Get the CPU number before enabling interrupts and hand it in to the
bad area variants.

I know that the aux reg code is required for other things, but just for
this it's complete overkill.

Thanks,

        tglx
