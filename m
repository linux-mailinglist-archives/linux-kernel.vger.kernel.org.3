Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC55958B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiHPKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiHPKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:43:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8B86C18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:03:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v10so10003864ljh.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OpAr4FILibAj60CMTr+2Ye6zNBQ/3UZQJ3hG9VyyeXQ=;
        b=yBRx89F71+/Nr+yqbTzxq7RaQS/DGhP+V/xTGPujyv864Z7WgklQ8/9btVLlypEccw
         7SFgAJ/0mXdj4EztCodYtKc/EWITIhKvD7fclaY87vclFFubKUv6Y7DjXkULIgxxuu80
         6ac1KYH/DNcm4i9TaNy9mkHyqDtTSi0yOdIppjx9nxhqI+mD8aKUTJ+V8F6Nquc/uQ6H
         A9Ww/IIBC9gRb7BVvnX/5kHJVi1+FMQ9HakmPCeH9PmbyXmKypE8OntnM0F8g8vKoT+j
         PvH+k6ODqRVmY/T6e3yxaXaE+SUGmuVA+0iriyuWG7kB7jfj2cFrX+UD3g/b0T31oNtP
         sMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OpAr4FILibAj60CMTr+2Ye6zNBQ/3UZQJ3hG9VyyeXQ=;
        b=NODUYBcoHf4bGYJ81guVDiqD44TETFHukBVyAJnKAxo8droUuF/c4hIKbVRMgMXEax
         UyAstAFXxV3f+96dEApDT12EHTtI2Zv7lXWyEimfsUCdECUvyELpv3+TvrFRUtdWVlPo
         3WQ1Fq6Y0LtDJ2JvIvCOtJDqbp90aXq6COeb5PSR1ZgNIQyMLxvKuSnrjNzPpQu6Mm7K
         Nfjyr8aq8LFs2pu85swSGpc6by+qxCdZIZrj0bNLjpH0k5z95qGltttwNCw6S9EqOtWk
         xNiMbMUsCQQ0aJ8TkOVD0/uyGnljveN9XBIfg+XPE8d1sLlTBn4jnwm4mScRY25ahPMr
         KCiw==
X-Gm-Message-State: ACgBeo2VzKrIekY9ZbMv6M/Vz3DADp5JSl6NIlIEUe1/R4VqF+4CNgwt
        ruNj/+BRUvmGMvELebFftp1NSA==
X-Google-Smtp-Source: AA6agR4F9d6orasLwhFe9sWvhDcTP2FvMOgxT2pZe4EqaWR/LzpEn20LKmDemBI2OQ1Jk122YL4BkQ==
X-Received: by 2002:a2e:a168:0:b0:25e:4dbc:2ac0 with SMTP id u8-20020a2ea168000000b0025e4dbc2ac0mr5760174ljl.187.1660644224935;
        Tue, 16 Aug 2022 03:03:44 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id j21-20020ac253b5000000b0048b124b070asm1335989lfh.173.2022.08.16.03.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:03:44 -0700 (PDT)
Message-ID: <82fedf98-1d94-514a-ba03-f88b4e1d888b@linaro.org>
Date:   Tue, 16 Aug 2022 13:03:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 4/4] soc: sunxi: sram: Only iterate over SRAM children
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-5-samuel@sholland.org>
 <e5969030-0a17-d10e-7eef-8d906e8a4dc4@linaro.org>
In-Reply-To: <e5969030-0a17-d10e-7eef-8d906e8a4dc4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 13:01, Krzysztof Kozlowski wrote:
> On 15/08/2022 07:34, Samuel Holland wrote:
>> Now that a "regulators" child is accepted by the controller binding, the
>> debugfs show routine must be explicitly limited to "sram" children.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> (no changes since v2)
>>
>> Changes in v2:
>>  - New patch for v2
>>
>>  drivers/soc/sunxi/sunxi_sram.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
>> index 92f9186c1c42..6acaaeb65652 100644
>> --- a/drivers/soc/sunxi/sunxi_sram.c
>> +++ b/drivers/soc/sunxi/sunxi_sram.c
>> @@ -120,6 +120,9 @@ static int sunxi_sram_show(struct seq_file *s, void *data)
>>  	seq_puts(s, "--------------------\n\n");
>>  
>>  	for_each_child_of_node(sram_dev->of_node, sram_node) {
>> +		if (!of_node_name_eq(sram_node, "sram"))
> 
> You should not rely on node names. They can change in DTS. Why do you
> need to test for the name?
> 

Ah, it is not a device node but a child property, right? In such case,
it's of course fine.

The device node names could change and should not be considered ABI (at
least I hope should not...).

Best regards,
Krzysztof
