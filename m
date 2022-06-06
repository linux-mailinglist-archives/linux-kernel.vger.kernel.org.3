Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C5053EAE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiFFQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbiFFQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CAA62914EE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654532441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SiJ9xom7N9pKMOdzxnCK3+PJOWSLJd7EA3DjmLBi34c=;
        b=FFopMXIXaspgU3OsHOiL9zXO23qE0lwEYp0XUY4Em0eh8m4r2LqJWIPImcjI+WlAQ5abp8
        pGQAkh8Rjtors03+cAA9jKfOC01dJTaZpzLueHKkmTWq+o1XH2qT6/RC4OHfhkLJEsyMpn
        0CiXO5UomjCaY8znbFl/qWdwE4mTl6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-jZQgIzVfOCWTTt_988W_XA-1; Mon, 06 Jun 2022 12:20:40 -0400
X-MC-Unique: jZQgIzVfOCWTTt_988W_XA-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c3b9200b00397335edc7dso11419929wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SiJ9xom7N9pKMOdzxnCK3+PJOWSLJd7EA3DjmLBi34c=;
        b=dwJHjOINLmFU+fsDlY+i2hDtkGjHhbTaVk/lgpVXU9smLPwX9xqV1ijyZ+rj8JAZF0
         TtoFF67Asxl/BrFhEAWND7IXzOWIfPQ4tiK5tWVcNsOZFNIxYMO3UlBJAfLRwQPkmKd9
         D3enAjYSbH4NmysDUnwheF99WDt6yIVZYDROZVz64uJx9tvmu+BxSJRkJ0oxmtg1g8DU
         H4ZqDg7GBFgMjeeVps78f88JXuyKQ1zKtwSnkWa/Krz38tDUHyhbQYHUuDIEqpgA4WXF
         nkoD9j08BmGCzEf+wvBRYK+WTX0bntJxTctv3VCsdNxpW0nlA7wD9nwo3xOyS0h7QNS7
         Z8Rg==
X-Gm-Message-State: AOAM532YAFTkYOb9SfaM5Tgr308KGBFiMLYEvpyG5VTv5/tIyr9LwvKO
        r3Dvkxhojc/zXEqNT755GaADZIpZvJCP1kAfE+FcolU+LsitlymzDIjb0POsjEwD7QgOwJufqOe
        zJSKF5q6RqzVVyqNRTcIFnRzP
X-Received: by 2002:a05:6000:1c0d:b0:216:c9f4:2b83 with SMTP id ba13-20020a0560001c0d00b00216c9f42b83mr11271672wrb.405.1654532439232;
        Mon, 06 Jun 2022 09:20:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRaTzbA0QBQEva/7Bqtk+6R9scH/Yt15vQFFNyrQgBRo85G9w3nue1vJbR7yVabCwRBl1RyQ==
X-Received: by 2002:a05:6000:1c0d:b0:216:c9f4:2b83 with SMTP id ba13-20020a0560001c0d00b00216c9f42b83mr11271648wrb.405.1654532438966;
        Mon, 06 Jun 2022 09:20:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id k5-20020adff285000000b002101ed6e70fsm11539684wro.37.2022.06.06.09.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 09:20:38 -0700 (PDT)
Message-ID: <bf1d4cd1-d902-6efc-a954-58a11d85d9ac@redhat.com>
Date:   Mon, 6 Jun 2022 18:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] entry/kvm: Exit to user mode when TIF_NOTIFY_SIGNAL is
 set
Content-Language: en-US
To:     Seth Forshee <sforshee@digitalocean.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sean Christopherson <seanjc@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kvm@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20220504180840.2907296-1-sforshee@digitalocean.com>
 <Yp4LpgBHjvBEbyeS@do-x1extreme>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yp4LpgBHjvBEbyeS@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 16:13, Seth Forshee wrote:
> On Wed, May 04, 2022 at 01:08:40PM -0500, Seth Forshee wrote:
>> A livepatch transition may stall indefinitely when a kvm vCPU is heavily
>> loaded. To the host, the vCPU task is a user thread which is spending a
>> very long time in the ioctl(KVM_RUN) syscall. During livepatch
>> transition, set_notify_signal() will be called on such tasks to
>> interrupt the syscall so that the task can be transitioned. This
>> interrupts guest execution, but when xfer_to_guest_mode_work() sees that
>> TIF_NOTIFY_SIGNAL is set but not TIF_SIGPENDING it concludes that an
>> exit to user mode is unnecessary, and guest execution is resumed without
>> transitioning the task for the livepatch.
>>
>> This handling of TIF_NOTIFY_SIGNAL is incorrect, as set_notify_signal()
>> is expected to break tasks out of interruptible kernel loops and cause
>> them to return to userspace. Change xfer_to_guest_mode_work() to handle
>> TIF_NOTIFY_SIGNAL the same as TIF_SIGPENDING, signaling to the vCPU run
>> loop that an exit to userpsace is needed. Any pending task_work will be
>> run when get_signal() is called from exit_to_user_mode_loop(), so there
>> is no longer any need to run task work from xfer_to_guest_mode_work().
>>
>> Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
> 
> Friendly reminder as it seems like this patch may have been forgotten.

Probably AB-BA maintainer deadlock.  I have queued it now.

Paolo

> Thanks,
> Seth
> 
>> ---
>>   kernel/entry/kvm.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
>> index 9d09f489b60e..2e0f75bcb7fd 100644
>> --- a/kernel/entry/kvm.c
>> +++ b/kernel/entry/kvm.c
>> @@ -9,12 +9,6 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>>   		int ret;
>>   
>>   		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
>> -			clear_notify_signal();
>> -			if (task_work_pending(current))
>> -				task_work_run();
>> -		}
>> -
>> -		if (ti_work & _TIF_SIGPENDING) {
>>   			kvm_handle_signal_exit(vcpu);
>>   			return -EINTR;
>>   		}
>> -- 
>> 2.32.0
>>
> 

