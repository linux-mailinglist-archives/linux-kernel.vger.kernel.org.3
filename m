Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB51584719
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiG1UlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:41:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77FA683E3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:41:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so5739921pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=HFpO6jXv+thLIEQmIbyzTm5jXFu4Gb0lIjJbAQsrEBg=;
        b=aoqiVzJqBUfNWGKmug4CGVbsDsNx+O56FJEyWStkwyukKWyC0Oh9JgPMLicB6uvdAS
         FhJwN8mlZCK1chuNvxIAueX6DRpnawWaKcvjicasit8HCZUKQzDXouMjGsmuKynft9U9
         RE6V3Xx51zrUJnpMcMXN1kPM88/Ld7cBfLoFBaRWZv72mG6a0RuE6j86k7WlV5NWRycI
         STaX6kpYhyLRJFsDJRoskx4z7OLJLa2ddRpg5LxZyJFYIC4nMGaPQoAtIm2MFJWwqHMw
         zY5aD9YNHbIKQ31VtzNXg86MzdDGpzrySC1pMJ8it60kedxFcMSv9JmbGzbosDJGwGQU
         Oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HFpO6jXv+thLIEQmIbyzTm5jXFu4Gb0lIjJbAQsrEBg=;
        b=l5MAIMuMs8dCUIYs/dkx0mIIF/MF0GvrE3/ZlpaZKhwDi6q5KYthoM9unAbmIMtrNR
         2+bmVIO0nMJWHZ06xsMMP4vjBpmjPSW9nBmCI5iAtaV7Y6vx4VIP9Ug3iv6vyY/zXREn
         71h2hTp2OAIpypRHiZuAwhd5zzQR0AlJnUAXhwoO4ARArS41jnNHP0Plu1YPduiSud1Y
         VVtYgvRGfEJQbO3gm1MB51+5wuXaUrSIgkWZaTMgslG5ltFT5OdDKtIP92Bu6AVXgKz0
         ZJ4SLPbOb685QkW2Ou/rc/8smj7AwevwXqEa0wz8ifHJaJZy6PyIUr+cbHa4RLPf4C9j
         +hSA==
X-Gm-Message-State: ACgBeo2iCXnDxePBI1w0tOWqv8HZjMZmr0UovtfQG2LkRMbBJbI5ZCbS
        7YiB070vKpV4duXpyw7S5B0Dnw==
X-Google-Smtp-Source: AA6agR54UwxPWT+BJOMkCljAJZfwv/32I4EBEEeqIHnPKrlI00ej/DcuGkMtWit4bE0esUs0+oMo5g==
X-Received: by 2002:a17:90a:8c88:b0:1f2:12b0:ae9e with SMTP id b8-20020a17090a8c8800b001f212b0ae9emr1208812pjo.42.1659040878988;
        Thu, 28 Jul 2022 13:41:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b0016daee46b72sm1713570plb.237.2022.07.28.13.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 13:41:18 -0700 (PDT)
Date:   Thu, 28 Jul 2022 20:41:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Coleman Dietsch <dietschc@csp.edu>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86/xen: Fix bug in kvm_xen_vcpu_set_attr()
Message-ID: <YuL0auT3lFhfQHeY@google.com>
References: <20220728194736.383727-1-dietschc@csp.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728194736.383727-1-dietschc@csp.edu>
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

Be more specific in the shortlog.  "Fix a bug in XYZ" doesn't provide any info
about the bug itself, and can even become frustratingly stale if XYZ is renamed.
I believe we should end up with two patches (see below), e.g.

  KVM: x86/xen: Initialize Xen timer only once (when it's NOT running)

and
  
  KVM: x86/xen: Stop Xen timer before changing the IRQ vector

Note, I'm assuming timer_virq is a vector of some form, I haven't actually looked
that far into the code.

On Thu, Jul 28, 2022, Coleman Dietsch wrote:
> This crash appears to be happening when vcpu->arch.xen.timer is already set

Instead of saying "This crash", provide the actual splat (sanitized to make it
more readable).  That way readers, reviewers, and archaeologists don't need to
open up a hyperlink to get details on what broken.

> and kvm_xen_init_timer(vcpu) is called.

Wrap changelogs at ~75 chars.

> During testing with the syzbot reproducer code it seemed apparent that the
> else if statement in the KVM_XEN_VCPU_ATTR_TYPE_TIMER switch case was not
> being reached, which is where the kvm_xen_stop_timer(vcpu) call is located.

Neither the shortlog nor the changelog actually says anything about what is actually
being changed.

> Link: https://syzkaller.appspot.com/bug?id=8234a9dfd3aafbf092cc5a7cd9842e3ebc45fc42
> Reported-and-tested-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
> Signed-off-by: Coleman Dietsch <dietschc@csp.edu>
> ---
>  arch/x86/kvm/xen.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 610beba35907..4b4b985813c5 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -707,6 +707,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  		break;
>  
>  	case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
> +		/* Stop current timer if it is enabled */
> +		if (kvm_xen_timer_enabled(vcpu)) {
> +			kvm_xen_stop_timer(vcpu);
> +			vcpu->arch.xen.timer_virq = 0;
> +		}
> +
>  		if (data->u.timer.port) {
>  			if (data->u.timer.priority != KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL) {
>  				r = -EINVAL;

I'm not entirely sure this is correct.  Probably doesn't matter, but there's a
subtle ABI change here in that invoking the ioctl with a "bad" priority will
cancel any existing timer.

And there appear to be two separate bugs: initializing the hrtimer while it's
running, and not canceling a running timer before changing timer_virq.

Calling kvm_xen_init_timer() on "every" KVM_XEN_VCPU_ATTR_TYPE_TIMER is odd and
unnecessary, it only needs to be called once during vCPU setup.  If Xen doesn't
have such a hook, then a !ULL check can be done on vcpu->arch.xen.timer.function
to initialize the timer on-demand.

With that out of the way, the code can be streamlined a bit, e.g. something like
this?

	case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
		if (data->u.timer.port &&
		    data->u.timer.priority != KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL) {
			r = -EINVAL;
			break;
		}

		if (!vcpu->arch.xen.timer.function)
			kvm_xen_init_timer(vcpu);

		/* Stop the timer (if it's running) before changing the vector. */
		kvm_xen_stop_timer(vcpu);
		vcpu->arch.xen.timer_virq = data->u.timer.port;

		if (data->u.timer.port && data->u.timer.expires_ns)
			kvm_xen_start_timer(vcpu, data->u.timer.expires_ns,
					    data->u.timer.expires_ns -
					    get_kvmclock_ns(vcpu->kvm));
		r = 0;
		break;

> @@ -720,9 +726,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  				kvm_xen_start_timer(vcpu, data->u.timer.expires_ns,
>  						    data->u.timer.expires_ns -
>  						    get_kvmclock_ns(vcpu->kvm));
> -		} else if (kvm_xen_timer_enabled(vcpu)) {
> -			kvm_xen_stop_timer(vcpu);
> -			vcpu->arch.xen.timer_virq = 0;
>  		}
>  
>  		r = 0;
> -- 
> 2.34.1
> 
