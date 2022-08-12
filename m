Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA45911C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiHLNzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiHLNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:54:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74919A9257
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:54:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l4so1269532wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jM7EPdzO3/8UIbNc27Sgu5Ssc7D/JbAU5jUdYrnh1RQ=;
        b=j8Sp0Ny1AUyYQrQLBjWgLArXRjmzPu1lvmcKL+902eFWGt+x+95FkQ+LUAsRGB/lG9
         Dsd23JA6G0mporl2ukXShKbHFJXlIMyXriCwpi96pWky/eRqATdJp79iylWXQJGFpu9S
         xi+1UOTIuWDsawV/wl8Dto08G4ACp7h0YnyyjQPSXFK+U1fOlYPha14ooMsaX20r7lCm
         bpMNJ0Cuqi8z9Q9OwkQszpmVmR4TjAun/1/WWNu7V1kR1ByiV66W7m6jqDWkR+dh6V/z
         K9XUY1oS+Z8W3lx4hTsBrNot3HvxxwnQizqulHzAO+bfX7BrES7mig84NrV3S9AG12v1
         0SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jM7EPdzO3/8UIbNc27Sgu5Ssc7D/JbAU5jUdYrnh1RQ=;
        b=L33gOI2+6nG5HwIThWGL28+oeR5dg1knu6NnJR8eK7n/s+fZx7pGcxZNMqIracKd+9
         6KOjuoO+A9NMeGTzq92zFkdib7c5ed7CIsZx3m/LmadHDubHgw89MCmp0wOcFteTK1cp
         qmBTt1L1xzA7sI8o3WjRnxt1zRvnFAsQTSd2L8lAc5hU9/f+sHxguUHPszuqDQfTMSSZ
         kdW9ffemtiePnSQPtnSTj/ROj54v3BWWbTlLNy/4ItoMrUaHIQ3Q0OFioNauLVESQ4Wu
         6dh8a9N4oW4ChjOmSLb56MdN3CxfOaN5dNrnM+6FgWaOwnXgUCvZNGKCtSTE1ctlTSDs
         ZxfA==
X-Gm-Message-State: ACgBeo3gnBApeMXkoLjwQMZU47wp+ovbh3r8PgOWI1hunek/Dhpqe/9L
        bu9aesnOP7WCD4fQ9nzGxA2G0g==
X-Google-Smtp-Source: AA6agR5Kf8LT3vuuSyA8RzNo0c2gUbzfKa5DRzkQ/uyCoMf8X9uhFvLsN0rMwuIy/15RvIrWqifSIQ==
X-Received: by 2002:a05:6000:1acd:b0:220:62c2:bc29 with SMTP id i13-20020a0560001acd00b0022062c2bc29mr2199687wry.620.1660312493881;
        Fri, 12 Aug 2022 06:54:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bo22-20020a056000069600b0021d80f53324sm2164032wrb.7.2022.08.12.06.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:54:53 -0700 (PDT)
Message-ID: <c0c5b306-9fd5-1048-ba08-044d292cbf7a@linaro.org>
Date:   Fri, 12 Aug 2022 15:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/core: Fix lockdep_assert() warning
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     rafael@kernel.org, krzk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitk@kernel.org, linux-samsung-soc@vger.kernel.org
References: <f1fb1d84-85de-f3c5-0212-fcf0e9c0ccd2@samsung.com>
 <CGME20220812131216eucas1p266cfd4e51b59fc3cf8056474a6910094@eucas1p2.samsung.com>
 <20220812131202.1331238-1-daniel.lezcano@linaro.org>
 <ab708272-efe0-343e-2dfc-299187126a2a@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ab708272-efe0-343e-2dfc-299187126a2a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 15:34, Marek Szyprowski wrote:
> On 12.08.2022 15:12, Daniel Lezcano wrote:
>> The function thermal_zone_device_is_enabled() must be called with the
>> thermal zone lock held. In the resume path, it is called without.
>>
>> As the thermal_zone_device_is_enabled() is also checked in
>> thermal_zone_device_update(), do the check in resume() function is
>> pointless, except for saving an extra initialization which does not
>> hurt if it is done in all the cases.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> This fixes the warning I've reported. Feel free to add:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Great, thanks for testing


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
