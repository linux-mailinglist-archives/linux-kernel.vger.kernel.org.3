Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D70515E76
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382870AbiD3O6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbiD3O6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:58:08 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E262515A3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:54:46 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r17so5638855iln.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NnGCAeCGdC2rOPLY2oMqMtD1zv1olyIAR5RFlZYS+gA=;
        b=a/7ueX23zIupx6WHoMqsapfnlyIq6LOELnCnD7v1Sa5KY95hYZMyfm4kahYII9lfMr
         OzuaTO5pOFUxYfWJytz3ZEBgygOm3+nIKWiEU38lJlVC/9jlZpxFCsbkDxHErAnKsowW
         pFvE4MFmkuiUfs34FkO5FLsWQQq2EfwKagrOEsZW/m3lEnSWlw0+mpb49DKrnAmMcZMK
         Ppk04Z95OUdqvN6s7NtQ3BBeuMAoC2La8ei0fczLIKjXwDp0bPdfRhin+exVl+ZftEG5
         7Om6qYJufbu7hba+ffEJPiOM8LteFXGTIsUr3XJSi3PGu6zIJSuo+9kCKEJ96Q7bpxeW
         +jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NnGCAeCGdC2rOPLY2oMqMtD1zv1olyIAR5RFlZYS+gA=;
        b=gwynpa3Y17E4I9uIquuM7rF075mbZ3yBLjvgzpty3aGVQtBU/Sx/+0cHhBV5XCczyF
         LftiKkmbEPhNAP+fwoejhGxmW17nMHXEsJjyFbEDIuk8ZrSncV+Zj2yMZByNMWiDTxaT
         2Opit73CHn6FIfHgJuuJCN8voyoV5B/x2B3BhVNbvfOC36vSa5ehPVajlHGozJ7QE9KI
         Fzxst67VC+VM5PB31IXdvkNJ2mYqcKk120mQvN0fB2XZiPYEwMcV9R1PZ0KUvBYlU4mz
         uSSc1tszpOz+VJyP9o2SU9LthE2In0AgcMUSLs8pcp7hmRp4v3crpg53kVFoDK33q5sE
         SIPw==
X-Gm-Message-State: AOAM5331Lmbp0dMQNlTSx4FZOR3GqE8/v3LearbXPWlZtj72wGTSZs1T
        VJX/q1Bk5csCG3RgxbJbnaOdBw==
X-Google-Smtp-Source: ABdhPJwyEZqyYROVRVGoDYDjRfNcz69FnbV5ZW8qR0u1NGaJiGU05f6rGpiezo8BzP0zPRfv7lW4wA==
X-Received: by 2002:a92:ca0b:0:b0:2cc:45da:de13 with SMTP id j11-20020a92ca0b000000b002cc45dade13mr1731044ils.146.1651330485174;
        Sat, 30 Apr 2022 07:54:45 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id z5-20020a05663803a500b0032b5b40c82dsm382616jap.65.2022.04.30.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 07:54:44 -0700 (PDT)
Date:   Sat, 30 Apr 2022 14:54:41 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 04/18] KVM: arm64: Support SDEI_EVENT_REGISTER
 hypercall
Message-ID: <Ym1Nsaq/ERUx/ebD@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-5-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-5-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Sun, Apr 03, 2022 at 11:38:57PM +0800, Gavin Shan wrote:
> This supports SDEI_EVENT_REGISTER hypercall, which is used by guest
> to register event. The event won't be raised until it's registered
> and enabled. For those KVM owned events, they can't be registered
> if they aren't exposed.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 78 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 3507e33ec00e..89c1b231cb60 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -25,6 +25,81 @@ static struct kvm_sdei_exposed_event exposed_events[] = {
>  	for (idx = 0, event = &exposed_events[0];	\
>  	     idx < ARRAY_SIZE(exposed_events);		\
>  	     idx++, event++)
> +#define kvm_sdei_for_each_event(vsdei, event, idx)	\
> +	for (idx = 0, event = &vsdei->events[0];	\
> +	     idx < ARRAY_SIZE(exposed_events);		\
> +	     idx++, event++)
> +
> +static struct kvm_sdei_event *find_event(struct kvm_vcpu *vcpu,
> +					 unsigned int num)
> +{
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *event;
> +	int i;
> +
> +	kvm_sdei_for_each_event(vsdei, event, i) {
> +		if (event->exposed_event->num == num)
> +			return event;
> +	}
> +
> +	return NULL;
> +}

I imagine you'll drop this hunk in the next spin.

> +static unsigned long hypercall_register(struct kvm_vcpu *vcpu)

Hmm, hypercall_ is not a very descriptive scope. Could you instead do
something like kvm_sdei_?

so for this one, kvm_sdei_event_register()? Provides decent context
clues to connect back to the spec as well.

> +{
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *event;
> +	unsigned int num = smccc_get_arg(vcpu, 1);
> +	unsigned long ep_address = smccc_get_arg(vcpu, 2);
> +	unsigned long ep_arg = smccc_get_arg(vcpu, 3);

We discussed using some structure to track the registered context of an
event. Maybe just build it on the stack then assign it in the array?

> +	unsigned long route_mode = smccc_get_arg(vcpu, 4);

This is really 'flags'. route_mode is bit[0]. I imagine we don't want to
support relative mode, so bit[1] is useless for us in that case too.

The spec is somewhat imprecise on what happens for reserved flags. The
prototype in section 5.1.2 of [1] suggests that reserved bits must be
zero, but 5.1.2.3 'Client responsibilities' does not state that invalid
flags result in an error.

Arm TF certainly rejects unexpected flags [2].

[1]: DEN0054C https://developer.arm.com/documentation/den0054/latest
[2]: https://github.com/ARM-software/arm-trusted-firmware/blob/66c3906e4c32d675eb06bd081de8a3359f76b84c/services/std_svc/sdei/sdei_main.c#L260

--
Thanks,
Oliver
