Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17B04CBE99
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiCCNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiCCNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:14:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F4144F68
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:13:34 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 49E5F3F043
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646313213;
        bh=LMY/CePsTOMSqNYl6Ts31E/1/fcnzCoQjKnJ0fOnEQc=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=KQKxrkujYln3AzsBJ1Oils/gN4AIspd3sjKJFOKmLCU/5qip9IAPrCZNab9N1tEvi
         vRU1UEZXGbOQrADg1Uiezx2AftXvOMysYxYWBK5D0Tr/ZKDBJgy9hH6f43F8+Z5cwN
         M4rKDJ5D3C8BtJQ2zotbmA7vUcLmHV7k8sdjdUPX6dMPItO/JmAm6zXFuksahe/4AG
         idqbVoB3ws1zb4ixIjlSUrtE1sXUSCAIG2UpdAMXmVWTItJQTnPyKk0us+R3tdim/5
         ivQ7zJCI+UwOBqdGN5wpHJ7CLpcBsfJ6E3y9Lk1iyoS8sD5eufVVJl2DrnT1jLMXx/
         zPahphJK203tg==
Received: by mail-wm1-f72.google.com with SMTP id p35-20020a05600c1da300b0038151176781so1648939wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 05:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LMY/CePsTOMSqNYl6Ts31E/1/fcnzCoQjKnJ0fOnEQc=;
        b=6ycy5kADd/rPh/RIKf6632wMEF5TFmgRlTOwn4kHaOe67PSNVpT5yVPFB0OacoSzyO
         JFQX2qR0pkTjmezWwFoof/oYZgb9yvc9s5vMx94/kpuOhGEwwDSNFF5bPThAMryZeRdu
         IbdcvvV0QlwJFXWzJ3V5idF6vdhPfqbYst6rW6aUrB5fG0ZwnKHyjyGBuuancvLdGVyW
         FNqJh1ZS6d5yzmBDBNVtP7RnDnOqvJ1wEaT+ELr07wBxyPtQDSIDRbg78t466Uk9hi7p
         mDjZ5qYyR/zAh5lytB/6xGDD3riPLl+tMNUpZZnps6U4qftziHrkc35orqdyY5fUFg6h
         EgIg==
X-Gm-Message-State: AOAM532BPIaM1utro0x8i0Peq1cNmjDhyrWcpOTqupq64hT3jGiO5Yos
        cwjYo6yEi40Sf60Ep8awPduwp2b9Xt2ty3QxJTVruDbme2eEaC/3nVHyKsStlOcuiVlF8zHNuae
        Bo75g5EWNZXOGOT4aevO5gAvGMbE2maeT6s0/d/e6uQ==
X-Received: by 2002:a05:600c:1c1c:b0:381:45b4:3f69 with SMTP id j28-20020a05600c1c1c00b0038145b43f69mr3697486wms.86.1646313212178;
        Thu, 03 Mar 2022 05:13:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvYjeIPKK1xybBBwrybTxPehOwM+dcpiu2dLD6jZaYYr/U3PXkimjpZxKtXdvaWl32PpTVkA==
X-Received: by 2002:a05:600c:1c1c:b0:381:45b4:3f69 with SMTP id j28-20020a05600c1c1c00b0038145b43f69mr3697468wms.86.1646313211951;
        Thu, 03 Mar 2022 05:13:31 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b0038167e239a2sm2444025wmq.19.2022.03.03.05.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 05:13:31 -0800 (PST)
Message-ID: <92ecef5a-cd8d-09e6-a8af-201e04b251c1@canonical.com>
Date:   Thu, 3 Mar 2022 14:13:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH v2 4/6] nfc: llcp: use test_bit()
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-nfc@lists.01.org" <linux-nfc@lists.01.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
 <20220302192523.57444-5-krzysztof.kozlowski@canonical.com>
 <7fc4cb250bb8406cadf80649e366b249@AcuMS.aculab.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <7fc4cb250bb8406cadf80649e366b249@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 01:10, David Laight wrote:
> From: Krzysztof Kozlowski
>> Sent: 02 March 2022 19:25
>>
>> Use test_bit() instead of open-coding it, just like in other places
>> touching the bitmap.
> 
> Except it isn't a bitmap, it is just a structure member that contains bits.
> So all the other places should be changes to use C shifts and masks (etc).
> 

It's not declared as bitmap but it is unsigned long, so an appropriate
type (and same type) for test_bit.


Best regards,
Krzysztof
