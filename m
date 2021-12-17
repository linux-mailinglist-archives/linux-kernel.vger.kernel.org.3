Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918D3479058
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhLQPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:50:25 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60998
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235840AbhLQPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:50:23 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9D97D3F1F0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639756222;
        bh=Vz0WaZn+QjmviDVVOxxI0VKa9jS9jnpYSLlaJ+1iHt4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=o1gg2t2PWWZYaGrKTITfajwqnoGYNcR9VWFFkNaBAgleNCT3GPxq6h4i5acAaKFwq
         uGeicY7o4K0wTFilno8/chcSqkXh+oJxP+9IYGsxE74KUfe3L/561VJEv+HUvE4LJ6
         k+XKR+r9P5J815uWLAfEXiv74M7BthzoD4t/1fKzgN4CqyqEUS5/vD/e4qI0IP9UCv
         /3BtBKeWtV0tQVpCwyZyGOfArdF7jxA4YpxUYX7YGeGWzu2Awu6iqWtrZERO5w7Wlh
         NDbTTjxAr4WnupT5/Uh/aMraLVGG9NRAuOoW8clsqkOCj+GNu76DVjsR6M9CUVmIkf
         u94MtSQLbQtkQ==
Received: by mail-lf1-f72.google.com with SMTP id w21-20020a197b15000000b00422b0797fa3so1073339lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vz0WaZn+QjmviDVVOxxI0VKa9jS9jnpYSLlaJ+1iHt4=;
        b=1mq1rIaGXkZEmvtdkBYjR3IvjXd3ii8a1Ij5aQQs40ApjL92QO9EzfjYOBtifd8CMm
         UaE6VNTYJ20b9sxhf4g0erKmTyGD+AqgXcqgCueNR/EvS0Fc2KcHXRXThr44FvuY7LTI
         g230sLxRahoIUlTWxYPfU50RdnPDVADUxPvdCPGj2ZBqFaDsw/JiEruDClDk4aR6B5OJ
         31uiTO35MyIEsO0oU9W2SvF7BGHC8uUIbLYECdY6sZWMMcYPM/bW6TStnCQj0jzpAnGL
         CJInJLo1a5foR4aRun25f+zpoMBIvcxoQPVKr4ffwp9T7QSo07nULjKEbiZFr6NJMuZy
         Omyw==
X-Gm-Message-State: AOAM531tMdi222/VNs+yhKOrNk2urOy4rx64HLUE5XumZ7r4kEEll0dh
        g0n4bXrBn8nVCZfhEepQYJGs9S9ZXeV3rmdl5oNonOP0Y1BemZfALDUy2oUydC7x06oUH6myZ3J
        T1f4znpL3oy4zx4Ac636gtQOS8dUCJw6rVKI3RRD0sA==
X-Received: by 2002:a05:6512:3b13:: with SMTP id f19mr3294912lfv.321.1639756221691;
        Fri, 17 Dec 2021 07:50:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWVVHP8AIicFtgzT6t5zbqk3uLn5LaifrLCAR18ukQnW+gJGIDSWfttbU1Fp4zH33SsPnLLA==
X-Received: by 2002:a05:6512:3b13:: with SMTP id f19mr3294897lfv.321.1639756221533;
        Fri, 17 Dec 2021 07:50:21 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p20sm1443796lfu.151.2021.12.17.07.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:50:21 -0800 (PST)
Message-ID: <f5588a26-1a48-2513-a36a-13bec58e5003@canonical.com>
Date:   Fri, 17 Dec 2021 16:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 4/4] arm64: arch_k3: Select GPMC device driver
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211217102945.17432-1-rogerq@kernel.org>
 <20211217102945.17432-5-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217102945.17432-5-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 11:29, Roger Quadros wrote:
> The GPMC controller is present on some K3 SoCs.
> It provides access to NOR/NAND flashes and asynchronous
> SRAM-like memories and ASICs.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 

FWIW:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Other option would be to make it "default ARCH_K3" in OMAP_GPMC, but
this is fine for me.


Best regards,
Krzysztof
