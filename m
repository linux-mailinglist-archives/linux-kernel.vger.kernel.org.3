Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B052349C4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiAZIKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:10:19 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45476
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238164AbiAZIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:10:18 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BE4A3F32C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643184615;
        bh=DMOBbhpbxVYSRvBEVGGF1WPtdp5VA2Nvoeep49GDD7g=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dFDmyZiXNv5aCkXI4MaLT3gY7kfN531g2c7Nt8+2YxkWQ8SHBu+1mLK0K8N0PMbzc
         9Psf4MI7bO5fuyt6LelejIkWBqXucb4+STQb/NPYdX0K6vtX4PNCqHI4iWeJPAxJQR
         qxZaZm4VW+6SZcLeHVepUxsjmP0IBlx1WPVT+HWgSPfygFZ8NE/rGvE2d0wZFuFKUh
         4ozZVPY4zVCCfA09KyJ+/Uu4miQYH18dVTVCSA/AugLF/c+nw9Ft5aAVlIGuOrspCZ
         CTp+66AtM7n8g3ka2DQs1OTNflvpdfwxl7zikInLpTbvLac29dtB7gF59coWADmqHH
         Y26f4mHefsktg==
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b0034c29cad547so2232514wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DMOBbhpbxVYSRvBEVGGF1WPtdp5VA2Nvoeep49GDD7g=;
        b=bHzWskar+fsVN9aSITVzpy+q9HEhTswxazSKaslOyWtkZji5+4nqek6LDYpY7Vqx0M
         tEgQBbpRl2VmuJj8CEPHkaHZObURcQHfgeFybcCz6JNytpSgSHT+h7dRD4o6vujm4vpb
         WsRMPsOSVJDGmP5vkEOXugGGjfQxI43661pIVceU45iLTFZAefneRQ/tb2PTAHwyLSxy
         8HDku5MOGWLjqBPIx6ypnMirhDrt1QCWXusyv/YV4AWdoEQMRZtl8v2viGd8dpm22scT
         kybv/dmPW+1GzFooO54g5NzAYMXS3GjI26MqltNDDwHr8r4qTN9mruSk+kj/IZo7yP9/
         leRw==
X-Gm-Message-State: AOAM533b1bf4SGVeedvMR7aDnKNeY9+6YfO2C1p2dXtUU6ehSqobOHOL
        flpt/YJ8b0coILZxqghEdrF8DrjsS/aFEPV580C1KqDNNRaJEamSuU+d9MNLwU0AOxE1HEz0h5i
        /86aj8S58u3kawdVHeOi1UL56mYvV3YgXTeqzV5ekwg==
X-Received: by 2002:a5d:6210:: with SMTP id y16mr20242691wru.454.1643184615048;
        Wed, 26 Jan 2022 00:10:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnmI3G5A8EfcELI9u37UH1MZ8E80quDMGGBUUeCgGrHC65UI2ErBUkKdMwTg9U3hbsGtCuGw==
X-Received: by 2002:a5d:6210:: with SMTP id y16mr20242663wru.454.1643184614770;
        Wed, 26 Jan 2022 00:10:14 -0800 (PST)
Received: from [192.168.0.60] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o5sm17575019wrc.30.2022.01.26.00.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 00:10:14 -0800 (PST)
Message-ID: <cabc3a91-807c-856b-5b74-03788781e2a0@canonical.com>
Date:   Wed, 26 Jan 2022 09:10:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/12] arm64: dts: exynos: add USB DWC3 supplies to
 Espresso board
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
 <20220123111644.25540-2-krzysztof.kozlowski@canonical.com>
 <CAGOxZ51zavNVpvUv0C17Cit+pdkERC70m5Ez3ELGpFh8tGDozQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAGOxZ51zavNVpvUv0C17Cit+pdkERC70m5Ez3ELGpFh8tGDozQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 07:58, Alim Akhtar wrote:
> Hi Krzysztof
> 
> On Mon, Jan 24, 2022 at 1:34 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Add required voltage regulators for USB DWC3 block on Exynos7 Espresso
>> board.  Due to lack of schematics of Espresso board, the choice of
>> regulators is approximate.  What bindings call VDD10, for Exynos7 should
>> be actually called VDD09 (0.9 V).  Use regulators with a matching
>> voltage range based on vendor sources for Meizu Pro 5 M576 handset (also
>> with Exynos7420).
>>
> 
> I checked Espresso board schematic, it is 0.9V for the USB and supplied by LDO4
> 

Thanks for checking!


Best regards,
Krzysztof
