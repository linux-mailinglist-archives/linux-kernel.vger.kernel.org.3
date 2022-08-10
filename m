Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E658EC16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiHJMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHJMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AA737696E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660134963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87CTfpJXv+5cfHg/lnngjOgN/RrqyzIAd1Oqc8i/xvY=;
        b=CPXV9rH9TmF+bA0oEZ3dkiTztZ+QFJFIC3rkvagF9+7CP3bDT0/ptWLhmXg3unsCcS+0A5
        592QCzXJ+jgBYWkdu0yolfSVQDzg5N623UV9JDU+1B5xhe7sRrNxqczh0VQOZfuAvDVavr
        fVJ+aCi1FTt5wCVR1AJWOfIsS37Rm90=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-O46Iudq4Pky7_D87Yb5Lhw-1; Wed, 10 Aug 2022 08:36:00 -0400
X-MC-Unique: O46Iudq4Pky7_D87Yb5Lhw-1
Received: by mail-ej1-f71.google.com with SMTP id qk37-20020a1709077fa500b00730c2d975a0so4143721ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=87CTfpJXv+5cfHg/lnngjOgN/RrqyzIAd1Oqc8i/xvY=;
        b=E01Dd27yGxJI+XKvFDWPpmGs2KdEWs5BHZA2VOiE9v+ZZ+KAUSdtREiGdcER9oz5sH
         iWVmuEMYYX7KR0QsxAhVZdApwJyMkIBi0dIKTe2aE6u0IfvKT4vwsQ282sUO2uFqnogB
         7mqItuCURAM1Bxe2T100UHke997hdDk0i/mRQxKuCGvO7cMW46q5PBdAh/Ea0T5O/tsV
         yQqVMEmuBZ7LvCTI/9OMoU9StSArOojNloIuj//9LCaZpUJohxMeuaJUHm+tr3bX8KFM
         9tIxasX2wNH/5jzNGEMUoVrO919iqoxYMtItfX3J/lC7ROqW7kbmjXUtFMzdlmqk8Phu
         CNfw==
X-Gm-Message-State: ACgBeo2AlNsUzVP7OjZgtjnD/sIRUHuC65qPGKPYgCqxWGmBjuOKaqI9
        f+vVx953WSybsXUZFV4Fp1z8hS1Yfh0NyPWZzfiJc/nELK/TX5ZhlsZ6MrM+2Kbm8o6JShEPvFz
        1wcaBMpcKwXa7h/o7fXhzozW6
X-Received: by 2002:a17:907:7f9f:b0:733:76c:44c9 with SMTP id qk31-20020a1709077f9f00b00733076c44c9mr2231302ejc.642.1660134959422;
        Wed, 10 Aug 2022 05:35:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4VclOIWxDOiejEyzXNHWLBzTYbNnvJLzw2rnHm34/ZQmU9fDQpff2RJbtcZ+lFjHCJIwCYxQ==
X-Received: by 2002:a17:907:7f9f:b0:733:76c:44c9 with SMTP id qk31-20020a1709077f9f00b00733076c44c9mr2231285ejc.642.1660134959206;
        Wed, 10 Aug 2022 05:35:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ky16-20020a170907779000b00730a73cbe08sm2246142ejc.169.2022.08.10.05.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:35:58 -0700 (PDT)
Message-ID: <c95aec97-6fbd-dca5-6aa6-b8242d5a379a@redhat.com>
Date:   Wed, 10 Aug 2022 14:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gavin Shan <gshan@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, shuah <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        maz <maz@kernel.org>, oliver upton <oliver.upton@linux.dev>,
        andrew jones <andrew.jones@linux.dev>,
        yihyu <yihyu@redhat.com>, shan gavin <shan.gavin@gmail.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
 <YvLT1fd8ddybF5Uw@google.com>
 <8c1f33b4-a5a1-fcfa-4521-36253ffa22c8@redhat.com>
 <1316061904.375.1660134559269.JavaMail.zimbra@efficios.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1316061904.375.1660134559269.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 14:29, Mathieu Desnoyers wrote:
>> - By design, selftests/rseq and selftests/kvm are parallel. It's going to
>> introduce
>>    unnecessary dependency for selftests/kvm to use selftests/rseq/librseq.so. To
>>    me,
>>    it makes the maintainability even harder.
> In terms of build system, yes, selftests/rseq and selftests/kvm are side-by-side,
> and I agree it is odd to have a cross-dependency.
> 
> That's where moving rseq.c to tools/lib/ makes sense.
> 
>> - What selftests/kvm needs is rseq-thread-pointer.h, which accounts for ~5% of
>>    functionalities, provided by selftests/rseq/librseq.so.
> I've never seen this type of argument used to prevent using a library before, except
> on extremely memory-constrained devices, which is not our target here.

I agree.

To me, the main argument against moving librseq to tools/lib is a 
variant of the build-system argument, namely that recursive Make 
sucks[1] and selftests/kvm right now does not use tools/lib.  So, for a 
single-file library, it may be simply not worth the hassle.

On the other hand, if "somebody else" does the work, I would have no 
problem with having selftests/kvm depend on tools/lib, not at all.

Thanks,

Paolo

[1] Kbuild is a marvel that makes it work, but it works because there 
are no such cross-subdirectory dependencies and anyway 
tools/testing/selftests does not use Kbuild.

