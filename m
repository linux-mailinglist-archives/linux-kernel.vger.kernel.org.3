Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E667B516F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiEBLzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiEBLzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8213719C3B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651492334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NqBPLX8TzclPanWWsLIm67uAy6NiGYXkNprNmZ5h2U=;
        b=ZhpNlM1QZ9FB06pwwTMp4YxtpmD+Y3iPtOZSCJCasC+TzBvcpv0+t0CCM4sJIQdw+HQHY2
        s2cYTFv519S4POYbjgN4+rLUtWqntbZlvO5CWRmNpojQe9LxbB/JXcCtLG2Alv16nryKVU
        nvc3aSt5mqF54xzL6YE2gpwdmWmOkw0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-D8bz-OnHOly547M5SIYjxQ-1; Mon, 02 May 2022 07:52:13 -0400
X-MC-Unique: D8bz-OnHOly547M5SIYjxQ-1
Received: by mail-ej1-f72.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso6699569ejs.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 04:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4NqBPLX8TzclPanWWsLIm67uAy6NiGYXkNprNmZ5h2U=;
        b=MopCkMNwIfrDqt+KurIYl7BJKg3AZdUB1uhaLY2XO58ogpe0vvRj0OwjDCMAaZhezM
         1tyyOPW2iLBJqQyAvO1c5M7/RkdMpwb2oq7goqd0LcQsvU6EGc3zz2uEO1ziBiE3pKfj
         FTJv0iIibDNR/3W2Oihlu5aZhlKle7gmVVazNentNOYNGiSu9myyELfoC2fOp3+9WmhF
         FboyAkGESXDqBTGcBDBp6wAGeOMtmMp/MP1vJBYZfkfebgxP0SVyrh333bQHvhQT4I/c
         KoaYpIK6IFUiIhK16znJQsntzR24WRrGJSiXrd2Z/TAAV0H0UvEFZRaASEglUiGyikLb
         RMBQ==
X-Gm-Message-State: AOAM5325KUC757qwHpTEEDLjbqHJqnhAR4MtgnW2x13wXK28TLX10Wwv
        vEIyXstkymwu7GG+jphK4alhw0DNLOjQoI2zYFwxKKC+jAcpemWLWDfzSCSVuZEmcqUX4SGQkY1
        o7/s//Wug6jwAaP0PcJHlIjuY
X-Received: by 2002:a17:907:ea8:b0:6f4:78d1:806d with SMTP id ho40-20020a1709070ea800b006f478d1806dmr237372ejc.448.1651492332309;
        Mon, 02 May 2022 04:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7KJP4JNBhC3BYz4fdMtonBbL+pNQ691k+NxaTuWInVE57dVdzaO1Hr7zV3crJJ9y691uFQg==
X-Received: by 2002:a17:907:ea8:b0:6f4:78d1:806d with SMTP id ho40-20020a1709070ea800b006f478d1806dmr237359ejc.448.1651492332135;
        Mon, 02 May 2022 04:52:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id en22-20020a17090728d600b006f3ef214ddesm3520943ejc.68.2022.05.02.04.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 04:52:11 -0700 (PDT)
Message-ID: <8e2213fa-981a-11cd-5bcc-3338d3b2c5de@redhat.com>
Date:   Mon, 2 May 2022 13:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86/mmu: Do not create SPTEs for GFNs that exceed
 host.MAXPHYADDR
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
References: <20220428233416.2446833-1-seanjc@google.com>
 <2d10ff16d3f5fa03886721c24f2db10d79759ed2.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <2d10ff16d3f5fa03886721c24f2db10d79759ed2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 13:12, Kai Huang wrote:
>> -		if (unlikely(!enable_mmio_caching)) {
>> +		if (unlikely(!enable_mmio_caching) ||
>> +		    unlikely(fault->gfn > kvm_mmu_max_gfn_host())) {
> Shouldn't we check fault->gfn against cpuid_maxphyaddr(vcpu) instead of
> kvm_mmu_max_gfn_host() here?

No, the point of this check is to handle the case where 
kvm_mmu_max_gfn_host() is smaller than cpuid_maxphyaddr().

Paolo

