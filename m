Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688704B6464
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiBOHb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:31:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiBOHb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:31:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190E710F99B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:31:17 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD2DE40333
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644910275;
        bh=5KIzTmaU7Td0HdHjYzNLRhA3qi5eAUjP5mwcTbkjBL4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jkBPjI+/Wuf64H/qB4m0l7CcahMlqoIsLaLbSQZrFbQp7jFwIliEDy/l2OPEgogX3
         y9EdD//vNQeUr0blgLzxirk8JVHaH/JChPlSa1NhbFauVjpBBS5WD0Wgccu2ECZXus
         AGjrmTKFisxUIAC3fbTt3zDPTHj/O+i9A8H+fW8nNtfoOgHOhpI4URuio4IZWfKinp
         QHCWOzdmUDu7PQRS9oyyx/aFF/+c7LY5184qqIEygTwilI9efz/1RXkSRC3j871Lgn
         /IOd4gRky8buUeb722Jv3Dm9FuOZp7wJEc9YInQuFHTllFFTeY2GYlK3bM5OJUtMid
         UMgGkuUh2PI2Q==
Received: by mail-ed1-f71.google.com with SMTP id w3-20020a50c443000000b0040696821132so11789846edf.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5KIzTmaU7Td0HdHjYzNLRhA3qi5eAUjP5mwcTbkjBL4=;
        b=45aQ5ygTRFvA0awFayx//Q3oFfkbDWClCBK88xzhZft9SbijjXqpdYLbQuQ2yDPRH5
         bY1RNs23h5lBvOLALe+Vckx2fdFsIcpLKC/avUSlVE52n/KEDqM0KAhvGqoiScSnpFUe
         AwU97E+Q+umRKhbZRdGJDIzvR3a3/ZX+CZDadyOKYu0o7r5MyaEmpZaFN0tBWIdaCXKI
         KhRxa8vsZsCQ2oppwqz/DICW+/OaxNu0DmVzYaot7EPMDxIY9ul5emeryRl62YbFmF9U
         xZZOY4JzcK5Pj180TCXRGhn7tLjro1+VseNutNlDWbwf0JX6Tb1SStYcrCVFiIKHQn7C
         GN1g==
X-Gm-Message-State: AOAM531zyJQzbk4rAJfAhv95871bqjzX3GhSBcv73H0r94xS/wL3RcXR
        GHCyGrOCdC9iRPfhzljkPnBfNTY3DMKBsEmJcyeTkzf1bCGoTbefJwvuO5UU/E3bxI4d+B8dIT8
        YL5GHRYWi5h3TkZu5gSAcMxw7GfsZLFvqU2MisACq8w==
X-Received: by 2002:a05:6402:5156:: with SMTP id n22mr2554584edd.261.1644910275307;
        Mon, 14 Feb 2022 23:31:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKEdMrtFtr9+fyCK4bQAUhQJXP3ooGayJ+Qk+5aqufpIctM2yIOqsBaMB7ldhmHuU7FiXKuQ==
X-Received: by 2002:a05:6402:5156:: with SMTP id n22mr2554575edd.261.1644910275144;
        Mon, 14 Feb 2022 23:31:15 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h26sm570843eje.146.2022.02.14.23.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 23:31:14 -0800 (PST)
Message-ID: <bfa33105-88fc-5e51-8bec-594e89ce6acf@canonical.com>
Date:   Tue, 15 Feb 2022 08:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/3] regulator/mfd: dt-bindings: maxim,max77802:
 convert to dtschema
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <f0a9e656-cf18-f212-b701-a1c9d10c4a59@canonical.com>
 <YgDoG8Xlhq5L3Bii@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgDoG8Xlhq5L3Bii@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 10:36, Lee Jones wrote:
> On Sun, 06 Feb 2022, Krzysztof Kozlowski wrote:
> 
>> On 11/01/2022 18:54, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Changes since v1
>>> ================
>>> 1. MFD: Use absolute path to schemas.
>>> 2. Regulator: skip properties.
>>>
>>> Dependencies
>>> ============
>>> 1. DTS patch: nothing depends on it, sending here so Rob's automatic
>>>    checker won't complain about DTS.
>>>    I will take it via Samsung SoC tree.
>>>
>>> 2. Final MFD patch depends on regulator, so the two last patches could
>>>    go via Rob's, Mark's or Lee's trees.
>>>
>>
>> Dear Lee,
>>
>> This patchset was reviewed and there are no outstanding issues. Could
>> you pick up entire set via MFD tree?
> 
> Nothing from LED or Regulator?
> 

I will send a v3 of this with all acks and a minor change.

Best regards,
Krzysztof
