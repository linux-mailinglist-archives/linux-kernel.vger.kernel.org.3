Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5795F546DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350486AbiFJTxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348870AbiFJTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:53:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA224E1F1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:52:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso1620189wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/0seJj7vutXMisqi25YbC/BlVcmbiGDjG4jipxqxReo=;
        b=VFre5QqFlIlGENzelDzmUJOiheZWLY1JoEfaXQVUp03TC5OyhQ0ntZuxLQEbTNb1nI
         fZ77oE2MANgxD9i4a+OG/UMCw/nXPHHqaMOFIoC4TykgPW4PhLMOi5wWTtpljPBdjnpR
         KXH7emFO02shqEjX2tYrQfNFiFlRCpPjXdioNwa/7QFfw2YdLuLjJEjyHKcYdy5bQPaY
         Q74EgOC28ix3FxjkDeA/ZJFMW/F2ftQiTpB+up5jC65umBvutgiviDcZfXlWCHwd1wbp
         Wu42XjbBl1rdm1jHloojb5ZtGu8ZXX0go2pD5gbMSQ5o2jHwKwraEy919Hq7I979v9E5
         DoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/0seJj7vutXMisqi25YbC/BlVcmbiGDjG4jipxqxReo=;
        b=MJzmEm/idnOxV7gyEiXGDjbSZsMv5HI0HJ7JeAJHTGTC516NMGYlNobwQB+49k/eDv
         FR1JeHC6xF6VNFcuBVzZx/kDnpOPi7ZmSxtUOEFS/3Gw63TKimLQRR4rDaVO3mdzQegW
         aTMcKNSosEw++zY4F0teLwthTYrwwEA0dF8pafR7j5D8q1hYIvvhlElh41pk64P4aqfV
         X4V31WVoJDw7XB5tyjhCafvxFTQ/Fi6jlgGhqsi6Jis7NH0x1DOO64vpqR5YmFSnpHrQ
         8+r4AqrNEiJt5ltbvLCQS+VS+YnQRjf6P9Nlc6dFaDfupypwm1tXdgsJwLuKBzSN0pVx
         QlzA==
X-Gm-Message-State: AOAM533v2z0b1QQH42zMcLO4F5izoFz4Cd2Aihzbd04ui1fE0dMRUUK/
        h6BvoBGAXwfhw44La+qgCe+1mmtfoOOGqw==
X-Google-Smtp-Source: ABdhPJwlVgYEJ4hq/w7bJ1jcGdQfLjStMZWUjC+0iWkoeA/KWncZxa3J5xGCX5dZ/sQBCQE9dWBZGQ==
X-Received: by 2002:a05:600c:3516:b0:39c:8091:31b6 with SMTP id h22-20020a05600c351600b0039c809131b6mr1308386wmq.164.1654890778440;
        Fri, 10 Jun 2022 12:52:58 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f2-20020adfb602000000b002185c6dc5b1sm273167wre.108.2022.06.10.12.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 12:52:57 -0700 (PDT)
Message-ID: <bb4ab218-3461-9afb-ecba-5c9e87f6acfc@linaro.org>
Date:   Fri, 10 Jun 2022 21:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: i2s: Check before clk_unregister() not
 needed
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yihao Han <hanyihao@vivo.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220527065412.3677-1-hanyihao@vivo.com>
 <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
 <d53ad0e2-e32d-1b46-b626-e82b44230704@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d53ad0e2-e32d-1b46-b626-e82b44230704@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 18:15, Christophe JAILLET wrote:
> Le 29/05/2022 à 10:06, Krzysztof Kozlowski a écrit :
>> On 27/05/2022 08:54, Yihao Han wrote:
>>> clk_unregister() already checks the clk ptr using
>>> !clk || WARN_ON_ONCE(IS_ERR(clk)) so there is no need to check it
>>> again before calling it.
>>>
>>
>> No, this explanation does not make sense. clk_unregister() warns and
>> this code is not equivalent.
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi,
> 
> Moreover, as pointed out by greg in [1] on some plateform the assertion 
> in the commit description is wrong. His message is about clk_disable() 
> but, IIUC, it makes sense for clk_unregister() as well. See [2] on the 
> sh plateform.
> 

Yes, this is true as well, although does not have the practical impact
on this driver as it uses platforms with common clock framework.


Best regards,
Krzysztof
