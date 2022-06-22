Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3242155491C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357378AbiFVJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357317AbiFVJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:09:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA63983D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:08:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q9so22425941wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NZhUuJGfgOozPnZGU93PZgJO6/mLJiT5zeDUxp3YbvQ=;
        b=hVNChtAprKkGvLioCj8w2K4rrIzc8plb/cXzg3HiU4M4Pp+9k8GOJ+DwJdeD4/fnyK
         oAVH2KfyaBxdluJA/CjS0jNcKumj7b4gT+Kkd8QmOOarDyKbfCEQ8dD/4lzV/EFPno9f
         4KZw3kXfkSMjJq2eYlS0brgXRSqolRr1KiJnhYPwSjzmcnmMVnem19zLxP1NkBwW1v8g
         EY2Mickk2pIaKiHiUwuw8KgdIJxFjYPAG5nqMHu/X2E5RamCYRUrfqQdpnxtxMgR8A/4
         PNGsFJIQ6SMZVA7c19zJcxJR9oVv863xTybkc1zJY4ZU10z+wfQtFpLGJda4aOtvMLet
         DhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NZhUuJGfgOozPnZGU93PZgJO6/mLJiT5zeDUxp3YbvQ=;
        b=V8Ko2QLJJ0zVCWnu1UiKnuZSUu5JpZQzshf0ropXYZHkymOmxRDl0z9z1s6BKNoTv0
         DeuPxhBxDIDmVcd1Cl/7t9UcFQEpxSHVNOzX/AGnWiObx5wX0zqMi1DiWTq/xBFViudP
         eZI1Jb3fCJi6HpJLAZhQUW1Hf3cfEwTESUTzRlQdT52nEbe9UufdHbT4nEJ09D7s/12J
         53whiy0nlvr9k1dk931f+Aq1NxA89vdRYTVvIC/I9PMdhLlbhzxu4pEjY02tUstXsSHh
         8CD1GMPv/+Brrkkxh1wmaw81DcmSZrcTwOp50MrRzn9+26HfYqwKpfRIMNelEt45Dwwc
         dvwg==
X-Gm-Message-State: AJIora+IVD2juY1JQPJhMIDb7E7ivqkMRNsEWEqURnGQQt9+K5g6vs2+
        ZNmKUX6CLQuC60/0UmBApSLMtQ==
X-Google-Smtp-Source: AGRyM1sKjhMzR7hFPe1U7uPerH6AbKiQX8u0eGrnjQE3q/bvz2tlyAlLKDl7OLUWfTfNSvDCu+0U8w==
X-Received: by 2002:adf:f84a:0:b0:21b:88b8:183 with SMTP id d10-20020adff84a000000b0021b88b80183mr2258573wrq.265.1655888914476;
        Wed, 22 Jun 2022 02:08:34 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l12-20020a056000022c00b0021a3daef45esm19762733wrz.63.2022.06.22.02.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:08:33 -0700 (PDT)
Message-ID: <b3a0b35e-33fc-f7f3-a111-1a88498b4019@linaro.org>
Date:   Wed, 22 Jun 2022 11:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] memory/tegra: Add missing of_node_get() in
 tegra_emc_find_node_by_ram_code
Content-Language: en-US
To:     Liang He <windhl@126.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20220622042824.4094625-1-windhl@126.com>
 <2f3e843e-b72b-ee71-7465-b2b6c8d51b0d@linaro.org>
 <11875304.61a4.1818a9a66bb.Coremail.windhl@126.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <11875304.61a4.1818a9a66bb.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 10:49, Liang He wrote:
> 
> 
> At 2022-06-22 16:41:28, "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org> wrote:
>> On 22/06/2022 06:28, Liang He wrote:
>>> of_find_node_by_name() will decrease the refcount of its first arg and
>>> we need to add a of_node_put() to keep refcount balance.
>>>
>>> Besides, during the 'for' loop execution, the refcount of 'np' will be
>>> automatically increased and decreased. There is no need to call
>>> of_node_put() again.
>>>
>>> Signed-off-by: Liang He <windhl@126.com>
>>> ---
>>>  drivers/memory/tegra/tegra20-emc.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>
>> The patch was not even compiled... I consider it harmful approach. NAK.
>> See: https://lwn.net/Articles/854645/
>>
>> Best regards,
>> Krzysztof
> 
> Sorry, Krzysztof.
> 
> As the patch is so simple two lines , I thought I can handle it without compiling it.
> 
> Thanks very much for your notice about the article and I hope I have not done anyother harmful things.
> 
> And I will take care of my patch code in future no matter how simple it is.


Never send patches which were not built. It seems you didn't build them
in the past either, even though setting up cross compile is trivial (few
commands). QEMU is also an easy option.

Even though your contribution might be valuable, lack of building is a
sign for me that approach is not serious, so I am not going to take
risky code.

Best regards,
Krzysztof
