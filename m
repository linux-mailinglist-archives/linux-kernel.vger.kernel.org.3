Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D64F95D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiDHMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiDHMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:34:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED9FFFA9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:32:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r3so343821edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=k7TsspIZEQrKfrjQp/PsXSdv2fK0xhZqE0qfyZ1vZ1o=;
        b=cA+TOrmettMYXWjrYcnbtKZSir/JysRf50k7uqD/8l34NpO3JbGwtFXkSmPl3yVMLl
         ZRU6IaWLzuX7nQjZ4up+obPW5EGoddG54YpIK3mIw9Ih4/GiDaHg242YwbQIoy2aU6pG
         dD9cK3Qe5qOp0SYhxAQ2MvEUaujlm9K2GWPMS9bihYr1RedzTLbRsjrjZO1pK0uKMewV
         4Zywb9Ex7gpUfwwqoLGoJA7MyKTjGBTeFWPJl0mUuVVl0mw/UvZBbWLQ+tJVFkynymSx
         RnhmKkbeEHEGYjBY4XyV3s4DRoSyfoVZJRmpqk2iuGxjSh6FsiCdLvYitOBW65MnXwFh
         8ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k7TsspIZEQrKfrjQp/PsXSdv2fK0xhZqE0qfyZ1vZ1o=;
        b=H0BjrXU9Jzk6V9hlpc/zylm/BELvEc9WPtRmnnwLuHFxKfrApNyD+EF6aG8YkAJl+L
         dxI2KolBvwvF8hLxWGq5R1HrPhX3a0jyGJJ3DuiTYmPbzASLJUD8weUFzJSdB2V74GZc
         gs4BcVclgcv7BKWSElRACfS08/ILyCGn9S0ZN5a8LheUho4U13+HBNbvN0KIzY5LWssO
         3DB0Zoaox5WUriUXXAKKWh0UU3pD8GEOWnBSCoj+UHttgXdzVFATYXI/zkToZDEic4FE
         GfnjANTit+IQ9XOyT0x0AI1rIeyanWaP7RNexvs5XukLvGFR1rpJk3wZK2piHVT9yakg
         ozGA==
X-Gm-Message-State: AOAM532LVcTaVXWvEOJ2qSG6V3IEftA4cvi5DCvamcGqPq9iL5FoV3BK
        V0hmM8ViDWgMdXRaGl+Mg4jxFA==
X-Google-Smtp-Source: ABdhPJwiFak3etcetlhA6GgJU4bpRv7f/dGZM4e8WQjkOh2bQqKR3k6v8cJK9q0/ARV3sgpJpjVpmQ==
X-Received: by 2002:a05:6402:350d:b0:419:5099:1f10 with SMTP id b13-20020a056402350d00b0041950991f10mr19311410edd.144.1649421122660;
        Fri, 08 Apr 2022 05:32:02 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s11-20020a1709066c8b00b006e7ca6f0401sm6182318ejr.136.2022.04.08.05.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 05:32:02 -0700 (PDT)
Message-ID: <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
Date:   Fri, 8 Apr 2022 14:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 14:14, John Garry wrote:
> On 08/04/2022 11:30, Krzysztof Kozlowski wrote:
>> Several pointers to 'struct scsi_host_template' do not modify it, so
>> made them const for safety.
>>
> 
> Is this standard practice? What is so special here?

This is standard practice and there is nothing special here. Pointers to
const are preferred because:
1. They add safety if data is actually const. This is not yet the case,
but scsi_host_template allocation could be made const with some effort.
2. The more const variables, the easier function contents and its impact
is to understand. This is actually the biggest benefit when dealing with
code touching different structures.

In general, constifying is a common practice everywhere in the kernel.

Best regards,
Krzysztof
