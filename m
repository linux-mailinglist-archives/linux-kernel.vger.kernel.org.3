Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D105750C092
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiDVTyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiDVTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:54:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE991632C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:35:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650655820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5c3CLMMqVYhfDtG3GHGcpKgf6+Vvr2oQsy+wAdxJA8=;
        b=ktbNY0QVYnCK7w5Uwq2rBIPQKzBxNrZHIHCQgzzcV7OZpC2XvrknB/SrHffIBir+NOz35+
        5k4jihmCCggBqkZ0jq7Rfp5p4s01DjCsUeHqfkwcqJTH/ybdCcaH8BCt5cJ+mVgyuGSHU8
        yzLknyxOQ8G27x02oPv0+5NF39ZrQmmc4tA20OSXLcXj6rIByjISAQ7OoehrFBhIqKxrya
        N5/qMLfQf2LPC5WSODTtKiUwXnf3m3plxL6ZwUJ3FElo4Djbl93vQOcuJHgA3jQf8m8KID
        6+WywhpNaZtrTXzv/j2xGThpqCnuS2Y+zKvUnrcne+8DILYxmV4vcuC9IkFHFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650655820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5c3CLMMqVYhfDtG3GHGcpKgf6+Vvr2oQsy+wAdxJA8=;
        b=EqXgjvnMaDEsZq01kp11O5F1dGAeDCLJOJLOkiN5qrfGo8e+aRSM1c/L0vqTYdEP1pGApC
        YVGfHGBegPSTULBg==
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [patch 3/3] x86/fpu/xsave: Optimize XSAVEC/S when XGETBV1 is
 supported
In-Reply-To: <60e5a4d1-df7c-d3bd-2730-e528cd75c351@amd.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.713066297@linutronix.de>
 <a93e6d3f-e8b9-2fab-1139-a8ba3dc4820b@intel.com> <87ee1t9oka.ffs@tglx>
 <878rs0vkd2.ffs@tglx> <60e5a4d1-df7c-d3bd-2730-e528cd75c351@amd.com>
Date:   Fri, 22 Apr 2022 21:30:19 +0200
Message-ID: <87bkws6hmc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2022 at 13:15, Tom Lendacky wrote:
> On 4/19/22 16:22, Thomas Gleixner wrote:
>>> That was bare metal and I just checked that this was a production config
>>> and not some weird debug muck which breaks large pages. I'll look deeper
>>> into that.
>> 
>> I can't find any reasonable explanation. The pages are definitely large
>> pages, so yes the dTLB miss count does not make sense, but it's
>> consistently faster and it's always the dTLB miss count which makes the
>> big difference according to perf.
>> 
>> For enhanced fun, I ran the lot on a AMD Zen3 machine and with the same
>> test case (hackbench -l 10000) repeated 10 times by perf stat this is
>> consistently slower than the non optimized variant. There is at least an
>> explanation for that. A tight loop of 1 Mio xgetbv(1) invocations takes
>> 9 Mio cycles on a SKL-X and 50 Mio cycles on a AMD Zen3.
>
> I'll take a look into this and see what I find. Might be interesting to 
> see if the actual XSAVES is slower or quicker, too, based on the input mask.
>
> If the performance slowdown shows up in real world benchmarks, we might 
> want to consider not using the xgetbv() call on AMD.

As things stand now, I'm not going to pursue this further at the moment.

The effect on SKL-X is not explainable especially the dTLB miss count
decrease does not make any sense. Aside of that I just figured out that
it is very sensitive to kernel configurations and I have no idea yet
what exactly is the screw to turn to make the effect come and go.

So I just go and add the XSAVEC support alone as that's actually
something which _is_ beneficial for guests.

Thanks,

        tglx

