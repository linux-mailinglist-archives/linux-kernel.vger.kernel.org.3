Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0766E55AC30
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiFYTtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiFYTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 15:49:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB812D2A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 12:49:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c13so7763165eds.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=HA6yMKopT74zQaJjN9SZYwa0mNq4EMr02YrYzwvzxsM=;
        b=odF82Ov6/2ffkqCpBwU4vswyFYJuCV1DRSR82ZlEuBtS/ouJKvZ8K/a59J5jyhzw4A
         qJU/+H7XHjCgk+jEVVrFwvt7Epyvf0Orm3JNWJYMo1J0zLQ/6axyFUjLqu2aUi+cjQfG
         t9zZuthq+EeUI0sVpqwrlhxPj/QeYT/MRsQWj4Q1x1idaqN4AtmzhRM1ysPLw0uUfXsw
         Cr1+aUB/OXy54bJUiHP7vccztkf2ZT3CqzylN5U584Mc2dkScJjLTjnp2qB092Pdj5Sm
         rb+MQuVio/0qzwzjyft8XpFvWDtTpjCO+njwzuV3tVdwglHh9OxASXhLmFDwhwsyreVh
         QxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=HA6yMKopT74zQaJjN9SZYwa0mNq4EMr02YrYzwvzxsM=;
        b=Gy9JzL8bI6J99YRX1mbMiBQfCw4PudEPPHXHcAYgQIqTYcNoXnGdd5TU2iez1iDyEG
         o3CXIxp2zx6fX/BSFm3mZwZdoOMopvVBPjXGlceT2jbLmgbWJv34HMR3TH8a7MIQwkSK
         oHIKGKUgn3aQEYQX4ySOETrzuAPPyNSHSMuEe/2fYvF13ffTMvBPikAwMOJQ8wV6snJG
         mSLShQota/tRzF/5U6sERUSVsC2VyIZ66LeXvwgCHf0/Lr6Ym1rfMiVyee+Q9M87WFW/
         mh34oRisrQIajSf/E1OF18UGSSravPYROl+GXj3wpxjfrzdm7WSNvRW1DgUAp1lKG4SA
         skzw==
X-Gm-Message-State: AJIora+KD+CPQXUAlWk8LG2SDzcHL0gMmEEBYfrWOloSgIqTxIxxziWk
        2XHzi3yl1yMAZOTbTo/7LFlQuPhWouNeSg==
X-Google-Smtp-Source: AGRyM1s9XQKHvg1m+VzJMRiiDjGQ6PgKaGZRw/8e08B+jZj7zDsWlxP6vGY9sRSbO+O9QQVoGFnUXA==
X-Received: by 2002:a05:6402:2047:b0:435:67e0:44fe with SMTP id bc7-20020a056402204700b0043567e044femr6775259edb.360.1656186581159;
        Sat, 25 Jun 2022 12:49:41 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640204d200b00435a08a3557sm4610408edw.27.2022.06.25.12.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 12:49:40 -0700 (PDT)
Message-ID: <2d937f96-0a3e-9177-ea6f-6ebae113386b@linaro.org>
Date:   Sat, 25 Jun 2022 21:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Hangyu Hua <hbh25y@gmail.com>, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624024120.11576-1-hbh25y@gmail.com>
 <20220624173621.GC1736477@p14s>
 <47db0cd8-c940-6e74-f8dc-8e3931e13d80@linaro.org>
 <CANLsYkzT5ZROReZNQ_eYL-r49ijaZYZ5TzdMpqy1RK0_hvW3_Q@mail.gmail.com>
 <0bbee169-6fdc-b50e-87f7-1551dac821e2@linaro.org>
In-Reply-To: <0bbee169-6fdc-b50e-87f7-1551dac821e2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2022 21:40, Krzysztof Kozlowski wrote:
> On 24/06/2022 20:43, Mathieu Poirier wrote:
>> On Fri, 24 Jun 2022 at 11:45, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 24/06/2022 19:36, Mathieu Poirier wrote:
>>>> On Fri, Jun 24, 2022 at 10:41:20AM +0800, Hangyu Hua wrote:
>>>>> rpmsg_register_device_override need to call put_device to free vch when
>>>>> driver_set_override fails.
>>>>>
>>>>> Fix this by adding a put_device() to the error path.
>>>>>
>>>>> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
>>>>
>>>> This is funny... Neither Bjorn nor I have reviewed this patch...
>>>
>>> It was a fix for commit in Greg's tree and Greg's pick it up after a
>>> week or something. I am not sure if that's actually funny that Greg has
>>> to pick it up without review :(
>>>
>>
>> The patch was sent out on April 19th and committed 3 days later on
>> April 22nd.  Is 3 days the new patch review time standard?
> 
> Neither 19th, nor 22nd are correct. The patch which you set you never
> reviewed, so commit bb17d110cbf2 was sent on 29th of April:
> https://lore.kernel.org/all/20220429195946.1061725-1-krzysztof.kozlowski@linaro.org/
> 
> And committed on 6 of May, which gives some time for review. Where did
> you see the other dates?


Maybe you refer to much earlier commit, not mentioned here which was on
the list since February and committed indeed around April 22, so it gave
around 2 months of time for review. In the meantime the patch was
changing although since v6 (beginning of April [1]) it was almost
untouched, except one string change.

Therefore this original set, not one being mentioned here bb17d110cbf2,
was quite available. And you were Cc-ed since beginning - the version 2
this year (February, [2]). Two months is usually quite enough for
review, especially for not so big diff.

[1]
https://lore.kernel.org/all/20220403183758.192236-1-krzysztof.kozlowski@linaro.org/

[2]
https://lore.kernel.org/all/20220223191310.347669-1-krzysztof.kozlowski@canonical.com/


Best regards,
Krzysztof
