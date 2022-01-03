Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A7A483852
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiACV0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:26:25 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:46009 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiACV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:26:24 -0500
Received: by mail-pl1-f173.google.com with SMTP id w24so25653609ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 13:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bC8LoxAk4ImoNjvINLpnL+jC6inYUp6CTHIHcIutO5M=;
        b=qYMPVp+ti6OncNtxPiSO/A/b2yGvMHCFQwwm6yIvXjV2ioL3P3lfgrrXSyhLrRp0x9
         ZsjPwLrCmVmA9DLvat7HJnW0K+xIyAmkANW3APsYtgIDQ/6y8BmS6AYQaeMd2G3QWnsj
         HYIGsSprLKDgD425WseqaluiVC0deTqosQ5liauBIP++qK3wjKRVnNNblLurypW+dniu
         fLN6lWuIsNZMQmE+2OU7gkHqLGSf2KdyZRK7nuup9XnsEU5KwglVOYt/6xQyzw5I8qNP
         4jkjlTOIxpE9fbHCZfbq9occrjAuEDpMipikuIkkBQVRu1wUEBEnPJNzIgdOqPOEeFmD
         ITzw==
X-Gm-Message-State: AOAM5310L0aXKvj4uSiVzVSCPUek7KaDIwe88aQe96m4VTufVZnB1Cx9
        CpZImV2sckHWuJKFqlQ+1b8=
X-Google-Smtp-Source: ABdhPJyRmFMdigCiAtOngKbAYuFHQgjIRiO+T9HrpizDdmRuAygm3tmBI7dykTfH/rbPGx6s4eupEg==
X-Received: by 2002:a17:902:650c:b0:149:82bb:1145 with SMTP id b12-20020a170902650c00b0014982bb1145mr33815070plk.3.1641245183959;
        Mon, 03 Jan 2022 13:26:23 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id d185sm33102451pgc.58.2022.01.03.13.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 13:26:23 -0800 (PST)
Message-ID: <79a44096-57f0-4df7-62e0-a87b3eca6231@acm.org>
Date:   Mon, 3 Jan 2022 13:26:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] locking/lockdep: Avoid potential access of invalid memory
 in lock_class
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20220103023558.1377055-1-longman@redhat.com>
 <954086c4-d679-57d7-cc46-9ce6af2872a4@acm.org>
 <4d3b818e-2aca-a596-644f-28e9e52c27bd@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4d3b818e-2aca-a596-644f-28e9e52c27bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 10:17, Waiman Long wrote:
> On 1/3/22 12:47, Bart Van Assche wrote:
>> On 1/2/22 18:35, Waiman Long wrote:
>>> -    WARN_ON_ONCE(!found);
>>> -    __lockdep_free_key_range(pf, key, 1);
>>> -    call_rcu_zapped(pf);
>>> -    graph_unlock();
>>> -out_irq:
>>> +    WARN_ON_ONCE(!found && debug_locks);
>>
>> lockdep_unregister_key() should only be called for a registered key so 
>> I'd
>> like to keep the WARN_ON_ONCE(!found) here instead of changing it into
>> WARN_ON_ONCE(!found && debug_locks). Otherwise this patch looks good 
>> to me.
> 
> The reason for this change is to handle the case that a 
> lockdep_register_key()/lockdep_unregister_key() pair may be called after 
> debug_locks is turned off. Without that change, we are going to get the 
> warning in lockdep_unregister_key(). That is the motivation of your 
> original commit 8b39adbee805 ("locking/lockdep: Make 
> lockdep_unregister_key() honor 'debug_locks' again").

Ah, that's right. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
