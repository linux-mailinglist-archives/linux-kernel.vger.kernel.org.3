Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0167D57831D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiGRNFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiGRNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7028626AC8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658149520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNn/219w/nxXvIhafPjEI4PpysZRiwXMWVRFnBiLVQo=;
        b=e5VhSHQiJ1RtCWkdMfmXLO7M44KXVoD0YFycLlSm+UP8rNpdcxIFlwkPDGEFqKEbiKmHYN
        83SA5Rqt4VL9yyzBYmXnVDeED5gKvshhUdR7Flp/R3SyvXk6Qa4kkeL7jPUNWYewLvyQRI
        T6a3SHWP4eYdVvOHU08Pa50okEfne8g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-f8Y2mIxYNK6ep0M9cg4zVQ-1; Mon, 18 Jul 2022 09:05:19 -0400
X-MC-Unique: f8Y2mIxYNK6ep0M9cg4zVQ-1
Received: by mail-qv1-f70.google.com with SMTP id ln2-20020a0562145a8200b0047301e9bc53so5411196qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TNn/219w/nxXvIhafPjEI4PpysZRiwXMWVRFnBiLVQo=;
        b=EYwMk29m5noJAfTRGNGQB37Ng63McR/QHPv2tcqSFzNP+x3fSH4guH7E21sTjVZA7L
         NZ6kiDceWmemMN53KtVHaXEUnHfrO0lQi2k/2RJW+RhMOVwKTymBQAHhjcYqotkN5t0c
         joBfWxF5pMPeLW0JsghFEtM1Sq+D8omhAdjFkgmy79VdYZ6jNgRZoI9Hd5WdN59uey9l
         NG6AttnJn7k8iY+BuXMb/RZ8ucLz3t1oJjfwlNnoI2fDJVa2Z7jJ0s6zZUBqSehfhKp5
         G7ywIxmXT215K5dFxxFYA8qEOyu3PvMDzrRzBq1XODeNqWsS7aV2AjfNiNHo0Dy1Mi6Y
         rIVA==
X-Gm-Message-State: AJIora/UjxiXVpiNnvby7FgQ0nn3zGJ/u0gGnei+XVQPw64eBqPhp661
        rbl/NfLcLNXwHmfYv21wmKVxU8GpKxbeNJJIyP5rbnIDSSyN598+Ct6FVy/Vczfo3NoVSsMym5M
        IZGSOwL56qKs6ypzvR5vyT/sF
X-Received: by 2002:a05:620a:d83:b0:6a7:a68c:6118 with SMTP id q3-20020a05620a0d8300b006a7a68c6118mr17493321qkl.337.1658149518785;
        Mon, 18 Jul 2022 06:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t4AqfUdMQ2En1oft289/J+A0HQz/7crr95hCS3cG1hRbkgp1V5jTc9qwXelJWXoqR8RG90dg==
X-Received: by 2002:a05:620a:d83:b0:6a7:a68c:6118 with SMTP id q3-20020a05620a0d8300b006a7a68c6118mr17493292qkl.337.1658149518475;
        Mon, 18 Jul 2022 06:05:18 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id r2-20020ac87ee2000000b0031ed590433bsm8051643qtc.78.2022.07.18.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:05:17 -0700 (PDT)
Message-ID: <103afbe8e0d3c560d02fc3454bba3d0d88e9251a.camel@redhat.com>
Subject: Re: [PATCH v2 21/24] KVM: VMX: Update MTF and ICEBP comments to
 document KVM's subtle behavior
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Date:   Mon, 18 Jul 2022 16:05:14 +0300
In-Reply-To: <20220715204226.3655170-22-seanjc@google.com>
References: <20220715204226.3655170-1-seanjc@google.com>
         <20220715204226.3655170-22-seanjc@google.com>
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

On Fri, 2022-07-15 at 20:42 +0000, Sean Christopherson wrote:
> Document the oddities of ICEBP interception (trap-like #DB is intercepted
> as a fault-like exception), and how using VMX's inner "skip" helper
> deliberately bypasses the pending MTF and single-step #DB logic.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 5302b046110f..de6fcfa0ef02 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1578,9 +1578,13 @@ static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
>  
>         /*
>          * Per the SDM, MTF takes priority over debug-trap exceptions besides
> -        * T-bit traps. As instruction emulation is completed (i.e. at the
> -        * instruction boundary), any #DB exception pending delivery must be a
> -        * debug-trap. Record the pending MTF state to be delivered in
> +        * TSS T-bit traps and ICEBP (INT1).  KVM doesn't emulate T-bit traps
> +        * or ICEBP (in the emulator proper), and skipping of ICEBP after an
> +        * intercepted #DB deliberately avoids single-step #DB and MTF updates
> +        * as ICEBP is higher priority than both.  As instruction emulation is
> +        * completed at this point (i.e. KVM is at the instruction boundary),
> +        * any #DB exception pending delivery must be a debug-trap of lower
> +        * priority than MTF.  Record the pending MTF state to be delivered in
>          * vmx_check_nested_events().
>          */
>         if (nested_cpu_has_mtf(vmcs12) &&
> @@ -5084,8 +5088,10 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>                          * instruction.  ICEBP generates a trap-like #DB, but
>                          * despite its interception control being tied to #DB,
>                          * is an instruction intercept, i.e. the VM-Exit occurs
> -                        * on the ICEBP itself.  Note, skipping ICEBP also
> -                        * clears STI and MOVSS blocking.
> +                        * on the ICEBP itself.  Use the inner "skip" helper to
> +                        * avoid single-step #DB and MTF updates, as ICEBP is
> +                        * higher priority.  Note, skipping ICEBP still clears
> +                        * STI and MOVSS blocking.
>                          *
>                          * For all other #DBs, set vmcs.PENDING_DBG_EXCEPTIONS.BS
>                          * if single-step is enabled in RFLAGS and STI or MOVSS


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

