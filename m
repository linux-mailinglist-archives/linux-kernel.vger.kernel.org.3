Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DC1490749
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiAQLrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:47:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40684
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236426AbiAQLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:47:17 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C980B3F1E2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642420036;
        bh=KWW81zXKWRZLFTdKDAM8Dxes8YJlXIyroEnLeEEVaPY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=cEFMwErYPPv11jylDfBR49GDDOOUnQU2YyCLLsXLzxNyvTzX8R7N/UdoaI469bnnS
         nccNYXypFYXyLNYxx7kIbHfQGMoMnYYZIXNAU2TI+qA2Pl5vy4Tz4GRQi71kc08CL7
         QgIAVyGLaHkmUyWmS3AI4B2FbcPn7YWVuoUDHQwiAqjY1SkxUkeFkiAbhYpYuQQDfo
         9g3yN4faEs2bEFGLEzd+KmfnSf1QYaccJtEqQxurOuIYBzwpPr6Y5IVgCDPQG17NrT
         hC18DW8XefDcazmxuepLoj1EUHoXMo7lCqzF5iM37Ol1iONtV4VNXH/I5vq39REGJ9
         Y1xK16+nuc6XQ==
Received: by mail-ed1-f69.google.com with SMTP id bs4-20020a056402304400b004032af6b7ebso717637edb.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KWW81zXKWRZLFTdKDAM8Dxes8YJlXIyroEnLeEEVaPY=;
        b=JV3PrHPgeQcq7pJmp+sDEFoVm2T0bYn46KtrU9JkNWOfzPE9SEc0hQO4wLcAmbb4qL
         cWaWv6XPb0HwNNj1d3QqvM/vxCxJM2MgGPe4fHRNaDgn6wTHw6BGSBkMT4lm7ovsIy/Q
         V7FGuSEIybterqmaG15vxsBNmRhR8xn2rvy43vqYLefJuJbuNUQe/mTEjgx0ju/ezHjW
         +Gdszkk2/Cl2SsRQF0LuSnLyh5VDzuK5j8Lu2e8qhdMSoEeJUFGRP2GKSo/IPSfOoc5l
         uwE+oit3oXR5YCxBzvmbDMEeOmVp5NmWs5Ci4nK3jseDqMrXC4MLHkWcckREMtQpTUCf
         FSGA==
X-Gm-Message-State: AOAM5320FaufpA5XVZJknx/kIXsywcVSm0st+ugzi1s6a1exLIsJlxcn
        YThbh9waDvf2DM7eQymPW761x7YX8v1WyhDFPRFKnTYFv0ck5qt+Q3aHdqTCxF2JvL9PULsyUgj
        asVlVBJY3kJnsS0IsRjyQrM2Qt9Heg+C9sRpyxz4jQA==
X-Received: by 2002:aa7:c7c6:: with SMTP id o6mr20427692eds.32.1642420036551;
        Mon, 17 Jan 2022 03:47:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYbl0ZqyxizwYR/FD3lH5PkLtBQvCTWyelYpaOm+E51QulRzhjkDzSRFhvzmstty4uu+QIVg==
X-Received: by 2002:aa7:c7c6:: with SMTP id o6mr20427685eds.32.1642420036423;
        Mon, 17 Jan 2022 03:47:16 -0800 (PST)
Received: from [192.168.0.37] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f13sm5807955edd.73.2022.01.17.03.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 03:47:15 -0800 (PST)
Message-ID: <1116a187-b43e-c139-ebdf-7d27a83c2389@canonical.com>
Date:   Mon, 17 Jan 2022 12:47:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 04/11] arm64: defconfig: enable pcieaer configuration
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-5-marcel@ziswiler.com>
 <a03f3240-0e68-1451-0d97-109c024f784a@canonical.com>
 <28f9ff53dc1379fa6462bf54c5db556c3474c302.camel@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <28f9ff53dc1379fa6462bf54c5db556c3474c302.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 12:45, Marcel Ziswiler wrote:
> On Sat, 2022-01-15 at 17:45 +0100, Krzysztof Kozlowski wrote:
>> On 14/01/2022 15:15, Marcel Ziswiler wrote:
>>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> Enable CONFIG_PCIEAER which is required for CONFIG_ACPI_APEI_PCIEAER.
>>> Commit 8c8ff55b4da7 ("PCI/AER: Don't select CONFIG_PCIEAER by default")
>>> changed it to no longer being enabled by default.
>>>
>>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - New patch following full defconfig analysis as requested by Krzysztof.
>>>
>>
>> Good finding! The question is whether we actually need PCIe AER...
> 
> Yes, however, why else would we have explicitly enabled CONFIG_ACPI_APEI_PCIEAER?

Right, I missed that it is mentioned in defconfig.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
