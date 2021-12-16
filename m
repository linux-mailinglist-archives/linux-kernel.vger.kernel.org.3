Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6028476B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhLPHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:38:14 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45664
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232228AbhLPHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:38:13 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 723A23F1B0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639640291;
        bh=6XFRqSMdUPXz3BmHUNLepdt3XO5NwJG7CC0ys/8y//o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=HNSMQxenY0j+HlqhsKwCfchyzWImIxIsAJ98dOJczBe4qrtBdcZ3hWr1SpTdCbDqt
         oPDoTE3w+hy5QsFwBBUOJ3hFimvs4+v5v3ntIR41SSoQOTGnHJnDoxjydEH4th5Hes
         YjRj7fTT1qh8O6yuDZYqK8qPFqIzbgZ0ohmjOZWWRnq0saw4hqUmBY3Z2CPqc03ssk
         b/tHqd5n2K92PqCzc4EGtqegKRxbZEQtmfMUa7FHwhkBl+s0UHdSc7M/hPGOUkWW6z
         8bxI4QuyKGqkz+J6AjLd9g2gCmbGbrWQsZ4RPa5xlwhmUdnirYihy4BHGN16hx3+it
         CJj+i8CpaihNg==
Received: by mail-lj1-f197.google.com with SMTP id h18-20020a05651c159200b0021cf7c089d0so8202960ljq.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 23:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6XFRqSMdUPXz3BmHUNLepdt3XO5NwJG7CC0ys/8y//o=;
        b=EMCbNHZAUxCU5SHwfCTomfg/DLNVN7VqTpptdSS96WD0ZnPcF/dxBu+mC3EYCQJKzD
         xfL+wszxL2jo2wH/vskzGRP4u3RRP5tudKjEvyCmHVe26a3vJ8hbjSEhKTPE2vphg+LZ
         U8iOUVvMyMqhJ6DCXv9t9zCYLhQyoXvtkc9agng6Nd899SJUYL5WdC+ckZQSQ/tTCMcq
         Fsbn+qTTKJGOSb5HPbdadPU9+1Dq5nyevNh5Fv3kzOZatcMJGRizvb31lC4Kr4c5vkMX
         oxk7I5VL+E0HQqzvbWXmA1URuEljTaYDdxH4hIbCwzivyZGptYQw1+2cWVIF4B3enqcM
         thZQ==
X-Gm-Message-State: AOAM531gM0r4lQJhGnGwbtO5jj3Mj2mGNa4Irqe+INcHP47QEUNwNPlb
        Av19lDJ/KlwLm/UJp2Zb6ueHSutDhumCNmE1FbcPFhk/nGixjb3uBdXvCvujPw/2JvSX85VbklP
        5sxEnGjWXxrI+YsxrFp6zuIE7HlSWGHqYa3FoatDpUw==
X-Received: by 2002:a05:6512:340c:: with SMTP id i12mr1545520lfr.442.1639640289539;
        Wed, 15 Dec 2021 23:38:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6D4M3milSj9T6RMMugHsSByLIVmvgCptY8KQLkssmSHA/cG6m1PV3kpo4dpmAQxiZhglncA==
X-Received: by 2002:a05:6512:340c:: with SMTP id i12mr1545502lfr.442.1639640289312;
        Wed, 15 Dec 2021 23:38:09 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s10sm955828ljd.75.2021.12.15.23.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 23:38:08 -0800 (PST)
Message-ID: <b432dfba-2388-5a22-d319-e03ddbdf1a47@canonical.com>
Date:   Thu, 16 Dec 2021 08:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] usb: ohci-s3c2410: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211215225358.1993774-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211215225358.1993774-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 23:53, Rob Herring wrote:
> Accessing platform device resources directly has long been deprecated for
> DT as IRQ resources may not be available at device creation time. Drivers
> relying on the static IRQ resources is blocking removing the static setup
> from the DT core code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/usb/host/ohci-s3c2410.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
