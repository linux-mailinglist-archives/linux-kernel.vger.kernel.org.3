Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094D492D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbiARSeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:34:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43416
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348065AbiARSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:34:12 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E4454000F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642530850;
        bh=ys9fbFG6FrwU8wrOLNvr69yPd+OIURRywK4KztzYv+A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ld8VkcRkuAMMSt3wqXaddxdRK1LeKFy+ePnObCzFcxKZCe9tFjkArgG20nDHnNlzM
         k2MJWI80DCi/FzbX8unu93L1PiwIL3FpUC7vCbgXYisZfKE1bH2/KHGWxmAQ6Na698
         10jTBu6ciWu9m5s6NirfpYDTYsKMGtRya50rUFQc12urGrujCfasVO6PSGrbcEEUZL
         f42zuOeEiZ0T9bYuikysT4m0Um2M4E+Xk16bIlKVWwBiwZPCdmgx8boSFuWoCzwxb3
         Vahl87vKUPYfx1ISs7sd8nh0yXRyOie0rQGljiAApyIP6x+y9dOqGeVxBV1kNtpxWz
         OgruoD+Q//0KA==
Received: by mail-ed1-f69.google.com with SMTP id ee53-20020a056402293500b004022f34edcbso7146549edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ys9fbFG6FrwU8wrOLNvr69yPd+OIURRywK4KztzYv+A=;
        b=Ob7QgZYQnmNNcqT6ScnmOwtDne71NtV3cZ/1cfETjl7HXAH7mPp03MhRLyRTNgQA+O
         aKVkFSBPY/EoNv1moaoCDMVKqkD8+4eZ1e3KJcbpgqavnRb9kmUD/WDZ742QGAfav1FD
         uiM7FImbu3zCm3vErHcAK8tC5+DFaMtQqOICQMRDVpuiPpECQCw3Lx/WfIW7yIOKRijt
         /WYfS+CLQ6FEcEU29ZR8c5in5I3pFbUbeABEyggMEG6Ld9O7i/9w24dviFgTTcySrnx/
         DKZkX4rJMNBajJSbH4pPKdSpWWPbeFnqWLFhEPFFOo1LrDyrICyUBdqHmBabBvcYrHLP
         JRTg==
X-Gm-Message-State: AOAM5329F+IY3s5i0OGth+aQae0LvajNh6rBqLg95byzy8eMXia6QcAr
        5YE5WQ9x0+M80wyh13OEg6yyeXsp39yOgH5JKG+YwFXezktzu3up9oIxNfiCgxjw+nRhmkLhz0K
        SzurAyZ0t1eMFs6Gum/F9u7njV7BjpYz0hmwjfflXiA==
X-Received: by 2002:a17:906:f02:: with SMTP id z2mr22210690eji.499.1642530849086;
        Tue, 18 Jan 2022 10:34:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeXYDGBJEK7l/U57vJp7HToUWrta7Pd/0gP+bMho/GHw6BP3wds5zuz/OgfUqhy0vc56VI6Q==
X-Received: by 2002:a17:906:f02:: with SMTP id z2mr22210677eji.499.1642530848938;
        Tue, 18 Jan 2022 10:34:08 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 7sm5544523ejh.161.2022.01.18.10.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:34:08 -0800 (PST)
Message-ID: <d61c2cef-4f59-53ba-7135-b9acc2defeee@canonical.com>
Date:   Tue, 18 Jan 2022 19:34:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 05/16] clk: samsung: fsd: Add cmu_peric block clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Aswani Reddy <aswani.reddy@samsung.com>,
        Niyas Ahmed S T <niyas.ahmed@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150033epcas5p15b88d4f0c695fc515f20d8dffe15202e@epcas5p1.samsung.com>
 <20220118144851.69537-6-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-6-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Add CMU_PERIC block clock information needed for various IPs
> functions found in this block.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/clk-fsd.c | 405 ++++++++++++++++++++++++++++++++++
>  1 file changed, 405 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
