Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC257BCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiGTRjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGTRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:39:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98896FA3F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:39:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 17so6751845pfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gKIOhejkrq+Q8uuRF6iQnfl7G8p3hbpVdHm8R8aIKko=;
        b=ajAxf9e0OHyYwpsX9evWazSHyzfB73W7maKkyeCSnXzXmlH15O4GzRs+O0rqWHboM2
         xaSFxnpeCt7qFTqMMS9oN6DJX38iQ3RLx0mOmFcZ6U9W7O/mWx8AyfjwXOHOQvL7H0Rz
         egvk5cESz+hck09fG4WZ1dlpsfjehnzKSqVdX1/DJb5U02Olw7UGzpads16T6KPILxGO
         CenaOBjFSIR0cZpUdrW+EGMT9UCBoCiLO4KSxZblrHalXsskYd6YWpP7LnebWdv9t/iX
         xhRAwAd2Rq5rT3mdzf/OSWlc6+6KWG9i+QTp4TaDwBUmH5pha1uY+kjF/vHKb+XNvPMj
         RA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gKIOhejkrq+Q8uuRF6iQnfl7G8p3hbpVdHm8R8aIKko=;
        b=KUDyqZK60PLYN4ZA1q2jAzZ9qK1RoMORMpQoGby3x1wWRwoqxbiCXghL4jI1mopF9o
         50FdxopNUWlx+4oHfB8jGwZW64xIUYIx2Ac+TJ/jZ31S/K4BjdeaOvDkhYd80D7AzmsO
         niSwyE+E0I1PNsV8ziDYF75XZxCyVd8KCJR0IlElSgw2Xa+V2FHK5NoLWqFLPe9HVjlc
         4dWecjNRe+EocM7IKX59EZAubcr8WCfPGDP9CwMb90QhSbB1II3Y8PqgDE6kZrZ3odfz
         +0EuKc+PVzxrj3wF2wqkSfWwZ+FZ+GnJRNxfmR0mR/VCDYZRDjfmZWtllZ6W7t8eRPux
         SoYA==
X-Gm-Message-State: AJIora/CTXIiGHxEtCCNmvv7cvuMyUjh3dX0H+/jZKTCcO3WS/BjCy7x
        VXkg0TNEXb9aoeJFwyrunTmh0Q==
X-Google-Smtp-Source: AGRyM1soWPcGGf8fAYVmZHjvcI2IFRbHXUOG1yZwYb5ZKKIs1YZVEFCQitJrLQtIHkL7ysf7SiTTNg==
X-Received: by 2002:a05:6a00:2481:b0:52a:d50e:e75e with SMTP id c1-20020a056a00248100b0052ad50ee75emr40449773pfv.43.1658338742013;
        Wed, 20 Jul 2022 10:39:02 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b0016cd74e5f87sm10433764plh.240.2022.07.20.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:39:01 -0700 (PDT)
Date:   Wed, 20 Jul 2022 17:38:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Kechen Lu <kechenl@nvidia.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, somduttar@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 5/7] KVM: x86: add vCPU scoped toggling for
 disabled exits
Message-ID: <Ytg9shoNq9XfTiHS@google.com>
References: <20220615011622.136646-1-kechenl@nvidia.com>
 <20220615011622.136646-6-kechenl@nvidia.com>
 <20220615024311.GA7808@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615024311.GA7808@gao-cwp>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022, Chao Gao wrote:
> >@@ -5980,6 +5987,8 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
> > int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> > 			    struct kvm_enable_cap *cap)
> > {
> >+	struct kvm_vcpu *vcpu;
> >+	unsigned long i;
> > 	int r;
> > 
> > 	if (cap->flags)
> >@@ -6036,14 +6045,17 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> > 			break;
> > 
> > 		mutex_lock(&kvm->lock);
> >-		if (kvm->created_vcpus)
> >-			goto disable_exits_unlock;
> >+		if (kvm->created_vcpus) {
> >+			kvm_for_each_vcpu(i, vcpu, kvm) {
> >+				kvm_ioctl_disable_exits(vcpu->arch, cap->args[0]);
> >+				static_call(kvm_x86_update_disabled_exits)(vcpu);
> 
> IMO, this won't work on Intel platforms.

It's not safe on AMD either because at best the behavior is non-deterministic if
the vCPU is already running in the guest, and at worst could cause explosions,
e.g. if hardware doesn't like software modifying in-use VMCB state.

> Because, to manipulate a vCPU's VMCS, vcpu_load() should be invoked in
> advance to load the VMCS.  Alternatively, you can add a request KVM_REQ_XXX
> and defer updating VMCS to the next vCPU entry.

Definitely use a request, doing vcpu_load() from a KVM-scoped ioctl() would be
a mess as KVM would need to acquire the per-vCPU lock for every vCPU.
