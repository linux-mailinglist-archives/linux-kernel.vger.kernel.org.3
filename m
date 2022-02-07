Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8227F4AB812
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbiBGJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbiBGJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:47:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B33AC043187
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:47:03 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3081C3F328
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644227222;
        bh=RpKisFMVOYgXhr4OBFF0I13PIr7NXdi+wKM2xMCNQ4M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Gn7MshsG9J1Ke5+3eCcwYpe5i0jScbu/mOcDCL99CFtmDJW5F7VjB3Z4OhybMxt55
         LBbvP3QIlqGYuHolUrorzj+1xQHrIfG9A+cV82DAnW5YresuS9FOPa17xEHNfpxyAi
         Yqw+Ac2081joSDl9Gdx9ktZDmLibh6CPYFnzxBLLK6AoRp/sqQi6H30k6HjJ/P2mGg
         hp1gjJoV+O6Xxdvb5K8pe5Z9O8gK6gURhmTYNqiDECPhCwONKzELK2SuKRiZBWgTqE
         Bxax7DtsvHf4Tk5QsYO+ZtRlFEpfhOf0/XzVizRFaPWNg1GGC6y4g3Ihbl9Gi6vH5P
         Qo+npaKNuKHXA==
Received: by mail-ed1-f69.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so2339508edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RpKisFMVOYgXhr4OBFF0I13PIr7NXdi+wKM2xMCNQ4M=;
        b=MEkmzMBBKMTTiWg5unpPg+9SIM5e3od0xVJWoiCiP9W0B8KIp5CUCjhHmnvnVZn/OC
         aEsUr2YMlFNzXcb/1aYBUDt5LxmI1WxIbzBoYJ1BPe1GK0H3eWVtvi9ctkqMcNJc6Ln+
         2AnJ4MfxeM3gBG4LwMtHNoxDuGDi0zj76X9JCVjHne12oYXOwgqn7A37mTvUkvr20r1R
         CO2qT7LYRx7MZkWufavjjSyncSdgL4wr9HTdmNjrGAx2Jq+OobEfixWFJ6OWu+mHQ1qM
         XMko5TVvxOdQJrz49GY9UuDH8US46Ebd7eWkfZ6ch9qqN/55UbFdjbx/+nkKdloSA/Zt
         iWmw==
X-Gm-Message-State: AOAM531DEL5NDH8XDSGUy72GrjIQWvAj9M/ZHr7hMSrbXekk5wxKQePK
        G7CTs+/sh2tNlSL3YmNYwabY+S9GLX31zwBrJAK9oAZ6d5Wmlm0l8r+OjrO1QwS+EF8+9EcKmbv
        aF2DDGXYcrw0DUm5zVAUwdMQ4K1TXm7RjTXM8RZuC5Q==
X-Received: by 2002:a17:907:3da1:: with SMTP id he33mr9059614ejc.603.1644227221796;
        Mon, 07 Feb 2022 01:47:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1BoRtqvleLXKJ94x9jr4A9T/K/xfXE9FqqRN0ilJdw6S1IME3NnflwItPXK1N2kfs64wGqQ==
X-Received: by 2002:a17:907:3da1:: with SMTP id he33mr9059600ejc.603.1644227221642;
        Mon, 07 Feb 2022 01:47:01 -0800 (PST)
Received: from [192.168.0.86] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o3sm108814edt.67.2022.02.07.01.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 01:47:01 -0800 (PST)
Message-ID: <88fcdbe6-5fef-d9cc-a645-69e35230cdeb@canonical.com>
Date:   Mon, 7 Feb 2022 10:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/5] mfd/extcon/regulators: max77843: add
 dtschema/bindings
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <1bebedb9-644f-783d-492c-84a5de91720d@canonical.com>
 <YgDnUNCNCO+JLyHU@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgDnUNCNCO+JLyHU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 10:33, Lee Jones wrote:
> On Sun, 06 Feb 2022, Krzysztof Kozlowski wrote:
> 
>> On 11/01/2022 18:48, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> The max77843 shares some parts with max77693 but it lacked bindings.  All
>>> its compatibles were undocumented.  Add basic bindings for max77843,
>>> matching existing devicetree.  These are not complete bindings, but
>>> rather reverse-engineered to match current state.
>>>
>>> I do not have access to device with MAX77843, so if anyone else
>>> volunteers to be the bindings maintainer, please join.
>>>
>>> Changes since v1
>>> ================
>>> 1. MFD: Use absolute path to schemas.
>>> 2. Regulator: mention all allowed properties,
>>>    additionalProperties=false, add min/max values for voltages and
>>>    current, don't use patternProperties when not needed.
>>> 3. extcon: Use absolute path to schemas.
>>>
>>> Dependencies
>>> ============
>>> 1. Patch 1/5 (dts): nothing depends on it, sending here so Rob's automatic
>>>    checker won't complain about DTS.
>>>    I will take it via Samsung SoC tree.
>>>
>>> 2. The patch 4/5 (mfd bindings) depends on regulator and extcon, so they
>>>    should come together (2+3+4+5).
>>>
>> Dear Lee,
>>
>> This patchset was reviewed and there are no outstanding issues. Could
>> you pick up patches 2-5 (skipping DTS patch) via MFD tree?
> 
> Are the subsystem maintainers not going to review/ack?
> 

Would be nice to have them, but maybe since these are dt-bindings maybe
they were skipped? Or maybe it was the end-of-year holidays?

I can resend hoping it will trigger more acks. Do you wish me to resend?

Best regards,
Krzysztof
