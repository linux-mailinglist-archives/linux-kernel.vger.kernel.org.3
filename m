Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2B534EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiEZMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbiEZMBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9C62D02BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653566507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=055SoySeYXCWiLn0CzY+x8sr/f0kC8O6z5eyzr7h1MY=;
        b=N4CAE3oo1tMYh2scOE8dKZp+3n9aWlyF1F1TNbqirg0gY45hx5MmHW7iHnHVGov79+u2cL
        heQVXClTZjGXTU5UYOc722kRZ3oPuYuOF5NzaQtyPEMjErhuFE+Prf7S5j/Fx+IP/mbhQ2
        GK2a8OZX1ARl19w0m3GgeO/Y9BS78l8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-AvxagEL0OpW5pujQBj8z3g-1; Thu, 26 May 2022 08:01:46 -0400
X-MC-Unique: AvxagEL0OpW5pujQBj8z3g-1
Received: by mail-ej1-f72.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso721489ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=055SoySeYXCWiLn0CzY+x8sr/f0kC8O6z5eyzr7h1MY=;
        b=si1YrOBYYjQO8LDsDZBIb4uloNtNZ9tlg4xnynd2sqZSY9ErkgvmLhoKtGogxE6vmj
         do1vZlMRSLcIno1owuwtVnsEur8qFNH0Hqr0ikdRJYsR5aINkbtKsX1BcrJsIu0hPgS9
         PkJM7XsFgOqWzd79xzCWWXC4F8nZF2QFxYB7C4dPNNnl41XuYyue73PLGfESn6AFfrMZ
         BA3b0HJa0YWq+iViviRRETgROceW6YzqUI46E13cnlNuWvsmAh0LhmIYH64BX6X8PLhM
         TvY7iOJXh4hO2FV8cmiHIGja6cKlKL3i0otjqV7ox4uXvLCc5itZfvSICXNWWJ1Yo+Pl
         AncA==
X-Gm-Message-State: AOAM531++Vvlxy2iL4KCs8td8tqJ/w/VX6Ul9mWShWUkhKFNzHVUtKJh
        J5U+5VcsnNfB8ggfI25zXVfa+eBV+arrwBZ2atyOgUkpOfp5nTMIcxiH36QcOoAyo6Ck8UYyUOz
        4brfVaSplghtQeMB2/Kf+b7Um
X-Received: by 2002:a05:6402:4384:b0:42b:5bf6:6d0a with SMTP id o4-20020a056402438400b0042b5bf66d0amr23209295edc.298.1653566505415;
        Thu, 26 May 2022 05:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKcWoJHWNsYMQzmjLeHxlnKvIV9QJoGSG5PucM9P0VaBH4aybz1rC298akfqvIO/hsmF/cLQ==
X-Received: by 2002:a05:6402:4384:b0:42b:5bf6:6d0a with SMTP id o4-20020a056402438400b0042b5bf66d0amr23209276edc.298.1653566505226;
        Thu, 26 May 2022 05:01:45 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id o15-20020a1709062e8f00b006fe9a2874cdsm446934eji.103.2022.05.26.05.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:01:44 -0700 (PDT)
Message-ID: <a3ea7446-901f-1d33-47a9-35755b4d86d5@redhat.com>
Date:   Thu, 26 May 2022 14:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86/MMU: Zap non-leaf SPTEs when disabling dirty
 logging
Content-Language: en-US
To:     Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
References: <20220525230904.1584480-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220525230904.1584480-1-bgardon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 01:09, Ben Gardon wrote:
> +		WARN_ON(max_mapping_level < iter.level);
> +
> +		/*
> +		 * If this page is already mapped at the highest
> +		 * viable level, there's nothing more to do.
> +		 */
> +		if (max_mapping_level == iter.level)
> +			continue;
> +
> +		/*
> +		 * The page can be remapped at a higher level, so step
> +		 * up to zap the parent SPTE.
> +		 */
> +		while (max_mapping_level > iter.level)
> +			tdp_iter_step_up(&iter);
> +
>   		/* Note, a successful atomic zap also does a remote TLB flush. */
> -		if (tdp_mmu_zap_spte_atomic(kvm, &iter))
> -			goto retry;
> +		tdp_mmu_zap_spte_atomic(kvm, &iter);
> +

Can you make this a sparate function (for example 
tdp_mmu_zap_collapsible_spte_atomic)?  Otherwise looks great!

Paolo

