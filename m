Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8531A566FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiGENu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGENt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:49:58 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C47222B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:21:49 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31c89653790so57534577b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IPoGdykj+3ee/wM/cq+WRQhuSgY/3IBkzM+/n+knw/o=;
        b=Iwv1GaJPNpzttmaDpb2UYiSLiAGDot6cyW22FF1AEszYAels7JAPnb2oCBil//6frD
         /DSGD6fsIS8LvkN/mnKlz4W+Dlq35D85SJvNYA17zEQCXXEsv8yTFxu7VjYHoSn+7Xuu
         x7+2zltTig1CXhfsquZNiFT4GVOI55+D0QD98dc5mKeOno0uXXG475kkiXF9Cilyw42O
         BgraIMWL8lSMk5t6EnvxD+q+KHFonvuAhIwFsAuTPqWjSWJPfjRS4KiB+4vtQ9stk9pk
         BJvnQ+kQeVFqtp/JMWl/8aETR1TsyC4m0lmwspJH5HTmI6guKE3LbhSdeMYMQ80bh46U
         y42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IPoGdykj+3ee/wM/cq+WRQhuSgY/3IBkzM+/n+knw/o=;
        b=FfOTpd1x8wD9k1F/xhthiHjRN65wFHN3LCMZwnJVcgz7BupQ2APhrXTE+DYhQtSsbZ
         Pe0vcwJU+s4niUpjPWjojqE8KKtrrAHlB5zzaKmyXGX+hwQxl55qAtu8lGaj1wPI05dr
         1n9C+BTGSCFwQUCgYm8Th/VBlKjsx7fYc5TLu9NgGI64ca7NIQQhv/iPYcM4eo+T/IN1
         m6sqRp9a8Mp2PigRcfKU39/fDTHp+wn+KKZp01FXdgPlNCUBloFDPsqFR5sX0vmMYDNc
         hT5la3ztBtoeKjB6ZIlljaK8W4LksrC50aOjqSllyxexAZytESEDw1Hix5FrtRZTOCRo
         P8gA==
X-Gm-Message-State: AJIora/tuUFZkbBfuLJP1q2CcD6YxItLehiAdKsvh81CZoqMwd/O0NHt
        Ybtfhw7QkiGHX3rkiYver0GiZZULR4RWSy83tMRYnfk6oDQ=
X-Google-Smtp-Source: AGRyM1vGGiRxQfSaIpmJ2YAqaULSewOVGcEtCJIP4MqQQgb6Ky7gRu1fHCu0YHIQzl+JjesZxQqWGdiRJst6Z60ureI=
X-Received: by 2002:a0d:ca93:0:b0:31b:ac58:1047 with SMTP id
 m141-20020a0dca93000000b0031bac581047mr38169568ywd.323.1657027308488; Tue, 05
 Jul 2022 06:21:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:f944:0:0:0:0:0 with HTTP; Tue, 5 Jul 2022 06:21:47 -0700 (PDT)
In-Reply-To: <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com> <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 5 Jul 2022 10:21:47 -0300
Message-ID: <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     Kai Huang <kai.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com
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

On 7/5/22, Kai Huang <kai.huang@intel.com> wrote:
> On Mon, 2022-07-04 at 11:22 -0300, Martin Fernandez wrote:
>> Right now the only way to check this is by greping the kernel logs,
>> which is inconvenient. This is currently checked for fwupd for
>> example.
>>
>> I understand that cpuinfo is supposed to report every feature in the
>> cpu but since AMD is doing the same (and it also broke backwards
>> compatibility [1]) for sme/sev I think it's good to have this for
>> Intel too.
>>
>> Another option to prevent greping the logs would be a file in
>> sysfs. I'm open to suggestions to where to place this infomartion. I
>> saw a proposal about a firmware security filesystem [2]; that would
>> fit perfectly.
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=08f253ec3767bcfafc5d32617a92cee57c63968e
>>
>> [2]
>> https://lore.kernel.org/all/20220622215648.96723-3-nayna@linux.ibm.com/
>
> Leave above to others, but...
>>
>> Changelog since v1
>>
>> Clear the flag not only for BSP but for every cpu in the system.
>
> ... the changelog history shouldn't be in the commit message.
>
> You can put one additional '---' after your 'Signed-off-by' and add your
> changelog after it.  The content between two '---'s will be stripped away
> by
> 'git am' when maintainer takes the patch:
>
> 	Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> 	---
> 	v1->v2:
> 		xxx
> 	---
> 	arch/x86/kernel/cpu/intel.c | 1 +
> 	1 file changed, 1 insertion(+)'

Thanks!, didn't know about it, makes sense.

>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>>  arch/x86/kernel/cpu/intel.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index fd5dead8371c..17f23e23f911 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -570,6 +570,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
>>
>>  	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
>> !TME_ACTIVATE_ENABLED(tme_activate)) {
>>  		pr_info_once("x86/tme: not enabled by BIOS\n");
>> +		clear_cpu_cap(c, X86_FEATURE_TME);
>>  		mktme_status = MKTME_DISABLED;
>>  		return;
>
> This code change itself looks good to me.
>
> But, TME actually supports bypassing TME encryption/decryption by setting 1
> to
> bit 31 to IA32_TME_ACTIVATE MSR.  See 'Table 4-2 IA32_TME_ACTIVATE MSR' in
> MKTME
> spec below:
>
> https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/002/intel-multi-key-total-memory-encryption/
>
> When bit 31 is set, the TME is bypassed (no encryption/decryption for KeyID
> 0).
>
> So looks userspace also needs to check this if it wants to truly check
> whether
> "TME memory encryption" is active.
>
> But perhaps it's arguable whether we can also clear TME flag in this case.

Yep, that's what I thought.

> So:
>
> Acked-by: Kai Huang <kai.huang@intel.com>
>
>
> --
> Thanks,
> -Kai
>
>
>
