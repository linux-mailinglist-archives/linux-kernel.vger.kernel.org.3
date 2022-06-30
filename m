Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9203E56209C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiF3Qy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiF3Qy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:54:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC4393DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:54:56 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s17so19709512iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=3yzQoY2ucWrQqXREQTyNPjG4X86W8VdDP00R8nZTgn0=;
        b=gKHIqcp0AXkJmHeV5RhLZd4icY5aYh4HmgWSU7ggoO73jfesxxLYVvV03O8gLsc2g5
         +cOwbiWrWLrnxa5Ivba04k23sLZ/VzDqvVJGxIuNRO5EFyAaZT8XPV48zebXLz7r3zPE
         nRM+1xIjvy9uFrtZkqNlL92HXCv2ysiQc2OBuTiijyC60csdeQWNQUric+SODQoFdcNO
         +f5AT3XUhy8XYk6g7mLvG0i5OjWUMLHCs5JRBTmY/dYg2Bx0dAaSfEcVomqUN6GSSFmM
         bFdS0Oweb2Xt6h1Wo2E36OtoM61U2v81mUipbJ64BoAnv3q3w5ZV7NEw6i9ETiEp66jF
         dXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=3yzQoY2ucWrQqXREQTyNPjG4X86W8VdDP00R8nZTgn0=;
        b=0vN+jm288QKAzUMGr+qKkve/NAxQFBup1ryvC8wt3N+UXuB1Vbg9Y52R4QI+3XLy6z
         olexXYUgb4uAPL9DN/ceGSxTUOaitovJI51w08tC9rIvmAjwZ47Iz0smgamvq1Thjunf
         tfT2y7zM/cutoIH5CB6TGnWXTjQvQK+8SpFDBboue0Hrd8eCqGrU56RRF5ljmL75KOO9
         //vdzlprB27f2VhaLLZeyOA0NQfPTXVgQAC+06gltaPMRJmKjkOaUrYOzLRrHM/eLdRE
         pxM6Fztt0FlBEKqpqP42RGLTsG11d4Qt5/T+aishp6K55pGXjwuB4Faacxobs9LPHZqO
         fXfw==
X-Gm-Message-State: AJIora8o043UJzKUcuIMjGwTlF6Ed0q98GN7NWZpwwWMV1cvTCbDPmxK
        iyh2UVWBK5pE4mvXZtOZ95c/8ufMKq4BCg==
X-Google-Smtp-Source: AGRyM1t1lqGrk46YUgq5ZmtKS2YxO4+SXDt+L/ChvS1zfaHjZTfXt/gVL3fenni78YqCtJp7hGr+WQ==
X-Received: by 2002:a05:6638:1a8d:b0:33c:9a98:ff2d with SMTP id ce13-20020a0566381a8d00b0033c9a98ff2dmr6243491jab.31.1656608095139;
        Thu, 30 Jun 2022 09:54:55 -0700 (PDT)
Received: from ArchLinux ([240e:390:a20:ece0:3ad5:47ff:feb5:73b2])
        by smtp.gmail.com with ESMTPSA id p7-20020a02b007000000b00339dd3976absm8723936jah.110.2022.06.30.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:54:54 -0700 (PDT)
References: <20220630161220.53449-1-schspa@gmail.com>
 <87mtdu15ok.wl-maz@kernel.org>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix 64 bit mmio handle
Date:   Fri, 01 Jul 2022 00:50:59 +0800
In-reply-to: <87mtdu15ok.wl-maz@kernel.org>
Message-ID: <m2bkua148a.fsf@gmail.com>
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

> On Thu, 30 Jun 2022 17:12:20 +0100,
> Schspa Shi <schspa@gmail.com> wrote:
>> 
>> If the len is 8 bytes, we can't get the correct sign extend for
>> be system.
>
> I'm afraid you'll have to give me a bit more details.
>
>> 
>> Fix the mask type len and the comparison of length.
>> 
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  arch/arm64/kvm/mmio.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
>> index 3dd38a151d2a6..0692f8b18f35c 100644
>> --- a/arch/arm64/kvm/mmio.c
>> +++ b/arch/arm64/kvm/mmio.c
>> @@ -81,8 +81,8 @@ unsigned long kvm_mmio_read_buf(const void 
>> *buf, unsigned int len)
>>  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>>  {
>>  	unsigned long data;
>> +	unsigned long mask;
>>  	unsigned int len;
>> -	int mask;
>>  
>>  	/* Detect an already handled MMIO return */
>>  	if (unlikely(!vcpu->mmio_needed))
>> @@ -97,7 +97,7 @@ int kvm_handle_mmio_return(struct kvm_vcpu 
>> *vcpu)
>>  		data = kvm_mmio_read_buf(run->mmio.data, len);
>>  
>>  		if (kvm_vcpu_dabt_issext(vcpu) &&
>> -		    len < sizeof(unsigned long)) {
>> +		    len <= sizeof(unsigned long)) {
>
> If you're reading an 8 byte quantity, what is there to 
> sign-extend?
> Sign extension only makes sense if what you're reading is 
> *smaller*
> than the size of the register you are targeting.
>

Yes, you are correct, sorry for my bad patch.
Please ignore this patch.

> I must be missing something. And how is that related to running 
> BE? BE
> in the host? The guest?

I mean BE is for guest running with BE mode.

>
> Please convince me.
>
> 	M.

-- 
BRs
Schspa Shi
