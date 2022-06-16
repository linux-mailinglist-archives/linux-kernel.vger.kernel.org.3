Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF854E34F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377674AbiFPOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377441AbiFPOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:23:19 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D69240AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:23:18 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-317741c86fdso13776317b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Quvgg9TT1sJ7rZx0Qc3rOqTl2Vqp1hUlztudbikfDio=;
        b=hxDkmJK8xMN3j72+YV82VC5LKIQWFBeOrzWUE2hoFsCMiujcuCCp7t0e7SFQvkgHB0
         aG25Zhb2ZdiUFAtDNKWUhmJHD1s0LTBVwrWNVs6+ue8yN15OAtr4od8xiGztHYsFqRo/
         FRdupSxsE3qULP1Y0v+LhDPMvxVlOQdW1TPa56e48t3mP1OvO4eQ0EroCDEtWGT7y7L5
         4EnVCwx/gl1/WIS0CA+dTpJQf7AnxwatGeeW1FMaK8GYxyRL4gMAiUHkjpCY2QgunWwx
         fwL5lDFj6bYghq5On99wX/z9iyaf6B1rsG96fBWr9R/Ix+TLAKwtjCdnZwIESBJjYFXE
         bm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Quvgg9TT1sJ7rZx0Qc3rOqTl2Vqp1hUlztudbikfDio=;
        b=J+AkN/YMc2lA08PYyz39iW+QnfqgebgsTZF234JWRG/BUUZGeF5Nry1Ms/xX+IzX1S
         62ffD07I/6frr05BPnW0mrrtx66GP4tBWKV/N1sFCYy6Y1GJGe5dDVe2lGvEroxPdmv2
         gs6tbcrWLW1fIBoi6aqnbcWV8VazaVW0fS0EK5Pz3FOv3RjQN6Q4RE626hdfV/13i+u/
         um4N423oTJ+8Lqt/KdyUEVTlJovz/ksaZvWl0T1G3iddAPPOJdFKpGuYEkSVidCqwoII
         b+7Lck3VhZpArBCUrrNsVICs+r6okZanqClCgayI8wJ/TMO6EKYKCuyIZsbU87peXU2+
         WP2A==
X-Gm-Message-State: AJIora/ABgKbEtVlRNpMt6+ZJ5i775fXLKhCgeNeJ8IzOJy7y032Sd4w
        loQt6PwQWkrLCiI/o+oXfFa9cU8hLKKVKn3q5IKCQA==
X-Google-Smtp-Source: AGRyM1spyUZ7W5puT5JmITJuY0l4a2+pykCPOVv3xRaOVPgVcH28oB0sWrREzJ7z81r+E5YqC4isfDRcGmqHxvslhQE=
X-Received: by 2002:a0d:d1c3:0:b0:313:eca0:bf42 with SMTP id
 t186-20020a0dd1c3000000b00313eca0bf42mr5949985ywd.369.1655389397686; Thu, 16
 Jun 2022 07:23:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:af52:0:0:0:0:0 with HTTP; Thu, 16 Jun 2022 07:23:16
 -0700 (PDT)
In-Reply-To: <3b274c9a58ddfba8bd37827519aec541d1838697.camel@intel.com>
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com> <3b274c9a58ddfba8bd37827519aec541d1838697.camel@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 16 Jun 2022 11:23:16 -0300
Message-ID: <CAKgze5YXqi_+bbxCKd_yped5Vx=H8u0dc7uXH3WdF4T5oTOPFQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     Kai Huang <kai.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22, Kai Huang <kai.huang@intel.com> wrote:
> On Tue, 2022-06-14 at 18:02 -0300, Martin Fernandez wrote:
>> Right now the only way to check this is by greping the kernel logs,
>> which is inconvinient. This is currently checked for fwupd for
>> example.
>>
>> I understand that cpuinfo is supposed to report every feature in the
>> cpu but since AMD is doing the same for sme/sev I think is good to
>> have this for Intel too.
>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>>  arch/x86/kernel/cpu/intel.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index fd5dead8371c..7311172aceaf 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -570,6 +570,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
>>
>>  	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
>> !TME_ACTIVATE_ENABLED(tme_activate)) {
>>  		pr_info_once("x86/tme: not enabled by BIOS\n");
>> +		if (mktme_status == MKTME_UNINITIALIZED)
>> +			clear_cpu_cap(c, X86_FEATURE_TME);
>
> The above code seems only clear TME on BSP, if I read correctly.  Why not
> unconditionally clear this flag?  If TME is detected as not enabled by BIOS
> on
> *this* cpu, then the flag for *this* cpu should be cleared.

Yes, I think you're right. Thanks.

> Also could you CC Kirill A. Shutemov <kirill.shutemov@linux.intel.com>, who
> is
> the original author of this code?

I'll add Kirill for the next version, thank you for mention it.

>>  		mktme_status = MKTME_DISABLED;
>>  		return;
>>  	}
>> --
>> 2.30.2
>>
>
> --
> Thanks,
> -Kai
>
>
>
