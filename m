Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05855AC2E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiFYTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiFYTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 15:40:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405771409B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 12:40:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so11112723ejj.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TNVYDe807rXFprGHCwJ69e6uyKbChN+0aVPm+tJ314w=;
        b=vk2/0sZaYEt9w8JdOsnMSV+I1T72oHCtLW+bQC0gx7suA1ceOea6oGvWMuTopIfkSu
         QW1q3xmFg6IO8Mi796I/KNLPcVo49S13DfInvzO/C6KN89j8buQoz+uAGHa5V7M/8Ok+
         mWD4ITTDJ4Sjrwbnjz8xHGe+Ih4d2zgosVaGqQJieAlToUp2TcuMFNuS1RvjcI8ghDzT
         DcVuHI9AEdpAXO8yI+j5/dzFXQn7Z/2FZnYvk+Kt4yf8mjttMJ3F6XItc9XjPlYSlCsa
         HYk/IocvN9RNzPnTd/0x13/ktJep1vwaHBfhtrpo3/jflX5LaVN0bXPtJ0vnjk9EqopZ
         ZkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TNVYDe807rXFprGHCwJ69e6uyKbChN+0aVPm+tJ314w=;
        b=sA5DeXGakTlSFqRDKOCeglwuwwGcv6r5oDqE42nG48wOXhVeCOpvLlLJftFATv+mBf
         Fwhk0WEqo/YXVcOcyBmUIWbAaXQ5pTym7zlCEJUE5CkK8nQsrQu+YMR81U7pabZkwL7e
         P5HxOr7ChjXMbPkdBimM8d3LQE2faeAYW+g+N0fnnbbNze9lI/dgUs6w6l/x8DH2DN0j
         JYpbrVGA5sPj5ezyQSueOgQDtqHg9Zdcg58RG4c1X5vBcI99xKSCCY8C60GPQ3K+BkZP
         ifXF+xkrh3eg9k1XNdGa35eO/C3DArm1wjaFCWJ+L5Wa35xNmNETcaBnBnuhuc3A5JWf
         5l7A==
X-Gm-Message-State: AJIora9t6tu5gK3/9k5QCeBCh90aCDvYq69Nj1r9ynsHYusvyLVfGcVo
        BndoDjnPUt9nQDZvKdPGlO/O6w==
X-Google-Smtp-Source: AGRyM1sbZ2BV6SDBpUkPaVel+EYBY+2WmOxAHnwUX9FzQhDZeKLC9SgSrmpkdCJb4Rq8HTj29D4iag==
X-Received: by 2002:a17:907:9488:b0:722:e5c8:c647 with SMTP id dm8-20020a170907948800b00722e5c8c647mr5127672ejc.291.1656186037632;
        Sat, 25 Jun 2022 12:40:37 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm4584343edb.29.2022.06.25.12.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 12:40:37 -0700 (PDT)
Message-ID: <0bbee169-6fdc-b50e-87f7-1551dac821e2@linaro.org>
Date:   Sat, 25 Jun 2022 21:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Hangyu Hua <hbh25y@gmail.com>, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624024120.11576-1-hbh25y@gmail.com>
 <20220624173621.GC1736477@p14s>
 <47db0cd8-c940-6e74-f8dc-8e3931e13d80@linaro.org>
 <CANLsYkzT5ZROReZNQ_eYL-r49ijaZYZ5TzdMpqy1RK0_hvW3_Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANLsYkzT5ZROReZNQ_eYL-r49ijaZYZ5TzdMpqy1RK0_hvW3_Q@mail.gmail.com>
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

On 24/06/2022 20:43, Mathieu Poirier wrote:
> On Fri, 24 Jun 2022 at 11:45, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/06/2022 19:36, Mathieu Poirier wrote:
>>> On Fri, Jun 24, 2022 at 10:41:20AM +0800, Hangyu Hua wrote:
>>>> rpmsg_register_device_override need to call put_device to free vch when
>>>> driver_set_override fails.
>>>>
>>>> Fix this by adding a put_device() to the error path.
>>>>
>>>> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
>>>
>>> This is funny... Neither Bjorn nor I have reviewed this patch...
>>
>> It was a fix for commit in Greg's tree and Greg's pick it up after a
>> week or something. I am not sure if that's actually funny that Greg has
>> to pick it up without review :(
>>
> 
> The patch was sent out on April 19th and committed 3 days later on
> April 22nd.  Is 3 days the new patch review time standard?

Neither 19th, nor 22nd are correct. The patch which you set you never
reviewed, so commit bb17d110cbf2 was sent on 29th of April:
https://lore.kernel.org/all/20220429195946.1061725-1-krzysztof.kozlowski@linaro.org/

And committed on 6 of May, which gives some time for review. Where did
you see the other dates?


Best regards,
Krzysztof
