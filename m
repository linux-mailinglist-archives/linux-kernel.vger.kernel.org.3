Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4717A4A4FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343872AbiAaUKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAaUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:10:15 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2FC061714;
        Mon, 31 Jan 2022 12:10:15 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q8so14439538oiw.7;
        Mon, 31 Jan 2022 12:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=md82yNcHzb9hUMdO0D3wtsJDnKHtblS8Ove1AcpVwL4=;
        b=oXTOBWrpW2gl4tIhPPYXSYCdP3/cyVxxxJjLIU/H6PIvlisO2smazTA843hl8ym1lu
         UQ7nFj5dP4YilaIX47t5/UUo3/rF1VOovK3M3N2EaKiJGlRHmJX3+FjlpirLm3l1VzQJ
         rTInEmWelM97XSI0pjbfRPDkUZWpKI/Dx/4W61B0pNtP215V96YLYxf9HE8o5Kuboq3Z
         NIit3Xta78XA6PRj0xsV3mDcMaibY61xh8H5qnodjaHfE+ADK0mi2swPIdYKxgmuVmXr
         yMBQfMmLflXEcCe0vR8b9sX+XFzGMouCZTpVbj0PuFA78c5fM8NvMXqdOtzsD4X4snjM
         EA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=md82yNcHzb9hUMdO0D3wtsJDnKHtblS8Ove1AcpVwL4=;
        b=cMFAB+MOAzCT6M1T3tWMF6FduCB+S5wbtnRvUWBY/KID8MS6abpH4V0xP1DraTPsL9
         xENOacZXbdo3xRUSM9Q+6+S/ncOZVvqC4+cKcVRXAzEbNNCHRSfgTgjJETiNuIz8p5+m
         8NAUCV0lIIlX5TxhPtMFOR31EaYik0PzZW2hHr+IrANvfm3Fm+vPbePo/IFrrHXOWmYB
         AtgyHhvJkF6HDxhSgdCgKpTsec79PPsv+xCMQWaH2h9q1wAzAw6FCjMZli3VjLJnOllR
         oA2xs4lC535jMWg78vwBGRIMDfZOJfhX7lwAkHqSlbuEv9T4bJcrk0j2z2jyr13b9n6V
         S2YQ==
X-Gm-Message-State: AOAM533nCrcqHOoJbyWAHsai8wFTlMSF7RA2HZU7TDit3IAv2kJ9a82v
        jJvSrih4ETqA3YotkPUfuVagiuYp1/pWRQ==
X-Google-Smtp-Source: ABdhPJxGKaP8CEQPw0ggAidZHCs0odovFzUCuaCNznTdQv7o1VKhCNXQn2SGRGodc/39NDolZDqXOA==
X-Received: by 2002:a05:6808:1443:: with SMTP id x3mr13850490oiv.40.1643659814832;
        Mon, 31 Jan 2022 12:10:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21sm8177727otq.81.2022.01.31.12.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 12:10:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3af7602a-1703-4ff2-3905-dfd35742dd90@roeck-us.net>
Date:   Mon, 31 Jan 2022 12:10:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] hwmon: (sch56xx-common) Replace msleep() with
 usleep_range()
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220131193137.3684-1-W_Armin@gmx.de>
 <20220131193137.3684-4-W_Armin@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220131193137.3684-4-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 11:31, Armin Wolf wrote:
> msleep(1) will often sleep more than 20ms, slowing down sensor
> and watchdog reads/writes. Use usleep_range() as recommended
> in timers-howto.rst to fix that.
> 
> Tested on a Fujitsu Esprimo P720.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/hwmon/sch56xx-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index 0172aa16dc0c..f66e1ed4b1aa 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -139,7 +139,7 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg, u8 v)
>   	/* EM Interface Polling "Algorithm" */
>   	for (i = 0; i < max_busy_polls + max_lazy_polls; i++) {
>   		if (i >= max_busy_polls)
> -			msleep(1);
> +			usleep_range(1, 2);

This replaces a 1-millisecond sleep with a 1-2 microsecond sleep.

Are you sure this is what you want to do ? Given that task switches typically
take several microseconds, the new code is pretty much identical to a busy
loop, and the maximum sleep time is reduced significantly.

Guenter

>   		/* Read Interrupt source Register */
>   		val = inb(addr + 8);
>   		/* Write Clear the interrupt source bits */
> --
> 2.30.2
> 

