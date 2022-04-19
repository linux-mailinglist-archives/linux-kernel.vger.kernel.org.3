Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750DC506D88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbiDSNgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244235AbiDSNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:36:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D503369CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:33:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650375212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTfXq7PWiJj7ZJkf1E4qzGVF2Sd4LMK521qHQyg+0Lo=;
        b=lx+TAt5dM8VnFSrN4W7NK59UtbZ8s/UBct7zPRUjXdyRofwsKw+PB1uAILhuw/0pLtuZc/
        AgModsK1rxCKfk++8Cd1myTy8GIWuSD1JUaekc0QE7nx1RwuSTiJ4EWHvJ2TcRQbtKLH1T
        5gydvHg2tIxDO/zoaI3PmPcNlEE3++KOgC8sXyDLMsMVn2R+1gW2VFGLexyw0AyRnasKzn
        WEGi+1S4PnDdkkHrgVxlvLVJqC6GGyHshiZrH4U7LoNb3VVQ91MxlVKxSi+lLJ82EOCBYy
        rxo9RSJrVZRYPfvG+oM5e/fSvD2Fa0nqZBx2LYWsbym0uw2zTQB6f2ByXv2OZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650375212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTfXq7PWiJj7ZJkf1E4qzGVF2Sd4LMK521qHQyg+0Lo=;
        b=2vr0XN3o1Mnhi+OYPYyAAiE4ZHZwHKYVa8pGPzkOMoj1oaraiAf/U3H+nPnUz7axwcw6ui
        295qR9U37c9BnMBA==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [patch 2/3] x86/fpu/xsave: Prepare for optimized compaction
In-Reply-To: <87k0bl9rhz.ffs@tglx>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.656881574@linutronix.de>
 <d2f927c9-187a-906c-e1f3-33541b3b5a84@intel.com> <87k0bl9rhz.ffs@tglx>
Date:   Tue, 19 Apr 2022 15:33:31 +0200
Message-ID: <87h76p9p04.ffs@tglx>
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

On Tue, Apr 19 2022 at 14:39, Thomas Gleixner wrote:
> On Thu, Apr 14 2022 at 08:46, Dave Hansen wrote:
>>> +	for (i = fls64(xtmp) - 1; i >= FIRST_EXTENDED_XFEATURE;
>>> +	     i = fls64(xtmp) - 1) {
>>> +		unsigned int to, from;
>>
>> Is it worth a check here like:
>>
>> 		/* Do not move features in their init state: */
>> 		if (!(xcur & BIT_ULL(i))) {
>> 			xtmp &= ~BIT_ULL(i);
>> 			continue;
>> 		}
>
> That would also require to clear the bit in xall, but we can't do that
> in the loop as that affects offsets. Let me think about that.

Duh, misread it. Yes it's possible to do that. OTOH, with the optimized
compaction there won't be a bit set in xbv, but not in xfeatures, except
for the initial state when a task starts.

Thanks,

        tglx

