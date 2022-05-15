Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0324352798B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiEOTiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 15:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEOTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 15:38:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DFF2A723
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 12:38:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652643489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5LCsW8k7IMBIoubQ8rXPA9GnJrMZKFQzAkQTlILy9g=;
        b=FldEA02iAWFSLvS9H+hHyYfFA9ud0FV7oPLk+g7hDSj8oxQiPEX1hLAxn+AfidjhgMCwJ3
        mobJFKKzvWnUg8imAqqVxCt4cuirIKf1ZeQvr81b664kPA31aROreeQt0WMV/20wompYKH
        3Pb1aVgmlSV8LLrjLqN7/oNBdFPj8Ioe7G1sfwZ5g2kPHB1ScBFd/gn5xSa62oVbFaMUYb
        Fty5/uYikAg4yCyW2nz+o3PmCFBtNndpyXOb/8S+Zg8pDv/wDtxU5w0SXLN7UCMfvq3P+W
        fbPctagAzNFNmIMb0ZoTrq+UQDgctfKpQmG8+yx1i1clnaVL76/VnngPh+BRjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652643489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5LCsW8k7IMBIoubQ8rXPA9GnJrMZKFQzAkQTlILy9g=;
        b=t0slTWbY4t8OnN7SBKS0xeJTT4TAWF5Ik5fODcSiFhvNSMnWKvW7AqqA3DXciGMvfww3Zy
        KCqcCoLTZrts9+DQ==
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
In-Reply-To: <95efb5ae85a96914fff3939d4924e46686196cc7.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
 <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
 <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
 <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
 <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
 <87k0aose62.ffs@tglx>
 <9e59305039f2c8077ee087313d1df5ff06028cfe.camel@intel.com>
 <87zgjjqico.ffs@tglx>
 <95efb5ae85a96914fff3939d4924e46686196cc7.camel@intel.com>
Date:   Sun, 15 May 2022 21:38:08 +0200
Message-ID: <87lev2r3hb.ffs@tglx>
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

On Sun, May 15 2022 at 18:24, Edgecombe, Rick P wrote:
> On Sun, 2022-05-15 at 11:02 +0200, Thomas Gleixner wrote:
>> If it really turns out to be something which matters, then you can
>> provide a batch interface later on if it makes sense to do so, but
>> see
>> above.
>
> Thanks, sounds good to me.
>
> Kirill, so I guess we can just change ARCH_THREAD_FEATURE_ENABLE/
> ARCH_THREAD_FEATURE_DISABLE to return EINVAL if more than one bit is
> set. It returns 0 on success and whatever error code on failure.
> Userspace can do whatever rollback logic it wants. What do you think?

Why having this feature bit interface in the first place?

It's going to be a demultiplex mechanism with incompatible
arguments. Just look at LAM. What's really architecture specific about
it?

The mechanism per se is architecture independent: pointer tagging.

What's architecture specific is whether it's supported, the address mask
and the enable/disable mechanism.

So having e.g.

   prctl(POINTER_TAGGING_GET_MASK, &mask);

works on all architectures which support this. Ditto

   prctl(POINTER_TAGGING_ENABLE, &mask);

is architecture agnostic. Both need to be backed by an architecture
specific implementation of course.

This makes it future proof because new CPUs could define the mask to be
bit 57-61 and use bit 62 for something else. So from a user space
perspective the mask retrival is useful because it's obvious and trivial
to use and does not need code changes when the hardware implementation
provides a different mask.

See?

The thread.features bitmap could still be used as an internal storage
for enabled features, but having this as the primary programming
interface is cumbersome and unflexible for anything which is not binary
on/off.

Thanks,

        tglx


