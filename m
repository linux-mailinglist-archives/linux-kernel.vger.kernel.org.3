Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D34F868E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbiDGRup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiDGRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:50:42 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0971F0462
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:48:25 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id t4so5577231pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ylGqf4i8xaVHnuzuNWAr0rdTSo9ggN34EheyoaVllw=;
        b=T2XNQRl+r0zIk1OVANQpnZ0kLjjeMgE3T1kBSsEGPJ/WdktFsvAc6X1DcFRBLJ7mXg
         1Pb558/lqG3HBzLaYiOUJtl+vFvbc0IFPOfaPNP1pkXW8UwqxKmu3yHnPqHHHXDCn/Ee
         qR5agD1tj66okNOXjq8CR9JdBjoHqbekDcnLMfdocVzpTAJtb23SiMaUGSWtSGNCdFO3
         JdYOdYW9CBhjqgmsk/96rqmSmtHRwBmoBDOXQoyh31jggD2mHXLUIYoAk90jtAUP8/vB
         59FDufcnLIH89VvuMJ9R5IlLMlUuujlWd4acEgEC2mWXax4J2y6zr6micuF65FeWVXvQ
         gFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ylGqf4i8xaVHnuzuNWAr0rdTSo9ggN34EheyoaVllw=;
        b=rdm2tuz5CHuc7kipjZVnix34GBE/sGUIoYOiOFZe3DLLhsGc3mztc5X+fVr3hk38aq
         3T7Fwb0MIHiIRIa97DQGL7q6vDvjsjLrcsRbOy1Dc7yIRnxyvVzH9qy4XMz7/QdduZTF
         I6aPEF/7WzpDrBihC309xByWIWP/KFeejzvrvPsy+JpXqtR8m8MLtT04faaZRnv1EBRu
         ILzYbHbTC1oQtHgbN50ElvWSl8hp778y7RLEjBCbelHwJKqN/ciVwrRUuRtK29zp6E9s
         dNESwrTkXtQ17Nn55S5Ps4yOKJKZ0Sb1O38Iezuih5kX8yJIrja7NyCf9vEKUDPnfh3b
         4ECA==
X-Gm-Message-State: AOAM532e7Xb3BaCttlf2646v3mFN/twR7wCVwvoXtXQT0S1PCa30GX6o
        wO7ZmUrdmjlZZd7SrFNK0q+8tQ==
X-Google-Smtp-Source: ABdhPJz9gLSTqTEoNtyZG0nVnVCMWvVfvlkvkWMvPMxGQ/pln4HEy6TzKBmrC6xpjbWUw0Q91GsMzw==
X-Received: by 2002:a05:6a00:1252:b0:4fa:afcc:7d24 with SMTP id u18-20020a056a00125200b004faafcc7d24mr15180138pfi.85.1649353643466;
        Thu, 07 Apr 2022 10:47:23 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090a2f8600b001cb162f1f52sm2829320pjd.53.2022.04.07.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:47:22 -0700 (PDT)
Date:   Thu, 7 Apr 2022 17:47:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/31] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
Message-ID: <Yk8jp5ZoQO6X8aTG@google.com>
References: <20220407155645.940890-1-vkuznets@redhat.com>
 <20220407155645.940890-4-vkuznets@redhat.com>
 <Yk8gTB+x2UVE34Ds@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk8gTB+x2UVE34Ds@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022, Sean Christopherson wrote:
> > @@ -1857,12 +1940,13 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
> >  	struct hv_tlb_flush_ex flush_ex;
> >  	struct hv_tlb_flush flush;
> >  	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> > +	u64 entries[KVM_HV_TLB_FLUSH_RING_SIZE - 2];
> 
> What's up with the -2?  And given the multitude of things going on in this code,
> I'd strongly prefer this be tlbflush_entries.
> 
> Actually, if you do:
> 
> 	u64 __tlbflush_entries[KVM_HV_TLB_FLUSH_RING_SIZE - 2];
> 	u64 *tlbflush_entries;

Looking at future patches, tlb_flush_entries is better for consistency (apply everywhere).

> and drop all_addr, the code to get entries can be
> 
> 	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
> 	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX ||
> 	    hc->rep_cnt > ARRAY_SIZE(tlbflush_entries)) {
> 		tlbfluish_entries = NULL;
> 	} else {
> 		if (kvm_hv_get_tlbflush_entries(kvm, hc, __tlbflush_entries,
> 						consumed_xmm_halves, data_offset))
> 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> 		tlbfluish_entries = __tlbflush_entries;

Heh, fluish, because TLB entries are somewhat fluid?

> 	}
> 
> and the calls to queue flushes becomes
> 
> 			hv_tlb_flush_ring_enqueue(v, tlbflush_entries, hc->rep_cnt);
> 
> That way a bug will "just" be a NULL pointer dereference and not consumption of
> uninitialized data (though such a bug might be caught be caught by the compiler).
