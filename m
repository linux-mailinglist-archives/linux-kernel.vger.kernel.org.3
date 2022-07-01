Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D334956337E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiGAMax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGAMaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:30:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7668834641
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:30:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so4984846pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=yVSDhYrK8Y7ydTrXkxqp6foDlogTshep1dzSeIK3bck=;
        b=Ock5oAG9Efpw4etgLVjnFZV11LyFwgPvpKTQ4ZUP1pTdSGoQ8WaiPAxfpYGWq90h9m
         SUVHcVVvNb7Va/VLakQLFak7sQxXMVzfgg+NjAsL/lGLVjoSKmEWL6poTH5XuxU7c8Lz
         /7PRP/5DzpiPw5tR5mamU95Ows+oMWRP6Je0dT/Y2Ux3bmPfqZjjnGmPo5k0ASNSS/e1
         fWS+ZlHOHc8fhTHQXEw+Ab8BV/EjCUHPxZL+h0xHUpwrLOYO/2bkfTV+/ROTkQTA1/qW
         gSSuoKarWvxc/9mRAsNX+9D4Jppfu0YqEv5yVvix/VhLZLWSpdyZlfRRPG6/jWWdDKfk
         IFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=yVSDhYrK8Y7ydTrXkxqp6foDlogTshep1dzSeIK3bck=;
        b=g5t5T1kAuL+V135JVN7/RVVUzZXqXerYOJoI0eYds1XxD8uEAWWZytDXcnsI5JLBrf
         mUz18Z9KPm548f6jbtb3By1AbWPy7uchAnVhTtznxSWUkY5nqKnRuWGJrGhOSgfZHTI2
         gTNJ90H32/WkHxddtgegc7ZuQpjmhyWqj6cpjjlHquT6bo8PIF/9/u7L5lair/mIfaRX
         /0ZnRps7YGgauCdTLnMelZkdusf/jQWSDz35IzEV4wD3OJAN+RKPoEgnut9eEoI0gNPI
         S96v5rzl5Je4abKo/kjeO5fcC+/cK1XRqo2v2/jfiQ8pZST5sB4ZJWJW/dHou4hMQIgS
         Ok/Q==
X-Gm-Message-State: AJIora+kQYSsWVF24+mvV4AqN6bVE0xjbjoF+dALtT4umJ6vpd1Y3dbK
        XM1+E4hMbDVtu/UMQUv1oxkY+qwIHbsT+g==
X-Google-Smtp-Source: AGRyM1vmkowsRZ77Rl9LxuQLsD4sTyOWaT8kaC4WNZGN6pzJBlYFKf5xB9txI4u8LtbbeJvoiyOjiA==
X-Received: by 2002:a17:90b:2391:b0:1ec:a241:5e79 with SMTP id mr17-20020a17090b239100b001eca2415e79mr18080199pjb.24.1656678650559;
        Fri, 01 Jul 2022 05:30:50 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id n18-20020a63f812000000b0040c33cb0ccasm15342175pgh.42.2022.07.01.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:30:50 -0700 (PDT)
References: <20220630161220.53449-1-schspa@gmail.com>
 <87mtdu15ok.wl-maz@kernel.org> <m2bkua148a.fsf@gmail.com>
 <a5ca4db3db9ef101258cab94d6b7e045@kernel.org>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix 64 bit mmio handle
Date:   Fri, 01 Jul 2022 20:22:21 +0800
In-reply-to: <a5ca4db3db9ef101258cab94d6b7e045@kernel.org>
Message-ID: <m2sfnlvwup.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc Zyngier <maz@kernel.org> writes:

> On 2022-06-30 17:50, Schspa Shi wrote:
>> Marc Zyngier <maz@kernel.org> writes:
>> 
>>> On Thu, 30 Jun 2022 17:12:20 +0100,
>>> Schspa Shi <schspa@gmail.com> wrote:
>>>> If the len is 8 bytes, we can't get the correct sign extend 
>>>> for
>>>> be system.
>>> I'm afraid you'll have to give me a bit more details.
>>> 
>>>> Fix the mask type len and the comparison of length.
>>>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>>>> ---
>>>>  arch/arm64/kvm/mmio.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
>>>> index 3dd38a151d2a6..0692f8b18f35c 100644
>>>> --- a/arch/arm64/kvm/mmio.c
>>>> +++ b/arch/arm64/kvm/mmio.c
>>>> @@ -81,8 +81,8 @@ unsigned long kvm_mmio_read_buf(const void 
>>>> *buf, unsigned
>>>> int len)
>>>>  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>>>>  {
>>>>  	unsigned long data;
>>>> +	unsigned long mask;
>>>>  	unsigned int len;
>>>> -	int mask;
>>>>   	/* Detect an already handled MMIO return */
>>>>  	if (unlikely(!vcpu->mmio_needed))
>>>> @@ -97,7 +97,7 @@ int kvm_handle_mmio_return(struct kvm_vcpu 
>>>> *vcpu)
>>>>  		data = kvm_mmio_read_buf(run->mmio.data, len);
>>>>   		if (kvm_vcpu_dabt_issext(vcpu) &&
>>>> -		    len < sizeof(unsigned long)) {
>>>> +		    len <= sizeof(unsigned long)) {
>>> If you're reading an 8 byte quantity, what is there to 
>>> sign-extend?
>>> Sign extension only makes sense if what you're reading is 
>>> *smaller*
>>> than the size of the register you are targeting.
>>> 
>> Yes, you are correct, sorry for my bad patch.
>> Please ignore this patch.
>> 
>>> I must be missing something. And how is that related to 
>>> running BE? BE
>>> in the host? The guest?
>> I mean BE is for guest running with BE mode.
>
> So what problem did you see? If you have noticed something going
> wrong, I'd like to get it fixed.
>

I have running some static code analysis software upon Kernel 
code.
Seeing there is possible overflow.

maks << 1U << ((len * 8) -1);

The AI don't know, len is only the value of 1, 2, 4, and make this
a warnings

I tring to analysis this, but didn't realize the real scenario of
sign extension, and finally sent this problematic patch.

I do see some uninitialized memory reads (the values are not used
in the end, just as temporary space for API execution),
do we need to fix these?

> Thanks,
>
>          M.


-- 
Schspa Shi
BRs
