Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9948F7F4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiAOQpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:45:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35378
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbiAOQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:45:19 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5DB2F3F1DE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642265118;
        bh=Qh/9dOJceOHlqPgghkG9ocUgEOI7Avk1izGQ2UpeUSI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FfQHvJ0+YjwvHsd1+2x5lbNobbVDkG5/3LwYUILlWREpoVNYnAa2Vbj+lm3S5U8UP
         g4Im8vxMD93qLe8QyArn+hMzGPOcrTxqcTNaNV1RVuYSy1QWAhElEcXFsiAha27j70
         1vxPnVWJGgCW25K/bilz3bFjmsBZG/hSI3kW7c060ie4hgkE3vxc0uRc9FMM1g6NIR
         lbX92DOfji6btG+xxzVLtRkkQuriGCmVKgfC/uusYgdmR4b6bQNi96VL8C+CimFeum
         OsyLJGq3F0F3F5PAxZ3N5HtqFWp7zufRT4+hB7zurqY5pNYLbQVnmDlQD5QSsZGb+q
         BZgyAuk4kGgdw==
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso2949832wmb.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qh/9dOJceOHlqPgghkG9ocUgEOI7Avk1izGQ2UpeUSI=;
        b=q1uGuhswRRQRtIsqZhHTYBKwFDaBUbWhq89O8DsQSskFHLQpbCUciELxk4or2E2fpn
         FFJaMZlKBCJ8i9NMpoayZ7Dmv3X77fqJwf34QYWhGJ0oQbQ8MGPz/I919hzBut1/5u3V
         XHD2/+gxACYnq1bhRrX1SHYzRS6+23r5SD0izU5vEhGciu/ftv0TG7e/MebOwNbaWNdb
         nZG38IFbyR5gf3tqQwFBSfrP71qM3h/mBtqcN3FxUro9lykINjkHSDGGdi8GCSQxnzki
         NhbhPYoL0f7mFF9asXR41vkIq2iw8d4+0MItBpLOcCI0uExMM3v4j18zwE7v3u7g8ERk
         GUpg==
X-Gm-Message-State: AOAM533y5aatOygATM7hvzWJXDKoSu/+nVOsBDqCjHP9kYA7nHevjAo4
        jiAtHg8yhWF8wKFkbT1PB10xsTrl+O/vUZhr/ge43tAACrtgqjiGZfFr3qRcfpFjQQMfkvNov1D
        c+G8gOl4RE4POpIN+REN8B9koMZrkqUiLbKjlI69m9w==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr11734546wrw.276.1642265118037;
        Sat, 15 Jan 2022 08:45:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRK7imukTWIXsWqH36depApLGHnxT/Gw52obivPX1oWM2s9X+EqGe0H5nThVQY0inyCk/fKw==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr11734533wrw.276.1642265117907;
        Sat, 15 Jan 2022 08:45:17 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z1sm9072918wmp.5.2022.01.15.08.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:45:17 -0800 (PST)
Message-ID: <a03f3240-0e68-1451-0d97-109c024f784a@canonical.com>
Date:   Sat, 15 Jan 2022 17:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 04/11] arm64: defconfig: enable pcieaer configuration
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
 <20220114141507.395271-5-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220114141507.395271-5-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 15:15, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable CONFIG_PCIEAER which is required for CONFIG_ACPI_APEI_PCIEAER.
> Commit 8c8ff55b4da7 ("PCI/AER: Don't select CONFIG_PCIEAER by default")
> changed it to no longer being enabled by default.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - New patch following full defconfig analysis as requested by Krzysztof.
> 

Good finding! The question is whether we actually need PCIe AER...

Best regards,
Krzysztof
