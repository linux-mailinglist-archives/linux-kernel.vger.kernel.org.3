Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63A537042
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiE2IGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2IGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:06:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42AABF40
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:06:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f21so15603339ejh.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=hQYyH1NuQCxodBSw7bWH/zqxL4qVmJndxBzPT88yQB4=;
        b=zK97chyQl8Zw0vTKRZg+NP7DyTXvJW4ZGtJmUCyHTZbs/UgyCwhpOk0whyyWkH4e2E
         LIt4VprENlnBrKz/nwjdqjiTluUmtnoYnwlTjNl2FzVeD86xec7VSyCh+ALTI4zEy3Ht
         cFPCDDX6ZAykzxccShnKKpc22cohMHAMWhkfvyarUDoljJ2F6Stxt4YjLoa52/nZJt/z
         kIfaiir+c5IDF1pbvDld2ve6u7rHPOrAlzLg/Vnr+W+eYx48gF9o5K2FwL51FFGI26bQ
         31epBhkXZmtxGPXgWMqem5R8DoT+WUhBgUD1TYkeYvRdlyNTl5pKH2nP9HRd+xB9pHSb
         1ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hQYyH1NuQCxodBSw7bWH/zqxL4qVmJndxBzPT88yQB4=;
        b=DpNCP2PtYZkQXASB91zi/WBZ+NZPsNrBPlmbcogpirMwGq5rYxbNM+Vc/RH4B/1lK4
         LdPRQ87F83CNtUhryfzF5/Do2lJEV1an3tNyyq/OAKjJqchlUyq1IBrvrnBEevncgZmy
         PU9xUGXsxCpEnFmVTRy36po//7AU3h4wPo4DWbOoyQ2+2UZpEzQ8kiIOh1i+sZwPmQJ3
         OCPpyQMacXQ1fZn0OXrUxD3qBmI9evN7OzwNJyu13NfeZurzyB5KGXyO5GjEIzn/K9s9
         Tg0CPNsV4kxj2Tfwp3dLFWLo4n5egb+hum+WtZqeDAhi7ClHuqDsQKbd4GzPMZdC9G5j
         VjEA==
X-Gm-Message-State: AOAM530ZCQuc4VBaCAEKKY5SWcR5tfMW2LLuO3nhj5tXxVDSg252Bqlw
        dPfCY00nYkxwDwjPb10ETopy3w==
X-Google-Smtp-Source: ABdhPJz3blndANSWk63eUvimaJRxk9h98saxwAdGFo6awH/GR+XpuYweVafdECGQDkyC3kfOjzSWQA==
X-Received: by 2002:a17:907:6d24:b0:6fe:c407:d956 with SMTP id sa36-20020a1709076d2400b006fec407d956mr32749932ejc.33.1653811577490;
        Sun, 29 May 2022 01:06:17 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s25-20020a508d19000000b0042dd05edeedsm91547eds.17.2022.05.29.01.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 01:06:17 -0700 (PDT)
Message-ID: <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
Date:   Sun, 29 May 2022 10:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: samsung: i2s: Check before clk_unregister() not
 needed
Content-Language: en-US
To:     Yihao Han <hanyihao@vivo.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220527065412.3677-1-hanyihao@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527065412.3677-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 08:54, Yihao Han wrote:
> clk_unregister() already checks the clk ptr using
> !clk || WARN_ON_ONCE(IS_ERR(clk)) so there is no need to check it
> again before calling it.
> 

No, this explanation does not make sense. clk_unregister() warns and
this code is not equivalent.



Best regards,
Krzysztof
