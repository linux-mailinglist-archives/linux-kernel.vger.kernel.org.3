Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB841529D23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiEQJBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244093AbiEQJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5004015811
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652778072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTEAmJWDQjyVQdo/huPK56rWT/Ja3yG1ilQMT9ylP9I=;
        b=gzy2VOILoYGmD0UpMSrdH6u0wHUf2ElS0bvAMLC2IiPFH1PNCRyZUCoc8LRCb4rp/h0hG7
        RAhvsDrIfn6cH1W+jU0IY+S+hsuivqQhM2rIfmT6nutOA3ZJhTnErg48FqZz4tJJo1PAmC
        cBNCItcYNJXizE748P+OzHQA6/RwlXk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-3hJp-_n8Ma-an1LYsytR5w-1; Tue, 17 May 2022 05:01:09 -0400
X-MC-Unique: 3hJp-_n8Ma-an1LYsytR5w-1
Received: by mail-ed1-f72.google.com with SMTP id w5-20020a056402128500b0042aa2647eb6so4976527edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bTEAmJWDQjyVQdo/huPK56rWT/Ja3yG1ilQMT9ylP9I=;
        b=0xCBIcP0BCdPYGzja6HTYNGcXt2hShxGuEeBraaiSGWihi6t9kxLISXG0rQaXy4g5B
         O0vzckuyXvG3HWyz7x6rXfAQQsufDDsoWklEaIaaIQ+8rolKopeEIRvucqfsqs0n1JjK
         bIX3jBucAknCQyfbLGlXcRCxrToxIzfkfWKmrpLKgNVRQcO2hu1Q23IYJVEfT9JjrrFb
         lZImXyhjATmH9+a7gAKKjGSsr1wtBPaq6ZRwR1AI9abJAyURmXwV92B/4M2It2jew88h
         4EuLt3OPUD+JifecIk099SBjIngQPhbJ40jM8IsqIipn2zaZYCvtglvOU0SJapa7v5KC
         RoDA==
X-Gm-Message-State: AOAM530i52q7FmAtL0TN3y1eVG2cJoVFBl4hLL1HhgEXD3yWWGr03nFF
        I9ER5QpByXvF2sZXI+3GNSE6O4vM61rdSnladTDUpTwoyrLb6uYDftF4J+F406D6gH6DBY5kl1I
        e+KTQlls7Kt1LhkkqgIflM+dk
X-Received: by 2002:a17:906:794b:b0:6f4:85e1:d7f with SMTP id l11-20020a170906794b00b006f485e10d7fmr18325319ejo.6.1652778068471;
        Tue, 17 May 2022 02:01:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4gP1uuWDN9RinZ3jE+uPtasR1lITXJRIKhSDb4PAL2nI0R5KsUc7yfZZFeaD1hC0ZPdxBcQ==
X-Received: by 2002:a17:906:794b:b0:6f4:85e1:d7f with SMTP id l11-20020a170906794b00b006f485e10d7fmr18325307ejo.6.1652778068277;
        Tue, 17 May 2022 02:01:08 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r9-20020a1709064d0900b006f3ef214dbcsm791988eju.34.2022.05.17.02.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:01:07 -0700 (PDT)
Message-ID: <6212bdfe-ecd2-3787-a2cb-b285318b102a@redhat.com>
Date:   Tue, 17 May 2022 11:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v11 14/16] KVM: x86/vmx: Flip Arch LBREn bit on guest
 state change
Content-Language: en-US
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     "jmattson@google.com" <jmattson@google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "like.xu.linux@gmail.com" <like.xu.linux@gmail.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220506033305.5135-1-weijiang.yang@intel.com>
 <20220506033305.5135-15-weijiang.yang@intel.com>
 <9f19a5eb-3eb0-58a2-e4ee-612f3298ba82@redhat.com>
 <9e2b5e9f-25a2-b724-c6d7-282dc987aa99@intel.com>
 <8a15c4b4-cabe-7bc3-bd98-bd669d586616@redhat.com>
 <5f264701-b6d5-8660-55ae-a5039d6a9d3a@intel.com>
 <d68f61ab-d122-809b-913e-4eaf89b337c4@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <d68f61ab-d122-809b-913e-4eaf89b337c4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 10:56, Yang, Weijiang wrote:
>> I added more things to ease migration handling in SMM because: 1) qemu 
>> checks LBREn before transfer Arch LBR MSRs.

I think it should always transfer them instead?  There's time to post a 
fixup patch.

>> 2) Perf event is created when 
>> LBREn is being set.  Two things are not certain: 1) IA32_LBR_CTL doesn't have 
>> corresponding slot in SMRAM,not sure if we need to rely on it to transfer the MSR.
>> I chose 0x7f10 as the offset(CET takes 0x7f08) for storage, need you double check if 
>> it's free or used.

0x7f10 sounds good.

> Hi, Paolo,
> 
> I found there're some rebase conflicts between this series and your kvm 
> queue branch due to PEBS patches, I can re-post a new version based on
> your queue branch if necessary.

Yes, please.

> Waiting for your comments on this patch...

I already commented that using bit 63 is not good, didn't I?

Paolo

