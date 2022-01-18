Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA2492D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiARSgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:36:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43670
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348091AbiARSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:36:04 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ADB0C4004C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642530963;
        bh=EE0Uqs2gxfZTLiuKZr5yQERb9YnbJAH824xo2Ga77Yc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VWfKvjK7OKJPAj8wXfnlcMno1Ur/yOfoHW2lOoY8f6/+0PexDw8457E+qG32QP2Wo
         bEhLJLf18dgHkTSV4Dqq4KYWPbJ+mFaHPqmC+oDJElMVMtZDRklQatjNoOpZDhJKBe
         o9btZEtrSiedrXV1ddXgrejC7Z2qfKtv7QN8B+EhSRkiBkdSuzvY2WfRdpIs+Wm48E
         fMzB7LPV9yKFkQIWbvBMMJYKjMOkNxpJZ2Znx00w+Bj8Qg0vY6L5/tm4RAhzunSI+T
         IlKD3mphx8xZMkY4VvLK2OdgmT4xSw1fXm0zCIIi8Yd79G74uypwLpw/oEiPE3ocLt
         DdnvQu8Jc5Z/A==
Received: by mail-ed1-f72.google.com with SMTP id el8-20020a056402360800b00403bbdcef64so1919530edb.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EE0Uqs2gxfZTLiuKZr5yQERb9YnbJAH824xo2Ga77Yc=;
        b=X153I44vnvHjmiVv6hvAYKAI5nyKYQqDXeSh3j+3E+DqsYSw50RMtA2SFqxJ7r/Lqp
         NRB5W7ESSzatLRiVZsmWL2+SuQ0Xvrj9CfNFylU5VOgUJH9d6+go0aKzbj2HyekKr0jA
         riCg9VehSjXwXj7NV5/kA0T6ADqU7tPnJnhloFbdBGfOVeXCQCVIgMNTr74SK20slRyb
         HLEr+zt3R2zy8x63nyyOfWm+LRu1oaa+lemwtdCtHUvTalTUItNLOkt0i67z0NIFQQiI
         Gsh6YNN8I5tsmTz0w/QilBG3slOOKCYTYApVKbRJF5XeYEB1RO6rZH0buNweocC4RFlI
         Sxeg==
X-Gm-Message-State: AOAM5319Ii+EVF8uV/mXIPAkAZ1gR7d0wpU3GkApwgHCVfoh0bePWFbs
        YOmzPNEcAGy4qlezjuTbaN8VQw+1QOsNhBUg2S1l0pF/uNWD5ViLVX+Pr+cG6j2KJV41282gT70
        9BP+g1WoJ2ozLfEhprBzIHWKjRq87fiuxbaD+fgaQ7A==
X-Received: by 2002:a17:906:950d:: with SMTP id u13mr2606644ejx.153.1642530963211;
        Tue, 18 Jan 2022 10:36:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7fvH2EjM40W+CUN1OS0nmGVd/o0ku+wn5FGo24qFNppsdaH6JzDP3RNs1r7cpe3wn6aNXCg==
X-Received: by 2002:a17:906:950d:: with SMTP id u13mr2606629ejx.153.1642530963016;
        Tue, 18 Jan 2022 10:36:03 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d7sm191717edt.74.2022.01.18.10.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:36:02 -0800 (PST)
Message-ID: <4606bf04-154f-97bb-9b8b-1103c6308004@canonical.com>
Date:   Tue, 18 Jan 2022 19:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 08/16] clk: samsung: fsd: Add cmu_imem block clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Arjun K V <arjun.kv@samsung.com>,
        Tauseef Nomani <tauseef.n@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150045epcas5p4e54922758fb7922b1fd8de0995d2127e@epcas5p4.samsung.com>
 <20220118144851.69537-9-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-9-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Adds cmu_imem clock related code, imem block contains IPs
> like WDT, DMA, TMU etc, these clocks are required for such
> IP function.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Tauseef Nomani <tauseef.n@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/clk-fsd.c | 283 ++++++++++++++++++++++++++++++++++
>  1 file changed, 283 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
