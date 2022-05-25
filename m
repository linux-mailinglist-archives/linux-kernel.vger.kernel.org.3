Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBDD533824
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiEYIPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbiEYIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A744387A2C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653466491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paaqYogLVjzUCWrA/Y5AMj98uKlpQl9nU/h23hCbGlI=;
        b=YtIJ2dv5WRFSfVWwGvsjfW1/OIo6zuxr/mavP08elktb84DBDmaUSNPIC1aQFPDsFbi5TQ
        po9AmqPFWSwXRwbxl05byZpk8tyF4Y2P4G5QZ+kZCJbtfqXQFd9ys5e8OJBfgDkborI37Y
        51VME3NQWGLenAiCKN5EnzuVLwndOXE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-tjFkdRgxMbK9OgE8KhDPlw-1; Wed, 25 May 2022 04:14:50 -0400
X-MC-Unique: tjFkdRgxMbK9OgE8KhDPlw-1
Received: by mail-ed1-f69.google.com with SMTP id p13-20020aa7c4cd000000b0042ab847aba8so14359021edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=paaqYogLVjzUCWrA/Y5AMj98uKlpQl9nU/h23hCbGlI=;
        b=j//fJ96vLaXI85JtdinxyCx1aIS1nVEDYTlWf6h+0kxr6yb1/lKX7M1R8HLJPTxIon
         FFEQV33ZvsJ2DBqa2nh8S0vAFyTQ3xz8+IMExL/VhKLNvw9EpIUqXA3yrVv92sTYdmvr
         OPPbvv+PiJ3+GGKNOE93SNBjsbljXomL8bp1RUlJJWrKibPDQuwiV2IiGALrno1mPiQt
         EeV1UfyKHkFlRnCTF7s7DM9JKmq2+xIiJck2SwpY4byo1HEkFQrYwtqYJvZjfNvL3pfL
         QPuUmW2mON8qsx/QLNLyguk6q2yyWuTDLQaoSVHO+4Mfe0918qVaYG8dNuTXVf+/6uxR
         +g5g==
X-Gm-Message-State: AOAM532ftUTdysXirWwYvXszDIUq33S1yl87+BAdwaTHPULROSc/eUcP
        PYmBOi4Iu8547yfzSt4STmFQcbg+yqN0wVJ4hzSSUu8O/JFirfpOCc4586waX+1SLmuVtRtlDNl
        iPfOVPIZ95t1rjU6v+ZDIVEz3
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr26737708ejc.53.1653466489183;
        Wed, 25 May 2022 01:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXnlUZYZZXDdC0VgEaTQQYu36A0YnrnR8kogMwBv4c9hC7aPIjAEVcxGrQcdY8NeeeBtgvLQ==
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr26737701ejc.53.1653466488995;
        Wed, 25 May 2022 01:14:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ev7-20020a17090729c700b006fe9191f47asm3885886ejc.70.2022.05.25.01.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:14:48 -0700 (PDT)
Message-ID: <0848a2da-c9cf-6973-c774-ff16c3e8a248@redhat.com>
Date:   Wed, 25 May 2022 10:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RESEND v12 00/17] KVM: x86/pmu: Add basic support to
 enable guest PEBS via DS
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
References: <20220411101946.20262-1-likexu@tencent.com>
 <87fsl5u3bg.fsf@redhat.com> <e0b96ebd-00ee-ead4-cf35-af910e847ada@gmail.com>
 <d7461fd4-f6ec-1a0b-6768-0008a3092add@gmail.com> <874k1ltw9y.fsf@redhat.com>
 <f379a933-15b0-6858-eeef-5fbef6e5529c@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <f379a933-15b0-6858-eeef-5fbef6e5529c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 09:56, Like Xu wrote:
> Thanks for the clarification.
> 
> Some kvm x86 selftests have been failing due to this issue even after 
> the last commit.
> 
> I blame myself for not passing the msr_info->host_initiated to the 
> intel_is_valid_msr(),
> meanwhile I pondered further whether we should check only the MSR addrs 
> range in
> the kvm_pmu_is_valid_msr() and apply this kind of sanity check in the 
> pmu_set/get_msr().
> 
> Vitaly && Paolo, any preference to move forward ?

I'm not sure what I did wrong to not see the failure, so I'll fix it myself.

But from now on, I'll have a hard rule of no new processor features 
enabled without KVM unit tests or selftests.  In fact, it would be nice 
if you wrote some for PEBS.

Paolo

