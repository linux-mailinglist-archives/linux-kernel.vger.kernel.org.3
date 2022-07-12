Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7B5719B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiGLMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiGLMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7B64564D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657628197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLtO+utoG4qodCG1Q0xb9T25+vkomgAJIsg2wmf1+Qw=;
        b=PDGRw1cQZS3O7uLIqS9WUS9foX0A1BXr92/Zm2RJHESPTf6Sy/Ktz9IyCx2zS12VE1gd7H
        hDQRXlUBUWtJnKpjCsYfA08jwAgtWbEAQ58RQhQZqGbclcyyt2qJ+oKGclj2B/IRTGiJ4w
        enkvl4WIxI59IcBcIY4VJz5siHMC41A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-WkRTj5yOMwiQWdaPObwvYw-1; Tue, 12 Jul 2022 08:16:36 -0400
X-MC-Unique: WkRTj5yOMwiQWdaPObwvYw-1
Received: by mail-qk1-f198.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso7617607qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JLtO+utoG4qodCG1Q0xb9T25+vkomgAJIsg2wmf1+Qw=;
        b=HGcmf8+yHv8ANFt/EO0ehe/XGzHttAF17gBd7bKWd82vtdDBZux/80utsgrhiY2Itv
         Mpeik329zWPBmq6P3LaIaQ0N63BH4ZS8ddDt5o3KZ5jFsKnNqVWz2uJOijVEuMalmxqU
         ZugENnEDKff3Y8uxT1DRQ/jnEUoUDMLiQ4ksj0uDA14f6WGFXK37yCFWLbtKwtuIFrkO
         e5b/a3M05M3n6pXl4LWjL1ZX+W0UAIPd/fVgF8r7tBpi9C8+Mugb5aHvIfylrepfSAkq
         W8HNELpnWSdnglYj8vQnBUyVDerw4WOc/BzmetB0BDtTRTpzc1jQf9/vyJcmtW3n8W+d
         RSnQ==
X-Gm-Message-State: AJIora9ldHCTPKBssM/7qspZDHTkXMQMCkLO0rkxrjmYzwcsd06UpJ7u
        n1qJASZItK6VfZ2Biswf5mQofp/TV26iQWrYheXQL5r8JiuNoEkIG3nR1JamwRwkrVh/bvP02Xt
        DwpU5qNhdVV9TtFnWLGiyKvOZ
X-Received: by 2002:a05:620a:492:b0:6b5:a6ec:b4f3 with SMTP id 18-20020a05620a049200b006b5a6ecb4f3mr1159273qkr.639.1657628196057;
        Tue, 12 Jul 2022 05:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tPS/8+mFo5fVP722REZ/gG45yh2vdOMTH4yFSkeOH+JPVynHXqJpxpi+fNcWAI6npEJ4tpTg==
X-Received: by 2002:a05:620a:492:b0:6b5:a6ec:b4f3 with SMTP id 18-20020a05620a049200b006b5a6ecb4f3mr1159234qkr.639.1657628195727;
        Tue, 12 Jul 2022 05:16:35 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id h4-20020ac846c4000000b00304ea0a86cesm7100977qto.81.2022.07.12.05.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:16:35 -0700 (PDT)
Message-ID: <f9be9f7293ed366d750fa3fa7bb257d4f1b03891.camel@redhat.com>
Subject: Re: [PATCH v3 11/25] KVM: VMX: Get rid of eVMCS specific VMX
 controls sanitization
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Jul 2022 15:16:31 +0300
In-Reply-To: <877d4iplyp.fsf@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-12-vkuznets@redhat.com>
         <f1d030d7db4aaf3075fe625799b99ae335fc9f60.camel@redhat.com>
         <877d4iplyp.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-12 at 14:14 +0200, Vitaly Kuznetsov wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> > > With the updated eVMCSv1 definition, there's no known 'problematic'
