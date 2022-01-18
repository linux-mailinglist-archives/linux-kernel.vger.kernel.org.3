Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCEB492D78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348139AbiARSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:36:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36708
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244848AbiARSgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:36:50 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0874440028
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642531009;
        bh=Xr6SgdUN1TZh8LNJdRyo3Mtp+OngI4NaFYJZFvhIHmw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NGvScW1Rpl9xwrx2slmunED1b6Bp5QEbaTjOnMuNH/eo+EGWhMqZnn+IV+jB5cxq0
         v1HDdN806g8QMm7+J1kbkWH8SFoKzeoPLoB+wBGQqnFFNAV0dQrl7GqSY9lbmxZMld
         UjTx/b45MI/hskSfOPYMUEX+IkDKLnP/PEIq65fQpG6HS/oUhJgwyae5/Ag/zn4WFn
         tmEjzVsIRgZInVGywbygUJI5Zaw9vWZRB9FinCQsvl5vVN3vOLEhm8xNf4Jmp3J+8M
         mPCUTjeIvoY6EZhvAwldHzsHPkvOmpVuHQAshWP8sNZg9RWfc6X0WXphsEbZuojUA3
         uYY0Dq66bKrUw==
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso17795068edt.20
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xr6SgdUN1TZh8LNJdRyo3Mtp+OngI4NaFYJZFvhIHmw=;
        b=PkkMl7dOfiCsqDn/Ahr3M+8tAyWvX4jkI9/CK5tgPqfYyT76l1KQTDZayoLq4dt3x5
         5nBDm4fyjt14axrqRsStkWXaTMERFffYmcD9CrUErzJ7f4Fkon6uJZhXZtLSAe11UvlW
         uHRWdWVaXZSwiTguGHDdJmt7M9vCod0VtRrdN53SIQNmvudPfu6XcCEl6/Qpr6wLy12b
         FuWMnNUtkkegf2RJmQ5CU92fB/evxrokHiy+7YNRR8oxufMYb4kh3bJHHSY2uMwusXLo
         c31DsxRQAuu8wG8OBCU5+MD9zsLBSu9cr01SylQIEyxESIZhIB3UtkGZou8APJfHWDZm
         bcjw==
X-Gm-Message-State: AOAM531AUVcPU4/ZZhVDgZTVyjZuBVGCU7715rOFt7Atc8xJ/YNWAbed
        ajafbwBWeDaXipvdGjGKJoXR8OQ5g1Ds3rMC6vT509wv+F+EL4jLujLBl46UTrEf07vAqUHzK2L
        /MOjQ8RJDQi74APdCBkzmB4CHateQlL+ZYtI6QfJPpQ==
X-Received: by 2002:a17:907:9810:: with SMTP id ji16mr21430548ejc.202.1642531007367;
        Tue, 18 Jan 2022 10:36:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhfrqj3ReK7A0ko54v0kjJtEtaJOwjxvJZxY2r3mMd3765xiW/XF5zsxzkUqpiG2o3Eafuww==
X-Received: by 2002:a17:907:9810:: with SMTP id ji16mr21430530ejc.202.1642531007224;
        Tue, 18 Jan 2022 10:36:47 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id kw22sm5615885ejc.132.2022.01.18.10.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:36:46 -0800 (PST)
Message-ID: <ad954b04-9df9-6675-18b8-8cda01467ce8@canonical.com>
Date:   Tue, 18 Jan 2022 19:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 10/16] clk: samsung: fsd: Add cam_csi block clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Sathyakam M <sathya@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150052epcas5p12efa399d1a59fc2fb0595eef128ffdf9@epcas5p1.samsung.com>
 <20220118144851.69537-11-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-11-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Adds clocks for BLK_CAM_CSI block, this is needed for CSI to work.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Sathyakam M <sathya@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/clk-fsd.c | 207 ++++++++++++++++++++++++++++++++++
>  1 file changed, 207 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
> index 72a2b38524a1..afac8760ebe1 100644
> --- a/drivers/clk/samsung/clk-fsd.c
> +++ b/drivers/clk/samsung/clk-fsd.c
> @@ -1543,6 +1543,210 @@ static const struct samsung_cmu_info mfc_cmu_info __initconst = {
>  	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
>  };
>  


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
