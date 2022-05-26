Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB3553505C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347597AbiEZOH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiEZOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F1F8562C7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653574073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6CkHwV76sa3bQ9/SF4zQ633hT3tr9LRfdGie04Aukxc=;
        b=EsbQL6XVJqlRsHLQU1EwDlL4ilPUAb65dzPRLW9bReVnBZzKXz9GLEteBRHck3zZ+B0uvA
        SC9tXEm+VAf7EB34okQcWvwUcVyjMYQpBU0fbUIQ/Y0hx/PpRmWpPohiW+cADgV6uoK3+S
        8f8RABgu2PpF6uTfv5zTaQAdsA59/q0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-dFEmoDtmOC65qRDo9_WKQw-1; Thu, 26 May 2022 10:07:52 -0400
X-MC-Unique: dFEmoDtmOC65qRDo9_WKQw-1
Received: by mail-wr1-f72.google.com with SMTP id j17-20020adfe511000000b0020ff91f52faso291678wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6CkHwV76sa3bQ9/SF4zQ633hT3tr9LRfdGie04Aukxc=;
        b=mzdv3KjvF6Ic2bSzOAkR9k8hUxheVraFp6CTg8uXRgjvhb1vDOVCS14RKDZmIAWiNU
         tOv4JWj1TQg5dG8aFV3MSWbiS3R/wcsJhMwx+N+tmYzcsIO7vx12zyKJGAQJ2Tb6QYlx
         4Cqz70Qn9p0Z3Qg0F+uKWysbpP04ap0fYj/2t0HOb4ghuVhkm0seTuFZ4ywG3/NTyQGr
         P+NHwPmHQ1Qq14TYdlYlY+PqSP5dKUNEYH1RGEpQlHD/+Fq6PqYWFwY2vIOslgboHgwx
         kxMzaw/X6bIokb2AUrECi1OCrpOzRNwHqmG/RC6BHC1jvJGfkKsdzI+xRllszCWcPbeq
         OcYg==
X-Gm-Message-State: AOAM531vrNja032rSj8voSpce6R0h1nuRY9NgxcDc5tW5VvA6vjCLQQq
        RjKZjCmrdssRYy2UzQSWoZkTDV8UDDP3I7Kc2A+7LgxdRIbIBpuNsDUcvZ1NMeFr7vWuLCr3272
        xRZRL1M6SA47ltrWJfqPko1hW
X-Received: by 2002:a05:600c:1c91:b0:397:4711:e2a8 with SMTP id k17-20020a05600c1c9100b003974711e2a8mr2540932wms.82.1653574070985;
        Thu, 26 May 2022 07:07:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ6rFz1HsFtA9ho1GTDIECy348wMaOySSsNZOL4qG4bxS6j7h/9KhSNfDzprXGP6SyrMpUZA==
X-Received: by 2002:a05:600c:1c91:b0:397:4711:e2a8 with SMTP id k17-20020a05600c1c9100b003974711e2a8mr2540906wms.82.1653574070658;
        Thu, 26 May 2022 07:07:50 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w15-20020a7bc74f000000b003972c672859sm5078570wmk.21.2022.05.26.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:07:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] KVM: x86: Harden _regs accesses to guard against
 buggy input
In-Reply-To: <20220525222604.2810054-3-seanjc@google.com>
References: <20220525222604.2810054-1-seanjc@google.com>
 <20220525222604.2810054-3-seanjc@google.com>
Date:   Thu, 26 May 2022 16:07:49 +0200
Message-ID: <87r14gqte2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> WARN and truncate the incoming GPR number/index when reading/writing GPRs
> in the emulator to guard against KVM bugs, e.g. to avoid out-of-bounds
> accesses to ctxt->_regs[] if KVM generates a bogus index.  Truncate the
> index instead of returning e.g. zero, as reg_write() returns a pointer
> to the register, i.e. returning zero would result in a NULL pointer
> dereference.  KVM could also force the index to any arbitrary GPR, but
> that's no better or worse, just different.
>
> Open code the restriction to 16 registers; RIP is handled via _eip and
> should never be accessed through reg_read() or reg_write().  See the
> comments above the declarations of reg_read() and reg_write(), and the
> behavior of writeback_registers().  The horrific open coded mess will be
> cleaned up in a future commit.
>
> There are no such bugs known to exist in the emulator, but determining
> that KVM is bug-free is not at all simple and requires a deep dive into
> the emulator.  The code is so convoluted that GCC-12 with the recently
> enable -Warray-bounds spits out a (suspected) false-positive:
>
>   arch/x86/kvm/emulate.c:254:27: warning: array subscript 32 is above array
>                                  bounds of 'long unsigned int[17]' [-Warray-bounds]
>     254 |         return ctxt->_regs[nr];
>         |                ~~~~~~~~~~~^~~~
>   In file included from arch/x86/kvm/emulate.c:23:
>   arch/x86/kvm/kvm_emulate.h: In function 'reg_rmw':
>   arch/x86/kvm/kvm_emulate.h:366:23: note: while referencing '_regs'
>     366 |         unsigned long _regs[NR_VCPU_REGS];
>         |                       ^~~~~
>
> Link: https://lore.kernel.org/all/YofQlBrlx18J7h9Y@google.com
> Cc: Robert Dinse <nanook@eskimo.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/emulate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 7226a127ccb4..c58366ae4da2 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -247,6 +247,9 @@ enum x86_transfer_type {
>  
>  static ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
>  {
> +	if (WARN_ON_ONCE(nr >= 16))
> +		nr &= 16 - 1;

As the result of this is unlikely to match the expectation (and I'm
unsure what's the expectation here in the first place :-), why not use 
KVM_BUG_ON() here instead?

> +
>  	if (!(ctxt->regs_valid & (1 << nr))) {
>  		ctxt->regs_valid |= 1 << nr;
>  		ctxt->_regs[nr] = ctxt->ops->read_gpr(ctxt, nr);
> @@ -256,6 +259,9 @@ static ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
>  
>  static ulong *reg_write(struct x86_emulate_ctxt *ctxt, unsigned nr)
>  {
> +	if (WARN_ON_ONCE(nr >= 16))
> +		nr &= 16 - 1;
> +
>  	ctxt->regs_valid |= 1 << nr;
>  	ctxt->regs_dirty |= 1 << nr;
>  	return &ctxt->_regs[nr];

-- 
Vitaly

