Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC346E8F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhLINUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbhLINUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:20:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245C0C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:16:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t9so9642479wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 05:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lr8CMzo3EKfaVRi8NKOM7PsaQt1QpnCMNjRjYv/qQyo=;
        b=XXe6wyI1/vTCtKfUDcdu1iY6BQSB2loNeEXPNWWzgK6qaW0X54tZlazKL/8dqN9owz
         hLwJTVfg8rrLThmH2iIzNn2ZT95Uwa56qjCtQb/nsba9zc3cEWvqnY1/d1G57nv/ygcJ
         AkB6xSsiChyiTbs2vyX+C+cBo4r/3qAqAKAubF8at3DGpb42L4heGeZOffygBzc5t71t
         Gk6TMvlpYr2g6HH8eo8CNllRmsRfo8248agGy2ns9ffs2U/NtN71HbB84pxTSw6p7WAA
         GSISYIITEd3n4l5fkpe8iYCZvv4Hz3ZD8OZ9ZA/iEBmAq1wi6mRS05MOo2UAU3necv8J
         pIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lr8CMzo3EKfaVRi8NKOM7PsaQt1QpnCMNjRjYv/qQyo=;
        b=td2dsMuEnv/71EXeWJmWYsHLPVCEijqezA1qKdAcJ+LCVbuC9wY3Piqo6wbnT9S08j
         Jqik5YxUKxeTCedM08iQ0ZkjPpj7vwNkD7GnVzXIZag9e8vgnQvV4PaXuNrbQsgHB+wx
         uBS8WhsU/ZZjCJhbvuG4C7lPTeRO5RRCg4I7x63YOxFSPF/xgOlYou6PLfyJC+VHcgUc
         1qTPjQAG8yVUd3ZfNJ1IZgvLpOAIU+cokUhUg6psLbcC2it1aQMcwuszIr9XbyuyBNYz
         S4qFK5tbnpudi8r4LF1gXi1pW0Xef9tIJO1cldW9arnQbegDRZKphNrhM/QKFQeWVAtn
         ZDqA==
X-Gm-Message-State: AOAM531ohrHSqgzfI5o+UpmRbtBj64NUeT/fn3GDIgUCYtEpxWEsFTeM
        8MS2VIuDsh0wgje52n4nIHbV2K7COvNqrA==
X-Google-Smtp-Source: ABdhPJwwpW8Ir/iCl7C30/hUgRXiTRH+c/yG+7fviA7bFM91faOskb6Oa9KtWPEfHbfbKETbAySF9g==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr6243176wrw.151.1639055807403;
        Thu, 09 Dec 2021 05:16:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d? ([2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d])
        by smtp.googlemail.com with ESMTPSA id a198sm8619735wme.1.2021.12.09.05.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 05:16:46 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/pistachio: Fix
 -Wunused-but-set-variable warning
To:     Drew Fustini <dfustini@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20211123192524.1038304-1-dfustini@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <52d2195b-6675-690e-e579-c57b4c9377e5@linaro.org>
Date:   Thu, 9 Dec 2021 14:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123192524.1038304-1-dfustini@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2021 20:25, Drew Fustini wrote:
> Variable 'overflow' set but not used, but this is the intended behavior.
> The hardware only updates the counter register after the overflow
> register read. However, the value of overflow is not actually needed.
> 
> Link: https://lore.kernel.org/lkml/202111200402.afQsussU-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---

Applied, thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
