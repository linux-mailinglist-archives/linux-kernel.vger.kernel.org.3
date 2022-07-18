Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB05781A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiGRMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiGRMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 934812409F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658146102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krSpkigEkANftfmisITHLdv9RXWL+ZzBEaxDBKikm30=;
        b=H1YI4fKBtK1OG7jCvjKSuuU2cZLjiU2TztS0m2MjHnW/+eCbj8qEkF52ulqbYZiDlclQPn
        EU9OwcPgaQ1oAH7umB1FLz2FS6IdPcAvr+OQBLvLmFS2KMgey/aeb1Ka/xgoIuP33o/Qee
        C578FKYRmC+pMH4l+XBdjvxuWMceFAs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-DzLaMOenN7CskUL0DllixA-1; Mon, 18 Jul 2022 08:08:19 -0400
X-MC-Unique: DzLaMOenN7CskUL0DllixA-1
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so9329483qkp.20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=krSpkigEkANftfmisITHLdv9RXWL+ZzBEaxDBKikm30=;
        b=eL7mdZ5kPfNbrEegQxig1ShWUkRQo2rxPflcZP9rJiwaqwtXpkU7N9lBKBj6Wq9zL6
         MMCMlC7XnHXwyn+PA5/klWNtoxS6zQlZ/TDQ/H76pmAbS5JNAXJ3C+o6Yp68IKWf5IqY
         rkfoDDpAEVgRpisNT8wnBCXbWAIEZfSua4L/i0BQagVjRqSgdpIM8/S6MrScDjZ4IYQx
         XSfpFonxA7djxRxrCssS2KWSUp0lnbWtQ+9GfAq+pD+s53A8APv6KoQYhbpQ/olCoBKO
         xxDHYg7/2iRNe6i59T/SGUliarMS55ozVg33ID3NmJjaM1xVmTkfd7ZLVnDOvmZRDh4B
         fBsw==
X-Gm-Message-State: AJIora8U7UNuqCKwkEsZdSC1WFbwIZvo1Nb4ToN1n725bX1Tu80ydsq2
        dSYWtVYBeD5nlC/ge2IY0V7paGXzMVYWA2e1jrGRw/LODtxgpqODoM1YKN02z8KcyjGAFqPuEiV
        gywO9Spz8V3dKfbUFVqp+LbtX
X-Received: by 2002:a05:620a:2402:b0:6af:19d6:7445 with SMTP id d2-20020a05620a240200b006af19d67445mr16923162qkn.450.1658146099072;
        Mon, 18 Jul 2022 05:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uUBOKmb7F9eGk91ZPnmTx/rWBSUBHqWeuqoXYFAdjo1+aV05won6XaTI69GQn86EucYoRr7w==
X-Received: by 2002:a05:620a:2402:b0:6af:19d6:7445 with SMTP id d2-20020a05620a240200b006af19d67445mr16923121qkn.450.1658146098793;
        Mon, 18 Jul 2022 05:08:18 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id k11-20020ac8140b000000b0031e9d9635d4sm8898065qtj.23.2022.07.18.05.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 05:08:18 -0700 (PDT)
Message-ID: <f76cbfeca245fcd5e5d69cb91af9a0a1d6aaf1d0.camel@redhat.com>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Restrict mapping level based on guest
 MTRR iff they're used
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 15:08:15 +0300
In-Reply-To: <20220715230016.3762909-5-seanjc@google.com>
References: <20220715230016.3762909-1-seanjc@google.com>
         <20220715230016.3762909-5-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 23:00 +0000, Sean Christopherson wrote:
> Restrict the mapping level for SPTEs based on the guest MTRRs if and only
> if KVM may actually use the guest MTRRs to compute the "real" memtype.
> For all forms of paging, guest MTRRs are purely virtual in the sense that
> they are completely ignored by hardware, i.e. they affect the memtype
> only if software manually consumes them.  The only scenario where KVM
> consumes the guest MTRRs is when shadow_memtype_mask is non-zero and the
> guest has non-coherent DMA, in all other cases KVM simply leaves the PAT
> field in SPTEs as '0' to encode WB memtype.
> 
> Note, KVM may still ultimately ignore guest MTRRs, e.g. if the backing
> pfn is host MMIO, but false positives are ok as they only cause a slight
> performance blip (unless the guest is doing weird things with its MTRRs,
> which is extremely unlikely).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 52664c3caaab..82f38af06f5c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4295,14 +4295,26 @@ EXPORT_SYMBOL_GPL(kvm_handle_page_fault);
>  
>  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  {
> -       while (fault->max_level > PG_LEVEL_4K) {
> -               int page_num = KVM_PAGES_PER_HPAGE(fault->max_level);
> -               gfn_t base = (fault->addr >> PAGE_SHIFT) & ~(page_num - 1);
> +       /*
> +        * If the guest's MTRRs may be used to compute the "real" memtype,
> +        * restrict the mapping level to ensure KVM uses a consistent memtype
> +        * across the entire mapping.  If the host MTRRs are ignored by TDP
> +        * (shadow_memtype_mask is non-zero), and the VM has non-coherent DMA
> +        * (DMA doesn't snoop CPU caches), KVM's ABI is to honor the memtype
> +        * from the guest's MTRRs so that guest accesses to memory that is
> +        * DMA'd aren't cached against the guest's wishes.
> +        *
> +        * Note, KVM may still ultimately ignore guest MTRRs for certain PFNs,
> +        * e.g. KVM will force UC memtype for host MMIO.
> +        */
> +       if (shadow_memtype_mask && kvm_arch_has_noncoherent_dma(vcpu->kvm)) {
> +               for ( ; fault->max_level > PG_LEVEL_4K; --fault->max_level) {
> +                       int page_num = KVM_PAGES_PER_HPAGE(fault->max_level);
> +                       gfn_t base = (fault->addr >> PAGE_SHIFT) & ~(page_num - 1);
>  
> -               if (kvm_mtrr_check_gfn_range_consistency(vcpu, base, page_num))
> -                       break;
> -
> -               --fault->max_level;
> +                       if (kvm_mtrr_check_gfn_range_consistency(vcpu, base, page_num))
> +                               break;
> +               }
>         }
>  
>         return direct_page_fault(vcpu, fault);


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

