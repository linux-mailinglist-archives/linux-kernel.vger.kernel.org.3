Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04FB53A347
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351244AbiFAKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351042AbiFAKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:52:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB119527C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:52:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rs12so2864502ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=iMh1IyTG2d9en/ELE4xi4Q/xuh2OZdfW6JgVzXFlyN4=;
        b=oGe9Hcn98WvrZaT0jedFKgGxU2uNih6RFdmKu7nXQSE/RI5BKB4BqB1x0GBgCVDuV4
         /7KAA2IE9eo9WkUCOb+Nyx0tyEmzIcySMVICgBnYrJv5DPh8a2AYUlCcsQr00WqpTUMt
         RZIIuf7Qk0CZDzLyAN9T+o7jCI+Em86PBLOsQ1/AppLbJR4LHAZwn4Hrp3XmkvmXa5CT
         mMRRZfDM1Mvm/YYI1qp+KCIJjLTORf4ubhUkoOUq5Xl7V9Je6D3GJ0fec+yD87zOCFy4
         Hy2rv8huGAgv6MlNjeKt1jJMbkc1F0UJkvRiuyzvWKsIY90n/5pJPKiz0P8gU5iIADy4
         ksMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iMh1IyTG2d9en/ELE4xi4Q/xuh2OZdfW6JgVzXFlyN4=;
        b=S4mltQs+FT1bQjxQye8ypib+kToG967fQZ2agXx3kACzXDVTPT138Q2cuhHZ+cu/p7
         Wr0uoFUPCvAd2ek3clWpbQ666aquwf4J3QZenxWlGu1mjBkiiZO8HBLMop+A2NHefzB4
         KEKM5MtMdoCeEL2li6humhhBndRGBn89R1beAyJx9qFzo7Hj4wAOadOtpPWHGWUcGumF
         jcizzAtyWvcjNL2SsgUtdFKgau8JCtCDUEfSXHME4LRyKSodNo/bx2NtC2YJQHPBjnU9
         NArOFn4H+25i+uTJswpiAmK6Dc/2gmbcRzNm+AHfYp36fViIV0rOt3+U62ejbD8FkF6r
         kpiQ==
X-Gm-Message-State: AOAM530iJks2OWsybTw/hHdkozLGKrIFzoHp4+WULGfcw8R7GW8oE0pl
        Pt3pY6Jkn52M184Tbx/VguUDRA==
X-Google-Smtp-Source: ABdhPJwfrKKwsWAmFAlvmE33P2IfYMGV+b5KQgaK5GFfabKtS77U+iiNLrnlD9WSmBqm3Ul/6KDZcQ==
X-Received: by 2002:a17:907:8a0a:b0:6fe:cede:95d8 with SMTP id sc10-20020a1709078a0a00b006fecede95d8mr44626804ejc.59.1654080740174;
        Wed, 01 Jun 2022 03:52:20 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gi6-20020a1709070c8600b006fecf62536asm549266ejc.188.2022.06.01.03.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:52:19 -0700 (PDT)
Message-ID: <9f44c7bb-f403-7009-4b1c-8508d37e44fd@linaro.org>
Date:   Wed, 1 Jun 2022 12:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mfd: max77620: Fix refcount leak in
 max77620_initialise_fps
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20220601043222.64441-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601043222.64441-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 06:32, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 327156c59360 ("mfd: max77620: Add core driver for MAX77620/MAX20024")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
