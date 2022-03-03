Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642344CBB8F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiCCKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiCCKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:39:19 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7E810A7C9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:38:34 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 719723F1C5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646303911;
        bh=oUgxYlRh1Rc86CInB1MrO8TopcdQbjgGLLfiUWjhGQU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tVUw052T7EVtpFImelMitMKqhpjfRB6uAtDTzRCMpgxplmQD2hcUvNjJsJFI5uOqe
         ZqeH75x8q6cOFx8/8qLyk5O+qF8eExxuMi5TLe08S1OmKydlm/7WH9LUT/B5eX9ksA
         rAltfksKGAwcCvRkwQw1a3GpdJBiAmgZe4wgY+7vS5MTpZMFkesxcIgDsd/3fNTggq
         f6VTiAMR+u0GOppK1X7/fRI39AtjdYJnNDNaHv9j2pkaXJAZy2bUACjyS5xBe6XUOb
         iKyhLRgHVLbFPNR3BLQM3RsziPg5CULt/Z8od4Vk/FlDuJRffimDbwYmUyF7TMa7hk
         De+xgypV+/vPA==
Received: by mail-ej1-f71.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso2517639ejs.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oUgxYlRh1Rc86CInB1MrO8TopcdQbjgGLLfiUWjhGQU=;
        b=zXmuyp47GOA/Zko3EMbZey0XWx1sv8Gifbb/mPjJnOlK+NnQ2ZOpEWqHfGFxSxHto+
         QBogcIxZO4ZUqAph4rYlFQA+cj+oi4E9srSFZGQX5/urviaBVzqGDceODmDu5AdfE/Lf
         t9yJ9hIgxKTRdQqXGOO8yrKVIL0avH7RoA94zHrlqhfX5F8qBAr7wQlQ1x3jXbFAfxbI
         yZGg0adXxexozmPF0K5pUonCvyEev1Pa6/Sn/xnh40HAYEsEz900yG3mVh1G2ycAvpIG
         qMfC29NFErM71giD5bsj0BYiGyGdpuaHepZgV3sl6Te8PQ+nel0JeGOO7aEeeNdTImEs
         vLwQ==
X-Gm-Message-State: AOAM530sBHQjtP67VkcaYHj5f6x4ymx7K1kpOjFiN84UoE7PyxZeYUZ9
        5DP/6u6Bfn9QSw0al/eBO2lpdKy4KXqu9wNMsKl1wCt6krjZX1lrPX9w89wbq4QrtVRDVqS4qxq
        l151Qojf8sQQ3vVfxNQj8Qt8TTxutRHwN9b214doPJA==
X-Received: by 2002:a17:907:96ac:b0:6d3:4554:598b with SMTP id hd44-20020a17090796ac00b006d34554598bmr26295424ejc.424.1646303911149;
        Thu, 03 Mar 2022 02:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJye4d98ukofTvzQtJabYxzo+G/VGXZ0sIYUyS+Fa9bVBgV0PS+X9Wcsjj3cNKZfPz17muBx8A==
X-Received: by 2002:a17:907:96ac:b0:6d3:4554:598b with SMTP id hd44-20020a17090796ac00b006d34554598bmr26295394ejc.424.1646303910960;
        Thu, 03 Mar 2022 02:38:30 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id co19-20020a0564020c1300b00412879e4645sm671037edb.55.2022.03.03.02.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 02:38:30 -0800 (PST)
Message-ID: <d4f6fc91-ad07-7d4b-9c87-ec556ef26ff7@canonical.com>
Date:   Thu, 3 Mar 2022 11:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 04/11] i2c: npcm: Change the way of getting GCR regmap
Content-Language: en-US
To:     Tyrone Ting <warp5tw@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        yangyicong@hisilicon.com, semen.protsenko@linaro.org,
        wsa@kernel.org, jie.deng@intel.com, sven@svenpeter.dev,
        bence98@sch.bme.hu, lukas.bulwahn@gmail.com, arnd@arndb.de,
        olof@lixom.net, andriy.shevchenko@linux.intel.com,
        tali.perry@nuvoton.com, Avi.Fishman@nuvoton.com,
        tomer.maimon@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        kfting@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220303083141.8742-1-warp5tw@gmail.com>
 <20220303083141.8742-5-warp5tw@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220303083141.8742-5-warp5tw@gmail.com>
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

On 03/03/2022 09:31, Tyrone Ting wrote:
> From: Tali Perry <tali.perry1@gmail.com>
> 
> Change the way of getting NPCM system manager reigster (GCR)
> and still maintain the old mechanism as a fallback if getting
> nuvoton,sys-mgr fails while working with the legacy devicetree
> file.
> 
> Fixes: 56a1485b102e ("i2c: npcm7xx: Add Nuvoton NPCM I2C controller driver")
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> Signed-off-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>  drivers/i2c/busses/i2c-npcm7xx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
