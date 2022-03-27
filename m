Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44424E874A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiC0Kpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiC0KpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 06:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C6E4766E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648377821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2GIa+mmtal947w7XJ46Ep9n19VMMmjtdQlQdQQuEsg=;
        b=JYRX4/Dbr6I9FErfsls0fSF7O0cAOpS0RU0o9EodxTJ7vg/gdx9Pnzk1lay2IK5WIfPclo
        fW7WQaAwe0sqxgjo1Dj2w9ySSTV8eKUTzw99INxW0y4Y6gneovhqyc8F59J6WZySkgfvDa
        ECXX8dwHyvWblSVj0WV4dv7NceYQxJI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-2xR9a_KyM52K2_u8sPK4tg-1; Sun, 27 Mar 2022 06:43:40 -0400
X-MC-Unique: 2xR9a_KyM52K2_u8sPK4tg-1
Received: by mail-ej1-f70.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso5559840ejs.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H2GIa+mmtal947w7XJ46Ep9n19VMMmjtdQlQdQQuEsg=;
        b=UG6kB59ObUXOzbONlujel9md7BetoJD/1rqOKTYbZNb27QMs2b8fRbb/ebum/19xWZ
         yyKx3JCSOH4tXK2OpSc6c6wx21ZNH/7eDCaXbo998UeLdogSStb2lSkpb01kPQES9TJ7
         6Y6+l0pRteYy6SG8065H6aid4wRDmhT+aB+dCxTBXBZ+3BbI9NPusonH8mRrWEdJZqy3
         PoplPJwuixJ7Zja8v/ucskQWZWChwnCsJgP+5SPAruTyEC04a1RQbuw0gSnNWP+io/Kc
         HsZ/3O79neom+1CLWPXz7p7VTVBSccgGtTrdg6EEB+EQCNmf/uCQEHsJLyO2rcL6EWF2
         50Vg==
X-Gm-Message-State: AOAM530+bN+aPX1wINaMHebIHkqdWJImlLOHu5aLb4qPkkZRY4pMwrML
        g9UxHtJL1Xt20pFXvb11MnsysGaKYW1SNR8i16J7ha3u3JIrNqibVAYhtB5W0X/8zpYULQ1UdMs
        UobxRL1RtD6NIH8PrD3hxpT4Y
X-Received: by 2002:a17:907:1606:b0:6df:f528:4033 with SMTP id hb6-20020a170907160600b006dff5284033mr21505228ejc.433.1648377818833;
        Sun, 27 Mar 2022 03:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNsu4Jla66PU/uo2G0ZAf26Kt9rppr5HPcOcpESaC2zmv6zoGD5Ds5s4BA5nFsiY0f1omrBA==
X-Received: by 2002:a17:907:1606:b0:6df:f528:4033 with SMTP id hb6-20020a170907160600b006dff5284033mr21505206ejc.433.1648377818572;
        Sun, 27 Mar 2022 03:43:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8ca6:a836:a237:fed1? ([2001:b07:6468:f312:8ca6:a836:a237:fed1])
        by smtp.googlemail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm3213295ejc.109.2022.03.27.03.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 03:43:38 -0700 (PDT)
Message-ID: <e8488e5c-7372-fc6e-daee-56633028854a@redhat.com>
Date:   Sun, 27 Mar 2022 12:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86: optimize PKU branching in
 kvm_load_{guest|host}_xsave_state
Content-Language: en-US
To:     Jon Kohler <jon@nutanix.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220324004439.6709-1-jon@nutanix.com>
 <Yj5bCw0q5n4ZgSuU@google.com>
 <387E8E8B-81B9-40FF-8D52-76821599B7E4@nutanix.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <387E8E8B-81B9-40FF-8D52-76821599B7E4@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/26/22 02:37, Jon Kohler wrote:
>>>     Flip the ordering of the || condition so that XFEATURE_MASK_PKRU is
>>>     checked first, which when instrumented in our environment appeared
>>>     to be always true and less overall work than kvm_read_cr4_bits.
>>
>> If it's always true, then it should be checked last, not first.  And if
> 
> Sean thanks for the review. This would be a left handed || short circuit, so
> wouldn’t we want always true to be first?

Yes.

>> Not that it really matters, since static_cpu_has() will patch out all the branches,
>> and in practice who cares about a JMP or NOP(s)?  But...
> 
> The reason I’ve been pursuing this is that the guest+host xsave adds up to
> a bit over ~1% as measured by perf top in an exit heavy workload. This is
> the first in a few patch we’ve drummed up to to get it back towards zero.
> I’ll send the rest out next week.

Can you add a testcase to x86/vmexit.c in kvm-unit-tests, too?

Thanks,

Paolo

