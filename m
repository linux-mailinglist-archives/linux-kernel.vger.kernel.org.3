Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D908948D8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiAMNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:30:11 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56274
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232034AbiAMNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:30:09 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA7193F1F2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642080607;
        bh=Gdbdjf8zVy+P14tpf21E4rjEbB+nBaQfGlpLQYdJfQ0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GB41HmI4PjIjei7llhTJvyUGJqTjWaOA1MxnFwQhck2yBe1jeOYqsBudjXtPGHwQg
         dBktdfnjw1XdwfVQ14KwCP61rQPKVLiSQqLmyQz4xOj7tVzNZ52TxDst6zkcTOliGl
         Ex8VSrRgVJ2yz3b+RF1T3ntyfjQSf+ykKsn0rL3ua7mD7cdpxiW799n0vSC+VnDosr
         4qgfgOonvGBzsYQZumghjCVoCJUGCZIdwwlOxAQveXhYl/Ik8/2OR1OPFwucqam1+/
         m6v1TdDb1rPiNk9mjb/XkgmWN2DHzDjbnSUNLFX8Gzb41oPCdc1AjjKTULSCrcB+qE
         10gaRl28BdVhw==
Received: by mail-ed1-f71.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so5367758edz.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 05:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gdbdjf8zVy+P14tpf21E4rjEbB+nBaQfGlpLQYdJfQ0=;
        b=kkLpIYf9tFGAdfFDiuhTBHTLx3lm57dl5ZYPdaTtIL59tauCFSRoubeZNmIydz5Ban
         g2OLOGuSQHDjt26AAO2yjVvWelTcS8RjHAnwe7BlPYexon1J/hE5gZRHuBsofmQ+AmtD
         B7uRjNVAz6qj+jeiwT/nnCaT9zBLtJLxK13g+rJ/hcjrnYw+4tWmtQRjTVRp6p/zBIB9
         Rk2L+GK6ODWtnHgd9ckwjlH76+MI1iDdWg9IGH2mSBDgR7adE1h+jX+WkZIj4M6ZShmX
         ORrD7/0BDs8PVHrORWo/K6YtNVNJKZ0jA+poF08KOAVSlNl9W9sqy+pLDu6NLexghTyS
         8sbQ==
X-Gm-Message-State: AOAM532Lj38gjmuFUID6iowHT4IVmvaBakq9tr+XHJIpoKAoaAmtpouN
        9j6WsXW4mlUfXk+KbelXdoH7IPDNwJPBkDZ+yuxXj6iuthqQreALNyjKvqERbDt/AS2PgdOgblf
        atJ5sAeLjlQPNwP6uOSofVRp7pVx9FD8We1ADhaE2aw==
X-Received: by 2002:a17:906:a109:: with SMTP id t9mr3500772ejy.718.1642080607704;
        Thu, 13 Jan 2022 05:30:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMNkfQi4+m47jbNQiciQP+7ptefZU6skQjA2XWtlYYF4xXnLw2qZV1JKz789+WCaQqP5cfCw==
X-Received: by 2002:a17:906:a109:: with SMTP id t9mr3500755ejy.718.1642080607579;
        Thu, 13 Jan 2022 05:30:07 -0800 (PST)
Received: from [192.168.0.30] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w3sm877146eji.134.2022.01.13.05.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 05:30:07 -0800 (PST)
Message-ID: <9c3ef183-2872-f070-4d22-0ab2e79d2555@canonical.com>
Date:   Thu, 13 Jan 2022 14:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 19/23] arm64: dts: fsd: Add SPI device nodes
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        Aswani Reddy <aswani.reddy@samsung.com>, linux-fsd@tesla.com
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122440epcas5p4651d7cb2fc6d6a70fd5eaab5eadcf996@epcas5p4.samsung.com>
 <20220113121143.22280-20-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-20-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> From: Aswani Reddy <aswani.reddy@samsung.com>
> 
> This patch add device tree node for SPI IPs and needed
> GPIO pin configurations needed for SPI IP
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd.dts  | 12 +++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi | 57 ++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
