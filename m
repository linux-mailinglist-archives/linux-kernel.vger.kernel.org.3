Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1448F7F2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiAOQmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:42:49 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35336
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbiAOQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:42:48 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73D3F3F1AB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642264967;
        bh=4RTqjVM9A7kelr5YNDsPI7iEwbJQX3RuekydXmeC/fA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=r2CGiF3/RxdS6uw5B4stIbFwhURpk4ZBZl3IrJf5eFrHAhQxJ/iLeuMXTzElF2UnT
         I0VVS4LEb8qccjnxumubT8eswGt2ODeDs0MoS5EQfgSKAeE4EWRVEax+x0/GOyvpN1
         fulLtbnhvV5wGqiTKhPW+WCWRTkIoICWmS4rMVJw1ddSgcifV29fyyKvz8I/myWnHP
         syeR11SodGa01nPPOs0KASTZ3AOjzjQm0a5IJ+zye13wEcywKFuPtwTqMhYLLCf1Jh
         EOwc6MNluKMh+UP1BMZV+lVLje/1FQ7ls8dJ2FOf8wIEDdBN73rU3LYWYLdLWDq3n2
         hHNlus1/V3Dcw==
Received: by mail-wm1-f71.google.com with SMTP id p14-20020a1c544e000000b003490705086bso3652558wmi.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4RTqjVM9A7kelr5YNDsPI7iEwbJQX3RuekydXmeC/fA=;
        b=iXXcPQG6371teEdckttekBn3R+ABbbeav9GrsJeDlVlDrUtsKb5LCzujunGrsJO2pB
         DfPIXduZPLRQIMWKA7PzZfcKg3qRgpC6/tB+UvQj8gNDhH9vnoG6rA+B9jdn6g9jKNmc
         PdpjO5E9oE6szXdUwx9bSNE/4FoLRyPF6KRpcJmPvOkEIwJibLn7/IKRtGDvtYQ1Hc2j
         QfF20qXv1QsLw64sxUAWg2iyd127RGx59JLg14pF7kztBw4uCQH7YX/i8geUF2VJDW3e
         vpZ7srWX/V7GzeAr5j6Iw5YThUhc0QlSI8BT30m6weZbCgzB5C9vK1jUfgdDv1S6P7Zh
         KrlQ==
X-Gm-Message-State: AOAM532ueFxw/KsOT6etDy/KbQfAA+iCYj3c2v+zbP1kW3ZmtoENDNrT
        9cHG9lif6mM0NpERk1SuRsnMLFr8F9kFX7/SK8Vl79xg1YoOVEMxAJ370oIcZv9Hv+KIDtey3fD
        o5NNzTI4Tbso3dEICb1VerH2JcMhkGMBMfOdJmFBUsg==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr16941167wmc.23.1642264967127;
        Sat, 15 Jan 2022 08:42:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4zlqSaycxMCFsIm9xtksf3CBBziS1UotZVsiuUBnlgQ3nSPviRE9uVJE9JDAIAKzM7Nxuxw==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr16941153wmc.23.1642264966891;
        Sat, 15 Jan 2022 08:42:46 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s22sm13261122wmc.1.2022.01.15.08.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:42:46 -0800 (PST)
Message-ID: <be69a1e6-f044-2382-fb30-7b281d16ed9a@canonical.com>
Date:   Sat, 15 Jan 2022 17:42:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 03/11] arm64: defconfig: enable taskstats configuration
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-4-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220114141507.395271-4-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 15:14, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable CONFIG_TASKSTATS which is required for CONFIG_TASK_XACCT (and
> subsequently CONFIG_TASK_IO_ACCOUNTING). Previously, taskstats got
> pulled in by KVM but that got changed in commit 63b3f96e1a98
> ("kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT").
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - New patch following full defconfig analysis as requested by Krzysztof.
> 

Nice!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
