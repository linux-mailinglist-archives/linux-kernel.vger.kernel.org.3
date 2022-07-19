Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B795757A043
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiGSOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiGSOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:02:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF51272E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:13:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n18so24718497lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EZr/z2iKWbmMVzycB7BAEdZdd4qhgY+A/eEcUOmqg0c=;
        b=qgE6b+KluJv0iM4kKslfWj1ucjlBmmvsTOjzet3UdAoJd6znjidjMC5g1K9l3HzKqw
         8eJ49WUu68kTSHig/YQP59btXQkF0ytgtQAcWcSrUPCB5JwDhJKeIR/JX84WZsmmL4qk
         wLPn5lRnYBWSj8Nw7USb2vY/Sy649pMWCGkrM+3P5MiLgPgdJz9OkyWSXzICvJ4h0xqe
         AstB+xJ4UJpj8Kj53Hz9yHyzysLrZmt6ZCGbdr7+YQ9war5pEpH4ySgNR/lY8Jf8dETG
         VLYOE3Dy5YhzFbA92/+Y3pZJkxgvjQSGhmX9aB15f1Az3VDW1W8kByZh+Z4mkrE/Smlx
         zHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EZr/z2iKWbmMVzycB7BAEdZdd4qhgY+A/eEcUOmqg0c=;
        b=yqoBxvsfaWlXayEhrH5TGAJYJxucDr0a+3RvdaCx/g7Svo1Q27zTYjMrF06kuNTm5M
         JiU8FqFjd6/HG3XShaFkI+jbXfTrq9Zld6tNUCJZkm6x+JSjZ5H5cP6W2N2aDLUmuRoW
         i5dTDy+w/ogaNfkqyYci534SMr0m1xMon5GfJn5A1IvO/oFe/Io9r6GGG4NkJ+RQPUNy
         oTqTFw6aGIQSyRYr1ckJAITh8Ftm6b1YBxQNgJCi7lChTjf4qvpAYOiy49UyyTWXpcDC
         p+PcPbTV/aVC/+nh9AWeJiQrpgcZedDqrGhM6PoutSBOxjA1MoKtdwyxgV9PUIIhTc10
         4RLw==
X-Gm-Message-State: AJIora8ww7wBEE9a/WERsxSoexK5zDHDRkVtw2MAgWggdsOAYaJuYOws
        H7TxQOsOK750h/m/j5wMqK9/yQ==
X-Google-Smtp-Source: AGRyM1sMfGQdcW9JBmO6tMMP2HRvr9SfvmjXDkggEn/d3UAFT9rZEEHygcBWfua1E9Rjya/2mWNwOg==
X-Received: by 2002:a05:6512:22d2:b0:48a:1ec7:2220 with SMTP id g18-20020a05651222d200b0048a1ec72220mr11531102lfu.668.1658236393337;
        Tue, 19 Jul 2022 06:13:13 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b0047fa40b5051sm3189771lfl.248.2022.07.19.06.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 06:13:12 -0700 (PDT)
Message-ID: <d04ef271-9404-481c-f2fa-268ff51ee3dc@linaro.org>
Date:   Tue, 19 Jul 2022 15:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] regmap: support regmap_field_write() on non-readable
 fields
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
 <20220719125401.GA92394@ediswmail.ad.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220719125401.GA92394@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 14:54, Charles Keepax wrote:
> On Tue, Jul 19, 2022 at 02:14:46PM +0200, Krzysztof Kozlowski wrote:
>> Current implementation of regmap_field_write() performs an update of
>> register (read+write), therefore it ignores regmap read-restrictions and
>> is not suitable for write-only registers (e.g. interrupt clearing).
>>
>> Extend regmap_field_write() and regmap_field_force_write() to check if
>> register is readable and only then perform an update.  In the other
>> case, it is expected that mask of field covers entire register thus a
>> full write is allowed.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  drivers/base/regmap/regmap.c | 50 ++++++++++++++++++++++++++++++++++++
>>  include/linux/regmap.h       | 15 ++---------
>>  2 files changed, 52 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
>> index 0caa5690c560..4d18a34f7b2c 100644
>> --- a/drivers/base/regmap/regmap.c
>> +++ b/drivers/base/regmap/regmap.c
>> @@ -2192,6 +2192,56 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
>>  }
>>  EXPORT_SYMBOL_GPL(regmap_noinc_write);
>>  
>> +static int _regmap_field_write_or_update(struct regmap_field *field,
>> +					 unsigned int val, bool *change,
>> +					 bool async, bool force)
>> +{
>> +	unsigned int mask = (~0 << field->shift) & field->mask;
>> +	unsigned int map_val_mask, map_val_mask_h;
>> +	int ret;
>> +
>> +	if (regmap_readable(field->regmap, field->reg))
>> +		return regmap_update_bits_base(field->regmap, field->reg,
>> +					       mask, val << field->shift,
>> +					       change, async, force);
>> +
> 
> I think this will break other valid use-cases, regmap_readable (I
> believe) returns if the register is physically readable, however
> it should still be possible to use update bits if the register is
> in the cache even if it can't physically be read. So really you
> need to fall into this path if it is readable or in the cache.

But what type of real use case this would be trying to solve? Either
register is readable or not. The presence of cache is just optimization
and does not change the fact that we cannot read from register thus no
need to go via updates.

> 
> Which does I guess also raise the question if your problem would
> be better solved with caching the register?

And how the value would appear in the cache? Since register cannot be
read, I expect the cache to be filled on first update. First update
would be read+write, so we are stuck again.


Best regards,
Krzysztof
