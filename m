Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3596559E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiFXQIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiFXQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06CAA48E68
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656086909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QYcSN6BSAGdmrZWhumL4g7TVew4M5eK8Stam8vA0Dw=;
        b=cYSVq6gYt7wHccyPf3ArqWYjoLwLy4+zZqQNTSwbnYuj72gveyCNVC0qxp/cQj7xMioT7B
        VHHdrUbghL5B2r6UZBSYFvclCbx1zHpLMVkQ5T1bUYRwsLld8gEB7JG6nDoONrV3mULJqs
        9EW3iQIsStVLt7Ww/rVaYlear6vxUjQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-Rcdm5aGKM2irW-QK2gVOwg-1; Fri, 24 Jun 2022 12:08:27 -0400
X-MC-Unique: Rcdm5aGKM2irW-QK2gVOwg-1
Received: by mail-ed1-f72.google.com with SMTP id c20-20020a05640227d400b004369cf00c6bso1950060ede.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7QYcSN6BSAGdmrZWhumL4g7TVew4M5eK8Stam8vA0Dw=;
        b=qOqCEVmapOs9Um8fqa9T9Gt2v+VsD6jWRnOHEU84ZPoHKwIZ3XaGeBEpF7H0LnfTWa
         fmi2PDV/HZUIigyYWSn7eCouF94jH5Px6NuAkLDvuhibK2DsucJJQPrcpQSPwgXU1BjG
         rCKI0Hqt9BHS1DCOPnpAFJNxl4yWwHGJbWaX7qNaAhV5lbWKHf3vz68OHrMrm9o69mtt
         9hslhAv4rdwjyb6pqzxiVX0YWh/EGjZ54QMHYF5/mpzYMVqWppssHOm4CP2c0Uud4kQr
         V9W5P3O9EwTKETtNA0RZ/HU/sy1S5/geQNWJBM+vDmHSNauGot1kR8y5w4gbn0qL9N1N
         i2ng==
X-Gm-Message-State: AJIora96fa911zGQwiq/vHSbBciaarm5Z+oxbJa7VVeIjpvi0ZnuqMSN
        QuM+OW2ZEy1HJLox533URdVqsJ0eJ+ag4SAWCay8X1kBb9qOoNlGiQMWuaRyYbRBmvmXfDCgCNR
        tLesEl1LgSeLHkNEMeP+k5TFA
X-Received: by 2002:a05:6402:f14:b0:435:7f82:302b with SMTP id i20-20020a0564020f1400b004357f82302bmr18208478eda.57.1656086906385;
        Fri, 24 Jun 2022 09:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sZeLb33f/incZ/Z1MTbmneeUPO/IcG0f4Ys9xu85Ypg4dXzFzZ7s19o9ly3jHyYFcIEpPsUA==
X-Received: by 2002:a05:6402:f14:b0:435:7f82:302b with SMTP id i20-20020a0564020f1400b004357f82302bmr18208454eda.57.1656086906195;
        Fri, 24 Jun 2022 09:08:26 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id s3-20020a1709067b8300b0070efa110afcsm1333827ejo.83.2022.06.24.09.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:08:25 -0700 (PDT)
Message-ID: <413e22f2-2179-74f3-315b-2049d8751d80@redhat.com>
Date:   Fri, 24 Jun 2022 18:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 01/17] x86/cpufeatures: Introduce x2AVIC CPUID bit
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
References: <20220519102709.24125-1-suravee.suthikulpanit@amd.com>
 <20220519102709.24125-2-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220519102709.24125-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 12:26, Suravee Suthikulpanit wrote:
> Introduce a new feature bit for virtualized x2APIC (x2AVIC) in
> CPUID_Fn8000000A_EDX [SVM Revision and Feature Identification].
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 1d6826eac3e6..2721bd1e8e1e 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -343,6 +343,7 @@
>   #define X86_FEATURE_AVIC		(15*32+13) /* Virtual Interrupt Controller */
>   #define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* Virtual VMSAVE VMLOAD */
>   #define X86_FEATURE_VGIF		(15*32+16) /* Virtual GIF */
> +#define X86_FEATURE_X2AVIC		(15*32+18) /* Virtual x2apic */
>   #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
>   #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
>   

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

