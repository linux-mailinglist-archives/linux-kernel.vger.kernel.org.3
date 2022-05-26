Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F00534FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbiEZM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEZM5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:57:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037685001F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:57:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gh17so2873338ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vGz/arC7Pja/MTSIyxP5U16GbCQiU6CFTvtPfMYEdA8=;
        b=ytghNRDLFhibUiUzBwOt99ZQvclKbBNKmv+493Us2L8IpAuOIkeO7gbLs7hrMowYyG
         mQs/Kcp9DH4ycc/uvZIYUVoXISs02vXapbyOm108gy6rx3F80HJPiEnlFJurrZGqt5eD
         Z7tWDXDQprEatM6uEvMMPbsjWAy+as10sCYNOxFh4zcppcApyY0bqM0gVYVZjCdH6zBQ
         KcGPLGz38bOIWFc1l4zVfCmq5r0A19sXp8uOFSqN2cgO7ptr9rIINo3SQ6WyObuWKdEA
         h5GgzQVNI1GeHzAMDA2Fg9QaP00dqGy5zgLPZexKayNCyvhAOcNMNjjaWznjagNRQXe2
         aWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vGz/arC7Pja/MTSIyxP5U16GbCQiU6CFTvtPfMYEdA8=;
        b=FHxfHKwUkzFfdvNGn4887C9YlGLHP2x/AL5hunHt9bU1UgXcSg2lW8Rb1Dej2/U92v
         fnjyjwGzHZA1jPb8l19ry64i0HvAQp62OdAqVvDTTVeU7SUTmePrUiEklbmTQH0DUPlT
         t0FZjYwjKoY32pLB1amFFdJLXxkY1ouyMDl5cedx6JWDcURqs2DN+xO7cIRTUXpC3Gxy
         XxlxGWP1VctzA8P3W4FIUo2Znx56ll6rH/2d5d1s4Mcr5PDrjVLqg9fJP9yzlYx5qfFU
         0Fx54ESfYNvHg/ldZzLXE015fyle/rhHf+KweUtR8f5KUgc89jUr7DaXCK5fSnijGQeb
         kS0Q==
X-Gm-Message-State: AOAM530JKSu6+AlFPKPuMeMLWXwc0pR6ZBT/vf/SYYcvkO/rzEvEHTJF
        Jk3yNjGkNCdAxj3EpnhWZ+RgVjFJ+mp61UUr
X-Google-Smtp-Source: ABdhPJxRWLIvdoBe8sRMkBO3R+GhmALdztkOU8Cxw5Bw7MtVNzxsCwiQzUnuHPxwDlAqVArNGpRiVw==
X-Received: by 2002:a17:907:720a:b0:6ff:2e1c:f22f with SMTP id dr10-20020a170907720a00b006ff2e1cf22fmr733678ejc.16.1653569822611;
        Thu, 26 May 2022 05:57:02 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906368900b006febca5a604sm498503ejc.58.2022.05.26.05.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:57:02 -0700 (PDT)
Message-ID: <f92bc466-734e-b040-b8d5-0add023fe341@linaro.org>
Date:   Thu, 26 May 2022 14:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 18/31] media: tegra: Migrate to dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <67b10cc516558405bfff0fc7749cee9d3bf02fc0.1653564321.git.viresh.kumar@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <67b10cc516558405bfff0fc7749cee9d3bf02fc0.1653564321.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 13:42, Viresh Kumar wrote:
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
> 
> Lets start using it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 14 +++++++++-----

Wrong subject prefix - it's memory.



Best regards,
Krzysztof
