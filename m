Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46B44D1DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbiCHQyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiCHQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:54:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7DB3586C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:53:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so2947033pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aw18J68slMX3u6w2BrCY37hjJvd4h9lWvYqiNLs4b7Y=;
        b=rzRbOfUZOfhElw8AngwSYQi0wDv+onU3eZNvsbkqdyxvclz7Zr6mzrE32F2JkXEB3h
         qquq89/Nfnnx+ocxbv7dxKi6o1WdyAJJCf4x8MMUYl6HuvevN3g1+Sc1iK4XFOTam9kk
         LImDreePxQ/+7vLjuufPF+nN1ptc4DEmfLhZo55PMXI4yO+vg3oPSf1wmlIzcvDBMaps
         sO4cAAJc+uzjuw/EJmxufPiJbs5mpgOOAnj+GA3rfc5wBWrmZqDW6HCQ6OusDc4JXrKE
         buRXaU367GtMJ803qGtPhfIhcirjhgRLUDlUnSmC5kxeIj88+KW1oRcMTkAElv4EeHqH
         WzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aw18J68slMX3u6w2BrCY37hjJvd4h9lWvYqiNLs4b7Y=;
        b=5An1OgEXjBMvfhmeX7CgeoH0nogNEN+S/azUDDFc5fhg8IcZ88lj5B/vWt6DDeFwSY
         pT4/9b+EwI3iGOrxnUzT7BRtdPBYQVRmgPaiq+PqEmncIpCpAx38+aYrnTf7teiRZLj9
         Nj11F8qPpoWwHEj3dfDEleYoQulZm5FlLe6CNDqMpKPxvBDPPbkFKcoEsclhjysNvFR5
         vixAJG354sDPzY1IfRC/q5LlF7tHciWX8V3VEfESUw86+kO4+LWYZ/rvBfl07omVfg4r
         t0hiZEJOGFWkkLGYklGy3wcVKjmL5tMmiZkHHY5mq3LLZB/rObqFcijFkqF4V1jBy/nb
         31NA==
X-Gm-Message-State: AOAM531pL7dIgzR0DxygWYcXiVtC3Hk/MhUucYRD1NvLJfKf1P/iHkHh
        y4Yh1j3fJoqD4TtszDRsnN3o9g==
X-Google-Smtp-Source: ABdhPJwgJzz9fp6vtbUf9hQK5YdRHFNGxcelBmBpwGv/bCRXr90BgcERD99wdZgWPE6ZvkBRi3yAQw==
X-Received: by 2002:a17:90a:bf91:b0:1b9:bda3:10ff with SMTP id d17-20020a17090abf9100b001b9bda310ffmr5617947pjs.38.1646758394503;
        Tue, 08 Mar 2022 08:53:14 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004e10af156adsm20976388pfc.190.2022.03.08.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:53:13 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:53:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 01/25] KVM: x86/mmu: avoid indirect call for get_cr3
Message-ID: <YieJ9lkq7R87m1mJ@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-2-pbonzini@redhat.com>
 <YieBXzkOkB9SZpyp@google.com>
 <2652c27e-ce8c-eb40-1979-9fe732aa9085@redhat.com>
 <YieFKfjrgTTnYkL7@google.com>
 <96ff1628-eeb2-4d12-f4eb-287dd8fc9948@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96ff1628-eeb2-4d12-f4eb-287dd8fc9948@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022, Paolo Bonzini wrote:
> On 3/8/22 17:32, Sean Christopherson wrote:
> > 
> > Aha!  An idea that would provide line of sight to avoiding retpoline in all cases
> > once we use static_call() for nested_ops, which I really want to do...  Drop the
> > mmu hook entirely and replace it with:
> > 
> > static inline kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu)
> > {
> > 	if (!mmu_is_nested(vcpu))
> > 		return kvm_read_cr3(vcpu);
> > 	else
> > 		return kvm_x86_ops.nested_ops->get_guest_pgd(vcpu);
> > }
> 
> Makes sense, but I think you mean
> 
> static inline unsigned long kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu,
> 						  struct kvm_mmu *mmu)
> {
> 	if (unlikely(vcpu == &vcpu->arch.guest_mmu))

Well, not that certainly :-)

	if (mmu == &vcpu->arch.guest_mmu)

But you're right, we need to be able to do kvm_read_cr3() for the actual nested_mmu.

> 		return kvm_x86_ops.nested_ops->get_guest_pgd(vcpu);
> 	else
> 		return kvm_read_cr3(vcpu);
> }
> 
> ?