> > > controls which are exposed in VMX control MSRs but are not present in
> > > eVMCSv1. Get rid of VMX control MSRs filtering for KVM on Hyper-V.
> > 
> > If I understand correctly we are taking about running KVM as a nested guest of Hyper-V here:
> > 
> > Don't we need to check the new CPUID bit and only then use the new fields of eVMCS,
> > aka check that the 'cpu' supports the updated eVMCS version?
> > 
> 
> I've checked various Hyper-V versions available around and it seems
> there's no need for that: these new features are exposed in VMX control
> MSRs only when the updated eVMCS is supported.

Makes sense now. Might be worth a comment somewhere.

Best regards,
	Maxim Levitsky

> 
> We can, in theory, preserve the filtering for non-updated eVMCS verison
> but I'd vote for putting a WARN_ON() or something around: we can
> eventually get rid of it in case we don't get any reports.
> 
> > Best regards,
> >         Maxim Levitsky
> > 
> > 
> > 
> > > 
> > > Note: VMX control MSRs filtering for Hyper-V on KVM
> > > (nested_evmcs_filter_control_msr()) stays as even the updated eVMCSv1
> > > definition doesn't have all the features implemented by KVM and some
> > > fields are still missing. Moreover, nested_evmcs_filter_control_msr()
> > > has to support the original eVMCSv1 version when VMM wishes so.
> > > 
> > > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > ---
> > >  arch/x86/kvm/vmx/evmcs.c | 13 -------------
> > >  arch/x86/kvm/vmx/evmcs.h |  1 -
> > >  arch/x86/kvm/vmx/vmx.c   |  5 -----
> > >  3 files changed, 19 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> > > index 52a53debd806..b5cfbf7d487b 100644
> > > --- a/arch/x86/kvm/vmx/evmcs.c
> > > +++ b/arch/x86/kvm/vmx/evmcs.c
> > > @@ -320,19 +320,6 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
> > >  };
> > >  const unsigned int nr_evmcs_1_fields = ARRAY_SIZE(vmcs_field_to_evmcs_1);
> > >  
> > > -#if IS_ENABLED(CONFIG_HYPERV)
> > > -__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
> > > -{
> > > -       vmcs_conf->cpu_based_exec_ctrl &= ~EVMCS1_UNSUPPORTED_EXEC_CTRL;
> > > -       vmcs_conf->pin_based_exec_ctrl &= ~EVMCS1_UNSUPPORTED_PINCTRL;
> > > -       vmcs_conf->cpu_based_2nd_exec_ctrl &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
> > > -       vmcs_conf->cpu_based_3rd_exec_ctrl = 0;
> > > -
> > > -       vmcs_conf->vmexit_ctrl &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
> > > -       vmcs_conf->vmentry_ctrl &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
> > > -}
> > > -#endif
> > > -
> > >  bool nested_enlightened_vmentry(struct kvm_vcpu *vcpu, u64 *evmcs_gpa)
> > >  {
> > >         struct hv_vp_assist_page assist_page;
> > > diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
> > > index 4b809c79ae63..0feac101cce4 100644
> > > --- a/arch/x86/kvm/vmx/evmcs.h
> > > +++ b/arch/x86/kvm/vmx/evmcs.h
> > > @@ -203,7 +203,6 @@ static inline void evmcs_load(u64 phys_addr)
> > >         vp_ap->enlighten_vmentry = 1;
> > >  }
> > >  
> > > -__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
> > >  #else /* !IS_ENABLED(CONFIG_HYPERV) */
> > >  static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
> > >  static inline void evmcs_write32(unsigned long field, u32 value) {}
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index b4915d841357..dd905ad72637 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -2689,11 +2689,6 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
> > >         vmcs_conf->vmexit_ctrl         = _vmexit_control;
> > >         vmcs_conf->vmentry_ctrl        = _vmentry_control;
> > >  
> > > -#if IS_ENABLED(CONFIG_HYPERV)
> > > -       if (enlightened_vmcs)
> > > -               evmcs_sanitize_exec_ctrls(vmcs_conf);
> > > -#endif
> > > -
> > >         return 0;
> > >  }
> > >  
> > 
> > 
> 


