Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE74AC90F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiBGTA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiBGS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:59:52 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC2C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:59:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v74so14606150pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CtWHOL3r0vE0dVNQ7OfegrmekIbjr0Qo1AupSU7062w=;
        b=Q9EhMoHSpFDJ6+BzYiTUsC0IPnS7w9fC56SvLY++6V0VB+dEFV+rFTOOBuef6TFHuq
         uoSH+39f44KoYdj1VzCe7Hu2+SZ28EDXFO9iJ/rEXnJMWX0ohYnr8nAQ58EwKaLDOEbt
         gexeu+kblTBER96is4+7sCF9nj1EHi3hXTOmjy4fUMmJnkgHpoFZQ9UrLlC0q2oGwfZQ
         TpKufWSzvkY712OKqyFR5OUm7agZXdp/0XmyLCULUDn1RyMw0yZzG3G261CGvsFx8LOW
         aAXEWUKFy+wKGnkz7S7nNHAlCVEXWYoMFIBizNWfKYukWvYLHbVg6ToDjNWq6DeBfUDw
         R4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CtWHOL3r0vE0dVNQ7OfegrmekIbjr0Qo1AupSU7062w=;
        b=fAECSyX3h1Jbj8PJbd60ZYxgvmVxOXY0gfHK24I9d637I5ndSyLY5UHJ66LULq5Qph
         ucn6MbnRF3CXV/o+nQixK7899lkulBB/+6nR+J/hdFQGrDDdNRWvlVdnHtHKBJkg+IMs
         wu11uWdRKn4ABXQsZ20ib1gqkv1bdDus2ZRMfO5KWZH2vURV3aBY8BSBp6c0jek2+5Sv
         Hwl0bfkm7hLClSyhlxIIYCq+FEiKFzOmnSXeuxZqNNYkuDjT5TEr63FPaoOdLMNxEVMX
         qd/O9Sx64AdaNzYIsiNqsgLzkFr6O4+W2dmmjRwXGTAYAtrgjnurql84Sg7BufjqGd15
         P09A==
X-Gm-Message-State: AOAM532c0/dnaTtoqWn84YZX0istkezeHe4Q8PQ4X2g154n+4J7/Rl6v
        ubveS6PhLCEUAgS4V+c3PC6K6Q==
X-Google-Smtp-Source: ABdhPJwU6XnczZxNDXE76ffRZ3HcVN5y3W4ndgLuIbSYt0r3zqGJKU3yxvLmSmDqNZy+GIcP8ni1Tw==
X-Received: by 2002:aa7:8892:: with SMTP id z18mr789005pfe.15.1644260391118;
        Mon, 07 Feb 2022 10:59:51 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p2sm97744pjo.38.2022.02.07.10.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:59:50 -0800 (PST)
Date:   Mon, 7 Feb 2022 18:59:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lirongqing@baidu.com, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] KVM: X86: Introduce vfio_intr_stat per-vm debugfs file
Message-ID: <YgFsIyxauHVeepqJ@google.com>
References: <1642593015-28729-1-git-send-email-yuanzhaoxiong@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642593015-28729-1-git-send-email-yuanzhaoxiong@baidu.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022, Yuan ZhaoXiong wrote:
> +#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS

This is pointless, KVM x86 unconditionally selects HAVE_KVM_IRQ_BYPASS.

> +#include <linux/kvm_irqfd.h>
> +#include <asm/irq_remapping.h>
> +#endif
> +
>  static int vcpu_get_timer_advance_ns(void *data, u64 *val)
>  {
>  	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
> @@ -181,9 +186,94 @@ static int kvm_mmu_rmaps_stat_release(struct inode *inode, struct file *file)
>  	.release	= kvm_mmu_rmaps_stat_release,
>  };
>  
> +#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
> +static int kvm_vfio_intr_stat_show(struct seq_file *m, void *v)
> +{
> +	struct kvm_kernel_irq_routing_entry *e;
> +	struct kvm_irq_routing_table *irq_rt;
> +	unsigned int host_irq, guest_irq;
> +	struct kvm_kernel_irqfd *irqfd;
> +	struct kvm *kvm = m->private;
> +	struct kvm_lapic_irq irq;
> +	struct kvm_vcpu *vcpu;
> +	int idx;
> +
> +	if (!kvm_arch_has_assigned_device(kvm) ||
> +			!irq_remapping_cap(IRQ_POSTING_CAP)) {

Bad indentation and unnecessary curly braces.

	if (!kvm_arch_has_assigned_device(kvm) ||
	    !irq_remapping_cap(IRQ_POSTING_CAP))
		return 0;


> +		return 0;
> +	}
> +
> +	seq_printf(m, "%12s %12s %12s %12s\n",
> +			"guest_irq", "host_irq", "vector", "vcpu");

Bad indentation.  Ditto for many cases below.


	seq_printf(m, "%12s %12s %12s %12s\n",
		   "guest_irq", "host_irq", "vector", "vcpu");
	   
> +
> +	spin_lock_irq(&kvm->irqfds.lock);
> +	idx = srcu_read_lock(&kvm->irq_srcu);
> +	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
> +
> +	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
> +		if (!irqfd->producer)
> +			continue;
> +
> +		host_irq = irqfd->producer->irq;
> +		guest_irq = irqfd->gsi;
> +
> +		if (guest_irq >= irq_rt->nr_rt_entries ||
> +				hlist_empty(&irq_rt->map[guest_irq])) {

Indentation.

> +			pr_warn_once("no route for guest_irq %u/%u (broken user space?)\n",
> +					guest_irq, irq_rt->nr_rt_entries);

Indentation, though I personally don't see much point of duplicating the message
from vmx_pi_update_irte(), just continue on.

> +			continue;
> +		}
> +
> +		hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
> +			if (e->type != KVM_IRQ_ROUTING_MSI)
> +				continue;
> +
> +			kvm_set_msi_irq(kvm, e, &irq);
> +			if (kvm_intr_is_single_vcpu(kvm, &irq, &vcpu)) {

Unnecessary curly braces (though this one is debatable).

> +				seq_printf(m, "%12u %12u %12u %12u\n",
> +						guest_irq, host_irq, irq.vector, vcpu->vcpu_id);

Indentation.

> +			}
> +		}
> +	}
> +	srcu_read_unlock(&kvm->irq_srcu, idx);
> +	spin_unlock_irq(&kvm->irqfds.lock);
> +	return 0;
> +}
> +
