Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7019848FC8D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiAPMMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiAPMMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:12:34 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDAFC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:12:34 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id z25-20020a0568301db900b005946f536d85so7201210oti.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN4hyAkZ1Miqzb3/QhoFsGXlrqJg5gaQIvzhl2DDXYI=;
        b=CPNaiXWo2pnIicCgCE4TOFjmWNuRA9dzQpr3F9MQWVZndQVObEbrqc0LkwEobvrbAm
         b6jkPIJMdB2Xorzqzp3V0BiqMe5ONj9bKIWeOOKnukHWMiMqb9y3m4SwNrdoQkHfxhXq
         CDquO4Y5+rWhQ+usux8FaGzPpZ95FJFNAJGvYvwxZ9I3+VcEl9PH/Pvh6d4vmzz5tDtF
         V/8iIeMg4OwY/XNOgqmwFtCvGlXid6h50FVXjS+tHS/Kzh585Uwe2iOovV48wXEuLeyt
         nSve4ONIxR8/CbPDzw/rOM9rrux2qd5frYCAqc10IqjcAEKiOuYUepeHxW4aqbyBlcZl
         bWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN4hyAkZ1Miqzb3/QhoFsGXlrqJg5gaQIvzhl2DDXYI=;
        b=yrHPU5oNaeFPHjFx0FSOWW8FvatQKUoF/ZKVLOC8dm4Q8DMdp8omU/Os7itLhUZ5lt
         iCSSyGkRSmviXBkjrp0/EqzQ0NRuedJBSBAyOBRxEde/NDL/l5JR0SnMWodPWwUUm8Tl
         EgaADVnVNm3Vq+v4txUSvIf7mj/09/spcnprvtOY1tTw47ixUDfBFd2ob1/8UZL4SUeu
         VLyl7+eOvk4l8E+EELQYySRfJr9YSmVnUVHL9Wbnf/FFeeIheIl8JGOfL1oJhHf++R6e
         4bTL1zi1Aa//fjnAxvvxLaI+79yd0fDSAZ3IWquvQHOkIm+g7fDgsWtT5VIHAQAMncTD
         MbBg==
X-Gm-Message-State: AOAM530u0Rctv9VL7tWm4Hv0UXI1j+NCzJRdI7h5ohHSlYsmPMQYblDK
        5yUaCCjlVxuIAGLtpZRlEeJzJ5EP24MqwOvRTSNcvA==
X-Google-Smtp-Source: ABdhPJy8usbAaNUR44V9Qk15vyIj3ak49FQUUJBJouk/HUiIm/veRgYnOMPkzs5+HmpbNVpOzFFdybTHvuzzOVkJiXc=
X-Received: by 2002:a9d:465:: with SMTP id 92mr12902887otc.35.1642335153484;
 Sun, 16 Jan 2022 04:12:33 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220113122435epcas5p18e6a2699f193b9e1287588278a570235@epcas5p1.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com> <20220113121143.22280-19-alim.akhtar@samsung.com>
In-Reply-To: <20220113121143.22280-19-alim.akhtar@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:12:21 +0100
Message-ID: <CACRpkdYSR5hiVKoZTffxudNOUQCNFqX-yuys-xgeocn2vG_ecg@mail.gmail.com>
Subject: Re: [PATCH 18/23] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        catalin.marinas@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        Aswani Reddy <aswani.reddy@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 1:24 PM Alim Akhtar <alim.akhtar@samsung.com> wrote:

> This patch adds compatible and port configuration for
> spi controller for Tesla Full Self-Driving SoC.
>
> Cc: linux-fsd@tesla.com
> Cc: broonie@kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Note to self: now that I see that the Samsung "S3C" SPI controller,
which I was thinking of as "some kind of early 2000s legacy" is used
by the very latest silicon I bumped up fixing it to use GPIO descriptors
a bit on my TODO list.

Yours,
Linus Walleij
