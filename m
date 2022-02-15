Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F314B6855
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiBOJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:59:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiBOJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D797D10E07B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644919169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFs5onejenQ3kCvmT0LfSSKhonV10nIm+61L2qx/dBw=;
        b=VhQvhJuEFYBO0qa2EgnDrgF/omLfz5lfxhS0PZq5AKum4wqL06MfWIJuVXCqSRfYCf3cPk
        J9rnrZajKSzIlj9mHwdp5i7kapw3VeLveyyVWCoW8sacO67JZg/MkMDrzCR8H1C3QfzvDH
        3MM93r+xm7HEtBoGB8g7RTisYLYnrDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-U7xmFvLMPtGWAZmhpcCoGg-1; Tue, 15 Feb 2022 04:59:28 -0500
X-MC-Unique: U7xmFvLMPtGWAZmhpcCoGg-1
Received: by mail-wm1-f72.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so1142203wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RFs5onejenQ3kCvmT0LfSSKhonV10nIm+61L2qx/dBw=;
        b=jptjbQ+km556HRGd1rs518dC5XQSI0h44bwS+Px0PaSRRDU5crc2WvPGb1O5oN2f+r
         PvCpzzkcUvN5QLjtEiBwj+qyyTr2cs4tw0I4tIxTT05PTwdhRGZ8Rd3akKYcQrR4hKp1
         +W7768bnJ3igS6mwuxBAp3qcc6n1IOGr4LTu1FCQXgedgX9180YKg1meF3i72eB4wCvQ
         ff1o+TdXZscE4aE4IHI6G2+y4eEjP6c/THz0Bxmzr1r0tFH02WKuMlgxSFNXPXPlJHsl
         sqL3Yxhjjo6XQ5IkLiTLHPhnw4YSito9lmu5yT9XveRp0Jso8ROdjj3W+teHfBAIbGbd
         HciA==
X-Gm-Message-State: AOAM532X0MwQqdBaKcPWoYHFCHz5GgRSzLvot0uY2FalivTuwkceDMvm
        ZM7izfvDCgR0wMGLhj65NHfytxoTcgp8YGKL6yb7wFGhSqwyN8LXTOCGlq8FfCGAzNHi1tVYXXa
        xqvlmPWyM1qc1GPhk54Anu429
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr2529942wrq.61.1644919167294;
        Tue, 15 Feb 2022 01:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyf07QPKhcpmzkRYD8dtwY0N1LIJJxcaaknto183gW0tYcjUv+VlAV6/UoHcblLhZOXokAGQ==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr2529926wrq.61.1644919167092;
        Tue, 15 Feb 2022 01:59:27 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id 20sm12933136wmk.26.2022.02.15.01.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 01:59:26 -0800 (PST)
Message-ID: <c01824a7-9d15-1356-2530-04c6112ace65@redhat.com>
Date:   Tue, 15 Feb 2022 10:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] selftests: kvm: Check whether SIDA memop fails for normal
 guests
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220215074824.188440-1-thuth@redhat.com>
 <801aa4ea-ca26-7561-95f3-162b0f680929@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <801aa4ea-ca26-7561-95f3-162b0f680929@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 10.54, Janis Schoetterl-Glausch wrote:
> On 2/15/22 08:48, Thomas Huth wrote:
>> Commit 2c212e1baedc ("KVM: s390: Return error on SIDA memop on normal
>> guest") fixed the behavior of the SIDA memops for normal guests. It
>> would be nice to have a way to test whether the current kernel has
>> the fix applied or not. Thus add a check to the KVM selftests for
>> these two memops.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/s390x/memop.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
>> index 9f49ead380ab..d19c3ffdea3f 100644
>> --- a/tools/testing/selftests/kvm/s390x/memop.c
>> +++ b/tools/testing/selftests/kvm/s390x/memop.c
>> @@ -160,6 +160,21 @@ int main(int argc, char *argv[])
>>   	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
>>   	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
>>
>> +	/* Check that the SIDA calls are rejected for non-protected guests */
>> +	ksmo.gaddr = 0;
>> +	ksmo.flags = 0;
>> +	ksmo.size = 8;
>> +	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
>> +	ksmo.buf = (uintptr_t)mem1;
>> +	ksmo.sida_offset = 0x1c0;
> 
> What is the rational for that constant?
> Any would do, as long as size + offset < PAGE_SIZE, correct?

Right, it's rather a random value.

  Thomas

