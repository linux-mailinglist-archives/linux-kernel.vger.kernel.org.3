Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582A74D0691
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiCGSbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiCGSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:31:49 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059073DDD0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:30:55 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0CA713F5FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646677852;
        bh=7XKTjYGWAy5ocS9c+MyCrdo52ak0FW1Oc/1++V3LAOg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Ac7JRjYuMsI5dSAEOzsL9ORH69M9y/qDxss4vk7FXkHPzpXiHC3SI56t0QebdnEDQ
         N/WZddoMgG6jAks6KBTzwCZIP15fX6hw59ePNlJ2+pBAnGsrSBp9AfUnegRxVAzhXR
         /QK4i7mvnPN3MHVe7N2LSUv10WZ+BsGAW17U1LknTD9ZgGBXilv0SGQUjOEHsoUXJ+
         pKITXpzFS7JAcz3BzaFWreoM71f+Crm1WzYxQrSm2hqTql1ZYsXv6BnI2JeYEn+wb0
         gJpIbXT/ZxCKOBS3Lz5yy0PG15KcuMmp1ZciQznlf/s7/+SnBELNbVSg7UVnYGzWD+
         v+gWo6H8VTOeA==
Received: by mail-ed1-f70.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso9153722edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7XKTjYGWAy5ocS9c+MyCrdo52ak0FW1Oc/1++V3LAOg=;
        b=upuN2EDKJZXhv3kqEzL9RUhYn9kVXMmqZoxlhnfnXBybdwQXKxa5kvbEWKoakxkVAT
         rXlgmzQofKDwjhgtoYBLFp+OqmomwNBrVJbsJlsjlrGr0lLO5xPsulxt/h8nD5hlbxou
         m/+FR3d7krVO1708ccn5nwYmVp73xOKjURpghHvfEX2EMZHWPtF6A5xtDxf0EC4HY8zo
         xd1Nv8y+AL/ekfr38Q+FggTZW6NG+3ChKP2nxBBwiAApltVc3Q/NGvO44AZC8N3OwVbB
         uKptZSGd9Rz0dEt6e23RhELIGg4LXTU/WcGH8emLbNwCQw5Y1Se469qmVM4yDjh4jh3a
         Cyog==
X-Gm-Message-State: AOAM530kAKHRzGAtuxfcomGIbLZFN6dbNPN7qEZCIrDYSSopssiTM4BH
        nnZUN2TZ9Z1L4n4ckJRJfKQrQfwmA1RK3vbHp+UolBnNP3fuje7htkL6UzVBlfY/WNa6rhUuXoZ
        2sB9JspMQhu8sQA940xYlRIvhLX4C3l6bzdS0QXJeYQ==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr9906307ejd.253.1646677851702;
        Mon, 07 Mar 2022 10:30:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhU1uDNMUFnOAb3RXndJwPwDDKZbEEivbUeVrrthqF+GoSNwRiY2DLiZ0L4y4Hk76EzwyTLg==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr9906294ejd.253.1646677851551;
        Mon, 07 Mar 2022 10:30:51 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906374500b006d5825520a7sm5037411ejc.71.2022.03.07.10.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:30:49 -0800 (PST)
Message-ID: <22274a25-460a-75c1-91c1-e1bb321a7aeb@canonical.com>
Date:   Mon, 7 Mar 2022 19:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: juno: align pl330 node name with dtschema
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220129175621.299254-1-krzysztof.kozlowski@canonical.com>
 <YiZPCHtpmzNPEKt3@bogus>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YiZPCHtpmzNPEKt3@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 19:29, Sudeep Holla wrote:
> On Sat, Jan 29, 2022 at 06:56:21PM +0100, Krzysztof Kozlowski wrote:
>> Fixes dtbs_check warning:
>>
>>   dma@7ff00000: $nodename:0: 'dma@7ff00000' does not match '^dma-controller(@.*)?$'
>>
> 
> Sorry for the delay, obviously I missed this. Looks fine for me.
> I see you have already sent pull request which is good as I don't
> have any other juno DTS patch at the moment.
> 
> Just in case it helps SoC team to pull you PR,
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thanks!


Best regards,
Krzysztof
