Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2557A1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiGSOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbiGSOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:37:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11FFB21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:30:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n18so25122023lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S9mN7eRoc45OkDMOF7l1iyzcRPOqZFXQj1jlshtQlQY=;
        b=GP93j0qhUaeEHAIyT20c0zijriM388nPquFZYiwCTMakgJHdfpFhOH8v7w4jaMJ4eT
         8/EANyUSSU2SbseE48gszaT71dEs9N8tyng04VahzVB3XW+fL5+Aiy8cI/lNMMy1fBiq
         iYPnMuXeObPXtkodk9rKuXqkW3YG/yscyeVLr1qS82qSG17YHmQmGy8Aur+9CRis4wwL
         AflYJ4cfhtzrExiEoYh1mLIWCAJXC8ADZVeOk/uCZ2UwXuLhrNXDYEJL2YYC+MXbaeJ3
         +VcEul3UHoQI8TWV61dJXI+JciJCNnumufyeVmoFGHR8Az236TeC/3NDRkWS/fZ4yzUm
         gAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S9mN7eRoc45OkDMOF7l1iyzcRPOqZFXQj1jlshtQlQY=;
        b=6Jf63R1UYzP9otKIlHSOvsrnJkYImZduBGlsCHZuYHzODoHDWTZgACvtizFMq1nlkn
         X2caq5NTr34IXIG98BZL6yMVRUFi75eIG73srU6b4DmO1sMtn+hbKvQmyrlAULW4vavH
         +fO8KGtXCGt2GASFgVJKtXLwaxGAVIEx07PluumONPM1xYlTdeBbwIC3tnslM1FbBcT8
         RAbg9D+YWbZuIuE53GhAbQIXKCwHmor28NbOA8HuPXwRZUjOKZ1AP4zweFqlIBBX1m2Q
         3SKreoCxcOmwkGL+rO1oRzZobO8WgJ/wlJm4KzBy4C6ydV9WTw4GV8bOwQFNo13yNlhO
         WL9g==
X-Gm-Message-State: AJIora9OMvltRDoiKXtaKYMSguu1wL4WfsEMcM4jKV35xLR53apGezHL
        nYKGh2uqzNET1dzuJ9LV9UqaOg==
X-Google-Smtp-Source: AGRyM1s76CruLMBVVycHOyQjdhci2nnuoWznf9qjk45oAZTMSZokeB2A565qbLmGwJ7pYJ8iewcYeA==
X-Received: by 2002:a05:6512:2522:b0:489:daa9:467 with SMTP id be34-20020a056512252200b00489daa90467mr18122312lfb.71.1658241056219;
        Tue, 19 Jul 2022 07:30:56 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id b16-20020a0565120b9000b0048585b6476bsm3233537lfv.206.2022.07.19.07.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:30:55 -0700 (PDT)
Message-ID: <e981f4f5-fe8f-a733-9ab3-b2c8febd0516@linaro.org>
Date:   Tue, 19 Jul 2022 16:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] regmap: support regmap_field_write() on non-readable
 fields
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
 <20220719125401.GA92394@ediswmail.ad.cirrus.com>
 <d04ef271-9404-481c-f2fa-268ff51ee3dc@linaro.org>
 <Yta0nKlqOcimEH/Q@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yta0nKlqOcimEH/Q@sirena.org.uk>
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

On 19/07/2022 15:41, Mark Brown wrote:
> On Tue, Jul 19, 2022 at 03:13:11PM +0200, Krzysztof Kozlowski wrote:
>> On 19/07/2022 14:54, Charles Keepax wrote:
> 
>>> I think this will break other valid use-cases, regmap_readable (I
>>> believe) returns if the register is physically readable, however
>>> it should still be possible to use update bits if the register is
>>> in the cache even if it can't physically be read. So really you
>>> need to fall into this path if it is readable or in the cache.
> 
>> But what type of real use case this would be trying to solve? Either
>> register is readable or not. The presence of cache is just optimization
>> and does not change the fact that we cannot read from register thus no
>> need to go via updates.
> 
> The original reason for creating the cache code was to simulate
> readability on devices that have no read support at all (think 7x9
> format I2C devices) so we can have things like helpers to map bitfields
> directly to subsystems (like ASoC uses extensively).  The fact that it
> also improves performance when the hardware does support reads is nice
> too of course.
> 
>>> Which does I guess also raise the question if your problem would
>>> be better solved with caching the register?
> 
>> And how the value would appear in the cache? Since register cannot be
>> read, I expect the cache to be filled on first update. First update
>> would be read+write, so we are stuck again.
> 
> This is one reason we allow cache defaults to be specified (it was the
> original reason, we later started using them to optimise out I/O during
> resyncs).

Thanks Mark and Charles. Let me try the cache.

Best regards,
Krzysztof
