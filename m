Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71A2500AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiDNKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiDNKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B84924F07
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649930669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yuBcaeBniy5n5/L8X5921bwDC++5b8Xw6Z88KRpE9bQ=;
        b=H6ThkuHQRkp0+KobMoIe4k1h+ICTCF7M03QuUQVfPghUjePcRurMyzgFUwPCCSMo4Fy/Ey
        Xnybm/UL6i6HY/U4brYH9R0SUP+6HXyDU2xE2lqa7R5mQfwNN5P6izDpRphFF81V4+JVBZ
        uqGwofKnqyI7XkwBUcYcLRf8pP84xps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-lfkcvLJfP2iUfNlDxr3NnQ-1; Thu, 14 Apr 2022 06:04:26 -0400
X-MC-Unique: lfkcvLJfP2iUfNlDxr3NnQ-1
Received: by mail-wm1-f72.google.com with SMTP id j20-20020a05600c1c1400b0038eb5cb35ecso4255301wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yuBcaeBniy5n5/L8X5921bwDC++5b8Xw6Z88KRpE9bQ=;
        b=BT0K/ZtQUBykOaxVGHG92ZyA7LcGvg5x498byn40Yv2RWydpR2Y/pHFlv0l0PgHT3w
         qhV6+5UAgk7aXNelvu6H2hZayEvwvNaR2haItB+Zv6bm/frkXnyw4yyhVxjKoJYBBOHA
         u46GY4tdr727Xw7i81pmBgHIJonI2Qy3DRHZ9EELOs+vZC1Q+xmgiAq8TZIiHnuFrAXM
         6Yjsf+mhCKimLrEuHdQbjW8bpNrbpES38ypHo/HFPd5NRIBDrTDZ+8vXuwXAmlWTD0go
         semgljZsa9beHLPql6PJuz+rSbmBo1UKRfJ+h9OigVIbydE/YDxmYs7rdCz6OCP8ZtEw
         0WWQ==
X-Gm-Message-State: AOAM533p6TmgpdFMJ9aPEEwobJIzMKpXE5OgcTEc+eWPA/bLfliBilnW
        BwntLR2ahFYk9chU4igh3mty3kY+fCfsFmmBEfj0nvMpt2zh8jGPgSWPFCuSa6TmqT5Za4l2PQj
        7OGGZtMTcTemqbuOgC1a3/bvh
X-Received: by 2002:a05:600c:3ba9:b0:38e:c8c6:ae0d with SMTP id n41-20020a05600c3ba900b0038ec8c6ae0dmr2410328wms.120.1649930664853;
        Thu, 14 Apr 2022 03:04:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWW/CBrPwe+sYaoZNvV9T6UgMbQHF1faFSZFy0/f2vgkvI5kJx/Q5UzWAjnkbtTzqBMnumbg==
X-Received: by 2002:a05:600c:3ba9:b0:38e:c8c6:ae0d with SMTP id n41-20020a05600c3ba900b0038ec8c6ae0dmr2410293wms.120.1649930664610;
        Thu, 14 Apr 2022 03:04:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r14-20020a0560001b8e00b00205918bd86esm1395196wru.78.2022.04.14.03.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 03:04:24 -0700 (PDT)
Message-ID: <658729a1-a4a1-a353-50d6-ef71e83a4375@redhat.com>
Date:   Thu, 14 Apr 2022 12:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH V3 3/4] KVM: X86: Alloc role.pae_root shadow page
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org
References: <20220330132152.4568-1-jiangshanlai@gmail.com>
 <20220330132152.4568-4-jiangshanlai@gmail.com> <YlXrshJa2Sd1WQ0P@google.com>
 <CAJhGHyD-4YFDhkxk2SQFmKe3ooqw_0wE+9u3+sZ8zOdSUfbnxw@mail.gmail.com>
 <683974e7-5801-e289-8fa4-c8a8d21ec1b2@redhat.com>
 <CAJhGHyCgo-FEgvuRfuLZikgJSyo7HGm1OfU3gme35-WBmqo7yQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAJhGHyCgo-FEgvuRfuLZikgJSyo7HGm1OfU3gme35-WBmqo7yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 11:32, Lai Jiangshan wrote:
> kvm_mmu_free_roots() can not free those new types of sp if they are still
> valid.  And different vcpu can use the same pae root sp if the guest cr3
> of the vcpus are the same.

Right, but then load_pdptrs only needs to zap the page before (or 
instead of) calling kvm_mmu_free_roots().

Paolo

> And new pae root can be put in prev_root too (not implemented yet)
> because they are not too special anymore.  As long as sp->gfn, sp->pae_off,
> sp->role are matched, they can be reused.

