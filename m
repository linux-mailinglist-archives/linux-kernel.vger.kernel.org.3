Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3225631E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiGAKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiGAKuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:50:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46DF7C190
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0728B82F52
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47832C3411E;
        Fri,  1 Jul 2022 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656672604;
        bh=KL3HCbfmIFwpgQxHgKNqdfe68KZEBjGoiTLhKkW04Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZ8+LMQYkO8E3V0b8x4/wGg6JBNFWqJgwC4FRyMHck0/WTp19N4v4FQPnclu+j6uR
         tto47Kdud5bf028XT5T9xTI4e8nCc0FwS2yNCid9JchnCytU5A2DqvMnnV1o6H8AXA
         ZEZLW9NYPVGbKq/79ooZL4bkpTAoYHmbp3C3xXaCYGp1pSzxy79HHc46bmn4yxF8zr
         VCl0gB3p81ePFR2Vheu2BXxncQd+PVrwLIO3tivUDNPMDfYiYf0vSgoXhJohV70HtW
         UbCx/X16K93C/U1017ms10b96VSYr9qHLl1IymA5e1ONQD/z+1HQ16HBR6cxEH+Plz
         B4+WTj3FrWRmw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o7EDp-004Z3B-EI;
        Fri, 01 Jul 2022 11:50:01 +0100
MIME-Version: 1.0
Date:   Fri, 01 Jul 2022 11:50:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix 64 bit mmio handle
In-Reply-To: <m2bkua148a.fsf@gmail.com>
References: <20220630161220.53449-1-schspa@gmail.com>
 <87mtdu15ok.wl-maz@kernel.org> <m2bkua148a.fsf@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a5ca4db3db9ef101258cab94d6b7e045@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: schspa@gmail.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-30 17:50, Schspa Shi wrote:
> Marc Zyngier <maz@kernel.org> writes:
> 
>> On Thu, 30 Jun 2022 17:12:20 +0100,
>> Schspa Shi <schspa@gmail.com> wrote:
>>> 
>>> If the len is 8 bytes, we can't get the correct sign extend for
>>> be system.
>> 
>> I'm afraid you'll have to give me a bit more details.
>> 
>>> 
>>> Fix the mask type len and the comparison of length.
>>> 
>>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>>> ---
>>>  arch/arm64/kvm/mmio.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
>>> index 3dd38a151d2a6..0692f8b18f35c 100644
>>> --- a/arch/arm64/kvm/mmio.c
>>> +++ b/arch/arm64/kvm/mmio.c
>>> @@ -81,8 +81,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, 
>>> unsigned int len)
>>>  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>>>  {
>>>  	unsigned long data;
>>> +	unsigned long mask;
>>>  	unsigned int len;
>>> -	int mask;
>>>   	/* Detect an already handled MMIO return */
>>>  	if (unlikely(!vcpu->mmio_needed))
>>> @@ -97,7 +97,7 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>>>  		data = kvm_mmio_read_buf(run->mmio.data, len);
>>>   		if (kvm_vcpu_dabt_issext(vcpu) &&
>>> -		    len < sizeof(unsigned long)) {
>>> +		    len <= sizeof(unsigned long)) {
>> 
>> If you're reading an 8 byte quantity, what is there to sign-extend?
>> Sign extension only makes sense if what you're reading is *smaller*
>> than the size of the register you are targeting.
>> 
> 
> Yes, you are correct, sorry for my bad patch.
> Please ignore this patch.
> 
>> I must be missing something. And how is that related to running BE? BE
>> in the host? The guest?
> 
> I mean BE is for guest running with BE mode.

So what problem did you see? If you have noticed something going
wrong, I'd like to get it fixed.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
