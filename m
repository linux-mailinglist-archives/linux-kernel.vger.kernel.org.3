Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76B146B6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhLGJPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:15:48 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35376
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233625AbhLGJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:15:46 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 277413F19E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638868335;
        bh=GaOIt/pSSnxls48YeUnnQvYgi4Owp7/cq1T2WhbsgYA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vkulWaNHv5e6cXMmJC8Tntffc7KXOOld1iynXVfIeIjk1vZQR+a3W2crGy7yEJE8x
         9W8yU3Oh1dsIliz9IKPozglVplhEle6nXyLwqpWAcUA42Zk/4fzkiP2xPbAjc2gd26
         7NsPzHo1bR80z4mNen1TETJX1EQLuKRClfe9OUUo/A2S8JcOICjwDm5Q6JN91iAzJR
         otsZlSKeNY5lMn4WRYZY8Bq2nl5RKn54K0RaURkyrNu4xXYSLKL6acVu5uADJjW4hw
         S9/6CJfYV2Ao7FcBBHiUHrMjQ7pjjGTzQYLRnXLmCORVZd2mcCI0ymR2g4L5SbVh3j
         rDo9fKN54nZOA==
Received: by mail-lf1-f72.google.com with SMTP id o11-20020a056512230b00b0041ca68ddf35so1680992lfu.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 01:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GaOIt/pSSnxls48YeUnnQvYgi4Owp7/cq1T2WhbsgYA=;
        b=UFikVsdQMX0u/rD2WLa283AgqNFwgqjjL+K06BZp5Jwq71U+Z3DHXjnSCgoxcQTjs0
         qpUkIFg8CoxTQzetCvMaBes2Cxh2yk6BM3UNC1l/xcIwkZ8XMZz+Us3krGNDDy0K2PSa
         cs0r0dwRXRA4uSTUYElgZ2YTzDvcN9znNXYSBvGrOqzXC6bawRE44UQpNwi8zmLG5svH
         bzKFJnFueHGNrF+rFlhCL536OJ0myGXfSczmozjmgWr4En9Pe1+h6W6SFDq2vlxTMqpg
         JB3tlt6nxT5rihiMNjbZvaYax9WVRjZS0+aWT1zDKiwawGYgNTti5NUWOgVFCFiEjyEg
         LS4g==
X-Gm-Message-State: AOAM531fiZflZGgQajSb3hobfEPEgDEEjcIuW/q8BNG6Ixz4+hVJEFE/
        5/Y0avnoMqcc34K1esiLvLo/nzPrgDPhg2LM3zsa7xmXuqDdZ+3ct9rhO3UjcxKIWdjf/sP0aTW
        TqP0FtJILCjkLDQl/WXsgIrC7pkgPDuL/5qBI0kwYqg==
X-Received: by 2002:a2e:95d3:: with SMTP id y19mr41718552ljh.175.1638868334645;
        Tue, 07 Dec 2021 01:12:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoosoQHLil3eUjvo4iMu1SXp7cmiktaSPpGa0qP5LvgOU5irMTlVL8Bg9LA4mGAsqDJxeHsg==
X-Received: by 2002:a2e:95d3:: with SMTP id y19mr41718538ljh.175.1638868334490;
        Tue, 07 Dec 2021 01:12:14 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s9sm1620472lfr.304.2021.12.07.01.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:12:14 -0800 (PST)
Message-ID: <9400d57e-7db7-0f58-b391-417e103576cd@canonical.com>
Date:   Tue, 7 Dec 2021 10:12:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dt-bindings: memory-controllers: ti,gpmc: Drop incorrect
 unevaluatedProperties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211206174215.2297796-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206174215.2297796-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 18:42, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the TI GPMC example
> has a warning:
> 
> Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.example.dt.yaml: memory-controller@6e000000: onenand@0,0: Unevaluated properties are not allowed ('compatible', '#address-cells', '#size-cells', 'partition@0', 'partition@100000' were unexpected)
> 
> The child node definition for GPMC is not a complete binding, so specifying
> 'unevaluatedProperties: false' for it is not correct and should be
> dropped.
> 
> Fixup the unnecessary 'allOf' while we're here.
> 
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/memory-controllers/ti,gpmc.yaml      | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Looks good. Rob, do you want to take it via your tree or I should handle it?


Best regards,
Krzysztof
