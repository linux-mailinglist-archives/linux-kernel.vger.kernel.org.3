Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81FC5A6426
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiH3MzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiH3My4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:54:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034E122BCF;
        Tue, 30 Aug 2022 05:54:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z25so15403993lfr.2;
        Tue, 30 Aug 2022 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=PI82MzFvdHP75c7weRhmZb8nU9JOXMueIl3nwAOMIGk=;
        b=XhN2VTNabjEKtoWOzHgPVjJ1yePu6flob5CKlciItMWh9Q559bF3hKp4BefZlZ5k7s
         TezrpQO7B2zeRnRrah1a38p/pc2jJV0YOl1YXmx3lWIGI0p+CDKIGeuQQJCCyHvkJD6f
         zQ6sb1rqQ9qegqcAeq+XKvHbqBVGNSqYDt9O+gzjaFRH+YziJ0x6gFXfUnhrZuzittNf
         W4YdMl72KP0whn81v46NKjK4TZV2Hwy6sgl+OwZhIsvOrjsk32GBS/tAf1M5GWldwaYD
         VOAdggCQtCsoxWRiEl5aUAG8LIbWLlS2dEIB3pzTCAqd2cHtRUqrZlyzvZOs7EoZluI9
         oS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PI82MzFvdHP75c7weRhmZb8nU9JOXMueIl3nwAOMIGk=;
        b=E3o5nRMX4Zdy9iZqk6KGfmH6ldvX3jV4elekYbT/uLEm2DqbeMXOCEnQGY3PBPzzj4
         J3QBfjqtCA+Ip74jxc+uukbdPkOWg3thdRAK0keNha0qEQ0Eu91VBGBFQSQlJmvhyeQU
         /TVqiEyp/6QM6A+RXcwF4w/f+q5aytlwZFykJygkbocKzAhOsuCDB88lRc7NuRlhWZ4q
         i+oSDxHWe05xAcjk7TBhaSTV06+inQQW/rEwtUsDc9P8mFdOi/fzykBi/VK5YYaCUqr8
         vPPCiNV3WVepM46zsmsm8yYhz6k2jaPyoUeidg18UW/9AvWvrJMLevNTOjsf86O0Ba+a
         t5vA==
X-Gm-Message-State: ACgBeo3lDj5v7x5fw/00wBLTcAqlWNHlaXtg3IhV7fLvbPlUpbxI+MBu
        9RHwqm/MITHR6chQFjWkF9c=
X-Google-Smtp-Source: AA6agR6OkiSrMxyw4LWK6fNAB7FxseNF8wU9mDYISGsRgO04gUdFhOFyiclQMQeFrJRC6Ue3RkSMdQ==
X-Received: by 2002:a05:6512:3b0b:b0:494:66e7:e3f with SMTP id f11-20020a0565123b0b00b0049466e70e3fmr4065680lfv.279.1661864048680;
        Tue, 30 Aug 2022 05:54:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512315400b0048af3c315efsm1605659lfi.191.2022.08.30.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:54:08 -0700 (PDT)
Message-ID: <0aaeb018-94ba-eaaa-4000-7ad082a09850@gmail.com>
Date:   Tue, 30 Aug 2022 15:54:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 11/14] iio: ad7606: simplify using
 devm_regulator_get_enable()
Content-Language: en-US
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <521c52f5a9bdc2db04d5775b36df4b233ae338da.1660934107.git.mazziesaccount@gmail.com>
 <SN4PR03MB6784BE44D4A6DCECA0859C5F99799@SN4PR03MB6784.namprd03.prod.outlook.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <SN4PR03MB6784BE44D4A6DCECA0859C5F99799@SN4PR03MB6784.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review(s) Nuno!

On 8/30/22 14:46, Sa, Nuno wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>> Sent: Friday, August 19, 2022 9:20 PM
>> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
>> <matti.vaittinen@fi.rohmeurope.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
>> <Michael.Hennerich@analog.com>; Jonathan Cameron
>> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH v3 11/14] iio: ad7606: simplify using
>> devm_regulator_get_enable()
>>
>> [External]
>>
>> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
>> add_action_or_reset(regulator_disable)' and use the
>> devm_regulator_get_enable() and drop the pointer to the regulator.
>> This simplifies code and makes it less tempting to add manual control
>> for the regulator which is also controlled by devm.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
> 
> The commit message could state that while doing the change, dev_err_probe()
> was also introduced. Bah, anyways:
> 
> Acked-by: Nuno Sá <nuno.sa@analog.com>

Good point. I have few other changes to the series pending - and I 
probably need to rebase/respin when -rc1 is out (and dependency patches 
are merged from Mark's tree) => I may as well alter the commit message.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
