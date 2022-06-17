Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0CC54F429
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381106AbiFQJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379797AbiFQJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C495D643
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655457740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FjuEQv4Qeb+ua2EzfVRmN0EZRhGaGIjPcxZ3XMGWqQ=;
        b=RoW4V/2cIjCODXreqwy4XfQmIUUugPlbAckZCowhMmSfkXNhA3ncncd+xlnot2VMxWxsDW
        F/yOLGjdpGzjb7Z4qh7xt1t3tXbjubD1C/YDe9H0uyOL+RzVhj+CipJ9O9yl8JAWXp4Vm+
        nwEt0awW4uKWPJrr33+L8i4z9Iw4Dzc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-2D6-lIfpOauBJ8RGCoHHuQ-1; Fri, 17 Jun 2022 05:22:18 -0400
X-MC-Unique: 2D6-lIfpOauBJ8RGCoHHuQ-1
Received: by mail-ed1-f72.google.com with SMTP id h17-20020a056402281100b0043555086cdcso2377650ede.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0FjuEQv4Qeb+ua2EzfVRmN0EZRhGaGIjPcxZ3XMGWqQ=;
        b=tCmZFZ5JVgoAGo44NjQWdCzLEu8zOvEztcfyo6u2y7AkUx8qXwnIDagGROqydSITsv
         QKPjpAKYi+ZUgoSy1+MOQUYF/07k8kCBV4pzBuFzjyD/xOvNWvchxJ9Iv5bkpdPLWOUj
         YlPyxJjRCNN5U0Ux7u3M4USjnbkA9edbcD9ma+1oRyG+v1MgT7XGFZtEChp4PgirmDmF
         BKntOu0E30Pnvw4YAkPeFfppbzV7a3A7AWGe6oZK8+GU6SG5bHGdimV5CnVvyhg8Ekls
         9qVzSzhE700ewaX5uSliK9M+ldsEVKeiADS8Xkx6+ZZg42evZpkx7QQQCm9BNeI4BykJ
         JtIg==
X-Gm-Message-State: AJIora8qQhrHzwAYJ5CeWvL6SS0F+FGNv3nBPSyEpq3MKomtqxa3dqbC
        Lu7nAl4oNTdhSGIUp4XmzBXBPh+ueC7131g24x9+6MQxr20ZG94/WaonHJNVGggWI9HUmag2nNg
        Msmz/LIMtvdtTZzsJhwK6fPfY
X-Received: by 2002:a17:907:c202:b0:710:8d1c:2501 with SMTP id ti2-20020a170907c20200b007108d1c2501mr8036303ejc.377.1655457736793;
        Fri, 17 Jun 2022 02:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sxScwELvm5Z4jJpyq2068amOUJIbJurQnj8zaZ+VzizUFIGSt842UCMnLfjZlggLVeac5uRA==
X-Received: by 2002:a17:907:c202:b0:710:8d1c:2501 with SMTP id ti2-20020a170907c20200b007108d1c2501mr8036279ejc.377.1655457736560;
        Fri, 17 Jun 2022 02:22:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id h18-20020a056402281200b0043173ab6728sm3611928ede.7.2022.06.17.02.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 02:22:13 -0700 (PDT)
Message-ID: <34e1b920-0a6b-5030-bbd9-6b1816789b8d@redhat.com>
Date:   Fri, 17 Jun 2022 11:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
Content-Language: en-US
To:     Andrew Jones <drjones@redhat.com>,
        David Laight <David.Laight@aculab.com>
Cc:     "'oliver.upton@linux.dev'" <oliver.upton@linux.dev>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <3e73cb07968d4c92b797781b037c2d45@AcuMS.aculab.com>
 <20220615185706.1099208-1-rananta@google.com>
 <20220616120232.ctkekviusrozqpru@gator>
 <33ca91aeb5254831a88e187ff8d9a2c2@AcuMS.aculab.com>
 <20220616162557.55bopzfa6glusuh5@gator>
 <7b1040c48bc9b2986798322c336660ab@linux.dev>
 <2ec9ecbfb13d422ab6cda355ff011c9f@AcuMS.aculab.com>
 <20220617072800.cvqb4wmafxdi3knq@gator>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220617072800.cvqb4wmafxdi3knq@gator>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 09:28, Andrew Jones wrote:
> On Thu, Jun 16, 2022 at 09:54:16PM +0000, David Laight wrote:
>> From: oliver.upton@linux.dev
>>> Sent: 16 June 2022 19:45
>>
>>>
>>> June 16, 2022 11:48 AM, "David Laight" <David.Laight@aculab.com> wrote:
>>>> No wonder I was confused.
>>>> It's not surprising the compiler optimises it all away.
>>>>
>>>> It doesn't seem right to be 'abusing' WRITE_ONCE() here.
>>>> Just adding barrier() should be enough and much more descriptive.
>>>
>>> I had the same thought, although I do not believe barrier() is sufficient
>>> on its own. barrier_data() with a pointer to uc passed through
>>> is required to keep clang from eliminating the dead store.
>>
>> A barrier() (full memory clobber) ought to be stronger than
>> the partial one than barrier_data() generates.
>>
>> I can't quite decide whether you need a barrier() both sides
>> of the 'magic write'.
>> Plausibly the compiler could discard the on-stack data
>> after the barrier() and before the 'magic write'.
>>
>> Certainly putting the 'magic write' inside a asm block
>> that has a memory clobber is a more correct solution.
> 
> Indeed, since the magic write is actually a guest MMIO write, then
> it should be using writeq().

It doesn't need to use writeq() because no special precautions are 
needed with respect to cacheability or instruction reordering (as is the 
case with hardware registers).

WRITE_ONCE is okay, especially since the code never reads it (and if it 
did it would also use READ_ONCE).

Paolo


