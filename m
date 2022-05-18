Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400AC52C64C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiERWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiERWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:31:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EBF33E9D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gg20so3443618pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=thG3qSgnZW+qUMLaaxOPkQALuH6P7RbZ23MHltmMGlE=;
        b=AQkqPj3D0tdfs64sN8mLJd9diiGRGQDbqzoTBkPKxEszGHSW23pLd3DZLq1t7J1BaH
         N9Dc9tw3fZhqvdD7K5lreOPHKrd45AK941vaNu1U6kmB0u/LHeGMLIh4oh/lBCmsuM/R
         nT++BAX42jIVpVd2Cbc0IDNOSqTH4QxG9Nid9TMDGCoIPhTqZxONNkMk58Jq/wMtOPZn
         FR121zdv/+aGTq1DPhIOuVGzvj3hKtit/Buc/d9k5941ePSeMzytuGUKs98ffe6KJ8yI
         O4tYIxZQsAbIvPWbv/KXPvXLRccYsR4v+/q7YR/qrq7ooDJjsiO24fAzsrF642GuT1FQ
         Z4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=thG3qSgnZW+qUMLaaxOPkQALuH6P7RbZ23MHltmMGlE=;
        b=Ldjp6+IW+u/xP6wh7WLMroMiz+cqwZ0upCpTxjxOHPpbQPThodyJ6i0NyL4NB+Ahq8
         76nX9sneCQm1x29AXDF1mxlTQE1St5WtNn8joPgxhpIrU4uEkOqcQdPlY5dh3OBWYxjK
         15Q+LAU9Q0nEI2By6almZV34A3OfJpWlJllcByGnCBJn06QdrW5TwqV+8HXSS5Ivimvr
         h5v06V//nBzNKwrrs5LhZKgIAJvMA+PjMYg8y/cNR0OrI2oGNbb1Hjf8cITppb+YxCCY
         kLba1kvqZV6nbo72aj49mTVlxVlE5gDQ9chyd/1fuXgLMr9Xjy+x4HLxdWiBjwx/VP4A
         u/Tw==
X-Gm-Message-State: AOAM530pHndnZq1Row6C+BvKn/liAnbR7fmMCv1fXLPXsuTeBy20JcrQ
        xmrXeiSQ7vZ7qpcbVo80lahUyA==
X-Google-Smtp-Source: ABdhPJxkM5dIjxffREWV17PoskbyG+tIqaT0rCNzAEMnjsyNnVjB3wANcJQX1M94VA+U2oCPAiV1OQ==
X-Received: by 2002:a17:902:b684:b0:156:80b4:db03 with SMTP id c4-20020a170902b68400b0015680b4db03mr1626285pls.16.1652913115359;
        Wed, 18 May 2022 15:31:55 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h1-20020a62de01000000b005181409a78esm2397294pfg.110.2022.05.18.15.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:31:54 -0700 (PDT)
Message-ID: <de6b0f81-67e1-b167-a618-193c2303f149@kernel.dk>
Date:   Wed, 18 May 2022 16:31:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Marek Szyprowski <m.szyprowski@samsung.com>, bh1scw@gmail.com,
        tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220516173930.159535-1-bh1scw@gmail.com>
 <CGME20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46@eucas1p1.samsung.com>
 <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
 <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
In-Reply-To: <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 4:29 PM, Jens Axboe wrote:
> On 5/18/22 1:28 PM, Marek Szyprowski wrote:
>> On 16.05.2022 19:39, bh1scw@gmail.com wrote:
>>> From: Fanjun Kong <bh1scw@gmail.com>
>>>
>>> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
>>> Which can serve as RCU read-side critical region, so remove
>>> rcu_read_lock/unlock().
>>>
>>> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
>>
>> This patch landed in today's linux next-20220518 as commit 77c570a1ea85 
>> ("blk-cgroup: Remove unnecessary rcu_read_lock/unlock()").
>>
>> Unfortunately it triggers the following warning on ARM64 based Raspberry 
>> Pi 4B board:>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at block/blk-cgroup.c:301 blkg_create+0x398/0x4e0
> 
> Should this use rcu_read_lock_any_held() rather than
> rcu_read_lock_held()?

I think the better alternative is just to delete the WARN_ON(), we have
a:

lockdep_assert_held(&q->queue_lock);

right after it. Since the queue_lock is IRQ disabling, having two checks
serves no purpose. I'll kill the line.

-- 
Jens Axboe

