Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D30B521C58
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiEJOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245270AbiEJOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:09:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0BC7658
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:43:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c14so14987346pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=no4knFj2QkkG24w5BpGtHthRtUO1MTUEciG91xe028g=;
        b=fTLJckD+LdKD21kXVmiJtp60Iev8s/1LA8KcxKZqvHWZt7LbRid5lQbpzOVFixyRXr
         6c/SwjoaijWHCa/cY11vzsye30v95o28+AKDT9eb5rYsxBcX744c4SCq0nnH50Vptu6c
         OpXcz3VbtQnJ9BdmNn5OyRBrspO7m6Hc+3PzVFhbrKuhnAEofJABBFoU0Nfo4nBhAckN
         57+R+5GIZT/KIob/+juDeGfCbhwUvXqF8/ugGVejcy4wfHysUBRMAZjXcvayfsFee8pT
         5ocBjrR5QgsGbfjWCD4I/IUhu4iAM+5Gad4aEIO4+gjq7ZkI+pATFyfYiom9Zsme11JS
         Hs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=no4knFj2QkkG24w5BpGtHthRtUO1MTUEciG91xe028g=;
        b=eXHEkF243KSTRTV9dwrhBkOCP8X0YVoWDpZrHvXCrQQnfEEfv0kdcUCDP0La+z5uhd
         xH8+AkWRN9W17Rr22ixWUI6DSHaXbbjCgzNniAeirsnupz4mDYHMa9q9BiLvF42Uu+09
         Ik1NNGn62KdjpJDPB+hkA8g4z2cytq3LpUJ7JovHf34dz6lubmIpmY8JW3ebaGCiM3h3
         4VsNCvqfUPGYMAHaTtF8cREDhXDN74eQwJQVnFNAPXL8Yz1iA++G2JIWyCVb6k0//b24
         uqE/rkXQ4v42DTv0TUXArXKiQsx28/VICmAG3LCQH/5+kY3Uxkjzp2P65A9wL+RkFKBI
         eTDw==
X-Gm-Message-State: AOAM533cZ8NNQ9XowfaqCyKg3Tr1bvNRs8rZDT3p6sexqrJVFx24Ps6C
        KpMKFzooRlaHsNN/nHVvPgo95Q==
X-Google-Smtp-Source: ABdhPJyOopUd0tEn4NWLvw+TLQgnEqGNe3teQaVnB3OwAvTVYOpo3ul4fVGXJ+cPKtzzJYqEczgAAw==
X-Received: by 2002:a63:d504:0:b0:3c6:ab6b:fd2b with SMTP id c4-20020a63d504000000b003c6ab6bfd2bmr9333333pgg.437.1652190225544;
        Tue, 10 May 2022 06:43:45 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o20-20020a635a14000000b003c5e836eddasm10175398pgb.94.2022.05.10.06.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 06:43:45 -0700 (PDT)
Date:   Tue, 10 May 2022 13:43:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: LAPIC: Disarm LAPIC timer includes pending timer
 around TSC deadline switch
Message-ID: <YnpsDSDqU5oNK3bQ@google.com>
References: <1652175386-31587-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652175386-31587-1-git-send-email-wanpengli@tencent.com>
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

On Tue, May 10, 2022, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The timer is disarmed when switching between TSC deadline and other modes, 
> however, the pending timer is still in-flight, so let's accurately set 
> everything to a disarmed state.
> 
> Fixes: 4427593258 (KVM: x86: thoroughly disarm LAPIC timer around TSC deadline switch)
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 66b0eb0bda94..0274d17d91c2 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1562,6 +1562,7 @@ static void apic_update_lvtt(struct kvm_lapic *apic)
>  			kvm_lapic_set_reg(apic, APIC_TMICT, 0);
>  			apic->lapic_timer.period = 0;
>  			apic->lapic_timer.tscdeadline = 0;
> +			atomic_set(&apic->lapic_timer.pending, 0);

What about doing this in cancel_apic_timer()?  That seems to be a more natural
place to clear pending.  It's somewhat redundant since the other two callers of
cancel_apic_timer() start the timer immediately after, i.e. clear pending anyways,
but IMO it's odd to leave pending set when canceling the timer.

>  		}
>  		apic->lapic_timer.timer_mode = timer_mode;
>  		limit_periodic_timer_frequency(apic);
> -- 
> 2.25.1
> 
