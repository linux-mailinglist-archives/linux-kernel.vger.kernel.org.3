Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72B253DC59
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347100AbiFEOse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349668AbiFEOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:48:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A2E4ECF8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 07:48:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so24469534ejj.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=a2QjC+ghP6BlX77hE1IU2dKwYl81feAt3LbDCMQWYOw=;
        b=ncceEXar/H9ND4JlWpkM3vguIRi6WiXuZin0c4ARD1buKUav5Wekz5YSOBCYaWyplK
         TTZ59I5eOubwEM3PjyaXTC+pe2twgRsk7boVIL71Q6mA+Ea0nu2DnIt3prFkbiusu3Jf
         kYPbeHNtL956KPGeNyX8Aw++CXB/od1xllZ8DYJSK8SoClA1u9wmF5OJm1PL2hT9dgZB
         zZFOA6a/fh8hGDdH7J4r78qweCPPWI1qFlZdMOJWl/CV63ImtpobFLWjLl3W/IuihdsA
         sx4Jkg8aTUcIw6/Ej545GNnYfollFR3d6XtScFkbop5oIW7ORk8RVuw73Ec6tmN0U3u7
         DTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a2QjC+ghP6BlX77hE1IU2dKwYl81feAt3LbDCMQWYOw=;
        b=DWvJgS9B0tC19+azBj2AQUUvrQNNzaZlPJ1/TsAH/E9QJw/U9xRa9KzbMNUQ1fYZ9X
         5MR9XMWXbuDwEPxK9N9y3Org1jgR0tcdeIjC2UaPGSIraasn/gKp/5JrvejHBYjWp1DO
         sT/r1pse5PJnL/oO+7NyhatYoW+3XHB1w0fUj2RpoKG+4EZuvFR4bQI5Prl+o9SXI2kn
         01UjMzmCUFtTfaYEaPQSM4EfX1Mn9kSdGjY858Y79ljEkbQU/hfINXByijDEt2la7qyy
         CXOf9At147blquAGvGCGYFvVtTNX9Rr2MHwQZYQcLuJKGZBu3VKjciQV8cEfGhTBqHbD
         3Fag==
X-Gm-Message-State: AOAM5300KabQP/CPz7uSho6Tu1X5+T1alsvUzp8hZCqbDBOPwbjQK5NS
        3wwhEyVBBdtA7hQJeeyTJY9M2A==
X-Google-Smtp-Source: ABdhPJxpzRZ/BzwBG0v7L5D6OCZfmxyuO0KFXbn9h3ZD5zijXdRiEhCQw402AH6J73jxT31s8LNnRw==
X-Received: by 2002:a17:906:c834:b0:6ff:4275:1e4e with SMTP id dd20-20020a170906c83400b006ff42751e4emr2271781ejb.121.1654440489770;
        Sun, 05 Jun 2022 07:48:09 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a25-20020a50c319000000b0042dd2f2bec7sm6821134edb.56.2022.06.05.07.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 07:48:09 -0700 (PDT)
Message-ID: <3a012c64-206e-3da0-7263-ac952b55b62d@linaro.org>
Date:   Sun, 5 Jun 2022 16:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ASoC: samsung: Fix error handling in aries_audio_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220603130640.37624-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603130640.37624-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 15:06, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> This function is missing of_node_put(cpu) in the error path.
> Fix this by goto out label. of_node_put() will check NULL pointer.
> 
> Fixes: 7a3a7671fa6c ("ASoC: samsung: Add driver for Aries boards")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
