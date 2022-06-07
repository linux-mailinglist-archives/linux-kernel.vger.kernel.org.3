Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461D7540255
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbiFGPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbiFGPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A10AEC5E75
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654615424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGqsi3KJd9LaOiP/2DKVqWgAXQfJ4BFecWZlXXq685g=;
        b=RcOv5nO4hzPDkygro2xWKTFpmrdRZo4U1LTx4puorgHWpH+tVxOi3m9QVhn+DJ/oPdajEx
        pH+HvY6aMiyVkAbRnJuuchvtjzDlOiYeqHfOrYsPQpxYBVOdg2ir457JwcgT0jTIIOBsru
        H4b5W1sGiZxzlebeegqoBEO5XkAOk/k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-v02VOAFfNh6GQmH5_y6Dvw-1; Tue, 07 Jun 2022 11:23:43 -0400
X-MC-Unique: v02VOAFfNh6GQmH5_y6Dvw-1
Received: by mail-wr1-f70.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so4032583wra.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uGqsi3KJd9LaOiP/2DKVqWgAXQfJ4BFecWZlXXq685g=;
        b=vxUV/8JNePFpF7OCVXvqMXgsMjQWgZjZ2fuQGhuWoa113yYOVplcs7eJD80GNFifvJ
         aPyiL1/36+zbHjvPV5c1kx298VbG+pxDKpeP0KTcPZSi1TOS2tQzS/uMrQzHmLY+/wAA
         WsmREfI2xKFvCjmTN0zhKspMd8TYpM9ioFXC205n89v18W6P2iD1ZiH7qgeSRZWg09p2
         a5JtYiXljTCry1fV+Y0XcqgUSYzYY70Iw3yDmSHg2AtuMRxQu5Q7qs0/wgOiL3SIjcxu
         vdf5KzBwXry6s3aIAdg/hT2t0M7YPx6nv0lhAOlGzUZO46G2pTXvZJZ/ODT9KuR47bFD
         y0Gw==
X-Gm-Message-State: AOAM531ILup6HSa63WqXjGSOS/bFsqBPFGZqXk4tHHvZ0SfU6KzWQRRa
        MawnCp/NR+kULcvEwsYr0KmgdAhJ/iwrjw4yyvgkNs8oe9vfDRZ3o8wjK6E2xEwFUzhQGU65g3u
        KchiDOxRfM64fAb2hgvTK3sV/
X-Received: by 2002:adf:f5d0:0:b0:216:5680:b41e with SMTP id k16-20020adff5d0000000b002165680b41emr17135762wrp.216.1654615422410;
        Tue, 07 Jun 2022 08:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymxyv939js1nCuiezDwMezdK7yYmsUnLpwyHlPMFlqmHxZ41tVGiSN5DSbEsqemA33zqMWzg==
X-Received: by 2002:adf:f5d0:0:b0:216:5680:b41e with SMTP id k16-20020adff5d0000000b002165680b41emr17135716wrp.216.1654615422026;
        Tue, 07 Jun 2022 08:23:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bw1-20020a0560001f8100b002184280b3cbsm4675249wrb.91.2022.06.07.08.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 08:23:41 -0700 (PDT)
Message-ID: <2c561959-2382-f668-7cb8-01d17d627dd6@redhat.com>
Date:   Tue, 7 Jun 2022 17:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86: preserve interrupt shadow across SMM entries
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
References: <20220607151647.307157-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220607151647.307157-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 17:16, Maxim Levitsky wrote:
> If the #SMI happens while the vCPU is in the interrupt shadow,
> (after STI or MOV SS),
> we must both clear it to avoid VM entry failure on VMX,
> due to consistency check vs EFLAGS.IF which is cleared on SMM entries,
> and restore it on RSM so that #SMI is transparent to the non SMM code.
> 
> To support migration, reuse upper 4 bits of
> 'kvm_vcpu_events.interrupt.shadow' to store the smm interrupt shadow.
> 
> This was lightly tested with a linux guest and smm load script,
> and a unit test will be soon developed to test this better.
> 
> For discussion: there are other ways to fix this issue:
> 
> 1. The SMM shadow can be stored in SMRAM at some unused
> offset, this will allow to avoid changes to kvm_vcpu_ioctl_x86_set_vcpu_events

Yes, that would be better (and would not require a new cap).

Paolo

