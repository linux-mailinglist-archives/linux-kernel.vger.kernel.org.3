Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6157568E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiGNUrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiGNUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:47:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634D6D54C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:47:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h145so2415138iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5yRvOTGRnegCHVbLMlYfoPtqBZjcDcdjxcIFgXJXUCY=;
        b=iJPwVMEVmlDdOGjIdwfPb3QcpmckWwU5zfZ+LxI/bNEFOG6/9CW3Jx6lK9kNMJWD7G
         80Lmohh26UHNK9omBR0hZuW0wp5QNpk5BqZio+4xjDDfneepPC5T2xVYg8jg5Cy5sPC6
         +rtTRlBCuYe/Bvx0Ff2Im9iXajwrm2vS9vkhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yRvOTGRnegCHVbLMlYfoPtqBZjcDcdjxcIFgXJXUCY=;
        b=s0WFH7U4gJcdrNx/jSKsF7dCpaLSmBvmBmxoaRZtxXRQHCJCswpymEtqofkr0ItqsN
         2KwH0PUQs/RzLWkBUmcxAeGV7uJY2ib2fq1fgAQhG2bkI8TpnPjjrinmjNc/uT7C4WPT
         zLLWBBuHYe9XvLPaQbag4EuCRZTqqz6xex5w0f/V7nE/rMqYP9Ep/Z/a0aiEdDsoqJk1
         Ma5yqfSlf9RMEwCm/0k74BCwb0fuNB4HBhvDXW4IDSRDgr0uF4tAL/ZzG2/KzY+d0rnv
         /FClqD/5BUmUBA/52ne3pSRQ4JDUzxWJ/5y4WOc9Z7zLZHXkWNkK3GyeWXvc4atIbAKj
         pvYg==
X-Gm-Message-State: AJIora8VRtPPutPg0inCQaABGetUl8ud9l5rkenVVXX2it4zm/TmxQFw
        Ff/KaTbFJq1clj7eGeRAerzJbA==
X-Google-Smtp-Source: AGRyM1vjWGII0bZhPhJVaJRGo6OHgsPZnk4TMLd+wqVlwkc8jmrMUpSfm+11hdWAmeCQuRJvu1qklw==
X-Received: by 2002:a05:6638:164b:b0:33c:9b6f:457d with SMTP id a11-20020a056638164b00b0033c9b6f457dmr5928163jat.224.1657831639911;
        Thu, 14 Jul 2022 13:47:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e10-20020a921e0a000000b002d79f619517sm972694ile.26.2022.07.14.13.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:47:19 -0700 (PDT)
Subject: Re: [PATCH 0/9] selftests: timers: fixes and improvements
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        John Stultz <jstultz@google.com>,
        linux-renesas-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
 <CANDhNCp3KhGjXSrS4xmqrdPJfxStZOOn+FQxJEEoiXZ39CxDpg@mail.gmail.com>
 <dbe428f6-37fd-cba7-2947-e042585d3a42@linuxfoundation.org>
 <YtBj5NPGi5MUKuvP@shikoro>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <01cd5e24-7732-3a67-8171-3c99b620d617@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 14:47:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YtBj5NPGi5MUKuvP@shikoro>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 12:43 PM, Wolfram Sang wrote:
> 
>> Wolfram, are you going to send v2 to address John's comment on
>> 8/9?
> 
> Yes, will do!
> 

All patches now applied to linux-kselftest next for 5.20-rc1

Picked up v1 1-7 and 9 and v2 8

thanks,
-- Shuah
