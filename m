Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2B506D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351457AbiDSNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbiDSNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:06:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A32377F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:04:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650373447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eupx91ipHUfoNRi4brayBvoybEh9b09e5p2b6SLiofg=;
        b=cI4CmBORYShGFfnHSNBz9VGYvmJmfBwTLETF0Z+PuDFf2wTU9JTPwNPBirPKGGFshg//ha
        hEm01DvI077mODBNvpXZmwmvGGMWqAmdNMd/4/ZU7LkaGNK+MH4oMc1HsdrR2A2y9ToDN9
        dfvQYeRyQlJUbZY4c55MJJWGX3LXUKGf9VYOGlL0TsqvacsFbZhO1FhClqBpnu2SGWmCvc
        7lSq2jkCKicVMT+fSn4X3fajQycGrcV+2XuHYsXNYlQ5/Qqc33b1GqObujveM64Ce16zdH
        ATr4Od3B9zAyALcKk5CEKccPtc3Ysh6p38t04yUemeqV4CmuHDWqLziruWEyPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650373447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eupx91ipHUfoNRi4brayBvoybEh9b09e5p2b6SLiofg=;
        b=rZwxEQnkdn25xC4vmQ1vWWlUtUGc2zX9kYvqyN9BrZ3mVG/9Iy+L5nK7KWr1dF4b/jpdj5
        d8tqyF7f42zAWYBA==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [patch 2/3] x86/fpu/xsave: Prepare for optimized compaction
In-Reply-To: <d2f927c9-187a-906c-e1f3-33541b3b5a84@intel.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.656881574@linutronix.de>
 <d2f927c9-187a-906c-e1f3-33541b3b5a84@intel.com>
Date:   Tue, 19 Apr 2022 14:39:36 +0200
Message-ID: <87k0bl9rhz.ffs@tglx>
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

On Thu, Apr 14 2022 at 08:46, Dave Hansen wrote:
> On 4/4/22 05:11, Thomas Gleixner wrote:
> Any interest in doing something like the attached to make
> copy_uabi_to_xstate() easier to read?

Yeah. I've picked it up.

>> +static void xsave_adjust_xcomp(struct fpstate *fpstate, u64 xuser)
>> +{
>> +	struct xregs_state *xsave = &fpstate->regs.xsave;
>> +	u64 xtmp, xall, xbv, xcur = xsave->header.xfeatures;
>> +	int i;
>> +
>> +	/* Nothing to do if optimized compaction is not in use */
>> +	if (!xsave_use_xgetbv1())
>> +		return;
>
> The comment makes me wonder if we need a more descriptive name for
> xsave_use_xgetbv1(), like:
>
> 	if (!xsave_do_optimized_compaction())
> 		return;

Makes sense.

>> +	/*
>> +	 * No more optimizations. Set the user features and move the
>> +	 * supervisor state(s). If the new user feature is past
>> +	 * the supervisor state, then the loop is moving nothing.
>> +	 */
>> +	xtmp = xbv & XFEATURE_MASK_SUPERVISOR_ALL;
>> +	xall = xbv | xuser;
>
>
> I'd probably at least comment why the loop is backwards:
>
> 	/*
> 	 * Features are only be moved up in the buffer.  Start with
> 	 * high features to avoid overwriting them with a lower ones.
> 	 */
>
> I know this is a very typical way to implement non-destructive moves,
> but my stupid brain seems to default to assuming that for loops only go
> forward.

:)

>> +	for (i = fls64(xtmp) - 1; i >= FIRST_EXTENDED_XFEATURE;
>> +	     i = fls64(xtmp) - 1) {
>> +		unsigned int to, from;
>
> Is it worth a check here like:
>
> 		/* Do not move features in their init state: */
> 		if (!(xcur & BIT_ULL(i))) {
> 			xtmp &= ~BIT_ULL(i);
> 			continue;
> 		}

That would also require to clear the bit in xall, but we can't do that
in the loop as that affects offsets. Let me think about that.

Thanks,

        tglx
