Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52C492D64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbiARSet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:34:49 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43462
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244394AbiARSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:34:33 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74B953F1E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642530872;
        bh=2sNtXURDOFY5YeHmaa+6rq6KkuL9DgoBnkrsKI2ksQ0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=d9fYef2tNB6ehF92zvFjV3K2EE6XGUodRdbxbluAW0k0uyMJedXwD5dY1DfzAO9kE
         549do6eSe9xguqLlp3kOA/sqc/0v2ikRYUlN8OZiJ9dctEYqtTTh9qSNDjmJtScalD
         NaqzaY6C2lqXdRciSKSNVT92/n7s7P8nlfa76MSjtdr66/GMyqJaMtIEv4ysSvNFYQ
         S5oqpLiGOwwvb/ujUY+boGe+QXCzeXxUqegcXSj/+6a3saOJv88iXGnQlnT+LaoNl9
         BrF9f//q3TDJJRocp8WCjNZE/Qr5cNfAjUDDykZbKJ5hVEK99KJiTHWdlxInTP44/G
         pXwoQ2b/3NprA==
Received: by mail-ed1-f69.google.com with SMTP id a18-20020aa7d752000000b00403d18712beso780712eds.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2sNtXURDOFY5YeHmaa+6rq6KkuL9DgoBnkrsKI2ksQ0=;
        b=OLWhe7sJH11Naser4T/I39cawlGrHGVY+Ni5Ym+uF1DPBxiRWndt8zkpzRDhbPlEex
         PcJ7noi+LRJk47URAUrezlwwvY8aAgKvwzMqOF23SAdgZ/jZjkqRV8H7Bt6XWEYQFGSY
         vj5UK2df35UgG3+L12PZB+7q+tpu+sAfM0rR5O+TG/TKkvrbuALQdohr0gRiR8bCId5p
         ecPvrOOHGf67S61bv3irkIH/Q3BZfg3cVD7AI5kjhUgLi4BrOBUOigWFrtgfQngA2agq
         BsnYYEHVlIbCW5M5oUEaAPgKgdTkDD2I7zwlFs3b3Jjn8XU8PI486W82ICo1AXiqaveF
         5LYQ==
X-Gm-Message-State: AOAM530xnqGAtYSG9uCFPr25HF3PjYiZSjCUhynDIeXOcFtUBYu7Y7oi
        0C42BWNgPafiZXSOC4zbZhDmPuxS1OwvGTugJOiCOkiqWJ59qrW4aBfoMW3i1E5Ma+XgcaURlR1
        ZM+dnCZP7ryg7gxxNXF3eb+nMGZmz4VgVnGqZg8zzNg==
X-Received: by 2002:a50:d69e:: with SMTP id r30mr1416880edi.284.1642530872198;
        Tue, 18 Jan 2022 10:34:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFfk4qysqwQQ+JBGYnqeMFUI+XaHpezXkBv6eaAh0acQ0crMg2NxWfal3ZD4TuQozsNPJjAA==
X-Received: by 2002:a50:d69e:: with SMTP id r30mr1416854edi.284.1642530872062;
        Tue, 18 Jan 2022 10:34:32 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l10sm5590235ejh.102.2022.01.18.10.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:34:31 -0800 (PST)
Message-ID: <3c400f9f-9d02-050e-cf21-c3376bf15127@canonical.com>
Date:   Tue, 18 Jan 2022 19:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 06/16] clk: samsung: fsd: Add cmu_fsys0 clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Shradha Todi <shradha.t@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150037epcas5p1624361eb48fa14cdf9ed88de6f890db4@epcas5p1.samsung.com>
 <20220118144851.69537-7-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-7-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> CMU_FSYS0 block has IPs like UFS, EQOS, PCIe etc, lets add
> the related clock information for the same.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/clk-fsd.c | 302 ++++++++++++++++++++++++++++++++++
>  1 file changed, 302 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
