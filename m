Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F286D59B2C1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiHUI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiHUI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AA14019
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661070448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFzAjE0zTNtd8Ej3/B1XhcyvTRPt0rrbrcv8bhNIVNs=;
        b=ay4EC4jlfCkSaLFaZua9drvfOxWS9AR5xAGUaUUQj3nBBZwZPPPLXDjIAlk8cc30HAMymp
        oyTRaMri7E7m0lctFvnpCYlRmttoXFcoAjSuDGm2jqbb029Of+eYopizbL+9hSJ1OQm5tv
        CjujYVORKt2OyEKMb9JnnAPSuJPTzLo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-BqdF8xXfOSWAnClxifBcPQ-1; Sun, 21 Aug 2022 04:27:27 -0400
X-MC-Unique: BqdF8xXfOSWAnClxifBcPQ-1
Received: by mail-qk1-f200.google.com with SMTP id bq19-20020a05620a469300b006bb70e293ccso7354703qkb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=zFzAjE0zTNtd8Ej3/B1XhcyvTRPt0rrbrcv8bhNIVNs=;
        b=Bvjuk/ASYITCdsc9thOen/7C1S5O2slNxVcX+ApHXnvwEP3T9N7hpgTXwo6wPq6rNz
         3eMmoIEqq2q7/m6TWgD0pKdzzW68AKopVnCg9xZ4jxyVtyUqWySb6QnxRoL0aCFpwEBH
         QGlf7KTo7ETU8WWvDaShKDCpBvjB480EbJmrl9QApLSduHvMRXXhJksRhKKYEcRlSSt7
         KcP8njUz0nlqpI3gEEjqOp6pRD4oCOTwNQDLVsOgRoE4jkYMq7vv5prcD31dhVYuI1o6
         pFW8E7kf941TcCQSs8xhnW/w3j02X68uyh/W44NiWIOJYaGhnh1uRXIFe4qi1XAfyAka
         Yj4Q==
X-Gm-Message-State: ACgBeo3CnMMAqL2LqGpBOqMzx2p9A1w3gmrwDqsTEMtnPt8eWJZYHUEA
        lv161ZqLU2R+5qCGBqDO/gdu4ZE/VQPZrD+cxJ1Sadts3mlF/3dWxGDsSNIYMj5LNj26VfnRC2k
        kltyi+hzVV1JBwedYqdXrCdP4
X-Received: by 2002:a37:9a8c:0:b0:6ba:c06f:bc1d with SMTP id c134-20020a379a8c000000b006bac06fbc1dmr9575074qke.193.1661070446445;
        Sun, 21 Aug 2022 01:27:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6U/je9YVqAQok1Bzw8VdnzY5WkqvswJCcRzzI5oAh8Zdik1aV8ZCbUe+y2hYH8IXnVAezA7A==
X-Received: by 2002:a37:9a8c:0:b0:6ba:c06f:bc1d with SMTP id c134-20020a379a8c000000b006bac06fbc1dmr9575063qke.193.1661070446182;
        Sun, 21 Aug 2022 01:27:26 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bs13-20020ac86f0d000000b0031ef67386a5sm6488408qtb.68.2022.08.21.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 01:27:25 -0700 (PDT)
Message-ID: <74218ad22f227bb62e7bc52397426545eb1c995d.camel@redhat.com>
Subject: Re: [PATCH] KVM: SVM: remove unnecessary check on INIT intercept
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Date:   Sun, 21 Aug 2022 11:27:23 +0300
In-Reply-To: <20220819165643.83692-1-pbonzini@redhat.com>
References: <20220819165643.83692-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 12:56 -0400, Paolo Bonzini wrote:
> Since svm_check_nested_events() is now handling INIT signals, there is
> no need to latch it until the VMEXIT is injected.  The only condition
> under which INIT signals are latched is GIF=0.
> 
> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f3813dbacb9f..26a348389ece 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4697,15 +4697,7 @@ static bool svm_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
>  
> -       /*
> -        * TODO: Last condition latch INIT signals on vCPU when
> -        * vCPU is in guest-mode and vmcb12 defines intercept on INIT.
> -        * To properly emulate the INIT intercept,
> -        * svm_check_nested_events() should call nested_svm_vmexit()
> -        * if an INIT signal is pending.
> -        */
> -       return !gif_set(svm) ||
> -                  (vmcb_is_intercept(&svm->vmcb->control, INTERCEPT_INIT));
> +       return !gif_set(svm);
>  }
>  
>  static void svm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

