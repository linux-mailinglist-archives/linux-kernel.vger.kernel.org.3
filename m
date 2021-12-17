Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0B479798
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhLQXiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLQXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:38:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B0C061574;
        Fri, 17 Dec 2021 15:38:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l22so7738933lfg.7;
        Fri, 17 Dec 2021 15:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tvLuwZuQc2vFuQbM3eSjczyde6xCYDzNlRUJGi0Zkrg=;
        b=SmZais2gwhqBddKIjEvC4Z//0TkJ/MVGWod8LzyjqWqOke6DIyRTXv6PcSYOav5I6p
         7AfiLXQMco+QuuePLY4RHwexzF9NNJRs/Bvs4SBIDjQjtimzFHmgGJp6cprxJw+UpJ7U
         DvGrh4jXZq+rXI/f6JEt80eX1ZKN6MqCvEZ0s/1/vitpsJmau25HIEf0zSK0WIPyGoL0
         LnagQZOEby10gv78HVUvaofMr0X1aJOsT4ze/xVzh22sOoSam8VuF3u+xTM2bKr4PlMs
         Elz+ldEKAcSIBXLGVD/7OW+c87k5WVS7Uw0TIJlUeoaoPVWO8OmX6tchO4IhDCYSUY1h
         04GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tvLuwZuQc2vFuQbM3eSjczyde6xCYDzNlRUJGi0Zkrg=;
        b=ao/ALRdgx9etM7QbbrhjtKfabJb3MCJJiPdH4kMfC2yocwtHEDJdtRVSlGchbPLMBn
         S4PC3XpQZUn1+bV9skZT/03lzPvges67mSAb6kq5/pCemLawI05hjaWpWJUb1v3Jpbv3
         Yyn5PySyEt0eJPYaSXPHtiRqy3rnS603003BZR6svmvknqL5pZm6KMi09D4ocaFYr4Ug
         8DmpMIa46Za3lpJP+Z5CiTvopdrK4miXuaKtB1fD17agF0g9RI2+lLuNHpqZ1b5ZJe1s
         ad+m0UxFQqPzaynmf+Bxp89kBRz2RbLDHaGHSBzCkC2FHxTVjgYTtUmHsmvNJmR0y0+1
         /gwA==
X-Gm-Message-State: AOAM531NKhFj8SSu+0I822yB23WkBYnkaTzFnD8hjePtgSAKbEp+0Tuy
        5nz5llpZbwWpyetorVQncDrZfTRJDAo=
X-Google-Smtp-Source: ABdhPJzWv9aV3PULV5S7fOiTwP7zomEueQZzONpp6mhA8Ryq7mVqDKVY3/4jPvZL22vPCwZnPcnInA==
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr4836388lfu.13.1639784298641;
        Fri, 17 Dec 2021 15:38:18 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id be25sm1868385ljb.114.2021.12.17.15.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 15:38:18 -0800 (PST)
Subject: Re: [PATCH v1] mfd: tps65910: Set PWR_OFF bit during driver probe
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211124190104.23554-1-digetx@gmail.com>
Message-ID: <9e28e8a8-2ff1-1990-b8d5-778e8251fe53@gmail.com>
Date:   Sat, 18 Dec 2021 02:38:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124190104.23554-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.11.2021 22:01, Dmitry Osipenko пишет:
> The PWR_OFF bit needs to be set in order to power off properly, without
> hanging PMIC. This bit needs to be set early in order to allow thermal
> protection of NVIDIA Terga SoCs to power off hardware properly, otherwise
> a battery re-plug may be needed on some devices to recover after the hang.
> 
> Cc: <stable@vger.kernel.org>
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/tps65910.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Hello Lee,

Will you be able to take this patch into yours MFD tree?


