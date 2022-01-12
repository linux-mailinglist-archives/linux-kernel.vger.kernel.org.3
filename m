Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE148C00D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351678AbiALIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351684AbiALIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:36:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09146C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:36:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so1065713wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1E2KjRoh5QPl4QWMlc2IUWvkR+6ixdGn9JSrzheefFg=;
        b=idLfv1ilDizLmqIzN61Jg0hGt0PH90u8gTat3Tz816EZ1fpB7SwujvNV+f/SdYwJdD
         SE0zDt28mqiF/ZTr5LNv8XWtCZZOQ6o1m8ug1MCsQisTcy3sOY6lRLZ9YOKe/ot+Bver
         9hnZD4hZhJ2aBcBudLe4eUBzeYT6kd3eECZSoGQ+mpUhxOVRwrpY9U8Mm7XKMd4coD8l
         IlRcTsbIaH4YX4m+W/B0o5Ww8kKxzHHBuKR0d4EPpPSDY8kvIXy7LeaaaU9uFv8JOLql
         0mWdHWznsrb7NdYNrYOfBY0bzvOAYHXy4O07H55qY7KlbHfzKWB7grQxSKi6E1Oj9hvH
         TWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1E2KjRoh5QPl4QWMlc2IUWvkR+6ixdGn9JSrzheefFg=;
        b=5SxTFps3TvxaMkGY1HVruZNmaoaR8mf9ERpt1yPm/WOPVnJG94ixUwyJMI4b40Yq/I
         q7/uoNhth3d49ZPd+XTn90uX3qduG33DWlTtrS1V5jy/Mj1HPDznGUbqCv6dezVh9S7g
         e/5GzQ814DxZfBBx6MUimvez6hLIgQYwEOVXq4BAI9qlKNnLJZTdguyqcHcvoAjdSWM7
         USRJpbmZV+abp6Ma6CaliFsXL2IPcXqhawBBUQ7btefypkJGvxwVWfSdkGbyQxd/iATN
         1HWgmkvho24B19hBuDDdRyctF03xbCV8irj6e9bWy0IwRqmVsaRdta60/HJPUMScaDcD
         5GhA==
X-Gm-Message-State: AOAM530moeoDcYO38FDZ7XeqtA/7WwyixJC0Yqjd44UYuYXodG5TQ6HJ
        jaQOXfXvN+GUepR4FgRXlLSEwg==
X-Google-Smtp-Source: ABdhPJwO5grJqRAgA1XNoFKUoNoU+h2BcmLSXzb5kwD5rMkFiB4D067C/be3+G1ireruH4pCRhKW7Q==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr2295490wmq.148.1641976584294;
        Wed, 12 Jan 2022 00:36:24 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:381b:6e50:a892:5269? ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id o10sm4351118wmq.31.2022.01.12.00.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:36:23 -0800 (PST)
Subject: Re: [PATCH V2 2/2] soc: s4: Add support for power domains controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Shunzhou.Jiang" <shunzhou.jiang@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com
References: <20211230094434.3053195-1-shunzhou.jiang@amlogic.com>
 <20211230094434.3053195-3-shunzhou.jiang@amlogic.com>
 <CAFBinCALAOJz16=u7r8tLM6ditriq=-NOACS2HRLrWs5B_FkVA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b2a9b8f0-2b12-c49f-9609-21999b1fffc8@baylibre.com>
Date:   Wed, 12 Jan 2022 09:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCALAOJz16=u7r8tLM6ditriq=-NOACS2HRLrWs5B_FkVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shunzhou,

On 30/12/2021 23:15, Martin Blumenstingl wrote:
> On Thu, Dec 30, 2021 at 10:44 AM Shunzhou.Jiang
> <shunzhou.jiang@amlogic.com> wrote:
>>
>> From: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
>>
>> Add support s4 Power controller. In s4, power control
>> registers are in secure domain, and should be accessed by smc.
>>
>> Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
> Also here I don't have any datasheet to compare this with, so this gets my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]
>> +       SEC_PD(S4_VPU_HDMI,     GENPD_FLAG_ALWAYS_ON),
>> +       SEC_PD(S4_USB_COMB,     GENPD_FLAG_ALWAYS_ON),
>> +       SEC_PD(S4_GE2D,         0),
>> +       SEC_PD(S4_ETH,          GENPD_FLAG_ALWAYS_ON),
> For the A1 SoC's UART entry we have the following comment which
> explains why we want to to be "always on":
>   UART should keep working in ATF after suspend and before resume
> 
> If for some reason you need to re-send this series then it would be
> great if you could add a comment above each entry with
> GENPD_FLAG_ALWAYS_ON.
> It will help others (like me) understand these SoCs better.

Can you resend with those comments added so I can apply the patches ?

Thanks,
Neil

> 
> 
> Best regards,
> Martin
> 

