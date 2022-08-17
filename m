Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF695979BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiHQWkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiHQWki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:40:38 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A688712D18
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:40:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-33387bf0c4aso164154397b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=J81yxb+B+6s5/E+3d62WGHV/0oRet+1BBMtJwVekE7E=;
        b=UVV3tBJN+nWPgXWbzXoIJ7ET1m0vHO1eOl1vsUPP33ajyJXls3XLYbyaM8JBtAbuTo
         gszE7Bqg/242FQYx7cA1yTbssCv+bIo2SJ+toiN3eHXiu/IYX7mIOUwF5nwqfKeFaTII
         0JT1BC5Z/ssN2J8UO2ZmHeK4ygUBP6SI5l+60a0Cgas2gpUcsYdxDRASXYxSbC71+Moj
         8ssx58q2egBLNn5JXq2ItIcFv9Zg1zYgLPQDHE2QiHRO0lH4yFUPfYCb8U/w6BVRlvgW
         xuGMkBSYo/WHk6IdUjc069oBP/pLEX91lTjhbnWDmYonNcv7fDYpm/5WAwVn1Y5bktNd
         gtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=J81yxb+B+6s5/E+3d62WGHV/0oRet+1BBMtJwVekE7E=;
        b=QNvJpF/lz8UmPhTKyoaRUG4lqZswTBRj8AAKfSGvpwWiSacAMroE7QjUK2M/+T8PL+
         0pxJJf2iwxASWooZ6VL2AYRc6/yXIVh97AJm4bBgQiPPgMhqGtzfkXM0rHu2RobNPfVf
         H2p3ZFU+j0I24Ev5VmRiAloB02p8ala0G5deXZhjECdA2tc8YzGS3dhOuONAeSh1Zsk4
         S9s4OgkR3BY3gHLakVwW3hQqiXn/0zzbeb75m5TVib3im+r+RZUzZ09rJKEMIeTTmUdb
         AXFypx5/TGHYr/kxmug6tLBOCw1hg2iIxpVCn40nwOwm+gtgljJ6I++JN7B5GCBwi/PY
         lmBA==
X-Gm-Message-State: ACgBeo13zVU3seBZfVluACb5UC5FUKSLY+AMzp1h5q1SRjBO2Py4vuLn
        h0tIkgHtR403wTsIJAjgYyExhvRvv5KWk/ij1tpobw==
X-Google-Smtp-Source: AA6agR63irMBuNJvUV6dHagvxLxtF40zcMq/BDY/Y/mI/gQ26YgrS9LS7HL2vDj4yBbSgLwws5Jx4rCzvzBBO3cHL9I=
X-Received: by 2002:a25:bb04:0:b0:67e:e3b:ee91 with SMTP id
 z4-20020a25bb04000000b0067e0e3bee91mr394878ybg.71.1660776035737; Wed, 17 Aug
 2022 15:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659854790.git.isaku.yamahata@intel.com> <ce183d47a93012c46472b32077e80dc8b56c88ed.1659854791.git.isaku.yamahata@intel.com>
In-Reply-To: <ce183d47a93012c46472b32077e80dc8b56c88ed.1659854791.git.isaku.yamahata@intel.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Wed, 17 Aug 2022 15:40:24 -0700
Message-ID: <CAAhR5DH2y=MXMSiM0YDn0qj3s3D3SBg6L3_uBP+a8KeC2u2jyQ@mail.gmail.com>
Subject: Re: [PATCH v8 095/103] KVM: TDX: Handle TDX PV rdmsr/wrmsr hypercall
To:     "Yamahata, Isaku" <isaku.yamahata@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Aug 7, 2022 at 3:03 PM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Wire up TDX PV rdmsr/wrmsr hypercall to the KVM backend function.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 341c29385544..fdd0609bd01b 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1157,6 +1157,41 @@ static int tdx_emulate_mmio(struct kvm_vcpu *vcpu)
>         return 1;
>  }
>
> +static int tdx_emulate_rdmsr(struct kvm_vcpu *vcpu)
> +{
> +       u32 index = tdvmcall_a0_read(vcpu);
> +       u64 data;
> +
> +       if (!kvm_msr_allowed(vcpu, index, KVM_MSR_FILTER_READ) ||
> +           kvm_get_msr(vcpu, index, &data)) {
> +               trace_kvm_msr_read_ex(index);
> +               tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_INVALID_OPERAND);
> +               return 1;
> +       }
> +       trace_kvm_msr_read(index, data);
> +
> +       tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_SUCCESS);
> +       tdvmcall_set_return_val(vcpu, data);
> +       return 1;
> +}
> +
> +static int tdx_emulate_wrmsr(struct kvm_vcpu *vcpu)
> +{
> +       u32 index = tdvmcall_a0_read(vcpu);
> +       u64 data = tdvmcall_a1_read(vcpu);
> +
> +       if (!kvm_msr_allowed(vcpu, index, KVM_MSR_FILTER_READ) ||
                                                                   ^
This should be KVM_MSR_FILTER_WRITE

> +           kvm_set_msr(vcpu, index, data)) {
> +               trace_kvm_msr_write_ex(index, data);
> +               tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_INVALID_OPERAND);
> +               return 1;
> +       }
> +
> +       trace_kvm_msr_write(index, data);
> +       tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_SUCCESS);
> +       return 1;
> +}
> +
>  static int handle_tdvmcall(struct kvm_vcpu *vcpu)
>  {
>         if (tdvmcall_exit_type(vcpu))
> @@ -1171,6 +1206,10 @@ static int handle_tdvmcall(struct kvm_vcpu *vcpu)
>                 return tdx_emulate_io(vcpu);
>         case EXIT_REASON_EPT_VIOLATION:
>                 return tdx_emulate_mmio(vcpu);
> +       case EXIT_REASON_MSR_READ:
> +               return tdx_emulate_rdmsr(vcpu);
> +       case EXIT_REASON_MSR_WRITE:
> +               return tdx_emulate_wrmsr(vcpu);
>         default:
>                 break;
>         }
> --
> 2.25.1
>
