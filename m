Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64834D9A48
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbiCOLXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiCOLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:23:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418734F9D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:22:28 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 264513F32D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647343345;
        bh=ZR87jLnsJuZ+lD47i7OuEBcvzhkBsEEC6j8sgB7HSzg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vyFG8r8bKXhyTi4CSQkOZxwyAgZFXCMJniShTO7bXloX5Sawv0htA40sXUaEZmMWh
         Jq8+4H0AzMpQZ7rOTM60VVPmDyye2AJ1yHPLLRKN9zsXQ1za3uN9XAIHlfesPpvPCt
         sR7tz5mTIm9/zUAjcrr0Gry8X/qxGN9ov79WD+wFOn3MXEXfjdZfBcXoylu2R6xliK
         uCk3PouFd4ouU3qD2jx3OmxOy0o+/Au4GDTg8uP0vhMZPMwLLgswKlbcRrggcDrSMz
         x4nJPT/C4BfH0pUOKqUX6++pkZwDWW9T5BtsMFtOAqT8lK7xBTLC2PHM/3u7ZyGpjE
         ii7c2ObQ0Tu1w==
Received: by mail-ej1-f70.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso9407872eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZR87jLnsJuZ+lD47i7OuEBcvzhkBsEEC6j8sgB7HSzg=;
        b=0MbplRgWOfjkyK1aETrQ2qZPkDha/Aieg3sXC+IMHDpUBbKsSpS7/1HBlF3nqJLJzz
         /gXCDrmy/uTufmwxJW9v/Q4OO7lPNmGAivw6np2FMH6Zl6+UsL4j6yy+JOkqvSE+39B5
         LzmnLiDClHI6PEHhjRzdNUQkOlm1onnrqZL9PJ1dQeQGW0s/jCrwdOO1hrIKX52xvxpN
         AHbiwk8FrHBjzoj5EOdhfS35cvy1iN2yy7/G66MNCw+xkHEYcnCIjpMbq3NGB+MuzIcq
         svsNXyPUzlDvrYNaHqim1pSmWqSoPIsSMJgwbeT1a9OAgdZvzoM+UNRNxYfeEFMad/+b
         rRsw==
X-Gm-Message-State: AOAM530COU1ee251G8SXePhFfb6pUoCZwvxGLi4IrMcaB/dfHtIktj/J
        KzZZa5qZZV1maaEaMiWgdIRmHXydAlf7sqhdwFqmDhU7c2Kxn6iXMO3ANtrTQuusrQiUPC8y1Kq
        bQXAHaWy0oBt8VysEw3u/TkFVwkirqanXJmepWq60PQ==
X-Received: by 2002:a17:906:9744:b0:6da:9e49:9fe3 with SMTP id o4-20020a170906974400b006da9e499fe3mr22399704ejy.319.1647343343944;
        Tue, 15 Mar 2022 04:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzDZjHpdMR3cdBSG8G8uQTY/SmwDksF/9hmIfn6WR742IkO9/4UxxVXNjzlphPFbHnqaOe1g==
X-Received: by 2002:a17:906:9744:b0:6da:9e49:9fe3 with SMTP id o4-20020a170906974400b006da9e499fe3mr22399691ejy.319.1647343343761;
        Tue, 15 Mar 2022 04:22:23 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id me17-20020a170906aed100b006db0dcf6746sm7942896ejb.216.2022.03.15.04.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 04:22:23 -0700 (PDT)
Message-ID: <9ec3c26a-3b85-4bea-5a5b-de9ac570cfca@canonical.com>
Date:   Tue, 15 Mar 2022 12:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
References: <20220314232214.4183078-1-swboyd@chromium.org>
 <20220314232214.4183078-2-swboyd@chromium.org>
 <e7f9466e-03c9-7754-0dc6-a04823d1047a@canonical.com>
 <YjB0JOKysPpg2KGF@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YjB0JOKysPpg2KGF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 12:10, Lee Jones wrote:
> On Tue, 15 Mar 2022, Krzysztof Kozlowski wrote:
> 
>> On 15/03/2022 00:22, Stephen Boyd wrote:
>>> Add a binding to describe the fingerprint processor found on Chromeboks
>>> with a fingerprint sensor.
>>>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: <devicetree@vger.kernel.org>
>>> Cc: Guenter Roeck <groeck@chromium.org>
>>> Cc: Douglas Anderson <dianders@chromium.org>
>>> Cc: Craig Hesling <hesling@chromium.org>
>>> Cc: Tom Hughes <tomhughes@chromium.org>
>>> Cc: Alexandru M Stan <amstan@chromium.org>
>>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>> ---
>>>  .../bindings/mfd/google,cros-ec-fp.yaml       | 89 +++++++++++++++++++
>>>  1 file changed, 89 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
>>> new file mode 100644
>>> index 000000000000..05d2b2b9b713
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
>>> @@ -0,0 +1,89 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/google,cros-ec-fp.yaml#
>>
>> Why is this in the MFD directory? Is it really a Multi Function Device?
>> Description is rather opposite. You also did not CC MFD maintainer.
> 
> A lot of the ChromeOS Embedded Controller support used to be located
> in MFD.  There are still remnants, but most was moved to
> drivers/platform IIRC.
> 
> Please see: drivers/mfd/cros_ec_dev.c

Yes, I know, that part is a MFD. But why the fingerprint controller part
is MFD? To me it is closer to input device.

Best regards,
Krzysztof
