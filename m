Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC77F4AB81C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245507AbiBGJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiBGJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:43:24 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D0C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:43:22 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 67D714025B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644227001;
        bh=+L6E+uDCjSN479CYKJ9gYlHkAuXqDhEQEWmjUAJvDhE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EehYkJpXRPjeAfAUTRGoah5C5hB5d++bxbE1a40LKh8POiNt+tO5eh6ap0osKBRWg
         cKSIG/g2/cZXW6PCMMFChioiSThT0TPCHhL4B3wWp/jFig1blGEEY4yndBQo/4RzRY
         LtsK1DmqdVPELoHgeOXjB02l+sukNVpO61UeNI+QR2gxOo3I4fvolhp3KlDNRlcK3o
         o1MV/7QUYB6lqKwE4j9DyPHzCkPjZhxYheAc7+Xdqt4BC8meRNivB0tP5AA3tHQ/6l
         7ssxN5dStQ3s+twKlXN+z/z/fKDZoczA/nNYHZftSjJgvthsMyGrREqogB7SMhLP2G
         5U0R3UcJFZ4bQ==
Received: by mail-wm1-f72.google.com with SMTP id n3-20020a05600c294300b0037bc685b717so1326640wmd.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+L6E+uDCjSN479CYKJ9gYlHkAuXqDhEQEWmjUAJvDhE=;
        b=IfwnzFGCHoO2kL10xGb01PJ+k/tLBwxi1DeXcvWMiKv0VaC5eYJJDKwzhNbeWQayHj
         bcBS1jY+xQFW0XE5f0ah+KQ9PKcrJO2THGpktZjSCKAygDyYYwIS2W+Suzu9Zzs6HKMb
         hE3PuWzmidLkTSJcB0jVp4jXuIbVC2LRMExeTJfF4vm9FPlAc5bWnn4Th4eei890e5cm
         fJYljBlh6QwpaXlX+F3AIe+tmjb7lf/NXJzgRiWMugwsabV8Lowl9c/HT0F+zhfaBV8S
         Vkt8fQJQndq43+caXFsXjchwWJvZrOEdJgGLzgRWXKjSZDX4eULGJkV1zApqD/elozNx
         J4Rw==
X-Gm-Message-State: AOAM532K27LD0GtkZbuWwJxGq05lGQjRjZiN05ma0y5fT28mitIdXKg0
        L2UKZOK5kKhxqPbPv9mET9AqEFyfU/ifpuzCf7CBqmfZSwXVi3RzagbaJaHdylm1BFzguCkFVsQ
        xf6xq65DcvQMEMDkyxMn/0ah5bCNfVi2F17uGPMQwMw==
X-Received: by 2002:a05:600c:3516:: with SMTP id h22mr13431084wmq.143.1644227000969;
        Mon, 07 Feb 2022 01:43:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHF7dm2ZsoEJJ5VPAil3jjFNgC2lqhi4OrFY5B5qRigsPvDSfxiXW8PeX3gyanY9lg95hK0Q==
X-Received: by 2002:a05:600c:3516:: with SMTP id h22mr13431067wmq.143.1644227000728;
        Mon, 07 Feb 2022 01:43:20 -0800 (PST)
Received: from [192.168.0.86] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v5sm10694902wrx.114.2022.02.07.01.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 01:43:19 -0800 (PST)
Message-ID: <68d1f184-bfc5-9d78-8c68-0c793b35adf4@canonical.com>
Date:   Mon, 7 Feb 2022 10:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] mfd/power/regulators: dt-bindings: max14577:
 convert to dtschema
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <73bad620-97eb-a734-cbc8-6f001d04c18a@canonical.com>
 <YgDnlWKO6/BTxZh2@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgDnlWKO6/BTxZh2@google.com>
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

On 07/02/2022 10:34, Lee Jones wrote:
> On Sun, 06 Feb 2022, Krzysztof Kozlowski wrote:
> 
>> On 11/01/2022 18:43, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Changes since v1
>>> ================
>>> 1. MFD: Use absolute path to schemas
>>> 2. Regulator: mention all allowed properties,
>>>    additionalProperties=false, add min/max values for voltages and
>>>    current, don't use patternProperties when not needed.
>>>
>>> Dependencies
>>> ============
>>> 1. DTS patch 1/4: nothing depends on it, sending here so Rob's automatic
>>>    checker won't complain about DTS.
>>>    I will take it via Samsung SoC tree.
>>>
>>> 2. Final MFD patch (4/4) depends on regulator and power, so the last
>>>    patches (2+3+4) should go via same tree.
>>>
>> Dear Lee,
>>
>> This patchset was reviewed and there are no outstanding issues. Could
>> you pick up patches 2-4 (skipping DTS patch) via MFD tree?
> 
> Nothing from Mark?

No, nothing. There is no other simultaneous work on these files, so I
don't expect conflicts here. Important part is that I got review from Rob.

If lack of ack makes you hesitant, I can resend hoping it will help but
it is a bit of pain.

Best regards,
Krzysztof
