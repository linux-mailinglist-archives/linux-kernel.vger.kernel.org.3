Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21164E9D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbiC1ROg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244466AbiC1ROe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93C9763BCD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648487571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAtr0LP2USxNpnB9STkRM5vT/HSx8javxned67kz0BE=;
        b=F7ljEjf9/F7+T10o02MkKDrzKWhG4t52h/R7Qmzqqbq58MORiTtlkE5MWQuz3LqAJHaGLK
        L8JqFMqjD0EtT0ytb2DSEgw24La+6vnTagWOROWZbsvItTjknhcWqCUVT91fLTDDGvJZ9o
        pMVf5sWxjSfBeP28OmjK4zFcxBsVuRg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-vf0O9GfzOoOeHVwglxcd5w-1; Mon, 28 Mar 2022 13:12:50 -0400
X-MC-Unique: vf0O9GfzOoOeHVwglxcd5w-1
Received: by mail-ed1-f71.google.com with SMTP id u13-20020a50a40d000000b00419028f7f96so9285426edb.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WAtr0LP2USxNpnB9STkRM5vT/HSx8javxned67kz0BE=;
        b=TUiBSpED6vp8HcHbXS6aEnU01tvqHoBun7pmpEfYEecJ9g+oLE/a2Bdwu0JLUtgik0
         felVjy3dbYFcHquhtDWxptR8EOdTPeYeoU9nOkCuT1EGjJl/zs+JLk5Rfxx5eQLIRLwQ
         yI7p8iofjRHIo3TJ4TBlogZ0ajaFokztLaKEB81Qr7luY7SIQmN2D9eKErC5F8s8DzeY
         rSZ/bGwyKIctlZysvuta6besC8LneFdsjh0tm+WVVwQjbEbEM9jxnpTaOFwqsVkrhOTh
         z9xNRqZEKQGh9x6yzPG2ORpZSg48y9KZpnFLJc+WDkaZQ346iRwnVRgO+pAgfDVHIoTe
         eh7Q==
X-Gm-Message-State: AOAM531BAvkSim3Vr6G1MRd9wr/gHuOiYmHY4pEgOlCStHWyNAH8IRLt
        JGOSlMVA7t+xIorZPPOJ4u4DInY31Rx9lC2lLQ+RBkarTmJ71301o/0MlkDEjWX8OK2Dh6yarsq
        zivNpe5brN3033uTFxMzIvtSw
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr29907125ejc.153.1648487568877;
        Mon, 28 Mar 2022 10:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoABRhK5yZ0JW/SGZSVJLT8XCL03jsbsmzA/8MI2IhCq8xMboMQCemSCrwCjRMZtuStMQFiA==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr29907090ejc.153.1648487568649;
        Mon, 28 Mar 2022 10:12:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8ca6:a836:a237:fed1? ([2001:b07:6468:f312:8ca6:a836:a237:fed1])
        by smtp.googlemail.com with ESMTPSA id u26-20020a05640207da00b00419a14928e5sm5270689edy.28.2022.03.28.10.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 10:12:47 -0700 (PDT)
Message-ID: <bfe9a0ce-7f83-4264-e450-a53e4e08d785@redhat.com>
Date:   Mon, 28 Mar 2022 19:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/6] KVM: x86: nSVM: implement nested LBR
 virtualization
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20220322174050.241850-1-mlevitsk@redhat.com>
 <20220322174050.241850-3-mlevitsk@redhat.com>
 <fca4a420-bdb4-0b46-c346-bee5500be43a@redhat.com>
 <612b6524258b949e381efec12d85b4e82be53308.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <612b6524258b949e381efec12d85b4e82be53308.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 17:12, Maxim Levitsky wrote:
> - with LBR virtualization supported, the guest can set this msr to any value
> as long as it doesn't set reserved bits and then read back the written value,
> but it is not used by the CPU, unless LBR bit is set in MSR_IA32_DEBUGCTLMSR,
> because only then LBR virtualization is enabled, which makes the CPU
> load the guest value on VM entry.
>   
> This means that MSR_IA32_DEBUGCTLMSR.BTF will magically start working when
> MSR_IA32_DEBUGCTLMSR.LBR is set as well, and will not work otherwise.

That can be fixed by context-switching DEBUGCTLMSR by hand when LBR=0 && 
BTF=1.  Would you like to give it a shot?

Paolo

