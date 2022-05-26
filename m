Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780F534D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347002AbiEZKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbiEZKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D0AACEB85
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653561601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8EWAiYBYk725y81Cip9A4eLxA/2E8LypU9bh49pcKwc=;
        b=agm06UuEjspG5OFD30hE4GjMcI1hLCJcezlAm1aR3+MvLvMvhDS3pT0/s4hYvkjyejw3Uq
        OoU+PnAMlwxF/gYkHdEe/Jo1PerQafREsUCcQOnT/w9BF9/7q8osw0rZHQkYCn5n+IBXhA
        r5jIJpKdYdqRs0z+srw1O8Qf2F6P5c4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-FapKfIr5MaOYObOOzRqP3Q-1; Thu, 26 May 2022 06:39:58 -0400
X-MC-Unique: FapKfIr5MaOYObOOzRqP3Q-1
Received: by mail-ej1-f72.google.com with SMTP id sd17-20020a170906ce3100b006ff12a1b982so635099ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8EWAiYBYk725y81Cip9A4eLxA/2E8LypU9bh49pcKwc=;
        b=o6IAH0AmqN5k02Aj/J0kVH4HkjuytynDvc9Fbyc48S8zeNXOAfiUJk/yYq5lQ/3yGy
         oS0q84IYpCygIHN99x9ZoTWrqZkEM5PAozAwKhOEn5HaLs9rU9PfSceXMaGQrUj4hHGS
         7R0muryxw6BISH+8DoKuDvW5+TH3K6lSJoHicxY5H8gaQDYglzRXV+x1cKlalbb9xx+v
         BWl7EHOf8iEnnIR4NXCo6oDRizeYUxaQuMh1md114giuUBxmX/XuCf+Pg8oKJ2vijdgD
         /A06RtBEk0raNOMjwIHNDs2Jhko1ZlR9M0uzxXODSEs0OzbjnVg/cA+FnSzlCuGH63RD
         nPtQ==
X-Gm-Message-State: AOAM531z7vEy6C6So4WW4eW2fNJ7qpP36sgDcz4zH0eezTSj4hDoaFSP
        ZQnklGVMr4sAKKp+IqLDs31wDfGf4ts1/VfQK2+WWPG3KfMEHqKE8h8LjIxJB9n0E375pqPYx/z
        V1cWQkyzFwhZBu8NoWBjH3nD0
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr33758323ejo.647.1653561596933;
        Thu, 26 May 2022 03:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtAO6TZgqMXrEm2H/AdlTd7mXLZMlmxf6oRDjQkfiY76qayygnuLVMz3FRQqkQ3im8y4fEOA==
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr33758303ejo.647.1653561596722;
        Thu, 26 May 2022 03:39:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id q14-20020a50c34e000000b0042bb015df6asm641485edb.6.2022.05.26.03.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 03:39:56 -0700 (PDT)
Message-ID: <8baca98e-63d6-f7dd-067b-05f8e0dc381f@redhat.com>
Date:   Thu, 26 May 2022 12:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] KVM: VMX: Sanitize VM-Entry/VM-Exit control pairs at
 kvm_intel load time
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Lei Wang <lei4.wang@intel.com>
References: <20220525210447.2758436-1-seanjc@google.com>
 <20220525210447.2758436-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220525210447.2758436-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 23:04, Sean Christopherson wrote:
>   
> +#define VMCS_ENTRY_EXIT_PAIR(name, entry_action, exit_action) \
> +	{ VM_ENTRY_##entry_action##_##name, VM_EXIT_##exit_action##_##name }
> +
>   static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>   				    struct vmx_capability *vmx_cap)
>   {
> @@ -2473,6 +2476,24 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>   	u64 _cpu_based_3rd_exec_control = 0;
>   	u32 _vmexit_control = 0;
>   	u32 _vmentry_control = 0;
> +	int i;
> +
> +	/*
> +	 * LOAD/SAVE_DEBUG_CONTROLS are absent because both are mandatory.
> +	 * SAVE_IA32_PAT and SAVE_IA32_EFER are absent because KVM always
> +	 * intercepts writes to PAT and EFER, i.e. never enables those controls.
> +	 */
> +	struct {
> +		u32 entry_control;
> +		u32 exit_control;
> +	} vmcs_entry_exit_pairs[] = {
> +		VMCS_ENTRY_EXIT_PAIR(IA32_PERF_GLOBAL_CTRL, LOAD, LOAD),
> +		VMCS_ENTRY_EXIT_PAIR(IA32_PAT, LOAD, LOAD),
> +		VMCS_ENTRY_EXIT_PAIR(IA32_EFER, LOAD, LOAD),
> +		VMCS_ENTRY_EXIT_PAIR(BNDCFGS, LOAD, CLEAR),
> +		VMCS_ENTRY_EXIT_PAIR(IA32_RTIT_CTL, LOAD, CLEAR),
> +		VMCS_ENTRY_EXIT_PAIR(IA32_LBR_CTL, LOAD, CLEAR),

No macros please, it's just as clear to expand them especially since the 
#define is far from the struct definition.

Paolo

