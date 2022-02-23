Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2D4C0D24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiBWHSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiBWHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:18:23 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D659A6C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:17:55 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D345407CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645600674;
        bh=pNhZLyO1aRbMKJR3E5jbPjYni0gu5zR1R9ulpGYQlfo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fNr9tmsd6x1Fy7uchtPcOhKjF86tBpqh4IBBaU29yuwEDzFMWm/peRpDiSVrNyD+M
         BVjrzHpEa7H9Nhk90z7y9Wbe1epZaLFvDDSuyRpBf8FnPwDjp0ep+wuouCsuxAX3Cv
         +JhBd0jHPzOpBX3Co2IW2l1i7ivj7MhbqauURjmIz7VXj0AvtN63Hkbp0cYbPM7CZn
         bQya5c6byiPPinHc/a9J5CPbcgphMrv5wwlyGId5B8O0lRaYQyso7BpwqGI2AHmxM+
         EfUXNpWq20HHL3vtSh4elW3kHxDYKCOngtTZ8dn1Ecpu4oq/CPkfFwoo33wD+6EuGA
         JUdTAL9kNGIHw==
Received: by mail-ed1-f69.google.com with SMTP id l3-20020a50cbc3000000b0041083c11173so13184250edi.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pNhZLyO1aRbMKJR3E5jbPjYni0gu5zR1R9ulpGYQlfo=;
        b=KXIl70GfT+/iun4rwN18O94e17rZjBfCTrugl8O4Wi43dfQgVj68SHF3BDdPh6ThX3
         hpvNfKhApBCE7sGb3eAN3gjNxDC7aENMr84c294xGfGil5sLq3Jpu8XDNB4Uh0Ca7vFa
         mqtfpFEjxQL+jz/FwUYd3MEWSIh25E4q0B5srW2/JYgKPOTzyuOug89r37Tibsq0dIcQ
         GJT7IRRFdIeIc7A+L5dqG7vphnUczO2fk2in2ZZ4Hj97wnL5ZhGSElbhp8j5F3A06MJC
         uPoLbDg6PJ30GCz0JeJvGduYw1gZamxIQuWUEvKUwqZpIiu3YyZ7S9hUfQqeT+AxL1x6
         WhTg==
X-Gm-Message-State: AOAM532gd24Y+M8GTtyOeJGBJU6eYt86xeLy26Ijl/XLHxnuB7IEMDS9
        cbrvoF77r6i9dQQCAZKc8cf1cmaRAeQnpMGqj/UASMBAjcMnZJwwUHPxP+89dWU1ILy4pgknTFa
        vTGDyhAIigF5iOAAEc0rzS+VZ8ujrcthhJ2hCB+yfTA==
X-Received: by 2002:a17:906:960c:b0:6ce:f326:f0d with SMTP id s12-20020a170906960c00b006cef3260f0dmr22364014ejx.154.1645600674002;
        Tue, 22 Feb 2022 23:17:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytxCMf3oX2iILnCYpZtMcrjt7Xa73med3vZDJvwLgW7YJjJ3i4vJy9tPCBBDUlxazJyY8A0w==
X-Received: by 2002:a17:906:960c:b0:6ce:f326:f0d with SMTP id s12-20020a170906960c00b006cef3260f0dmr22364002ejx.154.1645600673832;
        Tue, 22 Feb 2022 23:17:53 -0800 (PST)
Received: from [192.168.0.124] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm7021079ejl.67.2022.02.22.23.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:17:52 -0800 (PST)
Message-ID: <13af6f53-2a8c-c8d5-f061-baf59b511e58@canonical.com>
Date:   Wed, 23 Feb 2022 08:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: memory: lpddr2: Adjust revision ID
 property to match lpddr3
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220219012457.2889385-1-jwerner@chromium.org>
 <9d33314e-97da-dc47-8361-2e45b75fa566@canonical.com>
 <CAODwPW_JbcppFGKvrooxf25dLJuvf5iWoWim1xSXZ2wqgL1k0A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAODwPW_JbcppFGKvrooxf25dLJuvf5iWoWim1xSXZ2wqgL1k0A@mail.gmail.com>
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

On 23/02/2022 03:44, Julius Werner wrote:
>>> +  revision-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    minItems: 2
>>> +    maxItems: 2
>>
>> You need maximum value under items.  See:
>> Documentation/devicetree/bindings/arm/l2c2x0.yaml
> 
> Sorry, can you clarify how this is supposed to be? Do you want
> 
>  revision-id:
>    minItems: 2
>    maxItems: 2
>    items:
>      minItems: 2
>      maxItems: 2
> 
> or just
> 
>  revision-id:
>    items:
>      minItems: 2
>      maxItems: 2
> 
> I see examples of both in the file you linked (and also examples of
> what my original patch did).

There is no example of the first case in linked file. I am not sure if
it is correct even... I did not ask about maximum number of items, but
"maximum value", so like this:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/arm/l2c2x0.yaml#L73

> Is there any authoritative documentation
> somewhere I can read that specifies which of those is correct? (I
> tried looking at
> https://json-schema.org/understanding-json-schema/reference/array.html#length
> but I'm not sure if that's relevant here.)

example-schema.yaml is the best, but it might not cover that part. We
need more docs, I know...


> For updating existing DTSes, do you want that in the same patch or a
> separate patch in a series?

Separate patch in this series, please.


Best regards,
Krzysztof
